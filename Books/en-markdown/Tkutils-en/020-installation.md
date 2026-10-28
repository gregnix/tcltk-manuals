# Installation

## Paths

tkutils needs tclutils on the module path, plus Tablelist from tklib (for
the umbrella and all table widgets). The usual way is the bootstrap
`tools/setup.tcl`:

```tcl
source /pfad/zu/tkutils/tools/setup.tcl
package require tkutils
package require tkutils::tkudialog 0.3
```

`setup.tcl` is identical in tclutils and tkutils (`diff` shows no
difference); it does not matter which copy you source — both trees are
registered. The search order is as follows; only existing paths are
added:

1. `TCLUTILS_TM` / `TKUTILS_TM` (override, wins)
2. `lib/tm` of its own tree
3. next to the Tcl installation (`<tcl-lib>/<paket>/lib/tm`)
4. `/usr/local/share/tcltk/<paket>/lib/tm`
5. `$XDG_DATA_HOME/tcltk/<paket>/lib/tm`, otherwise
   `$HOME/.local/share/tcltk/<paket>/lib/tm`
6. sibling folder `<paket>/lib/tm`, then `<paket>-*/lib/tm` (highest
   version)

Without `setup.tcl`, add the trees yourself:

```tcl
tcl::tm::path add /pfad/zu/tclutils/lib/tm /pfad/zu/tkutils/lib/tm
package require tkutils::tkudialog 0.3
```

If only the tclutils tree is missing, modules that need an engine fail,
for example `tkugeometry` with `can't find package tclutils::common 0.1`.

### Copying Over an Older Tree

The umbrella of 0.48.0 is `lib/tm/tkutils-0.48.0.tm`. New module
versions in 0.48.0: `tkulauncher` and `tkuload` 0.3; in 0.47.0:
`tkufiledialog` 0.2; `tkutlsort`, `tkutlclip`, `tkutlfind`, `tkutltree`,
`tkutltools` 0.2; `tkutlfooter`, `tkutlfmt`, `tkutlstate` 0.3. Anyone
copying 0.48.0 over an older tree deletes the old files first, otherwise
two versions sit side by side.

Over a 0.47.0 tree:

- `lib/tm/tkutils-0.47.0.tm`
- `lib/tm/tkutils/tkulauncher-0.2.tm`, `tkuload-0.2.tm`

Over a 0.46.0 tree, the file `lib/tm/tkutils-0.46.0.tm` instead of
`tkutils-0.47.0.tm`, plus in `lib/tm/tkutils/`:

- `tkufiledialog-0.1.tm`
- `tkutlclip-0.1.tm`, `tkutlfind-0.1.tm`, `tkutlsort-0.1.tm`,
  `tkutltools-0.1.tm`, `tkutltree-0.1.tm`
- `tkutlfmt-0.2.tm`, `tkutlfooter-0.2.tm`, `tkutlstate-0.2.tm`
- `tkulauncher-0.2.tm`, `tkuload-0.2.tm`

The lists come from comparing the trees of 0.46.0, 0.47.0 and 0.48.0.

---

## The Environment Variables

Tcl does **not** read [TCLUTILS_TM]{.index} and `TKUTILS_TM` itself. They
take effect only where code evaluates them explicitly:

- `tools/setup.tcl` and with it the bundled apps (through
  `apps/_lib/paths.tcl`),
- `tkuload` on the first `build` (adds both paths with
  `tcl::tm::path add`),
- `tests/all.tcl`: `TCLUTILS_TM` helps to find the runner; the runner
  itself puts the trees from `TKUTILS_TM` and `TCLUTILS_TM` in front,
- the individual test files (`TKUTILS_TM`).

A script of your own that only calls `package require tkutils` finds
nothing despite the variables being set and reports
`can't find package tkutils`.

```bash
export TCLUTILS_TM=/pfad/zu/tclutils/lib/tm
export TKUTILS_TM=/pfad/zu/tkutils/lib/tm
```

Set them when a particular working tree should take precedence over an
installation — in CI, for example.

---

## Tests

```bash
xvfb-run -a tclsh tests/all.tcl
xvfb-run -a tclsh tests/all.tcl -match 'tkuunits-*'
```

The runner is [tutestrun]{.index} from tclutils (`::tclutils::tutestrun`,
since tclutils 0.64.0). `all.tcl` looks for it in its own tree, in
`TCLUTILS_TM` and in the sibling checkout `tclutils*`, never in an
installation. If it is missing, `all.tcl` ends with exit code 2 and the
message `all.tcl: tclutils::tutestrun not found (set TCLUTILS_TM)`.

- Every `tests/*.test` runs in a process of its own.
- The banner `Modules resolve to:` shows which files tkutils and
  tclutils were loaded from and names any path variables that are set.
- Limit per file: `TKUTILS_TESTGRENZE` in seconds, default 120.
- Further arguments go to tcltest (`-match`, `-skip`, …).
- Exit code 1 when a file reports failures, writes no summary, crashes
  or hangs. These files are listed at the end under
  `Files with problems:`.

Run it with `tclsh`, not with `wish`. GUI tests carry the constraint
`haveTk`; without a display they are skipped. `stack.test`,
`tkumdview.test`, `tkupdfinspect.test` and `tkuwinico.test` too report
`<datei>.test: no display, all tests skipped` without a display, and a
summary with 0 failures.

Tests for modules whose third-party package is missing (tDOM, sqlite3,
Tablelist, tical) are skipped. The tests look for tical through
`TICAL_DIR` or a sibling folder. `tkutical.test` finds a folder `tical`
next to `tkutils`. `tkumonthcanvas.test`, like `tkutical.test`, also
finds the flat checkout; without `TICAL_DIR`, 13 of 13 tests pass there.

### Test Run

tkutils 0.48.0 on Linux (Xvfb) with tclutils 0.68.0, tical 1.1 and
`TICAL_DIR` set; Tablelist 6.20 under Tcl/Tk 8.6.14, 7.11 under 9.0.4:

| Tcl/Tk | Files | Tests | passed | skipped | failed |
|---|---|---|---|---|---|
| 8.6.14 | 78 | 843 | 831 | 12 | 0 |
| 9.0.4 | 78 | 843 | 840 | 3 | 0 |

Under 8.6.14 the suite skips the SVG tests of `tkuicon` and `tkuwinico`
(no tksvg), plus one test each of `tkuscrolledframe` and `tkuwheel`. The
suite is not checked on Windows or macOS. Environment and results of
0.46.0: [Appendix G](860-anhang-testumgebung.md).

---

## Summary

- Source `setup.tcl` or use `tcl::tm::path add` for both trees.
- `TCLUTILS_TM`/`TKUTILS_TM` work only through setup.tcl, apps, tkuload
  and the test run.
- Tests: `xvfb-run -a tclsh tests/all.tcl`; without a display, GUI tests
  are skipped.
- When copying over an older tree, delete the old `.tm` files.

---

*Next chapter: [Dialogs](030-dialoge.md)*
