# File Widgets

## List and Tree

| Widget | Role |
|---|---|
| `tkufilelist` 0.2 | detail list of a directory through a provider |
| `tkufiletree` 0.2 | lazy tree; local or with `-provider` |
| `tkupath` 0.3 | path bar (breadcrumb) |
| `tkupreview` 0.2 | preview (text, Markdown, message, …) |

The widgets talk to a [provider]{.index} from `tclutils::tuprovider`,
not to the fixed file system. Without `-provider`, `tkufilelist` creates
a local one itself.

```tcl
package require tclutils::tuprovider
package require tkutils::tkufilelist

set prov [::tclutils::tuprovider open local]
::tkutils::tkufilelist::widget .l -provider $prov -dir [pwd] \
    -onactivate {apply {e {
        if {[dict get $e type] eq "dir"} {
            ::tkutils::tkufilelist::setDir .l [dict get $e path]
        }
    }}}
pack .l -fill both -expand 1
::tkutils::tkufilelist::setFilter .l *.txt
```

Callbacks receive the provider's entry as a dict with `name`, `path`,
`type` (`file`/`dir`), `size` and `mtime`; `size` and `mtime` may be
empty. Further commands: `dir`, `refresh`, `selectedEntry`,
`selectedEntries`. `tkufilelist` builds on `tkutablelist` and therefore
needs Tablelist.

Options of `widget`: `-provider`, `-dir` (default `/`, not the current
directory), `-files` (default 1), `-showhidden` (default 0), `-filter`,
`-onactivate` (double click or Return), `-onselect`, `-height`
(default 16). `setFilter` takes **one** glob pattern, case-insensitive;
folders always stay visible so that navigation remains possible. Sorting
by a header click keeps the mapping row → entry, because the entry is
stored as a row attribute of the Tablelist.

Controllers (`cufileops`, filter, monitor) wire up behavior — book
*Utils-Stack*. ZIP/remote: the provider's caps control write actions.

---

## tkufiletree

[tkufiletree]{.index} reads subdirectories only when they are expanded.
Options: `-root`, `-filter` (glob list, case-insensitive), `-files`,
`-showhidden`, `-provider`, `-onactivate`, `-onselect`, `-height`,
`-isolatekeys`.

```tcl
package require tkutils::tkufiletree
set t [::tkutils::tkufiletree::widget .t -root [pwd] -showhidden 1 \
    -filter {*.txt *.md} \
    -onactivate {apply {p {puts "öffnen: $p"}}}]
pack $t -fill both -expand 1
::tkutils::tkufiletree::reveal $t [file join [pwd] README.md]
```

Item ids are the normalized full paths. `reveal` expands down to the
target and returns 1 if exactly this target was selected, otherwise 0.
Further commands: `setRoot`, `root`, `up` (also BackSpace), `refresh`,
`refreshDir`, `selectedPath`, `treeview`, `volumesRoot`.

### Hidden Files on Windows

With `-showhidden 1` the tree reads `*` and `.*`. On Windows, `*`
already matches the dot files, so they came twice, and the treeview
aborted with `ITEM_EXISTS`. Since 0.46.0 the matches are deduplicated
with `lsort -unique` before insertion (test `tkufiletree-1.7`).

Without `-root`, the current directory counts. `volumesRoot` returns a
special value for `-root`: a virtual node *This PC* with all drives. At
a drive root, `up` climbs there when there is more than one drive.

---

## tkupath 0.3

[tkupath]{.index} shows a path as a row of buttons. A click sets the bar
to that partial path and calls `-onnavigate` with it. The bar touches no
file system; it only splits at `/`.

```tcl
package require tkutils::tkupath
::tkutils::tkupath::widget .bar -onnavigate {apply {p {puts "gehe: $p"}}}
pack .bar -fill x
::tkutils::tkupath::setPath .bar /srv/daten/docs
puts [::tkutils::tkupath::getPath .bar]   ;# -> /srv/daten/docs
```

The bar has already switched before it calls the callback. The callback
therefore needs no `setPath`. Only when navigation ends up elsewhere
(redirect, failed change), it sets the real location with `setPath`.

Options: `-onnavigate`, `-rootlabel` (label of the root `/`, default
`/`). Since 0.3 the bar recognizes drive and UNC paths; backslashes
count as `/`:

