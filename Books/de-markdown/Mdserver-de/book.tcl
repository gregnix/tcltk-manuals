# book.tcl -- mdserver, Handbuch (deutsch). Build (eine Ebene ueber dem Buchordner):
#   tclsh bookkit/tools/book-build.tcl Mdserver-de/ -number

set title     "mdserver — Handbuch"
set author    ""
set subtitle  "Markdown im LAN: HTTP, Seitenlayout, Suche, Control-Port"
set date      "2026-10-27"
set lang      "de"
set titlePage 1
set booktype  manual                 ;# Handbuch, siehe bookkit/doc/de/STYLE.md

set tocTitle   "Inhaltsverzeichnis"
set indexTitle "Stichwortverzeichnis"

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
