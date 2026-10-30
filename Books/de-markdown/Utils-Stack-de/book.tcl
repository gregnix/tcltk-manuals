# book.tcl -- Utils-Stack (bookkit). Build aus dem Ordner, in dem bookkit/ liegt:
#   tclsh bookkit/tools/book-build.tcl <buchordner>/Utils-Stack-de/ -number

set title     "Utils-Stack"
set author    ""
set subtitle  "tclutils · tkutils · ctrlutils · tical"
set date      "2026-10-28"
set lang      "de"
set titlePage 1
set booktype  manual                 ;# Handbuch, siehe bookkit/doc/de/STYLE.md

set tocTitle   "Inhaltsverzeichnis"
set indexTitle "Stichwortverzeichnis"

set chapters {
    010-stack-verstehen.md
    020-pairing-und-setup.md
    030-ctrlutils.md
    032-cufilter.md
    034-cumonitor.md
    036-cusync.md
    040-cufileops-und-undo.md
    050-explorer-und-dateiblick.md
    060-checkliste-app.md
    070-tical.md
    800-anhang-fallen.md
    810-anhang-module.md
    820-anhang-glossar.md
    830-anhang-fehlermeldungen.md
}
