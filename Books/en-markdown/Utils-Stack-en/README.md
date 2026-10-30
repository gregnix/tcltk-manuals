# Utils-Stack

*As of: 2026-10-28*

Manual for the **pairing** of [tclutils]{.index} **0.69.0**,
[tkutils]{.index} **0.49.0** and [ctrlutils]{.index} **0.4**: model / view /
controller, setup of all three libraries, tests, the five controllers,
Explorer and Dateiblick. Plus the calendar engine [tical]{.index} **1.1**,
on which two optional calendar widgets of tkutils are built. The
ctrlutils 0.5 umbrella contains `cufileops` 0.6, `cuundo` 0.5,
`cusync` 0.3 and `cufilter` 0.2.

This is the English edition. The German original is in `Utils-Stack-de/`
next to this directory; both have the same file names.

Examples and test suites checked with Tcl/Tk 8.6.14 and 9.0.4 on Linux
(Xvfb); on macOS and Windows only the test suites.

API books alongside: *tclutils* and *tkutils*. This book does not change
library code, nor the Explorer under `ctrlutils/apps/explorer/`.

## Audience

- Anyone wiring up a file or provider app
- Anyone who needs ctrlutils (5 modules) in context rather than as a
  book of its own
- Anyone adding a calendar with tical to a stack application

## Scope

`book.tcl`: **14** chapter files (10 chapters + 4 appendices). Book type:
manual (`booktype manual`, rules in `bookkit/doc/STYLE.md`).

## Building PDF and HTML

From the folder that holds `bookkit/`:

```bash
tclsh bookkit/tools/book-build.tcl <bookfolder>/Utils-Stack-en/ -number
```

Written with the help of AI tools; text and examples are checked by the author.

## License

Documentation: [CC BY-SA 4.0](LICENSE). Examples: [MIT](LICENSE).
Libraries: MIT (upstream).
