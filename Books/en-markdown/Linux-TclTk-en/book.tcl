# book.tcl — Tcl/Tk on Linux (bookkit), English edition
#
# Build (from bibliothek/books/):
#   tclsh bookkit/tools/book-build.tcl book-linux-tcltk/Linux-TclTk-en/ -number

set title     "Tcl/Tk on Linux"
set author    "Gregor Ebbing"
set subtitle  "X11, XDG, locale, Xfce, tests under Xvfb"
set date      "stand"
set lang      "en"
set titlePage 1
set booktype  workshop               ;# workshop book, see bookkit/doc/STYLE.md

set tocTitle   "Contents"
set indexTitle "Index"

set chapters {
    010-was-dieses-buch-ist.md
    020-tcl-platform-und-distribution.md
    030-welches-tcl.md
    040-pfade-umgebung-xdg.md
    050-suchpfade.md
    060-kodierung-und-locale.md
    070-exec-und-prozesse.md
    080-x11-fenstermanager-wayland.md
    090-schriften-skalierung-themes.md
    100-maus-tastatur-zwischenablage.md
    110-dialoge-und-desktop.md
    120-xfce.md
    130-gui-tests-xvfb.md
    135-gui-tests-fenstermanager.md
    140-tk-bauen-abhaengigkeiten.md
    150-weitergeben.md
    160-faq.md
    800-anhang-fallen.md
    810-anhang-cli.md
    820-anhang-glossar.md
    830-anhang-fehlermeldungen.md
    850-anhang-quellen.md
    860-anhang-testumgebung.md
}
