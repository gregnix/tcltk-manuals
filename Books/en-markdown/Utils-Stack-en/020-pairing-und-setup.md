# Pairing and Setup

## Recommended Pairing

| Lib | Version | needs |
|---|---|---|
| tclutils | 0.69.0 | — |
| tkutils | 0.49.0 | tclutils 0.64 or newer (`tusettings`, `tustr::graphemes`, `tudate::zones`, `tutestrun`); 0.69.0 for the CSV export of `tkutablelist` and for `tkusysinfo` |
| ctrlutils | 0.4 | tkutils with `tkudialog` 0.3 and `tkufilelist` 0.2 |
| tical | 1.1 | nothing from the stack; optionally Tk, `pdf4tcl`, `tdbc::sqlite3`, for the import tclutils (`tuical`, `turrule`) |

The CHANGELOGs of tclutils 0.69.0 and tkutils 0.49.0 name the trio
"tclutils 0.69.0 + tkutils 0.49.0 + ctrlutils 0.5". The tkutils 0.49.0
umbrella still needs only tclutils 0.64.0 or newer; the CSV export of
`tkutablelist` 0.5 and the widget `tkusysinfo` need 0.69.0. ctrlutils
0.5 needs nothing new from tclutils or tkutils. The suites below ran with exactly this trio.

tical is not part of the trio. tclutils and ctrlutils never load it,
tkutils only in the two optional widgets `tkutical` and
`tkumonthcanvas`, which are not in the umbrella (chapter
[Calendar: tical](070-tical.md)).

The `ctrlutils` 0.5 umbrella contains `cufileops` **0.6**, `cuundo`
**0.5**, `cusync` **0.3** and `cufilter` **0.2**; `cumonitor` 0.2 is
unchanged. `cufileops` requires `tkutils::tkudialog 0.3` and
`tkutils::tkufilelist 0.2`; an older tkutils with dialog 0.2 is not
enough. What is new is in the chapters
[ctrlutils](030-ctrlutils.md) and
[cufileops and Undo](040-cufileops-und-undo.md).

On the numbering: in the ctrlutils CHANGELOG, `cufileops` 0.4 and
`cuundo` 0.3 (texts through msgcat, entry) are listed under "## 0.3".
They came when the umbrella was already called 0.3 and got no number of
their own. They belong to ctrlutils 0.3 as delivered. From 0.4 on, the
umbrella number goes up with every module.

The other two libraries bring little that is new for the stack:

- tkutils 0.49.0: `tkutablelist` 0.5 (row ids, sorting through
  `tablelist::sortByColumn`, CSV export of visible rows and columns only,
  in UTF-8), the Tablelist helpers `tkutlclip` 0.3 (Ctrl+C now works),
  `tkutlfind` 0.3 (matches stay right after sorting), `tkutlsort` 0.3,
  `tkutlstate` 0.4, `tkutltree` 0.3, new `tkutlfilter`, `tkutlgroup`,
  `tkutldrag` and `tkusysinfo`. The ctrlutils Explorer uses
  `tkutablelist` and `tkutlfind`; both run without a change to
  ctrlutils, and searching in the list benefits from the new
  `tkutlfind`.
- tclutils 0.69.0: `tucsv` 0.2 (Excel profiles, BOM, encoding),
  `tusqlite` 0.2 (parameter dict, `update`, `delete`), new `tusysinfo`
  and `tuedid`. ctrlutils uses none of them.
- tkutils 0.48.0: `tkulauncher` 0.3 (with `-scroll 1`, buttons added by
  `reload` get the wheel binding too) and `tkuload` 0.3 (exports
  `widgetByName`, `setValue`, `getValue`, `fill`, `collect`). ctrlutils
  uses neither.

- tclutils 0.68.0: fixes in 76 modules, each with a new number (list in
  the CHANGELOG). For the stack, `tuprovider` 0.2 (`head` of the local
  provider returns the content), `tuprovider::sftp` 0.2 and `tuopen` 0.2
  (on Windows, URLs go through `rundll32`; all commands exported)
  matter. tkutils and ctrlutils require these modules without a version
  number and load 0.2 unchanged. The release asks nothing new of them.
- tclutils 0.67.0: `tupdftext` 0.1, the text of a PDF file. tkutils and
  ctrlutils do not use it.
- tclutils 0.66.0: `tutask` 0.2 (fixes to `group`, `pool` and
  `-timeout`; requires `tclutils::common` 0.2). tkutils and ctrlutils do
  not use `tutask`.
