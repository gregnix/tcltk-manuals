# Glossary

---

[pairing]{.index}
:   Matching version numbers of the three libraries; currently tclutils
    0.69.0, tkutils 0.49.0, ctrlutils 0.5.

[provider]{.index}
:   Uniform storage API (tclutils); schemes `local`, `zip`, `dav`,
    `ftp`, `sftp`.

[controller]{.index}
:   ctrlutils module: wires behaviour onto existing widgets. Exceptions:
    `cufilter` builds a filter row of its own, `cusync` needs no Tk.

[caps]{.index}
:   Provider capabilities; they control menus. Example ZIP:
    `get list stat`.

[operation record]{.index}
:   Dict that cufileops passes to `-onop` after every successful
    operation (`op mkdir|rename|paste|delete|movex` plus paths); cuundo
    records it.

[snapshot]{.index}
:   Content that cufileops keeps before deleting (bytes or a subtree),
    so that cuundo can restore it.

[polling]{.index}
:   Regular `list` through the provider (cumonitor); works the same
    locally, in a ZIP and remotely.

[sync plan]{.index}
:   Result of `cusync::plan`: copy actions for one direction, never
    deletions.

[msgcat]{.index}
:   Tcl package for translations; in ctrlutils 0.4, cufileops, cuundo
    and cufilter take their texts from it, catalog in the namespace
    `::ctrlutils`.

[test limit]{.index}
:   Time limit per test file in seconds (`CTRLUTILS_TESTGRENZE` and so
    on, default 120).

[site-tcl]{.index}
:   Directory in the default module path of a Tcl installation
    (`lib/tcl8/site-tcl`, `lib/tcl9/site-tcl`).

[Explorer]{.index}
:   Reference app in ctrlutils.

[Dateiblick]{.index}
:   End-user app on the stack.

[tical]{.index}
:   Calendar and iCalendar engine (1.1) in a repo of its own; core
    without Tk, renderers for text, Tk canvas and PDF; loaded through
    `auto_path`.

[tical::event]{.index}
:   Appointment format of tical (`summary`, `dtstart`, `dtend`, `allday`
    …) with `normalize` and `validate`; applies to views, model,
    iCalendar and SQLite.

[ViewSpec]{.index}
:   Dict of a tical view (`month-grid`, `week-grid`, `day-grid`) with a
    grid of cells; input of every renderer.

[holiday plugin]{.index}
:   Command that returns a dict `date → name` for a year, registered
    under a region with `tical::holidays` (`DE`).

---

## Summary

- The terms above carry the book: pairing, provider, caps, operation
  record, test limit, ViewSpec.

---

*Next chapter: [Error Messages](830-anhang-fehlermeldungen.md)*
