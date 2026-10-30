# Error Messages

Wording taken from the code. The lines marked "checked" were triggered
with Tcl/Tk 8.6.14 on Linux (Xvfb); the lines about the options of
cufileops, cuundo, cumonitor and cusync, about `owSetApp`, about the
Explorer start and about tical also with Tcl/Tk 9.0.4. The wording
applies to ctrlutils 0.5 and tical 1.1.1; where an older ctrlutils
differs, it says so.

| Symptom | Check |
|---|---|
| `can't find package ctrlutils` / `ctrlutils::…` (checked) | `tcl::tm::path add …/ctrlutils/lib/tm`; `setup.tcl` does not know ctrlutils |
| `can't find package tkutils::tkudialog 0.3` (checked) | tkutils ≥ 0.46 (dialog 0.3) |
| `no display name and no $DISPLAY environment variable` when loading `ctrlutils` (checked) | the umbrella needs Tk; without a display load only Tk-free controllers |
| `invalid command name "::tkutils::tkufilelist::widget"` (checked) | ctrlutils 0.3: `package require tkutils::tkufilelist` missing; from ctrlutils 0.4 on `cufileops` loads it itself |
| dialog without a default button | tkudialog ≥ 0.3 |
| multi-select gone after a right-click | cufileops ≥ 0.3 + tablelist 0.4 |
| `can't find package tclutils::tuprovider` | load tclutils |
| suite tests the wrong tree | banner / `TCL*_TM_PATH`; start the suite through `tests/all.tcl` |
| `unknown option "-onpo"` / `Known: -onop` (checked) | typo; error code `CTRLUTILS CUFILEOPS OPTION -onpo` |
| `missing value for option "-onop"` (checked) | option without a value; error code `CTRLUTILS CUFILEOPS OPTION` |
| `unknown option "…"` / `Known: -list, -refresh` (checked) | `cuundo::install`; error code `CTRLUTILS CUUNDO OPTION …`; up to ctrlutils 0.4 only `Known: -list` |
| `list not refreshed: …` (checked) | undo or redo is done, refreshing the list is not; error code `CTRLUTILS CUUNDO REFRESH`; check the script of `-refresh` or of `cufileops::install` |
| `unknown option "…"` / `Known: -interval -onchange` (checked) | `cumonitor::install`; error code `CTRLUTILS CUMONITOR OPTION …` |
| `cumonitor: <f> not installed` (checked) | `watch` before `cumonitor::install` |
| `can't read "state": no such variable` (checked) | `cumonitor::watch`, `poke` or `stop` before any monitor was installed in the process |
| `unknown option "-x"` / `Known: -onfile -ondir` (checked) | `cusync::apply`; error code `CTRLUTILS CUSYNC OPTION -x`; silently ignored in ctrlutils 0.3 |
| `missing value for option "-onfile"` (checked) | `cusync::apply`, option without a value; error code `CTRLUTILS CUSYNC OPTION` |
| `cannot list "…" (R): …` (checked) | `cusync::compare`: a directory cannot be listed; error code `CTRLUTILS CUSYNC LIST R dir` (`L` for left); up to ctrlutils 0.4 the side counted as empty |
| `invalid application name "mein app": use letters, digits, . _ -` (checked) | `cufileops::owSetApp`; only letters, digits, `.` `_` `-`; error code `CTRLUTILS CUFILEOPS APPNAME {mein app}` |
| "Open with" shows the programs of another app | no `cufileops::owSetApp` set (registry `explorer`) or, in ctrlutils 0.3, `owApp` set only after the first access |
| undo does nothing | cufileops without `-onop [list ::ctrlutils::cuundo::record $f]` or a different `$f` |
| Ctrl+Z has no effect | `cuundo::install` without `-list` |
| `Undo failed:` + `no saved content to restore` (checked) | delete without a snapshot (the provider could not read) |
| `Redo failed:` (checked) | target blocked; the record stays on the redo stack (in ctrlutils 0.3 it is lost afterwards) |
| `Cut is not available here (the source cannot delete).` (checked) | source without `delete`, e.g. ZIP; use copy |
| `Delete is not available here (the source cannot delete).` (checked) | source without `delete` |
| `Copied, but could not remove the source:` | cut: the copy exists, the source stayed |
| filter row missing | `cufilter::widget` created but not packed |
| monitor reports the app's own changes | `cumonitor::poke` after the operation |
| menu shows only "(read-only)" (checked) | no matching operation, e.g. ZIP without a selected file and with an empty clipboard |
| Explorer: "Explorer cannot start", `Missing package:`, `Searched module path (tcl::tm::path):`, `Searched auto_path:` (checked) | module path for all three libraries; Tablelist. In ctrlutils 0.3 without the module path lines |
| Explorer: `Sync needs the ctrlutils::cusync module.` | module `cusync` missing |
| Explorer: `Find in list needs the tkutils::tkutlfind module.` | module `tkutlfind` missing |
| `all.tcl: tclutils::tutestrun not found (set TCLUTILS_TM)` (checked, exit 2) | tclutils ≥ 0.64 as a sibling, or set `TCLUTILS_TM` |
| `<file> (hang after 120s)` | raise `CTRLUTILS_TESTGRENZE` |
| `smoke.test (1 failed)`, `couldn't connect to display` (checked) | ctrlutils 0.3: start the suite with a display (`xvfb-run -a`); skipped from ctrlutils 0.4 on |
| `can't find package tical::util 1.0` (checked) | tical added through `tcl::tm::path`; put the tical folder on the `auto_path` |
| `can't find package tical::view::month` or similar | tical missing from the `auto_path`; for tkutils set `TICAL_DIR` or use tical as a sibling checkout |
| calendar shows no public holidays | unknown region for `-holidays` (no error message) |
| `view::month::getData: -year and -month are required` (checked) | month without `-month`; `-count` does not replace it; errorcode `TICAL VIEW ARGS` |
| `view::month::getData: -count must be an integer >= 1, got "0"` (checked) | `-count` below 1 or not a number; errorcode `TICAL VIEW COUNT` |
| `view::month::getData: unknown option "-weekstart", must be -count, -events, …` (checked) | typo in an option of the view (skipped silently up to 1.0.1); errorcode `TICAL VIEW OPTION` |
| `render::term::print: unknown option "-colour", must be -color, -weekNumbers or -weekStart` (checked) | an option `render::term` does not know; errorcode `TICAL RENDER OPTION` |
| `render::term::print: -weekStart mon contradicts the view (starts on sun): week start comes from the view; use getData ... -weekStart mon` (checked) | `-weekStart` does not match the view; set the week start in `getData`; errorcode `TICAL RENDER WEEKSTART` |
| `render::pdf::create: bad paper "b5": must be a3, a4, a5 or letter` (checked) | a paper size `render::pdf` does not know; errorcode `TICAL RENDER OPTION` |
| `event missing required field: dtstart` (checked) | appointment without a start in `getData … -events`, `normalize`, `model` or `exportEvents`; errorcode `TICAL EVENT FIELD` |
| `dtend "20251014T090000" is before dtstart "20251014T100000"` (checked) | end before start; errorcode `TICAL EVENT RANGE` |
| `render::term::print: expected type month-grid, week-grid or day-grid, got "year-grid"` (checked) | a ViewSpec `render::term` does not know (up to 1.1 also week and day); errorcode `TICAL RENDER TYPE` |
| `setCallback: "w date" is not a widget path; pass one command prefix (setCallback CMD) or a canvas and one (setCallback .c CMD)` (checked) | `setCallback` with a parameter list and a body; pass a command prefix; errorcode `TICAL RENDER ARGS` |
| `dtstart format invalid: "2025-10-14" (expected YYYYMMDD, YYYYMMDDTHHMMSS or YYYYMMDDTHHMMSSZ)` (checked) | `io::ical::validate` with an ISO date; `validate` checks the form that is written; errorcode `TICAL ICAL FORMAT` |
| `FREQ must be DAILY\|WEEKLY\|MONTHLY\|YEARLY, got "HOURLY"` (checked) | `rrule` with another frequency; errorcode `TICAL ICAL RRULE` |
| `appointment not found: appt-9` (checked) | `tical::model::get…` with an unknown id; errorcode `TICAL MODEL NOTFOUND` |
| `event not found: nix` (checked, 9.0.4 only) | `adapter::sqlite::read`/`update`/`delete` with an unknown `uid`; errorcode `TICAL SQLITE NOTFOUND` |
| `can't find package tdbc::sqlite3` | `tical::adapter::sqlite` without TDBC SQLite; the suite skips `adapter-sqlite.test` |
| `can't find package tclutils::tuical 0.1` (checked) | `tical::io::import` without tclutils; `tcl::tm::path add …/tclutils/lib/tm`; the suite skips `io-import.test` |
| `VEVENT "X": RRULE FREQ=MONTHLY;BYSETPOS=-1: unsupported rule part: BYSETPOS` (checked) | `io::import::expand` with an RRULE part that `turrule` does not know; errorcode `TICAL IMPORT RRULE` |

Error codes of the single modules: the respective library docs and the
books *tclutils* and *tkutils*.

---

## Summary

- Load errors: module path, Tk/display, load `tkufilelist` yourself.
- Option errors name the known options and carry an error code
  `CTRLUTILS <MODULE> OPTION …`.
- Test errors: banner, display, `*_TESTGRENZE`.
- tical: `auto_path` instead of the module path; the import needs
  tclutils on the module path.