- tkutils 0.47.0: `tkufiledialog` 0.2 (a double-click on a file returned
  `""`). The `tkutl*` helpers now load `tablelist_tile` like
  `tkutablelist`; before, `tkutils` together with `tkutltools` failed
  with `can't set "usingTile"` (according to the CHANGELOG). Option
  errors in ten modules follow `tkuopts` (`unknown option "…"` plus a
  line `Known:`).

---

## Setup Once

The file `tools/setup.tcl` is **identical** in tclutils and tkutils.
Sourcing either one makes **both** libraries findable — but not
ctrlutils. Add the [module path]{.index} for ctrlutils yourself:

```tcl
source /pfad/zu/tclutils/tools/setup.tcl     ;# oder .../tkutils/tools/setup.tcl
tcl::tm::path add /pfad/zu/ctrlutils/lib/tm

package require Tk
package require tclutils
package require tkutils
package require ctrlutils
```

Without the second line, `package require ctrlutils` ends with
`can't find package ctrlutils`. Single controllers can also be loaded on
their own (`package require ctrlutils::cufilter`). The `ctrlutils`
umbrella needs Tk and a display; without Tk, load only the Tk-free
controllers one by one (see
[Understanding the Stack](010-stack-verstehen.md)).

`ctrlutils` 0.3 does not load `tkutils::tkufilelist`, although
`cufileops` calls its procedures. Up to ctrlutils 0.3, load the list
yourself with `package require tkutils::tkufilelist` — otherwise the
first call ends with `invalid command name "::tkutils::tkufilelist::widget"`.

Since ctrlutils 0.4, `cufileops` loads `tkutils::tkufilelist 0.2`
itself. Checked (Tcl 8.6.14 and 9.0.4, Linux, Xvfb): after
`package require Tk` and `package require ctrlutils`,
`tkutils::tkufilelist` 0.2 is loaded; with ctrlutils 0.3 it is not.

Checked (Tcl/Tk 8.6.14 and 9.0.4, Linux, Xvfb): the setup above loads
tclutils 0.69.0, tkutils 0.49.0 and ctrlutils 0.5 with `cufileops` 0.6,
`cuundo` 0.5, `cufilter` 0.2, `cumonitor` 0.2, `cusync` 0.3, plus
`tkufilelist` 0.2, `tkutablelist` 0.5, `tuprovider` 0.2 and `tuopen`
0.2.

For each library, `setup.tcl` searches in this order and takes only
directories that exist:

| Rank | Location |
|---|---|
| 1 | `TCLUTILS_TM` / `TKUTILS_TM` (override, wins) |
| 2 | `<repo>/lib/tm` of the package that `setup.tcl` comes from |
| 3 | `<tcl-install>/<pkg>/lib/tm` next to the Tcl library |
| 4 | `/usr/local/share/tcltk/<pkg>/lib/tm` |
| 5 | `$XDG_DATA_HOME` or `$HOME/.local/share/tcltk/<pkg>/lib/tm` |
| 6 | sibling folder `<pkg>/lib/tm` |
| 7 | sibling folder `<pkg>-*/lib/tm` (highest version) |

If a package really is missing, only `package require` reports it — by
design.

On Windows, the two intended hits are in `TCLUTILS_TM` and in `lib/tm`
next to the sourced file. The candidate `/usr/local/share/tcltk/...` is
looked up on the current drive. The user path applies only when `HOME`
or `XDG_DATA_HOME` is set. The script does not read `USERPROFILE`.

---

## Installing into a Tcl Installation

Instead of `setup.tcl`, all three trees can be copied into the
[site-tcl]{.index} directory of a Tcl installation:
`<tcl>/lib/tcl8/site-tcl` for Tcl 8.6, `<tcl>/lib/tcl9/site-tcl` for
Tcl 9. In general it sits next to the Tcl library:
`[file dirname [info library]]/tcl8/site-tcl`. Debian uses several
places for it, among them `/usr/share/tcltk/tcl8/site-tcl` and
`/usr/lib/tcltk/tcl8/site-tcl` (according to `tcl::tm::path list` under
Tcl 8.6.14). This directory is already in the default module path;
after that, `package require` is enough.

What is copied is the **content** of `lib/tm` with its subfolders:

