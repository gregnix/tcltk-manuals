# Test Environment

## Introduction

This appendix names the environment used to check the statements of the
book, the behavior of older versions and the points that are not yet
checked.

---

## Environment

| What | Version |
|---|---|
| System | Linux, GUI under Xvfb without a window manager, screen 1280×1024 |
| Tcl/Tk 8.6 | 8.6.14 with tDOM 0.9.3, sqlite3 3.45.1, tklib 0.8 (Tablelist 6.20, scrollutil 1.17), Img 1.4.16; without tksvg |
| Tcl/Tk 9 | 9.0.4 with tDOM 0.9.7, sqlite3 3.53.0, Tablelist 7.11, scrollutil 2.10, Img 2.1.1 |
| tkutils | 0.48.0 |
| tclutils | 0.68.0 |
| ctrlutils | 0.4 |
| tical | 1.1, through `TICAL_DIR` or a sibling folder |

The results of the test suite are in [Installation](020-installation.md),
section *Test Run*. For the run, tclutils, tkutils and tical lie side by
side as sibling folders; `TCLUTILS_TM`, `TKUTILS_TM` and `TICAL_DIR`
point to these trees.

Check scripts: every example with an output `;# -> …` runs under
`xvfb-run -a tclsh8.6` and `xvfb-run -a tclsh9.0`, with the modules from
`tcl::tm::path add <tclutils>/lib/tm <tkutils>/lib/tm`.

`tkulauncher-9.4` (mouse wheel in scroll mode) was unstable up to
`tkulauncher` 0.2: the buttons got the wheel binding only through a
later event, and after `reload` not at all. Since 0.3 the launcher binds
the buttons when it creates them; `tkulauncher-9.5` checks the case
after `reload`.

---

## Older Versions

### Test Suite 0.46.0

Tcl/Tk 8.6.14, Linux, Xvfb, tclutils 0.65.0, tkutils 0.46.0 (commit
`401ebde`), tklib 0.8, tDOM 0.9.3, sqlite3 3.45.1, without tksvg: 78
test files, 837 tests, 811 passed, 25 skipped, 1 failed.

- The failure was `tkulauncher-9.4` (mouse wheel in scroll mode). It
  could not be reproduced afterwards, not even in the unchanged tree
  (837 tests, 0 failures under 8.6.14 and 9.0.4); `tkulauncher.test`
  alone passed with 99 of 99 tests. The cause is fixed in `tkulauncher`
  0.3 (section *Environment*).
- Skipped were, among others, all 13 tests of `tkumonthcanvas.test` and
  7 SVG tests of `tkuwinico.test`.
- 0.47.0 added `tkufiledialog-1.4a` (double click),
  `tkutltools-2.1`/`-2.2` (both load orders with `tablelist_tile`) and
  `tkuform-3.7` (option error); the first three fail with the code of
  0.46.0.

**Without a display.** In 0.46.0, `stack.test`, `tkumdview.test`,
`tkupdfinspect.test` and `tkuwinico.test` abort on loading without
`DISPLAY`, write no summary, and the run ends with exit code 1. Remedy:
always start the suite under Xvfb or with a display.

**tical.** `tkumonthcanvas.test` from 0.46.0 looks only for
`tical*/tical` without `TICAL_DIR` and skips all 13 tests in a flat
checkout. Remedy: set `TICAL_DIR=/pfad/zu/tical`; then 13 of 13 pass.

### Two Tablelist Variants up to 0.46.0

`tkutablelist` loads `tablelist_tile` first and `Tablelist` only when
that is missing. The `tkutl*` helpers, in contrast, load `tablelist`.
With Tablelist 6.20 from tklib 0.8, `package require tkutils::tkutltools`
(and `tkutlsort` alone) therefore fails after `package require tkutils`
with

```text
can't set "usingTile": it is not supported to use both Tablelist and Tablelist_tile in the same application
```

Remedy: `package require tablelist` (or `tkutils::tkutltools`)
**before** the umbrella. Then `tkutablelist` takes the non-ttk variant,
and both families run together.

### tkufiledialog 0.1 (tkutils 0.46.0)

Dialog operated programmatically in each case (Tcl/Tk 8.6.14, Linux,
Xvfb):

| Operation | Result |
|---|---|
| type the name `a.txt`, Return | full path to `a.txt` |
| Escape | `""` |
| `save -initialfile bericht -defaultextension .txt`, *OK* | `…/bericht.txt` |
| `directory`, *OK* without selection | the start folder |
| double-click handler on file `a.txt` | `""` |

The last case is a bug in the code of 0.46.0: the double click on a file
enters the name and closes with *OK*, but does not set the return value.
Remedy: select the file and use *OK* or Return. Fixed in 0.47.0
(`tkufiledialog` 0.2).

---

## Not Yet Checked

| Chapter | open |
|---|---|
| all | Windows and macOS |
| [Dialogs](030-dialoge.md) | appearance, focus and placement on a real screen |
| [File Widgets](040-datei-widgets.md) | navigation of a file manager with Windows paths |
| [Geometry and Units](060-geometry-und-units.md) | configuration folder on Windows and macOS; several monitors; zoom state (Xvfb without a window manager has none) |
| [Actions and Layout](070-aktionen-und-layout.md) | starting `app` entries on Windows (only read in the code) |
| [Designer and load](080-designer-und-load.md) | the app Dateiblick (code not in tclutils, tkutils or ctrlutils) |
| [tkdevtools](085-tkdevtools.md) | display of the encoding profiles under Tcl 9; font aliases on Windows |

A result for one of these points belongs in the respective chapter and
is removed here.
