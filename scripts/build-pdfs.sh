#!/bin/bash
# build-pdfs.sh -- die Handbuecher und Buecher als PDF.
#
#   bash scripts/build-pdfs.sh ?-de|-en? ?NAME ...?
#
#   -de / -en   nur diese Sprache (ohne: beide)
#   NAME        nur diese PDFs (Namen aus der Liste unten)
#
# Das Repository hat drei Gruppen, jede mit LANG-markdown/ und LANG-pdf/:
#
#   Tcl-family/   Tcl/Tk 9.0 und 8.6, tcllib, tklib, Pakete von Csaba Nemethi
#   Extensions/   Erweiterungen (TDBC, Thread, [incr Tcl], tDOM, expect ...)
#   Books/        Tclutils, pdf4tcl, pdf4tcllib
#
# Ergebnis: GRUPPE/de-pdf/NAME-de.pdf und GRUPPE/en-pdf/NAME-en.pdf.
#
# Handbuecher: scripts/createpdf/createpdf.tcl, mit Titelseite,
# Inhaltsverzeichnis, Stichwortverzeichnis und Lizenzkapitel. Es braucht
# die Pakete docir, mdstack, pdf4tcl und pdf4tcllib (siehe
# scripts/createpdf/README.md: TCLLIBPATH und TCL8_6_TM_PATH bzw.
# TCL9_0_TM_PATH). TCLSH waehlt den Interpreter (Vorgabe: tclsh). Die
# Lizenztexte liegen als license.terms / LICENSE / COPYRIGHT.txt neben den
# Seiten (scripts/hole-lizenzen.sh); davor steht der Vermerk aus
# scripts/createpdf/uebersetzung-de.txt bzw. umwandlung-en.txt.
#
# Buecher: bookkit (tools/book-build.tcl). BOOKKIT=/pfad/zu/bookkit setzen;
# ohne BOOKKIT werden die Buecher uebersprungen.

cd "$(dirname "$0")/.." || exit 1
tclsh=${TCLSH:-tclsh}
sprachen="de en"
case "$1" in -de) sprachen=de; shift ;; -en) sprachen=en; shift ;; esac

# Name            Gruppe       Ordner         Unterordner  Titel (de)          Titel (en)
# Ordner: unter GRUPPE/LANG-markdown/; "." = die ganze Gruppe.
# Unterordner: nur diese (mit Komma getrennt), "*" = der ganze Ordner.
# Fehlen sie in einer Sprache (die C-API ist nicht uebersetzt), entfaellt
# das PDF dort.
LISTE='
tcltk-9.0        Tcl-family   9.0            tcl,tk       Tcl/Tk_9.0            Tcl/Tk_9.0
tcltk-9.0-capi   Tcl-family   9.0            tcl-c,tk-c   Tcl/Tk_9.0_C-API      Tcl/Tk_9.0_C_API
tcltk-8.6        Tcl-family   8.6            tcl,tk       Tcl/Tk_8.6            Tcl/Tk_8.6
tcltk-8.6-capi   Tcl-family   8.6            tcl-c,tk-c   Tcl/Tk_8.6_C-API      Tcl/Tk_8.6_C_API
tcllib           Tcl-family   tcllib         *            Tcllib                Tcllib
tklib            Tcl-family   tklib          *            Tklib                 Tklib
tablelist        Tcl-family   pakete/tablelist  *         Tablelist             Tablelist
mentry           Tcl-family   pakete/mentry  *            Mentry                Mentry
scrollutil       Tcl-family   pakete/scrollutil *         Scrollutil            Scrollutil
wcb              Tcl-family   pakete/wcb     *            Wcb                   Wcb
tsw              Tcl-family   pakete/tsw     *            Tsw                   Tsw
erweiterungen    Extensions   .              *            Erweiterungen         Extensions
'

# Buecher: Name, Ordner unter Books/LANG-markdown/, Sprache
BUECHER='
Tclutils-de      Tclutils-de     de
Tclutils-en      Tclutils-en     en
pdf4tcl-de       pdf4tcl-de      de
pdf4tcllib-de    pdf4tcllib-de   de
'

gewollt() {
    [ $# -gt 1 ] || return 0
    local name=$1; shift
    case " $* " in *" $name "*) return 0 ;; esac
    return 1
}

tmp=$(mktemp -d); trap 'rm -rf "$tmp"' EXIT
rc=0
for lang in $sprachen; do
    while read -r name gruppe ordner teile tde ten; do
        [ -n "$name" ] || continue
        gewollt "$name" "$@" || continue
        src=$gruppe/$lang-markdown/$ordner
        # Arbeitskopie ohne README.md und QUELLE.txt (sonst ein Kapitel "README")
        w=$tmp/$lang/$name
        rm -rf "$w"; mkdir -p "$w"
        if [ "$teile" = "*" ]; then
            [ -d "$src" ] && cp -r "$src/." "$w/"
        else
            for t in ${teile//,/ }; do
                [ -d "$src/$t" ] && cp -r "$src/$t" "$w/"
            done
        fi
        if [ -z "$(find "$w" -name '*.md' 2>/dev/null | head -1)" ]; then
            echo "$name ($lang): keine Seiten unter $src ($teile), uebersprungen"
            continue
        fi
        find "$w" \( -name README.md -o -name QUELLE.txt \) -delete
        case $ordner in
            pakete/*) ude="Programmierhandbuch (deutsch)"; uen="Programmer's guide" ;;
            *)        ude="Handbuchseiten (deutsch)";      uen="Reference manual pages" ;;
        esac
        if [ "$lang" = de ]; then
            titel=${tde//_/ }
            extra=(-lang de -subtitle "$ude" -subject "$ude"
                   -note scripts/createpdf/uebersetzung-de.txt)
        else
            titel=${ten//_/ }
            extra=(-lang en -subtitle "$uen" -subject "$uen"
                   -note scripts/createpdf/umwandlung-en.txt)
        fi
        mkdir -p "$gruppe/$lang-pdf"
        out=$gruppe/$lang-pdf/$name-$lang.pdf
        echo "== $out ($(find "$w" -name '*.md' | wc -l) Seiten)"
        if ! "$tclsh" scripts/createpdf/createpdf.tcl "$w" -o "$out" \
                -title "$titel" "${extra[@]}"; then
            echo "$name ($lang): Fehler" >&2; rc=1
        fi
    done <<< "$LISTE"

    while read -r name ordner blang; do
        [ -n "$name" ] && [ "$blang" = "$lang" ] || continue
        gewollt "$name" "$@" || continue
        src=Books/$lang-markdown/$ordner
        [ -f "$src/book.tcl" ] || { echo "$name: kein $src/book.tcl, uebersprungen"; continue; }
        if [ -z "$BOOKKIT" ] || [ ! -f "$BOOKKIT/tools/book-build.tcl" ]; then
            echo "$name: BOOKKIT nicht gesetzt, uebersprungen"
            continue
        fi
        mkdir -p "Books/$lang-pdf"
        out=Books/$lang-pdf/$name.pdf
        echo "== $out (bookkit)"
        if ! "$tclsh" "$BOOKKIT/tools/book-build.tcl" "$src" -number -pdf "$out"; then
            echo "$name: Fehler" >&2; rc=1
        fi
    done <<< "$BUECHER"
done
exit $rc
