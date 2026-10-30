# App Checklist

---

1. Load the pairing **0.69.0 / 0.49.0 / 0.4**; check in the suite's
   banner which files are really loaded.
2. `setup.tcl` (or `TCLUTILS_TM` / `TKUTILS_TM`), plus
   `tcl::tm::path add …/ctrlutils/lib/tm` — or everything in `site-tcl`,
   deleting old module files first.
3. `package require Tk` before `ctrlutils`. Up to ctrlutils 0.3 load
   `tkutils::tkufilelist` yourself; from 0.4 on `cufileops` loads it.
4. Choose the provider; check caps before hard-wiring menus.
5. Widgets: `tkufilelist` / tree / path; dialogs **0.3**; tablelist **0.4**.
6. `cuundo::install $f $prov -list $list`, then `cufileops::install …
   -onop [list ::ctrlutils::cuundo::record $f]` — both with the same
   `$f`; optionally `cufilter::widget` (pack it yourself) and
   `cumonitor`.
7. Refresh callback after a change, calling `cumonitor::poke` in it; at
   the end of a tab `cumonitor::stop` and provider `destroy`.
8. Pass the app's own file changes as an operation record to
   `cuundo::record`.
9. Language: translations for cufileops, cuundo and cufilter with
   `::msgcat::mcset` in the namespace `::ctrlutils`, for tkudialog in
   `::tkutils`.
10. Set an app name of your own for the "Open with" registry, at
    startup: `::ctrlutils::cufileops::owSetApp meineapp` (from
    ctrlutils 0.4).
11. Settings/geometry: `tusettings` / `tkugeometry`.
12. Tests: `tclsh tests/all.tcl` through tutestrun; check the banner,
    limit via `*_TESTGRENZE`; Tk tests with a display (`xvfb-run -a`).
13. Calendar: load tical 1.1.1 through `auto_path` (not `tcl::tm::path`),
    public holidays with `-holidays DE`, appointments with `-events` in
    the format of `tical::event`; as a widget load
    `tkutils::tkutical` or `tkutils::tkumonthcanvas` on its own.
14. Do not touch the Explorer; your own app in its own tree.

---

## Summary

- Load the stack → provider → view → controller → life cycle.
- Details: books *tclutils* and *tkutils*.

---

*Next chapter: [Calendar: tical](070-tical.md)*
