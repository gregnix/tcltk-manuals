# Error Messages

| Code / symptom | Meaning |
|---|---|
| `invalid command name "tkudialog::…"` | namespace missing; `::tkutils::tkudialog::…` |
| `can't find package tclutils::…` | tclutils not on the module path |
| `can't find package tkutils::…` | setup.tcl / `tcl::tm::path add` missing |
| `can't find package Tablelist` | umbrella or table widget without tklib |
| `can't set "usingTile": …` | up to 0.46.0: `tkutl*` loaded after `tkutablelist`, load `tablelist` first; fixed in 0.47.0. Today only when an application requires both variants itself |
| `{TKUTILS <MODUL> OPTION <opt>}` | unknown option (modules with `tkuopts`, `tkudialog`, `tkufiledialog`, since 0.47.0 ten more, see below) |
| `{TKUTILS <MODUL> OPTION}` | value for the option missing; up to 0.46.0 in ten modules also an unknown option |
| `{TCLUTILS COMMON OPTION <opt>}` | unknown option in tkugeometry, tkucanvaspng, `tkudavbrowser::refresh` |
| `{TKUTILS TKUDIALOG PARENT <w>}` | `-parent` does not exist |
| `{TKUTILS TKUFILEDIALOG PARENT <w>}` | the same in the file dialog |
| `{TKUTILS TKUGEOMETRY WINDOW}` | no toplevel for save/track/restore |
| `{TCLUTILS TUSETTINGS …}` | geometry persistence (tusettings), e.g. `APP` |
| `{TKUTILS TKUUNITS UNIT}` | unknown unit |
| `{TKUTILS TKUUNITS VALUE}` | not a number (`2c`) |
| `{TKUTILS TKUUNITS WINDOW}` | no such window |
| `{TKUTILS TKUACTION WINDOW}` | unknown window for enable |
| `{TKUTILS TKUACTION NOACTION}` / `NOGROUP` | unknown action / group |
| `{TKULOAD PARENT}` / `{TKULOAD NONAME}` | tkuload: parent / name missing |
| `unknown interpreter: <key>` | tkulauncher: no such interpreter key |
| `ITEM_EXISTS` in tkufiletree | before 0.46.0: dot files twice on Windows |
| `{TKUTILS TKCANVASPNG WINDOW}` / `EMPTY` | tkucanvaspng: window missing / canvas empty |
| `{TKUTILS TKUICON NOSVG}` | tkuicon: SVG without tksvg under Tk 8.6 |

The option check of [tkuopts]{.index} is used by 20 modules, among them
`tkufilelist`, `tkufiletree`, `tkupath` and `tkulauncher`. They report
an unknown option as `{TKUTILS <MODUL> OPTION <opt>}` with
`unknown option "<opt>"` and a second line `Known:` with the sorted
known options. A missing value reports `{TKUTILS <MODUL> OPTION}` with
`missing value for option "<opt>"`. `tkudialog` and `tkufiledialog`
check themselves, with the same structure; there the `Known:` list is in
the order of the code.

Ten modules check their options themselves: `tkuaction` (in `define`),
`tkuballoon`, `tkuform`, `tkukeynav`, `tkulayoutcanvas`, `tkumarquee`,
`tkuscrolledframe`, `tkutoolbar`, `tkuvalidate` and `tkutablelist`
(which checks before `tkuopts`). Since 0.47.0 they follow the structure
of `tkuopts`: code `{TKUTILS <MODUL> OPTION <opt>}`, message
`unknown option "<opt>"` and a second line `Known:` with the sorted
known options. Up to 0.46.0 the option name was missing from the code,
the `Known:` list was missing, and the message was
`unknown option '<opt>'`. Anyone comparing the error code must expect
the option as the fourth element since 0.47.0 (Appendix
[Pitfalls](800-anhang-fallen.md)).

Only a few modules use the tclutils check and report
`{TCLUTILS COMMON OPTION <opt>}`.

Not every module follows the scheme: `tkutlclip` and `tkutlfind` report
`{TKUTILS <MODUL> OPTION}` without the option name and without a
`Known:` line, `tkutlstate::autosave` the reason `badoption` in lower
case, and `tkutlfooter` does not check options.

Module-specific codes: the respective `docs/<modul>.md`.

---

## Summary

- Error codes follow `{TKUTILS <MODUL> <GRUND>}`; exceptions are tkuload
  (`TKULOAD`) and modules with the tclutils check (`TCLUTILS COMMON`).
- Since 0.47.0 the ten modules with their own option check name the
  option in the code and the known options in the message; up to 0.46.0
  both were missing. Modules with the tclutils check report the same
  under `{TCLUTILS COMMON OPTION <opt>}`. Different: `tkutlclip`,
  `tkutlfind`, `tkutlstate`, `tkutlfooter`.

::: {.info}
**Tested with** Tcl/Tk 8.6.14 and 9.0.4 on Linux under Xvfb: codes and
messages of `tkudialog`, `tkutablelist`, `tkutl*`, `tkugeometry`,
`tkuunits`, `tkuaction`, `tkuform`, `tkulauncher`, `tkucanvaspng` and
`tkuload` as given here and in the chapters. The other rows are read
from the code.
:::
