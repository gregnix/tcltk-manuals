# mdserver — Manual

*As of: 2026-11-16*

Manual for the HTTP service [mdserver]{.index} **0.5**: Markdown served
as HTML at request time, without Tk. With page layout `site`, full-text
search over Markdown and (with tclutils) PDFs, office and CSV files,
office and CSV files as a page, generated book landing pages, login with
rights per folder, a settings file and a GUI. Since 0.5 mdserver is a
repository of its own (up to 0.4 `mdstack/tools/mdserver/`); modules
`lib/mdserver-0.5.tm` and `lib/mdserver/*-0.5.tm`. The package
documentation is there under `doc/`.

This is the English edition. The German original is in `Mdserver-de/`
next to this directory; both have the same file names.

Tested with mdstack (parser 0.9.2, html 0.2), docir 0.1.1 (mdSource
0.2, html 0.2), tclutils 0.69.0, Tcl 8.6.14 and 9.0.4; tests
`test-mdserver-oo.tcl` (186) and `test-mdserver-gui.tcl` (18).

LXC, Samba, nginx and firewall: the textbook *Nginx* and the two LAN
books. This book is the program, as a manual (`booktype manual`, rules
in `bookkit/doc/STYLE.md`).

## Audience

- Those who start, check and stop the service
- Those who need options, HTTP behaviour and the control port
- Those who decide who may see what
- Those who build a site with books and manuals in the LAN

## Scope

`book.tcl`: **16** chapter files (12 chapters + 4 appendices).

## Building PDF and HTML

```bash
cd ../..
tclsh bookkit/tools/book-build.tcl book-mdserver/Mdserver-en/ -number
```

Written with the help of AI tools; text and examples are checked by the author.

## License

Documentation: [CC BY-SA 4.0](LICENSE). Code examples: [MIT](LICENSE).
