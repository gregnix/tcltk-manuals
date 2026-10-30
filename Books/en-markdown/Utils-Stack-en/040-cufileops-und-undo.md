# cufileops and Undo

## install

```tcl
ctrlutils::cufileops::install $f $prov $listwidget $refreshcmd ?-onop script?
```

- `$f` — identity of the view (e.g. tab frame); all state hangs on it
- `$prov` — provider
- `$listwidget` — a `tkufilelist`
- `$refreshcmd` — script after every successful change (re-read the list)
- `-onop script` — optional; gets an operation record (dict) appended
  after every successful operation. The only consumer so far: cuundo.

An unknown option is an error with the error code
`{CTRLUTILS CUFILEOPS OPTION <opt>}` and names the known ones. An option
without a value reports `missing value for option "-onop"` (checked, Tcl
8.6.14 and 9.0.4). Up to 0.1, `install` silently swallowed a typo such
as `-onpo` — undo was then simply off.

The chapter applies to `cufileops` 0.5 and `cuundo` 0.4 from ctrlutils
0.4. The steps before:

| ctrlutils | cufileops / cuundo | new |
|---|---|---|
| 0.3 | 0.3 / 0.2 | multiple selection on right-click, dialog 0.3 |
| 0.3 (addendum) | 0.4 / 0.3 | texts through msgcat |
| 0.4 | 0.5 / 0.4 | `tkufilelist` loaded, `owSetApp`, redo kept, cuundo dialogs with `-parent`, cuundo reasons through msgcat |

The behaviour of the operations themselves is the same across all
steps.

---

## Menu and Keys

[cufileops]{.index} rebuilds the context menu on every right-click, from
the [caps]{.index} of the provider. An entry appears only if the
operation can succeed:

| Entry | appears when |
|---|---|
| New Folder | `mkdir` |
| Open | file, `get` |
| `Open with <App>` | file, `get`, default app registered for the extension |
| Open with... | file, `get` |
| Rename | `move` |
| Copy | file: `get`; directory: `list` and `get` |
| Cut | as Copy, plus `delete` on the source |
| Delete | `delete` |
| Paste | clipboard full; `put`, for directories also `mkdir` |

If none of these applies, the menu shows only the greyed-out entry
"(read-only)". A ZIP is not automatically "(read-only)": its caps are
`get list stat`, also with `tuprovider` 0.2 from tclutils 0.69.0
(checked, Tcl 8.6.14 and 9.0.4). Checked (Tcl/Tk 8.6.14, Linux, Xvfb):

- ZIP, file selected: `Open`, `Open with...`, separator, `Copy`.
- ZIP, nothing selected, clipboard empty: only "(read-only)".
- Local, directory selected: `New Folder`, `Rename`, `Copy`, `Cut`,
  `Delete`.
- Local, clipboard full, nothing selected: `New Folder`, `Paste`.

Keys on the list body: Delete (delete), F2 (rename), Ctrl+C, Ctrl+X,
Ctrl+V. Ctrl+X and Delete on a source without `delete` report this in a
dialog instead of silently doing nothing:
`Cut is not available here (the source cannot delete).` or
`Delete is not available here (the source cannot delete).` The other
keys do nothing without matching caps.

All dialogs of cufileops get the toplevel of the list as `-parent` and
appear over their own window, not in the middle of another monitor.
Since `cuundo` 0.4 this also applies to its error messages (toplevel of
the list from `-list`; without `-list` no `-parent`). In `cuundo` 0.3
from ctrlutils 0.3 they came without `-parent`.

---

## Opening

- **Open** starts the system's default app through `tclutils::tuopen`
  (fallback without tuopen: `xdg-open` / `open` / `cmd /c start`).
- **Open with...** asks for a program. The choice is remembered in a
  registry per file extension; matching installed programs are
  suggested (checked with `auto_execok`).
- **`Open with <App>`** appears as soon as a default app is set for the
  extension — one click, no dialog.

