# Pitfalls

---

- Loading only tkutils and forgetting the provider from tclutils.
- ctrlutils 0.3 with tkudialog 0.2 / the old tablelist default.
- `package require ctrlutils` without Tk or without a display — it
  fails at `cufileops`. Without Tk, load only `cusync`, `cumonitor`,
  `cuundo` one by one.
- Write menus despite read-only caps.
- Copying Explorer code into Dateiblick instead of reusing the
  controllers.
- Reinventing app workarounds for multi-select/dialogs — libraries
  0.3/0.4.
- Suite against `site-tcl` instead of the workspace (read the banner).
  An installed copy of the same version hides the tree if it comes first
  in the module path; only `tests/all.tcl` moves its own trees to the
  front.
- New version copied over an old `site-tcl` copy: `cufileops-0.4.tm`
  stays next to `cufileops-0.5.tm`, and so do `cuundo-0.3.tm`,
  `cusync-0.1.tm` and the old tkutils and tclutils files (list in
  [Pairing and Setup](020-pairing-und-setup.md)).
- `setup.tcl` sourced, ctrlutils `lib/tm` forgotten —
  `can't find package ctrlutils`.
- `cufileops::install` without `-onop`: undo stays empty, without a
  message.
- cufileops and cuundo installed with different `$f`: undo does not
  find its records and does not refresh the list.
- `cuundo::install` without `-list`: no Ctrl+Z.
- `cufilter::widget` called but not packed — the row exists but is
  invisible.
- Forgetting `cumonitor::poke` after the app's own file operations: the
  monitor reports the app's own change as a foreign one.
- `cumonitor` under `tclsh` without an event loop (`vwait`): it never
  polls.
- `cumonitor::stop` or `poke` called for clean-up before any monitor
  was ever installed in the process:
  `can't read "state": no such variable`.
- Taking `cusync` for a deleting synchronization — it never deletes on
  the target.
- An app of your own without `owSetApp`: its "Open with" registry ends
  up in the configuration folder `explorer`.
- Setting `::ctrlutils::cufileops::owApp` directly instead of calling
  `owSetApp`: after the first access the old registry stays in memory.
- Patching the utils trees in book PRs.

---

## tical

- Adding tical with `tcl::tm::path add`: Tcl finds only the umbrella,
  then `can't find package tical::util 1.0`. tical belongs on the
  `auto_path`.
- Treating `month::getData … -count 3` like a single ViewSpec: from
  N > 1 on, a list of months comes back.
- `render::term::print … -weekStart sun` with a Monday view: error
  `TICAL RENDER WEEKSTART`. The option only checks; the view sets the
  week start (`getData … -weekStart sun`), the renderers follow it.
- Typos in options (`-weekstart`, `-weeknumbers`): since 1.1 an error
  `TICAL … OPTION`, before that skipped silently.
- Giving an all-day appointment `dtend` = last day: `dtend` is
  exclusive, `dtstart 20251020 dtend 20251023` are three days, not
  four. `normalize` turns a `dtend` equal to `dtstart` into one day.
- Looking for a multi-day appointment only in its start cell: the view
  puts it into every cell it touches, with `part` `start`, `middle`,
  `end`.
- Expecting the `render::term` output of 1.0.1: cells are now four
  characters wide, holiday `(3)` instead of `+3`, today `[17]` instead
  of `*17`, `*` after the number means an appointment.
- Checking for German error texts: tical reports in English; check the
  errorcode `TICAL …`, not the wording.
- `render::canvas::setCallback {w date} {…}` with a parameter list and a
  body: error `TICAL RENDER ARGS`; pass a command prefix.
- Relying on `starts_at`/`ends_at` or `title`/`date`/`startTime`: 1.1
  still takes and returns them, 1.2 no longer; use `dtstart`, `dtend`,
  `summary`.
- Loading `tical::io::import` without tclutils: `can't find package
  tclutils::tuical 0.1`; put tclutils on the module path.
- Relying on the `TZID` conversion when the file has custom
  `VTIMEZONE` names: a zone Tcl does not know stays local time;
  `tical::event::tzid name` then returns `""`.
- Storing imported appointments with `tzid` in `tical::adapter::sqlite`:
  the table has no column for it, the time counts as local afterwards.
  Convert to UTC first or store the zone yourself.
- Treating `tuholiday` and `tical::holidays::de` as the same:
  `holidays::de` leaves out Easter Sunday and Whit Sunday;
  `getHolidays -sundays 1` returns the same list as `tuholiday`.

---

## Fixed in ctrlutils 0.4

These pitfalls apply to ctrlutils 0.3. In ctrlutils 0.4 they are fixed:

- `tkutils::tkufilelist` not loaded because `ctrlutils` seems to bring
  it along — in 0.3 it does not; up to 0.3, load it yourself. Now
  `cufileops` loads it itself.
- "Open with": in 0.3 all apps share the registry `explorer`, and
  setting `owApp` after the first access has no effect. Now `owSetApp`.
- Error dialogs of cuundo without `-parent`: in 0.3 they can open behind
  the app window. Now over the toplevel of the list.
- Reasons of cuundo and the filter row of cufilter: always English in
  0.3. Now through msgcat.
- Failed redo: in 0.3 the record is gone, a second attempt is not
  possible. Now it stays on the redo stack.
- Typo in an option of `cusync::apply`: silently ignored in 0.3. Now an
  error `unknown option "…"` with `Known: -onfile -ondir`.
- `cusync` with a ZIP, DAV or SFTP target: in 0.3 a local file of the
  same name can get the source mtime. Now only between two local
  providers.
- Tests without a display: in 0.3 `smoke.test` fails in
  `explorer-0-load`. Now skipped.
- Explorer does not start: in 0.3 the message names only the
  `auto_path`, although the modules come through the module path. Now
  both.

## Fixed in ctrlutils 0.5

These pitfalls apply to ctrlutils 0.4:

- `cusync::compare`: if listing a side fails, it counts as empty. For
  the target this means: every source file is copied, newer files
  included. Now an error `{CTRLUTILS CUSYNC LIST …}`.
- Cut with a partial failure: after the paste the whole cut is gone,
  also for the entries that were not copied. Now they stay on the
  clipboard.
- Undo refreshes the list through an internal procedure of cufileops
  and swallows an error there. Now `-refresh` and an error
  `{CTRLUTILS CUUNDO REFRESH}`.
- `cufilter`: a filter that cannot be set vanishes silently. Now
  `invalid`, `<<CufilterError>>` and `lastError`.
- Old module files: the tree of ctrlutils 0.4 still contained
  `cufileops-0.4.tm`, `cuundo-0.3.tm` and `cusync-0.1.tm`. Copying
  `lib/tm` takes them along; a `package require -exact … 0.3` loads them.

---

## Summary

- Most pitfalls are silent wiring errors: wrong `$f`, missing `-onop`,
  missing `poke`, unpacked filter row.
- For version and path questions, read the suite's banner first.
- For tical: the loading path (`auto_path`), the case of the region,
  the exclusive `dtend` of all-day appointments.

---

*Next chapter: [Modules](810-anhang-module.md)*
