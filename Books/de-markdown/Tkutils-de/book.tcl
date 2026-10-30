# book.tcl — tkutils (bookkit)
#
# Build (im Ordner mit bookkit/):
#   tclsh bookkit/tools/book-build.tcl book-tkutils/Tkutils-de/ -number

set title     "tkutils"
set author    ""
set subtitle  "Tk-Widgets auf tclutils, 0.49.0"
set date      "2026-10-27"
set lang      "de"
set titlePage 1
set booktype  manual                 ;# Handbuch, siehe bookkit/doc/de/STYLE.md

set tocTitle   "Inhaltsverzeichnis"
set indexTitle "Stichwortverzeichnis"

set chapters {
    010-tkutils-verstehen.md
    020-installation.md
    030-dialoge.md
    040-datei-widgets.md
    050-listen-und-tablelist.md
    052-tablelist-helfer.md
    060-geometry-und-units.md
    070-aktionen-und-layout.md
    072-geruest.md
    074-eingabe.md
    076-kalender-und-notizen.md
    078-daten-ansehen.md
    080-designer-und-load.md
    082-bilder.md
    085-tkdevtools.md
    090-grenzen.md
    800-anhang-fallen.md
    810-anhang-widgets.md
    820-anhang-glossar.md
    830-anhang-fehlermeldungen.md
    840-api-katalog.md
    850-praxis-und-fehlerfaelle.md
    860-anhang-testumgebung.md
}
