#!/bin/bash
# hole-lizenzen.sh -- Lizenztexte der Originalpakete neben die Seiten legen,
# damit createpdf sie ins Lizenzkapitel nimmt.
#
#   bash scripts/hole-lizenzen.sh FOSSILDIR ?NEMETHIDIR?
#
# FOSSILDIR   Ordner mit den Fossil-Klonen (NAME.fossil oder
#             NAME_source_code.fossil), wie fuer tools/hole-quellen.sh in
#             tcltk-manual-de: fossil clone https://core.tcl-lang.org/NAME
# NEMETHIDIR  Ordner mit den ausgepackten Distributionen von Csaba Nemethi
#             (tablelist7.12/, mentry4.5.1/, scrollutil2.11/, wcb4.2/,
#             tsw1.5/); darin COPYRIGHT.txt. Optional: liegt COPYRIGHT.txt
#             schon in Tcl-family/LANG-markdown/pakete/*, wird
#             nichts gebraucht.
#
# Fuer jedes Paket der Liste wird im Fossil-Repository (Zweig trunk bzw. der
# Zweig aus der Liste) die erste vorhandene Datei aus license.terms,
# LICENSE.TERMS (mpexpr), LICENSE,
# LICENSE.txt, license.txt, COPYING genommen und als license.terms in
# GRUPPE/en-markdown/... und GRUPPE/de-markdown/... gelegt (nur in Ordner,
# die es gibt).
# Was nicht gefunden wird, steht am Ende in der Liste "fehlt"; dann den
# Lizenztext von Hand als license.terms in den Ordner legen.
#
# Schon vorhanden (aus den GitHub-Spiegeln von tcltk/*, tDOM/tdom und der
# SPDX-Lizenzliste): Tcl/Tk 8.6 und 9.0, tcllib, tklib, thread, tdbc und
# Treiber, bwidget, tdom (mit MPL-1.1-Volltext), tclws, itcl, itk. Mit
# FOSSILDIR werden auch diese aus den Klonen erneuert.

fdir=${1:?Aufruf: bash scripts/hole-lizenzen.sh FOSSILDIR ?NEMETHIDIR?}
ndir=$2
# Pfade absolut machen, bevor das Skript ins Repo wechselt (sonst passt ein
# relativer Pfad wie ../../fossil nicht mehr)
fdir=$(cd "$fdir" && pwd) || { echo "kein Ordner: $1" >&2; exit 1; }
if [ -n "$ndir" ]; then ndir=$(cd "$ndir" && pwd) || { echo "kein Ordner: $2" >&2; exit 1; }; fi
cd "$(dirname "$0")/.." || exit 1
command -v fossil >/dev/null || { echo "fossil fehlt im PATH" >&2; exit 1; }

# Ordner (Gruppe/Ordner unter Gruppe/LANG-markdown/)   Repo       Zweig
LISTE='
Tcl-family/9.0/tcl                 tcl            core-9-0-branch
Tcl-family/9.0/tcl-c               tcl            core-9-0-branch
Tcl-family/9.0/tk                  tk             core-9-0-branch
Tcl-family/9.0/tk-c                tk             core-9-0-branch
Tcl-family/8.6/tcl                 tcl            core-8-6-branch
Tcl-family/8.6/tcl-c               tcl            core-8-6-branch
Tcl-family/8.6/tk                  tk             core-8-6-branch
Tcl-family/8.6/tk-c                tk             core-8-6-branch
Tcl-family/tcllib                  tcllib         trunk
Tcl-family/tklib                   tklib          trunk
Extensions/thread                  thread         trunk
Extensions/tdbc                    tdbc           trunk
Extensions/tdbc-c                  tdbc           trunk
Extensions/tdbcsqlite3             tdbcsqlite3    trunk
Extensions/tdbcmysql               tdbcmysql      trunk
Extensions/tdbcodbc                tdbcodbc       trunk
Extensions/tdbcpostgres            tdbcpostgres   trunk
Extensions/itcl                    itcl           trunk
Extensions/itcl-c                  itcl           trunk
Extensions/itk                     itk            trunk
Extensions/bwidget                 bwidget        trunk
Extensions/tclws                   tclws          trunk
Extensions/tcltls                  tcltls         trunk
Extensions/tclvfs                  tclvfs         trunk
Extensions/tcludp                  tcludp         trunk
Extensions/tclhttpd                tclhttpd       trunk
Extensions/expect                  expect         trunk
Extensions/mpexpr                  mpexpr         trunk
Extensions/mclistbox               mclistbox      trunk
'
# tdom fehlt hier mit Absicht: seine LICENSE verweist nur auf die MPL 1.1;
# im Repo liegt Extensions/LANG-markdown/tdom/LICENSE mit dem MPL-Volltext
# dahinter.

tmp=$(mktemp); trap 'rm -f "$tmp"' EXIT
fehlt=()
while read -r ordner repo zweig; do
    [ -n "$ordner" ] || continue
    ziele=()
    gruppe=${ordner%%/*}; rest=${ordner#*/}
    for lang in en de; do
        d=$gruppe/$lang-markdown/$rest
        [ -d "$d" ] && ziele+=("$d")
    done
    [ ${#ziele[@]} -gt 0 ] || continue
    r=""
    for f in "$fdir/$repo.fossil" "$fdir/${repo}_source_code.fossil"; do [ -f "$f" ] && { r=$f; break; }; done
    if [ -z "$r" ]; then
        [ -f "${ziele[0]}/license.terms" ] || [ -f "${ziele[0]}/LICENSE" ] || [ -f "${ziele[0]}/LICENSE.txt" ] \
            || fehlt+=("$ordner (kein $repo.fossil)")
        continue
    fi
    ok=""
    for n in license.terms LICENSE.TERMS LICENSE LICENSE.txt license.txt COPYING; do
        if fossil cat -R "$r" -r "$zweig" "$n" >"$tmp" 2>/dev/null && [ -s "$tmp" ]; then
            ok=$n; break
        fi
    done
    if [ -z "$ok" ]; then fehlt+=("$ordner ($repo: keine Lizenzdatei)"); continue; fi
    for z in "${ziele[@]}"; do cp "$tmp" "$z/license.terms"; done
    echo "$ordner: $repo/$ok"
done <<< "$LISTE"

if [ -n "$ndir" ]; then
    for p in tablelist mentry scrollutil wcb tsw; do
        src=$(ls -d "$ndir"/$p[0-9]*/COPYRIGHT.txt 2>/dev/null | sort -V | tail -1)
        if [ -z "$src" ]; then fehlt+=("pakete/$p (kein COPYRIGHT.txt unter $ndir)"); continue; fi
        for lang in en de; do
            d=Tcl-family/$lang-markdown/pakete/$p
            [ -d "$d" ] && cp "$src" "$d/COPYRIGHT.txt"
        done
        echo "pakete/$p: $src"
    done
else
    # ohne NEMETHIDIR: nur melden, was noch fehlt
    for p in tablelist mentry scrollutil wcb tsw; do
        for lang in en de; do
            d=Tcl-family/$lang-markdown/pakete/$p
            [ -d "$d" ] && [ ! -f "$d/COPYRIGHT.txt" ] && fehlt+=("$d (kein COPYRIGHT.txt; NEMETHIDIR angeben)")
        done
    done
fi

if [ ${#fehlt[@]} -gt 0 ]; then
    echo; echo "fehlt:"; printf '  %s\n' "${fehlt[@]}"; exit 1
fi
