# Pitfalls

---

- Short form `tkudialog::confirm` instead of
  `::tkutils::tkudialog::confirm` —
  `invalid command name "tkudialog::confirm"`.
- Setting `TCLUTILS_TM`/`TKUTILS_TM` and leaving out `setup.tcl` — Tcl
  does not read the variables; `can't find package tkutils` or
  `can't find package tclutils::…`.
- Umbrella without Tablelist — `can't find package Tablelist`.
- Expecting `tkudialog` 0.2 — file removed, behavior = 0.3.
- Calling `tkudialog::message`/`warning` — they are called
  `showInfo`/`showWarning`.
- `input` returns `""` — cancel or empty field, both the same.
- Requiring `tkutablelist` 0.3 and expecting the old PRIMARY selection —
  it is always 0.4; set `-exportselection 1`.
- `tkufilelist` without `-dir` — shows `/`, not the current directory.
- Calling `tkugeometry::restore` before `track` — redundant; `track`
  restores by itself.
- `-default 800x600` gives only a size; the window manager chooses the
  position (under Xvfb without a window manager `+0+0`; not checked
  under a real window manager). The test `tkugeometry-3.2` therefore
  compares only the size.
- `setEnabled id 0` (global) after `setEnabled id 0 $w` — clears the
  window overrides; `invoke` follows only the global flag.
- Filling a placeholder and wondering why the content is clipped —
  200×120 and `pack propagate 0`.
- Starting the tests with `wish` — `tclsh tests/all.tcl`.
- Looking for file operations in the widget — they belong in ctrlutils.
- Unknown options to `tkutlfooter` — skipped without an error.
- Copying 0.48.0 over an older tree and leaving the old `.tm` files —
  then two versions sit side by side (list in the chapter
  [Installation](020-installation.md)).
- Checking for the error code `{TKUTILS <MODUL> OPTION}` without a
  fourth element — since 0.47.0 it also carries the option name as the
  fourth element in `tkuaction` (`define`), `tkuballoon`, `tkuform`,
  `tkukeynav`, `tkulayoutcanvas`, `tkumarquee`, `tkuscrolledframe`,
  `tkutablelist`, `tkutoolbar` and `tkuvalidate`:
  `{TKUTILS <MODUL> OPTION <opt>}`. Up to 0.46.0 it was missing there,
  and the message was `unknown option '<opt>'` without a `Known:` line.
  Code that compares the whole code or the message text must be
  adapted; `lrange $code 0 2` fits both versions. Only a missing value
  still reports `OPTION` without the option name.

---

## Fixed in 0.47.0

These pitfalls apply to 0.46.0. They are fixed in 0.47.0:

- Double click on a file in `tkufiledialog` 0.1 — the dialog closes, the
  result is `""`; up to 0.46.0 *OK* or Return had to be used. Fixed in
  `tkufiledialog` 0.2.
- Starting the tests without a display — four files abort, exit code 1.
- `tkumonthcanvas.test` without `TICAL_DIR` — all tests skipped when
  tical lies flat next to tkutils; up to 0.46.0 `TICAL_DIR` had to be
  set.
- `tkutltools` or a `tkutl*` helper **after** the umbrella —
  `can't set "usingTile": it is not supported to use both Tablelist and
  Tablelist_tile in the same application`; up to 0.46.0 `tablelist` had
  to be loaded first. Now all of them load `tablelist_tile`.

---

## Summary

- Most pitfalls are questions of paths and loading: setup.tcl,
  Tablelist, load order.
- Two pitfalls are code bugs in 0.46.0: double click in the file dialog
  and tests without a display. Both are fixed in 0.47.0.
- Code that detects option errors by their error code must expect the
  option name as the fourth element in ten more modules since 0.47.0.

---

*Next chapter: [Widgets](810-anhang-widgets.md)*