| Path | Segments | Targets |
|---|---|---|
| `/srv/daten/docs` | `/` `srv` `daten` `docs` | `/` `/srv` `/srv/daten` `/srv/daten/docs` |
| `S:/projekte/daten` | `S:` `projekte` `daten` | `S:/` `S:/projekte` `S:/projekte/daten` |
| `//srv/share/x` | `//srv/share` `x` | `//srv/share/` `//srv/share/x` |

Up to 0.2, every target started with `/` (`/S:/projekte`); Windows reads
that as a path on the current drive. `S:\projekte\daten` gives the same
segments and targets as `S:/projekte/daten`. The splitting is pure
string work.

---

## tkupreview 0.2

`tkupreview` shows content that the caller supplies (`text`,
`markdown`, `message` and other kinds); the app decides which file gets
which kind. Since 0.2 the messages the widget writes itself (preview
unavailable, file not readable, rendering failed) go through `msgcat`
when it is loaded. The app puts translations into the namespace
`::tkutils`:

```tcl
package require msgcat
namespace eval ::tkutils {
    ::msgcat::mcset {} "Image preview unavailable." "Bildvorschau nicht verfügbar."
}
```

Without a catalog the texts stay English.

---

## tkufiledialog 0.2

[tkufiledialog]{.index} is a modal dialog on `tkupath` + `tkufilelist`,
in the look of the explorer stack. A local provider by default,
optionally `-provider` for ZIP/remote.

| Command | Return value |
|---|---|
| `open ?opt?` | path; with `-multiple 1` a list of paths |
| `save ?opt?` | path (the file need not exist) |
| `directory ?opt?` | chosen folder, otherwise the current one |

On cancel the result is `""` (or an empty list).

| Option | Meaning |
|---|---|
| `-parent w` | toplevel for transient and placement |
| `-title t` | window title (default *Open*, *Save*, *Choose folder*, through `msgcat`) |
| `-initialdir d` | start folder; default `$HOME`, otherwise `pwd` |
| `-provider p` | `tuprovider`; default a fresh local one |
| `-filetypes {{Label {.ext …}} …}` | type combobox; filters by the first extension; without it one entry *All files* |
| `-multiple 0/1` | `open` only: several files |
| `-showhidden 0/1` | show dot files |
| `-initialfile name` | `save` only: preset name |
| `-defaultextension .ext` | `save` only: appended when the name has no extension |

```tcl
package require tkutils::tkufiledialog

set f [::tkutils::tkufiledialog::open -parent . -title "Text öffnen" \
    -initialdir [pwd] -filetypes {{Text {.txt .md}} {Alle *}}]
if {$f ne ""} { puts "gewählt: $f" }

set s [::tkutils::tkufiledialog::save -parent . -initialdir [pwd] \
    -initialfile bericht -defaultextension .txt]

set d [::tkutils::tkufiledialog::directory -parent . -initialdir [pwd]]
```

- A double click on a folder enters it.
- A double click on a file closes the dialog and returns the path
  (since `tkufiledialog` 0.2; in 0.1 it returned `""`).
- *OK* or Return in the name field confirms, Escape or *Cancel* cancels.
- `directory` lists folders only.
- Unknown option: `{TKUTILS TKUFILEDIALOG OPTION <opt>}`, message
  `unknown option "<opt>"` with a `Known:` list; unknown parent:
  `{TKUTILS TKUFILEDIALOG PARENT <w>}`, message
  `bad window path name "<w>" given as -parent`.

The double click goes through `_finishOk` like *OK* and Return (test
`tkufiledialog-1.4a`). Step-by-step operation and the bug in 0.1:
[Appendix G](860-anhang-testumgebung.md).

The dialog is not a full file manager.

---

## Summary

- List and tree talk to providers, not to a fixed file system.
- `tkufiletree -showhidden 1` shows dot files once, also on Windows.
- `tkupath` 0.3 shows drive and UNC paths with real targets.
- File dialog: `open`/`save`/`directory`, `""` on cancel; a double click
  on a file returns the path.

::: {.info}
**Tested with** Tcl/Tk 8.6.14 and 9.0.4 on Linux under Xvfb: the
examples for `tkufilelist`, `tkufiletree` and `tkupath`, the table of
segments and targets, `tkufiledialog.test` (7 of 7).

**Not tested:** Windows (hidden files in the tree, navigation with drive
and UNC paths).
:::

---

*Next chapter: [Lists and tablelist](050-listen-und-tablelist.md)*
