# Installation

tclutils is a tree of Tcl modules under `lib/tm/`. Tcl loads a
`.tm` file only if its directory is on the [module path]{.index}.
`lappend auto_path` is not enough for that.

---

## Adding a directory

```tcl
::tcl::tm::path add /pfad/zu/tclutils-0.68.0/lib/tm
package require tclutils                 ;# -> 0.68.0
package require tclutils::tucsv          ;# ein Modul, der Umbrella ist nicht nötig
```

`package require` returns the package version. If the package is missing, it
aborts with `can't find package tclutils::gibt-es-nicht`. A directory
that does not exist is not added by `setup.tcl`. The error only appears
at `package require`.

---

## setup.tcl

`tools/setup.tcl` is identical in tclutils and in tkutils. Sourcing it
once adds the existing `lib/tm` of both libraries:

```tcl
source /pfad/zu/tclutils/tools/setup.tcl
package require tclutils::tubin
```

The candidates are listed in `tools/setup.tcl` in this order. Only
directories that exist and are not yet on the module path
are added. They are added from back to front, so that the
first existing candidate ends up in front and wins:

| # | Candidate |
|---|---|
| 1 | `TCLUTILS_TM` or `TKUTILS_TM`, if the variable is set and not empty |
| 2 | `lib/tm` of the tree that `setup.tcl` comes from |
| 3 | next to the Tcl library: `[file dirname [info library]]/<paket>/lib/tm` |
| 4 | `/usr/local/share/tcltk/<paket>/lib/tm` |
| 5 | `$XDG_DATA_HOME/tcltk/<paket>/lib/tm`, otherwise `~/.local/share/tcltk/<paket>/lib/tm` |
| 6 | sibling folder `<paket>/lib/tm` next to the tree |
| 7 | `<paket>-*/lib/tm`, the highest version that has a `lib/tm` |

If `TCLUTILS_TM` is set, `package ifneeded tclutils 0.68.0` comes from
that directory, even if the source tree lies next to it. As soon as
installation and tree diverge, the variable decides, not
the proximity to the script.

Details of the search: `tools/setup.md`. What `.tm` is in general: the book
*Packages and Modules*.

---

## Which file is loaded

```bash
export TCLUTILS_TM=/pfad/zu/tclutils/lib/tm
tclsh8.6 tests/all.tcl
```

The runner writes into its banner which umbrella file `tclutils`
resolves to. It looks up the path; it does not load it at this point.

```text
Modules resolve to:
  tclutils   0.68.0   …/tclutils/lib/tm/tclutils-0.68.0.tm
```

If the same version lies
once more further back on the module path, the front one wins.
Which copies exist is shown by `tupkgfinder` in the chapter
[Tests and tutestrun](090-tests-und-tutestrun.md).

---

## In short

- Module path: `tcl::tm::path add …/lib/tm`, or `setup.tcl` once.
- `TCLUTILS_TM` comes before the tree that `setup.tcl` comes from.
- `package require tclutils` loads the umbrella. A single module works without it.
- A missing package is reported only by `package require`.

---

*Next chapter: [Umbrella and Modules](030-umbrella-und-module.md)*
