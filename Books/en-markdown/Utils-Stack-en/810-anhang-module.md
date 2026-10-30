# Modules (Stack View)

| Layer | Book / location | Size |
|---|---|---|
| tclutils | book *tclutils*, `tclutils/docs/` | 146 module files |
| tkutils | book *tkutils*, `tkutils/docs/` | 79 modules |
| ctrlutils | this book, `ctrlutils/docs/` | 5 modules |
| tical | this book, chapter 10, `tical/doc/`, `tical/schemas/` | 19 packages |

Counted as `.tm` files under `lib/tm/<lib>/` without the umbrella.
tclutils 0.69.0 has 142 flat modules and four providers in
`tuprovider/` (`dav`, `ftp`, `sftp`, `zip`). 0.69.0 adds `tusysinfo`
and `tuedid` and brings `tucsv`, `tusqlite` as 0.2. 0.68.0 brought no new
module, but new numbers for 76 existing ones, among them `tuprovider`
0.2, `tuprovider::sftp` 0.2 and `tuopen` 0.2. `tupdftext` came with
0.67.0, `tutask` with 0.65.0 (as 0.2 since 0.66.0). New in tkutils
0.49.0: `tkutlfilter`, `tkutlgroup`, `tkutldrag`, `tkusysinfo`;
renumbered `tkutablelist` 0.5, `tkutlstate` 0.4, `tkutlclip`,
`tkutlfind`, `tkutlsort`, `tkutltree`, `tkutltools` 0.3. Renumbered in
tkutils 0.48.0: `tkulauncher`, `tkuload` 0.3; in 0.47.0 `tkufiledialog`
0.2, `tkutlclip`, `tkutlfind`, `tkutlsort`, `tkutltools`, `tkutltree`
0.2, `tkutlfmt`, `tkutlfooter`, `tkutlstate` 0.3.

In tkutils, `tkutablelist` ships only as 0.5; the files for 0.3 and 0.4
have been removed.

ctrlutils in full:

| Module | Version | needs Tk | core calls |
|---|---|---|---|
| cufileops | 0.6 | yes | `install … ?-onop?`, `newFolder`, `openFile`, `openWith`, `openWithDefault`, `rename`, `copy`, `cut`, `paste`, `delete`, `refresh` |
| cuundo | 0.5 | only `-list` | `install … ?-list? ?-refresh?`, `record`, `undo`, `redo`, `canUndo`, `canRedo`, `clear` |
| cufilter | 0.2 | yes | `widget $path $list`, `clear`, `lastError` |
| cumonitor | 0.2 | no | `install … ?-interval? ?-onchange?`, `watch`, `poke`, `stop` |
| cusync | 0.3 | no | `compare`, `plan`, `apply`, `applyOne` |

Files: `lib/tm/ctrlutils-0.5.tm`, in `lib/tm/ctrlutils/`
`cufileops-0.6.tm`, `cufilter-0.2.tm`, `cumonitor-0.2.tm`,
`cusync-0.3.tm`, `cuundo-0.5.tm`.

In addition, for the "Open with" registry in cufileops: `owSetApp` (app
name, since 0.5), `owApps`, `owDefault`, `owAddApp`, `owRemoveApp`,
`owSetDefault` (key: extension in lower case with a dot, e.g. `.txt`).

Umbrella: `ctrlutils` 0.5 loads all five.

Version history: ctrlutils 0.3 first contained `cufileops` 0.3 and
`cuundo` 0.2, after an addendum `cufileops` 0.4 and `cuundo` 0.3, plus
`cusync` 0.1. From 0.4 on, the umbrella goes up with every module.

---

## tical 1.1.1

All packages are listed in `tical/pkgIndex.tcl`. What changed in 1.1.1
has version 1.1.1 (`tical::holidays::de` 1.0.1; `tical::config`,
`tical::locale` and `tical::holidays` 1.0.2); `tical::term` stays at
1.0.

| Package | File | needs | in the umbrella |
|---|---|---|---|
| `tical` | `tical-1.1.1.tm` | — | (umbrella) |
| `tical::core` | `core/tical-core-1.1.1.tm` | — | yes |
| `tical::util` | `core/tical-util-1.1.1.tm` | — | yes |
| `tical::config` | `core/tical-config-1.0.2.tm` | — | yes |
| `tical::locale` | `core/tical-locale-1.0.2.tm` | — | yes |
| `tical::term` | `core/tical-term-1.0.tm` | — | yes |
| `tical::holidays` | `core/tical-holidays-1.0.2.tm` | — | yes |
| `tical::holidays::de` | `holidays/tical-holidays-de-1.0.1.tm` | — | yes |
| `tical::event` | `core/tical-event-1.1.1.tm` | — | yes |
| `tical::view::month` | `views/tical-view-month-1.1.1.tm` | — | yes |
| `tical::view::week` | `views/tical-view-week-1.1.1.tm` | — | yes |
| `tical::view::day` | `views/tical-view-day-1.1.1.tm` | — | yes |
| `tical::render::term` | `render/tical-render-term-1.1.1.tm` | — | yes |
| `tical::render::canvas` | `render/tical-render-canvas-1.1.1.tm` | Tk | no |
| `tical::render::pdf` | `render/tical-render-pdf-1.1.1.tm` | `pdf4tcl` | no |
| `tical::model` | `model/tical-model-1.1.1.tm` | — | yes |
| `tical::io::ical` | `io/tical-io-ical-1.1.1.tm` | — | yes |
| `tical::io::import` | `io/tical-io-import-1.1.1.tm` | tclutils (`tuical`, `turrule`) | no |
| `tical::adapter::sqlite` | `adapter/tical-adapter-sqlite-1.1.1.tm` | `tdbc::sqlite3` | no |

In tkutils 0.49.0, `tkutils::tkutical` 0.4 and `tkutils::tkumonthcanvas`
0.5 build on tical; neither is in the `tkutils` umbrella.

---

## Summary

- tclutils 146 module files, tkutils 79, ctrlutils 5 modules, tical 19
  packages.
- ctrlutils 0.5 contains cufileops 0.6, cuundo 0.5, cusync 0.3 and
  cufilter 0.2.
- The `tical` umbrella loads everything except canvas, PDF, SQLite and
  import.

---

*Next chapter: [Glossary](820-anhang-glossar.md)*
