# book.tcl -- pdf4tcllib (bookkit, English)
#
# Build (from the folder that holds bookkit/):
#   tclsh bookkit/tools/book-build.tcl book-pdf4tcllib/pdf4tcllib-en/ -number

set title     "pdf4tcllib"
set author    ""
set subtitle  "Reports, tables and forms with pdf4tcl"
set date      "2026-10-26"
set lang      "en"
set titlePage 1
set booktype  workshop               ;# workshop book, see bookkit/doc/STYLE.md

set tocTitle   "Contents"
set indexTitle "Index"

set chapters {
    010-was-pdf4tcllib-ergaenzt.md
    020-einrichten-und-schriften.md
    030-unicode-sicher-ausgeben.md
    040-einheiten-und-seitenkontext.md
    050-text-setzen.md
    060-kopf-fuss-seitenzahlen.md
    070-spaltenfluss-wasserzeichen.md
    080-tabellen.md
    090-gruppen-und-kreuztabellen.md
    100-diagramme.md
    110-inhaltsverzeichnis.md
    120-formular-layout.md
    130-etikettenboegen.md
    140-bilder.md
    150-pfeile-und-callouts.md
    160-formeln.md
    170-treeview.md
    180-barrierefreie-pdfs.md
    190-grafikzustand.md
    200-messen-und-stapeln.md
    210-fallstudie-bericht.md
    800-anhang-fallen.md
    810-anhang-api.md
    820-anhang-glossar.md
    830-anhang-fehlermeldungen.md
}
