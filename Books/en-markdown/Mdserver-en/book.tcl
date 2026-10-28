# book.tcl -- mdserver, manual (English). Build (one level above the book directory):
#   tclsh bookkit/tools/book-build.tcl Mdserver-en/ -number

set title     "mdserver — Manual"
set author    ""
set subtitle  "Markdown in the LAN: HTTP, page layout, search, control port"
set date      "2026-10-27"
set lang      "en"
set titlePage 1
set booktype  manual                 ;# manual, see bookkit/doc/STYLE.md

set tocTitle   "Contents"
set indexTitle "Index"

set chapters {
    010-was-mdserver-ist.md
    020-starten.md
    030-optionen.md
    040-navigation-theme.md
    045-seitenlayout-und-suche.md
    050-http-verhalten.md
    060-control-port.md
    070-tls.md
    080-hinter-proxy.md
    090-site-aufbauen.md
    800-anhang-fallen.md
    810-anhang-cli.md
    820-anhang-glossar.md
    830-anhang-fehlermeldungen.md
}
