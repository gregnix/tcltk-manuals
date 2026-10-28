# Actions and Layout

## tkuaction 0.2

[tkuaction]{.index} describes an action once — label, command, icon,
shortcut, enable/check state — and keeps all registered widgets and menu
entries in sync. The module is the model; drawing happens in the
widgets.

```tcl
package require tkutils::tkuaction

proc speichern {} { puts gespeichert }
::tkutils::tkuaction::define save -label "Speichern" -command speichern \
    -accelerator "Ctrl+S"

foreach top {.a .b} {
    toplevel $top
    ttk::button $top.save -text Speichern \
        -command {::tkutils::tkuaction::invoke save}
    pack $top.save
    ::tkutils::tkuaction::register save $top.save
    menu $top.m -tearoff 0
    ::tkutils::tkuaction::addMenuItem $top.m save
}

::tkutils::tkuaction::setEnabled save 0 .b      ;# nur Fenster .b
puts [::tkutils::tkuaction::getEnabled save .a] ;# -> 1
puts [::tkutils::tkuaction::getEnabled save .b] ;# -> 0
::tkutils::tkuaction::setEnabled save 1         ;# global, hebt .b auf
```

---

## Enable per Window

- `setEnabled id 0|1` without a window affects all bound widgets, as in
  0.1. This call also clears all window overrides.
- `setEnabled id 0|1 $w` grays out only widgets and menu entries in the
  toplevel of `$w`. A child widget is resolved with `winfo toplevel`; for
  menus, which are toplevels themselves, the first ancestor that is not a
  menu counts.
- `getEnabled` and `groupSet` take the same optional window.
- `invoke` always checks the **global** flag.
- Unknown window: `{TKUTILS TKUACTION WINDOW}`.

Menu lines are not widgets; `addMenuItem $menu id` creates the line and
registers its index, `registerMenu`/`unregisterMenu` bind an existing
line. Groups switch several actions at once:

```tcl
package require tkutils::tkuaction
::tkutils::tkuaction::define zoom_in  -label "Vergrößern" -command {puts +}
::tkutils::tkuaction::define zoom_out -label "Verkleinern" -command {puts -}
::tkutils::tkuaction::groupDefine bild {zoom_in zoom_out}
::tkutils::tkuaction::groupSet bild 0
```

Error codes: `{TKUTILS TKUACTION <GRUND>}` with `OPTION`, `NOACTION`,
`NOGROUP`, `WINDOW`. An unknown option to `define` reports the code
`{TKUTILS TKUACTION OPTION -lable}` with the option name and two lines as
with `tkuopts`:

```text
unknown option "-lable"
Known: -accelerator -checkable -checked -command -compound -enabled -icon -iconChecked -label -tooltip
```

The other messages: `unknown action 'zz'`, `unknown group 'zz'`,
`unknown window '.nix'`. `getEnabled` for an unknown action returns `0`
instead of an error. For the state up to 0.46.0: Appendix
[Pitfalls](800-anhang-fallen.md).

---

## Scaffolding

Toolbar, status, tabs, tooltips, context menu, keys, focus, search,
filter, scrolling and the selection rectangle are in the chapter
[Scaffolding](072-geruest.md). Forms are in the chapter
[Input](074-eingabe.md). Viewers for CSV, JSON and diff are in the
chapter [Viewing Data](078-daten-ansehen.md).

---

## tkulauncher 0.3

[tkulauncher]{.index} is a program launcher as a menu (`-mode menu`) or
a list of buttons (`-mode list`). Entries: `app` (also `command`), `url`,
`open` (also `file`), `tcl`, `system`, `menu`, `separator`, `calendar`,
`calc`. URLs and files are opened by `tclutils::tuopen` with the
system's default program. `app` and `tcl` entries also know `dir`
(working directory) and `terminal 1` (start in a terminal window).

