# Understanding tkutils

## Introduction

[tkutils]{.index} provides Tk widgets and dialogs: dialogs, file list
and tree, file dialog, tablelist, geometry, units, actions, launcher,
designer slots and the tkdevtools app. The engines stay in
[tclutils]{.index}, so servers and CI do not need Tk. The code names
Tcl/Tk **8.6** and **9.x**.

This manual describes tkutils **0.49.0** for desktop applications built
on providers and ttk. The examples and the test suite run with Tcl/Tk
8.6.14 and 9.0.4 on Linux (Xvfb). The book is not checked on Windows or
macOS.

Recommended pairing: tclutils **0.69.0** + tkutils **0.49.0** + ctrlutils
**0.4**. The CSV export of `tkutablelist` 0.5 (`toCsv`, `saveCsv`) needs
`tclutils::tucsv` 0.2 from tclutils 0.69.0.
Otherwise tkutils 0.49.0 needs at least tclutils **0.64.0**: only that version
brings `tusettings` (for `tkugeometry`), `tutestrun` (test runner) and
the functions tkdevtools needs.

---

## Role

| Piece | Role |
|---|---|
| Prefix | package `tkutils::tku<name>`, namespace `::tkutils::tku<name>` |
| Layer | view |
| Rule | engine in tclutils, GUI here |
| Loading | `package require tkutils` or a single module |

Every module is a package `tkutils::tku<name>` in
`lib/tm/tkutils/tku<name>-<version>.tm`. Its commands live in the
namespace `::tkutils::tku<name>`. Most modules mark them with
`namespace export`, but no module imports them into the global
namespace. Therefore always call them fully qualified:
`::tkutils::tkudialog::confirm`, not `tkudialog::confirm` — the short
form fails with `invalid command name "tkudialog::confirm"`.

Two exceptions have a namespace of their own: [tkuload]{.index} lives in
`::tkuload`, [tkurender]{.index} in `::tkurender` (chapter
[Designer and load](080-designer-und-load.md)). The packages are still
called `tkutils::tkuload` and `tkutils::tkurender`.

---

## The Umbrella

`package require tkutils` loads **53** modules directly, among them
dialogs, file list and tree, file dialog, path bar, preview, tabs,
toolbar, status bar, actions, launcher, geometry and units. Two more come
in indirectly:

- [tkutablelist]{.index} — through `tkufilelist` (and thus
  `tkufiledialog`). The [umbrella]{.index} therefore needs **Tablelist**
  from tklib on the `auto_path`; without Tablelist,
  `package require tkutils` fails with `can't find package Tablelist`.
- `tkuopts` — the shared option check (chapter
  [Error Messages](830-anhang-fehlermeldungen.md)).

After `package require tkutils`, **55** packages `tkutils::*` are loaded
— 53 directly, plus `tkutablelist` 0.5 and `tkuopts` 0.1. The umbrella
asks for `tkupath 0.2` and `tkupreview 0.1`; the versions present, 0.3
and 0.2, are loaded.

Not in the umbrella — require them one by one:

| Module | Needs |
|---|---|
| `tkuxml` | tDOM |
| `tkusqlite` | sqlite3 |
| `tkuicon` | for SVG: tksvg (Tk 8.6) or Tk 9; PNG/GIF without |
| `tkuscrolledframe` | scrollutil (tklib) |
| `tkutical`, `tkumonthcanvas` | tical 1.0 |
| `tkucanvaspng` | `tclutils::tupngdraw` |
| `tkutltools` and `tkutlclip`, `tkutldrag`, `tkutlfilter`, `tkutlfind`, `tkutlfmt`, `tkutlfooter`, `tkutlgroup`, `tkutlsort`, `tkutlstate`, `tkutltree` | Tablelist (`tablelist_tile`) |
| `tkuload`, `tkurender` | — (designer core) |
| `tkumdview`, `tkupdfinspect`, `tkulayoutcanvas` | tclutils engines |
| `tkusysinfo` | `tclutils::tusysinfo` (tclutils 0.69.0) |

These are **24** modules; together with the 55 from the umbrella they
make up the **79** modules of the tree.

```tcl
package require tkutils
puts [package present tkutils::tkutablelist]   ;# -> 0.5, über tkufilelist
package require tkutils::tkuload               ;# extra
```

All 24 separate modules load when tDOM, sqlite3, tklib (Tablelist,
scrollutil) and tical are on the path; `tkuicon` loads even without
tksvg.

### Adding tical

[tical]{.index} 1.1 is the calendar and iCalendar engine described in the
book *Utils-Stack*. It is not part of tkutils, and `setup.tcl` does not
find it. The tical tree ships a `pkgIndex.tcl`; add it to the
`auto_path`:

```tcl
lappend auto_path /pfad/zu/tical
package require tkutils::tkutical        ;# -> 0.4
package require tkutils::tkumonthcanvas  ;# -> 0.5
```

`tkutical` needs `tical::view::month`, `tical::view::week` and
`tical::render::canvas` (1.0 each). `tkumonthcanvas` needs
`tical::config`, `tical::locale`, `tical::holidays`, `tical::holidays::de`
and `tical::view::month` (1.0 each).

### One Tablelist Variant

tklib does not allow both Tablelist variants (`tablelist` and
`tablelist_tile`) in one program. tkutils therefore uses
**`tablelist_tile`** everywhere: `tkutablelist` loads it first and falls
back to `Tablelist` only when it is missing. The `tkutl*` helpers load
`tablelist_tile` when no Tablelist is loaded yet; if the application
already has one of the two variants, they use that one. Apps
(tkdevtools, knowledge base), examples, tests and docs load
`tablelist_tile`. `tkutils` followed by `tkutltools` loads without
error, and so does the reverse order (tests `tkutltools-2.1`, `-2.2`).
For the behavior up to 0.46.0: [Appendix G](860-anhang-testumgebung.md).

---

## Scope of This Book

- Not a general Tk textbook — see the German book on Tcl/Tk user
  interfaces
- No controllers such as `cufileops` — see *Utils-Stack*
- No engines — see *tclutils*
- Not a copy of all widget docs — the API reference is
  `docs/<modul>.md`

---

## Structure

Chapter 2 covers installation and tests. Then come dialogs, file
widgets, lists and the Tablelist helpers, geometry and units, actions,
scaffolding, input, calendar and notes, data views, designer and load,
images and tkdevtools. Chapter 16 lists the limits. The appendices hold
pitfalls (A), the widget list (B), the glossary (C), error messages (D),
the API catalog (E), practical examples (F) and the test environment
(G).

---

## In short

- Widgets on tclutils engines, version 0.49.0.
- Pairing tclutils 0.69.0 + tkutils 0.49.0 + ctrlutils 0.5; at least
  tclutils 0.64.0, 0.69.0 for the CSV export of `tkutablelist`.
- Always call commands as `::tkutils::tku<name>::…`.
- The umbrella needs Tablelist; 24 modules come only on their own.
- `tablelist_tile` everywhere; tklib refuses both Tablelist variants in
  one program.

::: {.info}
**Tested with** Tcl/Tk 8.6.14 (Tablelist 6.20, scrollutil 1.17) and
9.0.4 (Tablelist 7.11, scrollutil 2.10) on Linux under Xvfb, tclutils
0.69.0, tical 1.1.

**Not tested:** Windows, macOS.
:::

---

*Next chapter: [Installation](020-installation.md)*