The registry is a Tcl dict in the file `openwith.dict`, stored through
`tuopen::configFile` in the configuration directory of the app
`explorer`, as long as the app sets no name of its own. Apps of your own
set it once at startup, before the first menu:

```tcl
::ctrlutils::cufileops::owSetApp meineapp
```

`owSetApp` (since `cufileops` 0.5, ctrlutils 0.4) accepts only letters,
digits, `.`, `_` and `-`. Anything else is an error
`invalid application name "…": use letters, digits, . _ -` with the
error code `{CTRLUTILS CUFILEOPS APPNAME <name>}`. It discards the cached
registry; the next access reads the file of the new app. Checked
(Tcl/Tk 8.6.14 and 9.0.4, Linux, Xvfb): `owSetApp "mein app"` reports
the error with `CTRLUTILS CUFILEOPS APPNAME {mein app}`; after
`owSetApp meineapp` and `owAddApp .txt vi` the registry is at
`$XDG_CONFIG_HOME/meineapp/openwith.dict`.

Up to ctrlutils 0.3 there was only the variable
`::ctrlutils::cufileops::owApp`. Every app without a value of its own
shared the registry of `explorer`. Setting the variable only after the
first access kept reading the old registry. New apps use `owSetApp`.

Checked on Linux: `$XDG_CONFIG_HOME/<app>/openwith.dict`; without
`XDG_CONFIG_HOME` it is under `$HOME/.config/<app>/`. According to
tuopen, on Windows `%APPDATA%\<app>`, on macOS
`$HOME/Library/Application Support/<app>` (not checked). Without
tuopen, it ends up as `<app>-openwith.dict` in `$TMPDIR` or `/tmp`.

Only the local provider opens an existing file directly. From a ZIP or a
remote provider, cufileops fetches the bytes with `get` into a
per-process temp directory `cufileops-<pid>-<µs>` under `TMPDIR`,
`TEMP`, `TMP` or `/tmp`. It disappears on the process's `exit`; leftovers
of dead processes or older than a day are cleaned up by the next call.
Checked (Tcl/Tk 8.6.14, Linux, Xvfb): `a.txt` from a ZIP was under
`$TMPDIR/cufileops-…/a.txt` when opened; after `exit` the directory was
gone. Double-click remains the app's business.

---

## Copy, Cut, Paste

Copy/paste runs through `get`+`put` in the controller, not through the
provider's `copy` — hence **cross-provider** (e.g. from a ZIP to local),
directories recursively. The clipboard applies module-wide to all tabs
and remembers the source provider. On a name clash, paste picks
`name (copy).ext`, then `name (copy 2).ext` and so on, and never
overwrites. If a directory fails halfway, paste deletes what it has
already created.

Cut marks for **moving**: paste writes at the target and then deletes
the source. So only if the source can `delete` — from a ZIP, copy works,
cut does not. A cut is used up by its paste; entries that could not be
copied stay on the clipboard as a cut since `cufileops` 0.6, so paste
tries them again. Up to 0.5 the whole cut was gone after a partial
failure. A cut into the same
directory of the same provider skips paste. If the source cannot be
deleted after copying, paste reports
`Copied, but could not remove the source:` and keeps the copy.

Checked (Tcl/Tk 8.6.14, Linux, Xvfb): `sub/` and `a.txt` copied from a
ZIP into a local directory, including `sub/c.txt`; pasting `a.txt` twice
gives `a (copy).txt` and `a (copy 2).txt`; cut of `b.txt` from one local
tab to another moves the file and empties the clipboard.

---

## Multiple Selection on Right-Click

Since 0.3, a right-click on an **already selected** row keeps the whole
[multiple selection]{.index} (file manager behaviour). Copy, cut and
delete then act on all selected entries. A right-click on a row that is
not selected selects only that one.

Technique: the right-click lets tablelist select the row itself
(synthetic Button-1) and then restores the previous selection if the
clicked row belonged to it. This needs `tkudialog` 0.3 and sensibly
`tkutablelist` 0.4 or newer with `-exportselection 0` — otherwise the menu takes
the PRIMARY selection and the highlight disappears.

