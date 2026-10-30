# Mirroring: cusync

[cusync]{.index} 0.2 is Tk-free and runs under `tclsh`. Each side has
its own provider. Local, ZIP, WebDAV and SFTP can be mixed. The flow is
compare, then plan, then apply. One way and without deleting: nothing is
removed on the target. There is no option for deleting. The dialog comes
from the Explorer, not from cusync.

```tcl
package require tclutils::tuprovider
package require ctrlutils::cusync

set pL [::tclutils::tuprovider open local]
set pR [::tclutils::tuprovider open local]
set diffs [::ctrlutils::cusync::compare $pL $dirL $pR $dirR]
set plan  [::ctrlutils::cusync::plan $diffs LR]
set res   [::ctrlutils::cusync::apply $pL $dirL $pR $dirR $plan]
```

Checked (Tcl 8.6.14 and 9.0.4, Linux) with `a.txt` and `sub/b.txt` on
the left and only `nur-rechts.txt` on the right: four diffs (`a.txt`,
`sub`, `sub/b.txt` as `onlyLeft`, `nur-rechts.txt` as `onlyRight`),
three actions in the plan, result `done 3 errors {}`. A second
`compare` afterwards reports `a.txt` `same`, `nur-rechts.txt`
`onlyRight` and `sub/b.txt` `same`; the directory `sub`, now on both
sides, is no longer in the list. The file on the right stays.

---

## compare

`compare` returns a dict per entry. Parents come before children.

| Key | Content |
|---|---|
| `rel` | path relative to both roots, `/`, without a leading slash |
| `name` | leaf name |
| `status` | see table |
| `ltype` | `file`, `dir` or `""` if missing on the left |
| `rtype` | `file`, `dir` or `""` if missing on the right |

| Status | Meaning |
|---|---|
| `onlyLeft` | left only |
| `onlyRight` | right only |
| `newerLeft` | both, left newer |
| `newerRight` | both, right newer |
| `diff` | both, same or missing mtime, different size |
| `same` | both, same mtime and size |
| `conflict` | file against directory |

Directories that exist on one side only are entered. Every file below
gets an entry of its own. A directory that exists on both sides has no
entry itself; only its content appears.

`same` compares only size and mtime, not the content. Two files with
equal metadata and different content count as the same.

If a directory that exists on one side cannot be listed, `compare` ends
with the error `{CTRLUTILS CUSYNC LIST side dir}` (`side` is `L` or
`R`). Up to ctrlutils 0.4 (`cusync` 0.2) this side counted as empty: if
listing the target failed, every source file became `onlyLeft`, and
`apply` copied it over the target, newer files included. The Explorer
shows the error in the status line of the dialog.

---

## plan

`plan` turns the diffs into copy actions `{op copy rel … type file|dir}`
for one direction, `LR` or `RL`. What is copied is what is missing on
the target or older or different there. The side that exists only on
the target does not come across. Neither does `conflict`. An `LR` plan
skips `onlyRight`, an `RL` plan skips `onlyLeft`.

---

## apply and applyOne

`apply` runs the plan and returns `done N errors {…}`. An error text
starts with the relative path, for example
`fehlt.txt (read): couldn't open …` or `… (write): …`. An error does not
abort the rest.

`-ondir` and `-onfile` get the relative path appended for each action,
before the action. An error in the callback is ignored. In `cusync` 0.1
from ctrlutils 0.3, `apply` does not check other options. A typo stays
silent. Since 0.2, an unknown option is an error
`unknown option "-x"` with the line `Known: -onfile -ondir` and the
error code `{CTRLUTILS CUSYNC OPTION -x}`. An option without a value
reports `missing value for option "-onfile"` with the error code
`{CTRLUTILS CUSYNC OPTION}` (checked, Tcl 8.6.14 and 9.0.4, Linux, Xvfb).

`applyOne` runs a single action and returns `ok 1` or `ok 0 error …`. A
user interface can work through the plan step by step with `after`.
Before a file, `applyOne` creates the parent directory on the target
with `mkdir`. An error there stays silent.

`applyOne` transfers the source mtime with `file mtime`. This only works
for local paths; otherwise it stays silent. In ctrlutils 0.3, with a
ZIP, DAV or SFTP target, a local file of the same name could get the
mtime. Since ctrlutils 0.4, `applyOne` transfers the mtime only when
both providers are the local one (test `cusync-3.7`).

---

## In short

- compare, plan, apply. Direction `LR` or `RL`.
- Nothing is deleted.
- A listing error stops `compare` (since `cusync` 0.3).
- `apply` collects errors and goes on. `applyOne` takes one action.
- mtime only between two local providers.

---

*Next chapter: [cufileops and Undo](040-cufileops-und-undo.md)*
