# ctrlutils

## Five Controllers

| Module | Role | Tk |
|---|---|---|
| `cufileops` 0.5 | context menu and keys on the file list: new, open, open with, rename, copy, cut, paste, delete | yes |
| `cuundo` 0.4 | undo/redo for the operations of cufileops | loads without Tk; keys only with `-list` |
| `cufilter` 0.1 | a filter row of its own above the list | yes |
| `cumonitor` 0.2 | watch a directory by polling, callback on change | no (only `after`) |
| `cusync` 0.2 | compare two trees and mirror one way | no |

```tcl
package require ctrlutils
# oder einzeln: package require ctrlutils::cufileops 0.6
```

`package require ctrlutils` loads all five and needs Tk for that. Since
ctrlutils 0.4, `cufileops` also loads `tkutils::tkufilelist` 0.2; up to
0.3 the app had to do this itself. Docs:
`ctrlutils/docs/<modul>.md`, man pages: `ctrlutils/man/mann/<modul>.n`.
Suite: **91** tests in 8 files (checked, Tcl/Tk 8.6.14 and 9.0.4, Linux,
Xvfb).

New in ctrlutils 0.5, in brief:

- `cusync`: a directory that cannot be listed is an error
  `{CTRLUTILS CUSYNC LIST side dir}`. Up to 0.4 the side counted as
  empty, and the mirror copied every source file over it.
- `cufileops`: entries of a cut that could not be copied stay on the
  clipboard. New `refresh $f`.
- `cuundo`: option `-refresh`; a failing refresh is an error instead of
  being swallowed.
- `cufilter`: a filter that cannot be set marks the row and stays
  readable through `lastError`.

New in ctrlutils 0.4, in brief:

- `cuundo`: a failed redo stays on the redo stack. The error dialogs get
  `-parent`, the reasons go through msgcat. `tclutils::tuprovider` is no
  longer loaded by it.
- `cufileops`: loads `tkufilelist` 0.2; new `owSetApp` for the app name
  of the "Open with" registry.
- `cufilter`: "Filter:" and "x" go through msgcat.
- `cusync`: checks the options of `apply`; it transfers the mtime only
  between two local providers.
- Explorer: the start message for a missing module also names the module
  path.

Every [controller]{.index} depends only on the provider interface of
tclutils and on tkutils widgets — never on a particular app. State lives
per view under a key `$f` (e.g. the tab frame); several views thus stay
separate. Undo and list find each other through the same `$f`: install
cufileops and cuundo for a view with the same key.

---

## Dependency on the View

`cufileops` 0.5 needs `tkucontextmenu`, `tkudialog` 0.3 and
`tkufilelist` 0.2; `tuopen` (open with the default app) and `msgcat` are
optional. It works with `tkutablelist` 0.4 or newer (default
`-exportselection 0`), so that the multiple selection is not lost on a
right-click. `cufileops` 0.4 from ctrlutils 0.3 called `tkufilelist`
without loading it. Details:
[cufileops and Undo](040-cufileops-und-undo.md).

---

## More

The three smaller modules have chapters of their own:
[Filter](032-cufilter.md),
[Watching a Directory](034-cumonitor.md),
[Mirroring](036-cusync.md). File operations and undo are in the chapter
[cufileops and Undo](040-cufileops-und-undo.md).

---

## Summary

- Five modules. cufileops, cuundo and cumonitor attach to existing
  paths. cufilter builds a row of its own. cusync computes without Tk.
- The umbrella needs Tk. cusync, cumonitor and cuundo also load without.
- ctrlutils 0.4 loads `tkufilelist`, keeps a failed redo, checks the
  options of `cusync` and takes an app name of its own for "Open with".
- ctrlutils 0.5 makes a listing error in `cusync` loud and keeps the
  rest of a cut after a partial failure.

---

*Next chapter: [Filter](032-cufilter.md)*