Checked (Tcl/Tk 8.6.14, Linux, Xvfb): selection `0 2 3`, right-click on
row 2 — selection stays `0 2 3`; right-click on row 4 — selection
becomes `4`.

With several entries, delete asks once: `Delete 2 items?`; with one
entry `Delete file '<name>'?` or `Delete folder '<name>'?`.

---

## Language

Since `cufileops` 0.4 and `cuundo` 0.3, menu entries, prompts and error
messages go through [msgcat]{.index} as soon as it is loaded. Since
ctrlutils 0.4, so do the reasons of cuundo and the filter row of
cufilter. The modules load msgcat themselves if available. Texts with a
detail take `%s`. The app puts the translation in the namespace
`::ctrlutils`; msgcat also searches there from `::ctrlutils::cufileops`:

```tcl
package require msgcat
namespace eval ::ctrlutils {
    ::msgcat::mcset {} Rename Umbenennen
    ::msgcat::mcset {} "Could not rename:\n%s" "Umbenennen fehlgeschlagen:\n%s"
    ::msgcat::mcset {} "Delete file '%s'?" "Datei '%s' löschen?"
}
```

Without a catalog the texts stay English. The form with `{}` (applies to
every language) is checked by the test `cufileops-10.2`. Checked
(Tcl/Tk 8.6.14, Linux, Xvfb): the example above verbatim, locale `c` —
menu entry `Umbenennen` and prompt `Datei 'a.txt' löschen?` come out in
German; likewise with `mclocale de` and `mcset de`. The keys are the
English texts themselves, such as `New Folder`, `Open with %s`,
`Open with...`, `(read-only)`, `Delete %s items?`, `Undo failed:\n%s`.
Since ctrlutils 0.4, `Filter:` and `x` from cufilter and the reasons of
cuundo are added, such as `no saved content to restore` or
`cannot undo op %s` (test `cuundo-11.1`). In ctrlutils 0.3 these stay
English.

---

## cuundo

[cuundo]{.index} records **only** what cufileops reports through
`-onop`. The two do not know each other; the app makes the connection:

```tcl
::ctrlutils::cuundo::install $f $prov -list $list
::ctrlutils::cufileops::install $f $prov $list $refresh \
    -onop [list ::ctrlutils::cuundo::record $f]
```

`cuundo::install` returns `$f` and empties both stacks. Without `-onop`
the undo stack stays empty. A `record` before `cuundo::install` for this
`$f` is silently lost. Without `-list` there are no keys; `-list` binds
Ctrl+Z (undo) as well as Ctrl+Y and Ctrl+Shift+Z (redo) on the list
body. Here, too, an unknown option is an error
(`{CTRLUTILS CUUNDO OPTION <opt>}`). After undo and redo, cuundo
refreshes the list: with `-refresh script`, otherwise through
`cufileops::refresh $f`, that is the `$refreshcmd` of cufileops for the
same `$f`. If refreshing fails, undo or redo ends with
`{CTRLUTILS CUUNDO REFRESH}`; the step itself is already done. Up to
`cuundo` 0.4 cuundo called the internal procedure `cufileops::_refresh`
inside `catch`, and an error stayed invisible.

| Operation | Undo |
|---|---|
| Rename from → to | move back |
| New Folder | delete |
| Paste | delete the target |
| Delete | restore from snapshot |
| Cut + Paste | delete the target, restore the source |

cufileops takes the snapshot **before** deleting (the bytes of a file or
a whole subtree, in memory). So a delete can only be undone if the
provider can read the content. Undo of New Folder and Paste in turn keeps
a snapshot so that redo restores what was deleted.

Checked (Tcl/Tk 8.6.14, Linux, Xvfb): New Folder → undo → redo; second
paste undone; delete of `b.txt` undone (content back); rename `b.txt` →
`b2.txt` undone; cut from one tab to the other undone — all as in the
table.

