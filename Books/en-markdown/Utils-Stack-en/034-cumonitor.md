# Watching a Directory: cumonitor

[cumonitor]{.index} 0.2 polls `list` of the provider and compares a
signature made of name, type, size and mtime. No inotify. Polling is the
way that works the same locally, in a ZIP and on remote providers. The
module needs no Tk, but an event loop.

```tcl
::ctrlutils::cumonitor::install $f $prov -interval 2000 \
    -onchange [list ::app::onDirChanged $f]
::ctrlutils::cumonitor::watch $f $dir    ;# neue Basis, feuert nicht
# nach eigenen Änderungen der App:
::ctrlutils::cumonitor::poke $f
::ctrlutils::cumonitor::stop $f          ;# beim Schließen des Tabs
```

- `-interval` in milliseconds, default 2000.
- `-onchange` gets the changed directory appended. An error in the
  callback is swallowed; polling goes on.
- An unknown option throws `{CTRLUTILS CUMONITOR OPTION -name}` and
  names the known ones. Before 0.2 this was an error without an error
  code.
- The first snapshot is the baseline; only a real difference fires.
  `watch` silently sets a new baseline, so navigating does not look like
  a change.
- `watch` before `install` is an error: `cumonitor: <f> not installed`.
  If no monitor at all has been installed in the process yet, `watch`,
  `poke` and `stop` report `can't read "state": no such variable`
  instead (checked, Tcl 8.6.14 and 9.0.4). So `stop` is safe only after
  the first `install`.
- A directory that can no longer be read counts as a change.
- Without `poke` after its own operations, the monitor reports them
  back.
- `stop` can be repeated and discards the state.

Checked (Tcl 8.6.14 and 9.0.4, Linux): under `tclsh` with `vwait` and
`-interval 200`, `-onchange` fires after a file is created and gets the
watched directory appended.

The Explorer sets the interval to 2000 ms and calls `stop` when a tab
is closed. This is in the chapter
[Explorer and Dateiblick](050-explorer-und-dateiblick.md).

---

## In short

- Signature: name, type, size, mtime.
- `watch` does not fire. `poke` swallows the app's own changes.
- An error in the callback does not stop polling.
- Load without Tk, run with an event loop.

---

*Next chapter: [Mirroring: cusync](036-cusync.md)*