```
site-tcl/
    tclutils-0.69.0.tm
    tclutils/            tu*-Module, Unterordner tuprovider/
    tkutils-0.49.0.tm
    tkutils/
    ctrlutils-0.5.tm
    ctrlutils/           cufileops-0.6, cufilter-0.2, cumonitor-0.2,
                         cusync-0.3, cuundo-0.5
```

Checked (Tcl/Tk 8.6.14 and 9.0.4, Linux, Xvfb): exactly this layout in a
test directory, added through `TCL8_6_TM_PATH` or `TCL9_0_TM_PATH`,
loads all three umbrellas. A real `lib/tcl9/site-tcl` is not checked.

tical does not belong in this layout: its packages are listed in a
`pkgIndex.tcl` and are found through `auto_path`. The whole `tical/`
folder therefore belongs in a directory that is on the `auto_path` (for
Tcl 9 under `/opt/tcl9`, for example `/opt/tcl9/lib`; on Debian, for
example `/usr/local/share/tcltk`), or its parent directory goes into
`TCLLIBPATH`. Checked (Tcl 8.6.14 and 9.0.4, Linux): with the parent
directory in `TCLLIBPATH`, `package require tical` loads version 1.1.
More in the chapter [Calendar: tical](070-tical.md).

None of the three repos ships an installation script. If you write one:
derive the target directory from the Tcl version, copy the three
`lib/tm` trees recursively, remove old files of the same modules first.
This is necessary because module names carry the version: when simply
copying over, the old file stays next to the new one. When moving to
this pairing, these are:

| Lib | delete old files |
|---|---|
| ctrlutils 0.5 | `ctrlutils-0.4.tm`; in `ctrlutils/`: `cufileops-0.5.tm`, `cuundo-0.4.tm`, `cusync-0.2.tm`, `cufilter-0.1.tm`, plus `cufileops-0.4.tm`, `cuundo-0.3.tm`, `cusync-0.1.tm` (they were still in the 0.4 tree); coming from 0.3, the file `ctrlutils-0.3.tm` instead of `ctrlutils-0.4.tm`, from even older trees also `cufileops-0.3.tm`, `cuundo-0.2.tm` |
| tkutils 0.49.0 | `tkutils-0.48.0.tm`; in `tkutils/`: `tkutablelist-0.4.tm`, `tkutlclip-0.2.tm`, `tkutlfind-0.2.tm`, `tkutlsort-0.2.tm`, `tkutlstate-0.3.tm`, `tkutltools-0.2.tm`, `tkutltree-0.2.tm`, `tkuical-0.2.tm`, `tkuvcard-0.2.tm`, `tkuldif-0.2.tm`, `tkuini-0.2.tm`, `tkutical-0.3.tm`, `tkunotes-0.2.tm`, `tkueditor-0.2.tm`, `tkubase64-0.1.tm`, `tkutlfooter-0.3.tm`, `tkulauncher-0.3.tm`, `tkuhexedit-0.1.tm` (coming from 0.47.0, the file `tkutils-0.47.0.tm` instead of `tkutils-0.48.0.tm`, plus `tkulauncher-0.2.tm`, `tkuload-0.2.tm`; coming from 0.46.0, the file `tkutils-0.46.0.tm` instead of `tkutils-0.47.0.tm`, plus `tkufiledialog-0.1.tm`, `tkutlclip-0.1.tm`, `tkutlfind-0.1.tm`, `tkutlsort-0.1.tm`, `tkutltools-0.1.tm`, `tkutltree-0.1.tm`, `tkutlfmt-0.2.tm`, `tkutlfooter-0.2.tm`, `tkutlstate-0.2.tm`) |
| tclutils 0.69.0 | `tclutils-0.68.0.tm`, in `tclutils/` `tucsv-0.1.tm`, `tusqlite-0.1.tm`, `tuholiday-0.1.tm`, `tuzip-0.1.tm`, `tudiff-0.1.tm`, `tubookmark-0.2.tm`, `tuical-0.1.tm`, `tuvcard-0.1.tm`, `tuini-0.1.tm`, `tupatch-0.2.tm`, `tusplit-0.2.tm`, `tutee-0.2.tm`, `tumd-0.1.tm`, `tuiconv-0.1.tm`, `tucat-0.1.tm`, `tuldif-0.2.tm`, `tucsplit-0.1.tm`, `tuhead-0.1.tm`, `tutail-0.1.tm`, `tugrep-0.1.3.tm`, `tustr-0.2.tm`, `tuer-0.3.tm`, `tugantt-0.2.tm`, `tuxychart-0.1.tm`, `tusankey-0.1.tm`, `tudate-0.2.tm`, `tunumany-0.2.tm`, `tubase64-0.1.tm`, `tucrc-0.1.tm`, `tudav-0.2.tm`, `tuflow-0.3.tm`, `tuc4-0.1.tm`, `tugit-0.2.tm`, `turadar-0.2.tm`, `tusort-0.1.tm`, `tuuniq-0.1.tm`, `tucut-0.1.tm`, `tupaste-0.2.tm`, `tujoin-0.1.2.tm`, `tushuf-0.2.tm`, `tucolumn-0.1.tm`, `tufold-0.2.tm`, `tufmt-0.1.tm`, `tutestrun-0.1.tm`, `tuarchitecture-0.2.tm`, `tustate-0.1.tm`, `tublock-0.1.tm`, `tunotes-0.1.tm`, `tumindmap-0.1.tm`, `common-0.2.tm`, `tused-0.1.3.tm`, `tusettings-0.1.tm`, `tuimage-0.1.tm`, `tuprovider-0.2.tm`, `tutreemap-0.2.tm`, `tuclass-0.2.tm`, `tupacket-0.2.tm`, `tujourney-0.2.tm`, `tukanban-0.1.tm`, `tutimeline-0.2.tm`, `tupie-0.2.tm`, `tuquadrant-0.1.tm`, `tusequence-0.2.tm`, `tudiagram-0.5.tm`, `tusvg-0.3.tm`, `tupngdraw-0.13.tm`, `tupng-0.5.tm`, `tuappinfo-0.2.tm`; coming from 0.67.0, the file `tclutils-0.67.0.tm` instead of `tclutils-0.68.0.tm`, plus the old files of the 76 modules with a new number in 0.68.0 (list in the CHANGELOG), among them `tuprovider-0.1.tm`, `tuopen-0.1.tm`, `tuprovider/sftp-0.1.tm`; from older trees also `tclutils-0.66.0.tm`, `tclutils-0.65.0.tm` and `tutask-0.1.tm` |

