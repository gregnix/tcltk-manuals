#!/bin/bash
# build-pdfs.sh -- die Handbuecher und Buecher als PDF.
#
#   bash scripts/build-pdfs.sh ?-de|-en? ?-index-terms auto|keywords|all? ?NAME ...?
#
#   -de / -en   nur diese Sprache (ohne: beide)
#   -index-terms M
#               Stichwoerter der Handbuecher, an createpdf durchgereicht
#               (Vorgabe auto: aus der Seite abgeleitet nur bei Seiten ohne
#               YAML-Kopf, etwa den Nemethi-Paketen; keywords: nur
#               Befehlsname und Keywords; all: bei allen Seiten ableiten)
#   NAME        nur diese PDFs (Namen aus scripts/katalog.tsv)
#
# Das Repository hat drei Gruppen, jede mit LANG-markdown/ und LANG-pdf/:
#
#   Tcl-family/   Tcl/Tk 9.0 und 8.6, tcllib, tklib, Pakete von Csaba Nemethi
#   Extensions/   Erweiterungen (TDBC, Thread, [incr Tcl], tDOM, expect ...)
#   Books/        Tclutils, pdf4tcl, pdf4tcllib (de und en)
#
# Welche PDFs es gibt, steht in scripts/katalog.tsv (gemeinsam mit
# scripts/pdfgui.tcl): Name, Art, Gruppe, Ordner, Teile, Sprachen, Titel.
#
# Ergebnis: GRUPPE/de-pdf/NAME-de.pdf und GRUPPE/en-pdf/NAME-en.pdf,
# Buecher als Books/LANG-pdf/NAME.pdf.
#
# Gesamtindex: Fuer die Tcl-Familie entsteht je Sprache zusaetzlich
# Tcl-family/LANG-pdf/tcl-family-index-LANG.pdf, ein Stichwortverzeichnis
# ueber alle ihre PDFs; jede Seitenzahl springt in das jeweilige PDF
# (scripts/createpdf/index-gesamt.tcl). Grundlage sind die Tabellen
# NAME-LANG.index.tsv neben den PDFs, die createpdf mitschreibt. Ein
# Teil-Index (z. B. nemethi-index) nimmt nur die Handbuecher aus seiner
# Spalte quelle, in dieser Reihenfolge; fehlt dort eine Tabelle, wird sie
# mit Meldung ausgelassen. Jeder Index (art index) wird gebaut, wenn alle
# PDFs gebaut werden oder sein Name genannt ist; er nimmt die vorhandenen
# Tabellen, darum nach jedem neuen PDF der Tcl-Familie mitbauen.
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
# ohne BOOKKIT werden die Buecher uebersprungen. Gebaut wird aus
# Books/LANG-markdown/ORDNER; dorthin kommt ein Buch von Hand oder mit
# „Seiten uebernehmen“ in pdfgui.tcl (README: Ein Buch aufnehmen).

cd "$(dirname "$0")/.." || exit 1
tclsh=${TCLSH:-tclsh}
sprachen="de en"
stichworte=
while [ $# -gt 0 ]; do
    case "$1" in
        -de) sprachen=de; shift ;;
        -en) sprachen=en; shift ;;
        -index-terms)
            case "$2" in
                auto|keywords|all) stichworte=$2; shift 2 ;;
                *) echo "-index-terms: auto, keywords oder all" >&2; exit 2 ;;
            esac ;;
        *) break ;;
    esac
done

# Die Liste der PDFs steht in scripts/katalog.tsv (Spalten dort erklaert),
# gemeinsam mit scripts/pdfgui.tcl. katalog gibt die Datenzeilen aus:
# ohne Kommentare, Leerzeilen und Kopfzeile, Felder mit Tabulator getrennt.
katalog() {
    local zeile
    while IFS= read -r zeile || [ -n "$zeile" ]; do
        zeile=${zeile%$'\r'}
        case $zeile in ''|'#'*|name$'\t'*) continue ;; esac
        printf '%s\n' "$zeile"
    done < scripts/katalog.tsv
}
[ -f scripts/katalog.tsv ] || { echo "scripts/katalog.tsv fehlt" >&2; exit 1; }

# Spalte quelle der Index-Zeilen pruefen: jeder Name ein Handbuch derselben
# Gruppe (wie scripts/katalog.tcl).
declare -A k_art k_gruppe
while IFS=$'\t' read -r name art gruppe _; do
    k_art[$name]=$art; k_gruppe[$name]=$gruppe
