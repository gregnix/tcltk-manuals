# book.tcl — tclutils (bookkit)
#
# Build (aus bibliothek/books/):
#   tclsh bookkit/tools/book-build.tcl book-tclutils/Tclutils-de/ -number

set title     "tclutils"
set author    ""
set subtitle  "Pure-Tcl Engines, 0.68.0"
set date      "2026"
set lang      "de"
set titlePage 1
set booktype  manual                 ;# Handbuch, siehe bookkit/doc/de/STYLE.md

set tocTitle   "Inhaltsverzeichnis"
set indexTitle "Stichwortverzeichnis"

set chapters {
    010-tclutils-verstehen.md
    020-installation.md
    030-umbrella-und-module.md
    040-text-und-dateien.md
    042-zeilenfilter.md
    043-zusammenfuehren-und-ablaeufe.md
    045-zeichen-zahlen-datum.md
    050-datenformate.md
    051-tdbc-und-mmdb.md
    052-kodierung-hash-vergleich.md
    053-binaerdaten-und-dateiinfo.md
    054-notizen-und-kalender.md
    055-pdf-text.md
    057-odf-und-pdf-struktur.md
    056-diagramme.md
    058-bilder-ohne-tk.md
    060-provider.md
    062-anwendungsbausteine.md
    070-netz-und-https.md
    080-tusettings.md
    085-tutask.md
    090-tests-und-tutestrun.md
    100-grenzen.md
    800-anhang-fallen.md
    810-anhang-module.md
    820-anhang-glossar.md
    830-anhang-fehlermeldungen.md
    840-api-katalog.md
    850-praxis-und-fehlerfaelle.md
}