After that: an installed copy can hide a working tree — see the test
section below.

---

## Tests

Every library ships `tests/all.tcl`. For ctrlutils:

```bash
cd ctrlutils
tclsh tests/all.tcl
tclsh tests/all.tcl -match 'cufileops-*'
```

Options such as `-match` are passed to every test file. With
`-match 'cufileops-*'` all eight files run, but only in `cufileops.test`
does a test match; the others report everything as skipped.

The runner is [tutestrun]{.index} from tclutils (since 0.64). `all.tcl`
takes it from its own `lib/tm`, from `$TCLUTILS_TM` or from the sibling
checkout `tclutils*/lib/tm` — never from an installed copy. If it does
not find it: `all.tcl: tclutils::tutestrun not found (set
TCLUTILS_TM)`, exit 2 (checked with a copy of `tests` and `lib` without
sibling checkouts).

Every `.test` file runs in a process of its own. Before the run, the
runner prints a banner showing which file ctrlutils, tkutils and
tclutils are loaded from, for example:

```
Modules resolve to:
  ctrlutils  0.5      .../ctrlutils/lib/tm/ctrlutils-0.5.tm
  tkutils    0.49.0   .../tkutils/lib/tm/tkutils-0.49.0.tm
  tclutils   0.69.0   .../tclutils/lib/tm/tclutils-0.69.0.tm
```

If a second version sits next to it, `(also: <version>)` follows, for
example `(also: 0.4)` as long as `ctrlutils-0.4.tm` sits next to
`ctrlutils-0.5.tm`. The runner does not see old files of the single
modules; a tree of ctrlutils 0.4 still contained `cufileops-0.4.tm`,
`cuundo-0.3.tm` and `cusync-0.1.tm` without the banner showing it. Variables that are set,
such as `TCL8_6_TM_PATH` or `TCLUTILS_TM`, are each reported in a line
`note: <VAR> is set: …`.

Own trees come first: the runner takes them out of `TCL8_6_TM_PATH` /
`TCL9_0_TM_PATH` and puts them at the front in the test process. A test
file started directly, without the runner, lacks this protection.

Time limit per file: [CTRLUTILS_TESTGRENZE]{.index} in seconds, default
120. tclutils and tkutils follow the same scheme with
`TCLUTILS_TESTGRENZE` and `TKUTILS_TESTGRENZE`. At the end comes
`All test files passed` or a list `Files with problems:` with the reason
per file: `N failed`, `no summary`, `exit code / error`,
`hang after Ns`, `could not start`. The exit code is then 1.