done < <(katalog)
while IFS=$'\t' read -r iname art igruppe _ _ _ iquelle _; do
    [ "$art" = index ] && [ "$iquelle" != - ] || continue
    gesehen=" "
    for q in ${iquelle//,/ }; do
        if [ -z "${k_art[$q]}" ]; then
            fehler="„$q“ steht nicht im Katalog"
        elif [ "${k_art[$q]}" != handbuch ]; then
            fehler="„$q“ ist kein Handbuch (art ${k_art[$q]})"
        elif [ "${k_gruppe[$q]}" != "$igruppe" ]; then
            fehler="„$q“ gehoert zur Gruppe ${k_gruppe[$q]}, nicht $igruppe"
        elif [[ $gesehen == *" $q "* ]]; then
            fehler="„$q“ doppelt genannt"
        else
            gesehen+="$q "
            continue
        fi
        echo "scripts/katalog.tsv: Index $iname: $fehler" >&2
        exit 1
    done
    if [ "$gesehen" = " " ]; then
        echo "scripts/katalog.tsv: Index $iname: keine Handbuecher in quelle" >&2
        exit 1
    fi
done < <(katalog)

# hat SPRACHEN (de,en) die Sprache LANG?
spricht() { case ",$1," in *",$2,"*) return 0 ;; esac; return 1; }

gewollt() {
    [ $# -gt 1 ] || return 0
    local name=$1; shift
    case " $* " in *" $name "*) return 0 ;; esac
    return 1
}

tmp=$(mktemp -d); trap 'rm -rf "$tmp"' EXIT
rc=0
for lang in $sprachen; do
    while IFS=$'\t' read -r name art gruppe ordner teile sprachen quelle tde ten; do
        [ "$art" = handbuch ] && spricht "$sprachen" "$lang" || continue
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
            titel=$tde
            extra=(-lang de -subtitle "$ude" -subject "$ude"
                   -note scripts/createpdf/uebersetzung-de.txt)
        else
            titel=$ten
            extra=(-lang en -subtitle "$uen" -subject "$uen"
                   -note scripts/createpdf/umwandlung-en.txt)
        fi
        mkdir -p "$gruppe/$lang-pdf"
        out=$gruppe/$lang-pdf/$name-$lang.pdf
        if [ "$gruppe" = Tcl-family ]; then
            extra+=(-index-tsv "${out%.pdf}.index.tsv")
        fi
        [ -n "$stichworte" ] && extra+=(-index-terms "$stichworte")
        echo "== $out ($(find "$w" -name '*.md' | wc -l) Seiten)"
        if ! "$tclsh" scripts/createpdf/createpdf.tcl "$w" -o "$out" \
                -title "$titel" "${extra[@]}" < /dev/null; then
            echo "$name ($lang): Fehler" >&2; rc=1
        fi
    done < <(katalog)

    # Index (art index) aus den Tabellen neben den PDFs: quelle "-" = alle
    # Handbuecher seiner Gruppe in der Reihenfolge des Katalogs (fehlende
    # Tabellen ohne Meldung, etwa die C-API deutsch), sonst die genannten
    # in deren Reihenfolge (fehlende mit Meldung)
    while IFS=$'\t' read -r iname art igruppe _ _ isprachen iquelle itde iten; do
        [ "$art" = index ] && spricht "$isprachen" "$lang" || continue
        gewollt "$iname" "$@" || continue
        tsvs=()
        if [ "$iquelle" = - ]; then
            while IFS=$'\t' read -r name art2 gruppe _; do
                [ "$art2" = handbuch ] && [ "$gruppe" = "$igruppe" ] || continue
                t=$igruppe/$lang-pdf/$name-$lang.index.tsv
                [ -f "$t" ] && tsvs+=("$t")
            done < <(katalog)
        else
            for name in ${iquelle//,/ }; do
                t=$igruppe/$lang-pdf/$name-$lang.index.tsv
                if [ -f "$t" ]; then
                    tsvs+=("$t")
                else
                    echo "$iname ($lang): $t fehlt, ausgelassen"
                fi
            done
        fi
        [ ${#tsvs[@]} -gt 0 ] || continue
        if [ "$lang" = de ]; then gtitel=$itde; else gtitel=$iten; fi
        out=$igruppe/$lang-pdf/$iname-$lang.pdf
        echo "== $out (${#tsvs[@]} Handbuecher)"
        if ! "$tclsh" scripts/createpdf/index-gesamt.tcl -pdf "$out" \
                -lang "$lang" -title "$gtitel" "${tsvs[@]}" < /dev/null; then
            echo "$iname ($lang): Fehler" >&2; rc=1
        fi
    done < <(katalog)

    while IFS=$'\t' read -r name art gruppe ordner _ sprachen _; do
        [ "$art" = buch ] && spricht "$sprachen" "$lang" || continue
        gewollt "$name" "$@" || continue
        src=$gruppe/$lang-markdown/$ordner
        [ -f "$src/book.tcl" ] || { echo "$name: kein $src/book.tcl, uebersprungen"; continue; }
        if [ -z "$BOOKKIT" ] || [ ! -f "$BOOKKIT/tools/book-build.tcl" ]; then
            echo "$name: BOOKKIT nicht gesetzt, uebersprungen"
            continue
        fi
        mkdir -p "$gruppe/$lang-pdf"
        out=$gruppe/$lang-pdf/$name.pdf
        echo "== $out (bookkit)"
        if ! "$tclsh" "$BOOKKIT/tools/book-build.tcl" "$src" -number -pdf "$out" < /dev/null; then
            echo "$name: Fehler" >&2; rc=1
        fi
    done < <(katalog)
done
exit $rc