Further calls: `undo`, `redo`, `canUndo` / `canRedo` (for menu states),
`clear`. New activity empties the redo stack.

cuundo shows errors through `tkudialog::showError` if tkudialog is
loaded (`Undo failed:` or `Redo failed:` plus the reason). A failed undo
stays on the undo stack. Since `cuundo` 0.4 (ctrlutils 0.4) a failed redo
also stays on the redo stack. Checked (Tcl 8.6.14 and 9.0.4, Linux,
Xvfb): test `cuundo-1.10` then gives `canRedo` 1; `cuundo.test` 13 of
13 passed. In `cuundo` 0.3 from ctrlutils 0.3 a failed redo is lost: it
ends up on no stack (afterwards `canRedo` 0 and `canUndo` 0).

`cuundo` 0.4 no longer requires `tclutils::tuprovider`; it only calls
the provider object it gets with `install`.

Apps should also pass changes of their own (such as a rename from a
form) as an [operation record]{.index} to `cuundo::record` — the same
undo trail as in the menu (Dateiblick: done according to the review, not
checked here). The records that cufileops produces:

```
op mkdir   path P
op rename  from A to B type file|dir
op paste   path P type file|dir
op delete  path P type file|dir saved SNAP
op movex   srcprov S dstprov D from A to B type file|dir saved SNAP
```

`SNAP` is `type file bytes …` or `type dir children {name SNAP …}`.
`movex` comes from a cut; if deleting the source fails there, cufileops
reports `paste` instead.

---

## Putting It Together

Runs under `wish` (Tablelist on the `auto_path`):

```tcl
source /pfad/zu/tclutils/tools/setup.tcl
tcl::tm::path add /pfad/zu/ctrlutils/lib/tm
package require Tk
package require ctrlutils
package require tclutils::tuprovider
package require tkutils::tkufilelist

set prov [::tclutils::tuprovider open local]
set f    [ttk::frame .tab]
::tkutils::tkufilelist::widget $f.l -provider $prov -dir [pwd]
::ctrlutils::cufilter::widget $f.filter $f.l
pack $f.filter -side top -fill x
pack $f.l -side top -fill both -expand 1
pack $f -fill both -expand 1

set refresh [list ::tkutils::tkufilelist::refresh $f.l]
::ctrlutils::cuundo::install $f $prov -list $f.l
::ctrlutils::cufileops::install $f $prov $f.l $refresh \
    -onop [list ::ctrlutils::cuundo::record $f]
::ctrlutils::cumonitor::install $f $prov -interval 2000 \
    -onchange [list apply {{cmd dir} {uplevel #0 $cmd}} $refresh]
::ctrlutils::cumonitor::watch $f [pwd]
```

Checked (Tcl/Tk 8.6.14 and 9.0.4, Linux, Xvfb, tclutils 0.69.0): the
example runs; the bindings on the list body are then `Button-3`,
Delete, F2, Ctrl+C/V/X/Y/Z and Ctrl+Shift+Z.

The Explorer wires things the same way, with a refresh callback of its
own that also refreshes the tree after every operation and calls
`cumonitor::poke`.

---

## Summary

- caps control the menu; "(read-only)" only if nothing fits at all.
- cufileops 0.3 = multiple selection on right-click + dialog 0.3;
  0.4 = texts through msgcat; 0.5 = `tkufilelist` loaded, `owSetApp`;
  0.6 = cut kept after a partial failure, `refresh`.
- Apps of your own set `cufileops::owSetApp meineapp`, otherwise they
  share the "Open with" registry with the Explorer.
- Undo only with `-onop [list ::ctrlutils::cuundo::record $f]`; keys
  only with `cuundo::install … -list $list`.
- A failed undo or redo stays on its stack since ctrlutils 0.4; in 0.3 a
  failed redo was lost.

---

*Next chapter: [Explorer and Dateiblick](050-explorer-und-dateiblick.md)*