Checked with ctrlutils 0.5, tkutils 0.49.0 and tclutils 0.69.0 (Linux,
Xvfb), the same under Tcl/Tk 8.6.14 and 9.0.4:

- 8 test files, **91** tests, all green (`cufileops` 27, `cufilter` 7,
  `cumonitor` 6, `cusync` 14, `cuundo` 15, `headers` 1, `smoke` 20,
  `versions` 1).
- New compared to ctrlutils 0.4 (82 tests): `cusync-4.1` to `4.3`
  (listing fails), `cufileops-13.1` (cut after a partial failure),
  `cufileops-13.2` (`refresh`), `cuundo-12.1`, `12.2` (`-refresh`),
  `cufilter-10.1`, `10.2` (filter error).
- New in ctrlutils 0.4 compared to 0.3 (76 tests): `cuundo-1.10` (redo),
  `cusync-3.6` (options), `cusync-3.7` (mtime), `cuundo-11.1`
  (dialog parent, msgcat), `cufileops-12.1` (`owSetApp`),
  `cufilter-9.1` (msgcat).
- `CTRLUTILS_TESTGRENZE=1` reports `cumonitor.test (hang after 1s)`
  (checked with ctrlutils 0.3).
- `cumonitor.test` works in the system temp directory; an interrupted
  run no longer leaves `cumon/` in the tree.

Without a display, the tests of `cufileops` and `cufilter` are skipped.
In ctrlutils 0.3, `smoke.test` then fails in `explorer-0-load`
(`couldn't connect to display`), exit 1. Since 0.4, `smoke.test` skips
this test: 20 skipped, 0 failures. So use a display for the Tk tests (on
Linux without a screen: `xvfb-run -a tclsh tests/all.tcl`).

The suites of the other two libraries (Linux, Xvfb), 0 failures each:

| Suite | Tests | Tcl 8.6.14 | Tcl 9.0.4 |
|---|---|---|---|
| tclutils 0.69.0 | 2620 | 2595 passed, 25 skipped | 2603 passed, 17 skipped |
| tkutils 0.49.0 | 947 | 935 passed, 12 skipped | 944 passed, 3 skipped |

The tkutils suite ran with tical as a sibling checkout; without tical,
`tkutical.test` and `tkumonthcanvas.test` skip their tests. The suite of
tical itself is in the chapter [Calendar: tical](070-tical.md).

On macOS (Darwin 27, arm64, Tcl/Tk 9.0.4 with Aqua) the three suites
passed without failures before the write-error tests:

| Suite | Tests | passed | skipped |
|---|---|---|---|
| tclutils 0.69.0 | 2582 | 2567 | 15 |
| tkutils 0.49.0 | 938 | 896 | 42 |
| ctrlutils 0.4 | 82 | 82 | 0 |

On Windows the three suites of the same state also passed without
failures, Tcl 8.6.17 with the system encoding cp1252 and Tcl 9.0.4:

| Suite | Tests | Tcl 8.6.17 | Tcl 9.0.4 |
|---|---|---|---|
| tclutils 0.69.0 | 2582 | 2545 passed, 37 skipped | 2549 passed, 33 skipped |
| tkutils 0.49.0 | 938 | 927 passed, 11 skipped | 935 passed, 3 skipped |
| ctrlutils 0.4 | 82 | 82 passed | 82 passed |

The skips on Windows come from the platform (`unix`) and from missing
packages (Zipfs, SFTP, HTTPS).

---

## Summary

- Pairing 0.69.0 / 0.49.0 / 0.5; the ctrlutils 0.5 umbrella contains
  `cufileops` 0.6, `cuundo` 0.5, `cusync` 0.3 and `cufilter` 0.2. tical 1.1.1 optional
  beside it.
- `setup.tcl` knows tclutils and tkutils; ctrlutils via
  `tcl::tm::path add …/ctrlutils/lib/tm`; load `tkufilelist` yourself up
  to ctrlutils 0.3, from 0.4 on `cufileops` loads it.
- Alternatively copy all three `lib/tm` trees into `site-tcl`, removing
  old module files first.
- `tclsh tests/all.tcl`; read the banner, limit via `*_TESTGRENZE`.

---

*Next chapter: [ctrlutils](030-ctrlutils.md)*
