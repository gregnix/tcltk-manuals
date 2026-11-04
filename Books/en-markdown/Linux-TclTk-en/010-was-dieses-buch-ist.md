# What this book is

## Introduction

Tcl/Tk is at home on Linux: the distributions ship it as a package,
`wish` draws with the [X11]{.index} windowing system, and most Tcl
examples on the web silently assume Linux. Still, a Tcl program on a
Linux workstation behaves differently than on macOS or Windows in many
places: several interpreters sit side by side, paths follow
[XDG]{.index}, the encoding comes from the locale, a window manager
decides on focus and size, and there are two clipboards.

This book covers these particularities from the point of view of
Tcl/Tk development: the platform value, which Tcl is currently running,
paths and search paths of the distribution, encoding, `exec`, X11 and
window managers, fonts and scaling, mouse wheel and clipboard,
integration into the desktop, Xfce, GUI tests under Xvfb, the build
dependencies of Tk, and distribution.

It is a workshop book. The chapters show procedures and commands that
have been tried on Linux, with the output they produce, and with the
places where something did not go as expected. It assumes general
Tcl/Tk knowledge. It is not a Linux manual.

---

## What the examples work with

The examples use Tcl 8.6 from the distribution package and Tcl/Tk
9.0.4, self-built under `/opt/tcl9`, on Debian and Ubuntu with X11.
Where 8.6 and 9.0 differ, the text says so, likewise when a value only
holds with one window manager or only under Xfce.

The basis is five howto series by the author. `serie-linux`,
`serie-xvfb` and `serie-xfce` are published, in the repository
`tcltk-manuals` under [`Serien/`](https://github.com/gregnix/tcltk-manuals/tree/main/Serien); `serie-tcltk-bauen` and
`serie-tcl9-app` are not. Notes like "(`serie-linux`, howto 08)" name the script a
value was checked with. Each series has a
`README.md` with the checked values, a `TUTORIAL.md`, a short reference
`howto/00-referenz.md`, and for each howto an explanation `NN-*.md`
with a runnable demo `NN-*.tcl`. The demos check their own claims and
report OK, SKIP or FAIL.

| Series | Content | Chapters here |
|-------|--------|--------------|
| `serie-linux` | Paths, XDG, environment, `exec`, encoding, file system, `tcl_platform`, dialogs | 2, 4, 6, 7, 11 |
| `serie-xvfb` | Xvfb, window managers, focus, iconify, grab, tests without decorator (20 howtos) | 8, 13, 14 |
| `serie-xfce` | Xfce 4.20 from Tcl: xfconf, DBus, Thunar, `exo-open`, `notify-send` | 11, 12 |
| `serie-tcltk-bauen` | Build dependencies of Tk on Debian, `TK_LIBS`, `ldd` | 2, 3, 5, 15 |
| `serie-tcl9-app` | Programs with Tcl 9 and zipfs | 16 |

The book does not take over the howtos piece by piece. It arranges them
by topic, explains the context, and keeps the lines of code that
matter. When the series run as a whole, `SERIES_AUTO=1` is set; then
no demo opens a dialog, a browser or a notification window.

To check a claim yourself, use the scripts in `beispiele/` next to the
book folder, above all [`messprobe-linux.tcl`](810-anhang-cli.md),
which prints all values of the tables in this book.

Machines, exact versions and what has not been tested yet are listed in
[Appendix F: Test environment](860-anhang-testumgebung.md). Values from
the Ubuntu container are called "container check" in the text; there,
Xvfb runs without a window manager, without a desktop session and
without Xfce.

---

## How to read the book

Part 1 (chapters 1 to 7) explains the platform: `tcl_platform`, which
Tcl, paths and XDG, search paths, encoding and locale, `exec`. Part 2
(chapters 8 to 12) goes to the user interface: X11 and window managers,
fonts and scaling, mouse, keyboard and clipboard, dialogs and desktop,
Xfce. Part 3 (chapters 13 to 17) covers tests under Xvfb, the build
dependencies of Tk, distribution, and frequently asked questions.

The appendices are for reference: pitfalls (A), commands (B), glossary
(C), error messages (D), sources (E) and the test environment (F).
Appendix A is worth keeping open alongside while reading.

Other topics are in separate books of the same series: Debian as an
operating system in *Debian unter Linux* (this book describes the
interpreter on the distribution, that one the distribution), the
sister books *Tcl/Tk unter macOS* and *Tcl/Tk unter Windows*, building
Tcl/Tk yourself in *Tcl/Tk 9.0 bauen* and *Tcl/Tk 9.1 bauen*, kits,
zipfs, `.deb` and `.rpm` in *Tcl-Anwendungen ausliefern* (in the text
*Ausliefern* for short), C extensions in *Tcl-Erweiterungen*, packages
and modules in *Pakete und Module*.

---

*Next chapter: [tcl_platform and the distribution](020-tcl-platform-und-distribution.md)*
