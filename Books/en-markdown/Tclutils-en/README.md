# tclutils

*As of: 2026-10-27*

Manual for [tclutils]{.index} **0.69.0**: pure-Tcl modules without Tk —
text filters, characters and paths, data formats, TDBC, PDF text, ODF, providers,
HTTPS policy, settings, tasks (`tutask`), test runner.

This is the English edition. The German original is in `Tclutils-de/`
next to this directory; both have the same file names.

Pairing: tclutils **0.69.0** + tkutils **0.49.0** + ctrlutils **0.5**.
Widgets: book *tkutils*. Stack and controllers: book *Utils-Stack*.

This book does not change the module code. API details: `docs/<modul>.md` in the
tclutils tree.

## Audience

- Servers, CLI and CI without Tk
- Apps that use the engines underneath tkutils/ctrlutils

## Scope

`book.tcl`: **29** chapter files (23 chapters + 6 appendices). Book type: manual
(`booktype manual`, rules in `bookkit/doc/STYLE.md`).

## Building PDF and HTML

```bash
cd ../..
tclsh bookkit/tools/book-build.tcl book-tclutils/Tclutils-en/ -number
```

Written with the help of AI tools; text and examples are checked by the author.

## License

Documentation: [CC BY-SA 4.0](LICENSE). Examples: [MIT](LICENSE).
tclutils itself: MIT (upstream).
