# Tcl/Tk on Linux

*As of: 2026-11-03*

A workshop book on [Tcl/Tk]{.index} on Linux: platform values, several
interpreters, XDG, the distribution's search paths, encoding from the
locale, `exec`, X11 and window managers, fonts and scaling, mouse wheel
and clipboard, desktop integration, Xfce, GUI tests under Xvfb, build
dependencies and distribution.

This is the English edition. The German original is in
`Linux-TclTk-de/` next to this directory; both have the same file
names.

The examples use Tcl 8.6 from the distribution and Tcl/Tk 9.0.4 under
`/opt/tcl9`, on Debian and Ubuntu with X11 and Xfce 4.20. They are
based on five howto series by the author (`serie-linux`, `serie-xvfb`,
`serie-xfce`, `serie-tcltk-bauen`, `serie-tcl9-app`). The series are
not published; notes like "(`serie-linux`, howto 08)" name the script
a value was checked with. To check for yourself, use the scripts in
`beispiele/` that come with the book. Machines, versions and open
checks: Appendix F.

Important for readers coming from Tk 8.6: Tk 9 reports the mouse wheel
under X11 as `<MouseWheel>` and assigns `<Button-4>`/`<Button-5>` to
the side buttons 8 and 9; `<Command-c>` matches no key under Tk 9 on
X11; `file normalize ~` no longer expands the tilde under Tcl 9; `wish`
without a display exits with status 0.

Author: Gregor Ebbing. Text and scripts were written with the help of
Claude (Anthropic), and this English edition was translated from the
German original with Claude; text and examples are checked by the
author. The program output comes from the author's howto series and
from checks in an Ubuntu container. Sources: Appendix E.

## Audience

- Readers who separate Tcl/Tk code on Linux from macOS and Windows
- Anyone running a Tcl 9 under `/opt` next to the distribution's Tcl
- Anyone testing Tk interfaces under Xvfb in a pipeline

## Scope

`book.tcl` is the build truth: **23** chapter files (17 chapters + 6 appendices).

| Figure | Value |
|---|---|
| Main chapters | 17 |
| Appendices | 6 |
| **Total** | 23 Markdown files |
| Language | English (translated from German) |

## Structure

Chapters are flat files `NNN-*.md` (bookkit). Overview:
[`BUCHSTRUKTUR.md`](BUCHSTRUKTUR.md), build: [`BOOKKIT.md`](../BOOKKIT.md).

## Building PDF and HTML (bookkit)

```bash
cd ..
tclsh bookkit/tools/book-build.tcl book-linux-tcltk/Linux-TclTk-en/ -number
```

Output: `Linux-TclTk-en.pdf` / `.html` in `bibliothek/books/book-linux-tcltk/`.

## Suggested reading order

### Getting started

1. **Part 1** — platform, which Tcl, paths and XDG, search paths,
   encoding, `exec`
2. **Part 2** — X11 and window managers, fonts, mouse and keyboard,
   desktop, Xfce
3. **Part 3** — tests under Xvfb, build dependencies, distributing, FAQ

### Appendices

1. **Appendix A (Pitfalls)**: keep it open alongside
2. **Appendix B (CLI)**: check script and results of the series in the
   container
3. **Appendix F (Test environment)**: what the examples were tried on
   and what is still open

## Trademarks

Linux® is the registered trademark of Linus Torvalds in the U.S. and
other countries. Debian is a registered trademark owned by Software in
the Public Interest, Inc. Ubuntu is a trademark of Canonical Ltd. Xfce
is the name of its project. This book is not affiliated with them.

## License

Documentation: [CC BY-SA 4.0](LICENSE)
Code examples: [MIT](LICENSE)

## Contributing

Corrections and additions are welcome — see [CONTRIBUTING.md](CONTRIBUTING.md).

## Style

- **Workshop book** (`booktype workshop`, rules: `bookkit/doc/STYLE.md`)
- **Imperative and impersonal** — the reader is not addressed directly
- Cross-references to other chapters and appendices

## Related works (German)

The following books exist in German only; the English edition keeps
their titles.

- *Debian unter Linux* — chapter Tcl unter Linux
- *Tcl/Tk unter macOS* — sister book
- *Windows 11* — chapter Tcl unter Windows
- *Tcl/Tk 9.0 bauen*, *Tcl/Tk 9.1 bauen* — chapter Unix
- *Tcl-Anwendungen ausliefern* (in the text *Ausliefern*) — chapters
  zipfs, Zipkits, Linux: deb und rpm
- *C-Erweiterungen*
