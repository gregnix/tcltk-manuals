#!/bin/sh
# gui-test-xvfb.sh -- ein Tk-Testskript unter Xvfb laufen lassen
#
#   sh gui-test-xvfb.sh tests/all.tcl            ohne Fenstermanager
#   WM=openbox sh gui-test-xvfb.sh tests/all.tcl mit Fenstermanager
#   WISH=wish8.6 sh gui-test-xvfb.sh app-test.tcl
#
# Feste Bildschirmgröße und DPI, damit Pixelwerte reproduzierbar sind.
# Kapitel "GUI-Tests mit Xvfb".

set -eu
WISH=${WISH:-wish9.0}
SCREEN=${SCREEN:-1280x1024x24}
DPI=${DPI:-96}
test $# -ge 1 || { echo "Aufruf: $0 testskript.tcl" >&2; exit 2; }

if ! command -v xvfb-run >/dev/null 2>&1; then
    echo "SKIP: xvfb-run fehlt (Debian: apt install xvfb)"
    exit 0
fi

if [ -n "${WM:-}" ]; then
    # Fenstermanager im selben Display vorab starten; sleep gibt ihm
    # Zeit, sich anzumelden.
    exec xvfb-run -a -s "-screen 0 $SCREEN -dpi $DPI" \
        sh -c "$WM >/dev/null 2>&1 & sleep 1; $WISH \"\$@\"" sh "$@"
fi
exec xvfb-run -a -s "-screen 0 $SCREEN -dpi $DPI" "$WISH" "$@"