Options of `widget`: `-mode` (default `list`), `-text` (button text in
menu mode, default `Start`), `-items`, `-file` (entries from `.json` or
`.ini`), `-onlaunch`, `-settings`, `-system`, `-scroll`, `-height`
(default 400), `-tooltips`, `-columns` (default 1), `-editable`.

```tcl
package require tkutils::tkulauncher
set spec {
    {type menu label Werkzeuge items {
        {type app label Editor cmd {xterm}}
        {type url label "Tcl-Handbuch" target https://www.tcl.tk/man/tcl9.0/}
    }}
    {type separator}
    {type tcl label "Meine App" target app.tcl interp wish8}
}
::tkutils::tkulauncher::widget .l -mode list -items $spec \
    -onlaunch {apply {{kind argv} {puts "$kind: $argv"; return 0}}}
pack .l -fill both -expand 1
```

`-onlaunch` receives `kind argv`; a false return value suppresses the
start — useful for logging, confirmation or tests. `calendar` and `calc`
entries open built-in windows and do not go through `-onlaunch`.

With `-scroll 1` the button list sits in a `tkuscrolledframe` and thus
needs scrollutil. The mouse wheel over the buttons scrolls the list,
also over buttons that `reload` creates anew; up to 0.2 they lacked this
binding. An unknown option to `widget` reports
`unknown option "-foo"` with the `Known:` list from `tkuopts`.

### Starting on Windows

On Windows, `app` entries run through `cmd /c start`, so that programs
registered under *App Paths* start without a full path; the working
directory goes through `start /D`. `start` reads a `/` as the beginning
of a switch. Since 0.46.0 the program (first word) and the `/D`
directory therefore get **backslashes**; the arguments stay as they are
(they may be URLs or options). A program with `://` keeps its spelling.
On Linux/macOS the program is run directly; a `dir` is set there with
`cd` before the start.

### Interpreters for `tcl` Entries

A `tcl` entry starts a script with `interp` (default `wish9`).
Optionally, `tcllibpath` sets the variable `TCLLIBPATH` for the child
process.

| Key | Linux | Windows |
|---|---|---|
| `wish9` | `wish9.0` | `wish90.exe` |
| `wish8` | `wish8.6` | `wish86t.exe` |
| `tclsh9` | `tclsh9.0` | `tclsh90.exe` |
| `tclsh8` | `tclsh8.6` | `tclsh86t.exe` |

Every platform except Windows uses the *Linux* column, macOS included.

```tcl
package require tkutils::tkulauncher
puts [::tkutils::tkulauncher::tclInterpreters]                ;# -> wish9 wish8 tclsh9 tclsh8
puts [::tkutils::tkulauncher::resolveTclInterp wish8 windows] ;# -> wish86t.exe
::tkutils::tkulauncher::setTclInterp wish9 -linux /usr/local/tcl9/bin/wish9.0
puts [::tkutils::tkulauncher::resolve \
    {type tcl label Demo target app.tcl interp wish9 tcllibpath {lib}}]
```

`resolve` shows without side effects what would be started (`kind`,
`argv`, optionally `env`, `dir`, `terminal`). The last line of the
example prints `kind exec argv {/usr/local/tcl9/bin/wish9.0 app.tcl} env
{TCLLIBPATH lib}`. The launcher expands a leading `~` in paths itself,
because Tcl 9 no longer does. An unknown interpreter key reports
`unknown interpreter: <key>` (without an error code).

---

## Summary

- Actions in one place; enable globally or per window
  (`setEnabled id 0 $w`).
- `invoke` follows the global flag.
- Launcher: Windows start with backslashes, interpreter mapping with
  `setTclInterp`.

::: {.info}
**Tested with** Tcl/Tk 8.6.14 and 9.0.4 on Linux under Xvfb: all
examples and messages of this chapter, `tkulauncher.test` (100 tests).

**Not tested:** starting `app` entries on Windows (only read in the
code), interpreters on macOS.
:::

---

*Next chapter: [Scaffolding](072-geruest.md)*
