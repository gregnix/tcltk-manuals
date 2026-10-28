# tkutils

*As of: 2026-10-27*

Manual for [tkutils]{.index} **0.48.0**: Tk widgets on top of the engines
in tclutils. Dialogs, file list, tablelist and its helpers, geometry,
actions, scaffolding, input, calendar and notes, data views, designer,
images and the tkdevtools app.

Pairing: tclutils **0.68.0** + tkutils **0.48.0** + ctrlutils **0.4**
(at least tclutils 0.64.0). Version 0.68.0 requires nothing new from
tkutils.

Related books: the engines are covered by the book *tclutils*, the stack,
controllers and tical by the book *Utils-Stack*, Tk basics without
tkutils by the German book on Tcl/Tk user interfaces. This book does not
change the module code.

Checked against tkutils 0.48.0 with Tcl/Tk 8.6.14 and 9.0.4 on Linux
under Xvfb. Windows and macOS are not checked; environment and open
points: Appendix G.

This is the English edition. The German original is in `Tkutils-de/`
next to this directory; both have the same file names.

## Audience

- Desktop apps built on providers and ttk
- Anyone who wants to reuse dialogs and file widgets

## Scope

`book.tcl`: **23** chapter files (16 chapters + 7 appendices). Book type:
manual (`booktype manual`, rules in `bookkit/doc/STYLE.md`).

## Building PDF and HTML

```bash
cd ../..
tclsh bookkit/tools/book-build.tcl book-tkutils/Tkutils-en/ -number
```

Written with the help of AI tools; text and examples are checked by the author.

## License

Documentation: [CC BY-SA 4.0](LICENSE). Examples: [MIT](LICENSE).
tkutils itself: MIT (upstream).
