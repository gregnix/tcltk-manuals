# Dialogs

## tkudialog 0.3

[tkudialog]{.index} replaces `tk_messageBox` patterns with ttk. The
message text can be selected and copied (Ctrl-C or the *Copy* button).
It adds a default button, Return/Escape, focus/grab and button ids. Pure
Tk, no tclutils engine.

```tcl
package require tkutils::tkudialog 0.3
set ok [::tkutils::tkudialog::confirm "Datei löschen?" -parent .]
if {$ok} { puts "wird gelöscht" }
```

`confirm` returns **1** for *Yes*, otherwise **0** — also on Escape or
when the window is closed.

---

## All Entry Points

| Call | Kind | Return value |
|---|---|---|
| `showInfo msg ?opt?` | modal | `ok`; `""` on Escape/close |
| `showWarning msg ?opt?` | modal | like `showInfo` |
| `showError msg ?opt?` | modal | like `showInfo`; `-detail` starts collapsed |
| `confirm msg ?opt?` | modal | 1 (Yes) or 0 |
| `input ?opt?` | modal | entered text; `""` on cancel or empty input |
| `form spec ?-title? ?-parent?` | modal | dict of values; `""` on cancel |
| `show win ?opt?` | modal | id of the chosen button |
| `build win ?opt?` | not modal | `win` |
| `choose win id` | choose a button programmatically | empty |
| `result win` | state | chosen id, `""` while open |
| `getText win` | state | message text |
| `getDetail win` | state | detail text |
| `copyText win` | clipboard | copied text (message + detail) |

All commands live in `::tkutils::tkudialog`. There is no `message` or
`warning`.

Options of `build`/`show` (and thus of the ready-made variants):
`-title`, `-message`, `-icon info|warning|error|question`, `-detail`,
`-buttons`, `-default`, `-cancel`, `-entry`, `-initial`, `-parent`,
`-detailcollapsed`, `-width` (default 48), `-maxheight` (default 20).
`input` knows only `-title`, `-message`, `-initial`, `-parent`; `form`
only `-title` and `-parent`. `input` returns `""` also for *OK* with an
empty field — cancel and empty input cannot be told apart by the result.

```tcl
package require tkutils::tkudialog 0.3
::tkutils::tkudialog::showInfo "Export fertig." -parent .
::tkutils::tkudialog::showError "Speichern fehlgeschlagen." \
    -detail "permission denied" -parent .

set name [::tkutils::tkudialog::input -title "Neuer Ordner" \
    -message "Name:" -initial "Neu" -parent .]
if {$name ne ""} { puts "anlegen: $name" }
```

---

## Buttons with Ids

`-buttons` takes entries `Label` (id equals label, as in 0.2) or
`{id Label}`. `show` returns the **id**, independent of the label — so
the code stays the same when [msgcat]{.index} translates the labels.

```tcl
package require tkutils::tkudialog 0.3
set id [::tkutils::tkudialog::show .frage -title "Ungespeichert" \
    -icon question -message "Änderungen speichern?" \
    -buttons {{save Speichern} {discard Verwerfen} {cancel Abbrechen}} \
    -default save -cancel cancel -parent .]
switch -- $id {
    save    { puts speichern }
    discard { puts verwerfen }
    default { puts abbruch }
}
```

- Return / KP_Enter chooses `-default` (without it, the first button).
- Escape and closing the window choose `-cancel`. Without it, the first
  button with the id `No`, `Cancel`, `no` or `cancel` or with the label
  `No` or `Cancel` counts; if there is none, the result is `""`.
- `confirm`, `input` and `form` use fixed ids (`yes`/`no`,
  `ok`/`cancel`).
- Titles and standard labels (`OK`, `Yes`, `Copy`, …) go through
  `msgcat` when it is loaded.
- Modal dialogs restore the caller's focus and grab.

---

## Form

`form` embeds a `tkuform` with OK/Cancel in a modal dialog.

```tcl
package require tkutils::tkudialog 0.3
set v [::tkutils::tkudialog::form {
    {name titel  label "Titel"    type entry}
    {name prio   label "Prio"     type combo values {niedrig normal hoch} default normal}
    {name fertig label "Erledigt" type check}
} -title "Neue Notiz" -parent .]
if {$v ne ""} { puts "prio=[dict get $v prio]" }
```

---

## Not Modal

`build` builds the dialog and returns at once. You wire up the rest
yourself.

```tcl
package require tkutils::tkudialog 0.3
::tkutils::tkudialog::build .info -title "Protokoll" \
    -message "Lauf beendet." -detail "3 Dateien kopiert" \
    -buttons {{ok OK}} -default ok
puts [::tkutils::tkudialog::getDetail .info]   ;# -> 3 Dateien kopiert
::tkutils::tkudialog::copyText .info
::tkutils::tkudialog::choose .info ok
puts [::tkutils::tkudialog::result .info]      ;# -> ok
destroy .info
```

---

## Parent and Placement

`-parent w` makes the dialog transient to the toplevel of `w` and
centers it over it. Without `-parent`, the toplevel with the keyboard
focus counts, otherwise `.`. Give `-parent` whenever the window is known
— with several monitors it is the only reliable answer. A `-parent` that
does not exist is an error `{TKUTILS TKUDIALOG PARENT <w>}` with the
message `bad window path name ".nix" given as -parent` (for
`-parent .nix`). A parent that is not yet visible does not make the
dialog transient; it is then centered on the screen.

---

## Options Are Checked

An unknown option is an error that lists the known ones:

```tcl
package require tkutils::tkudialog 0.3
catch {::tkutils::tkudialog::showInfo "x" -parnet .} msg opts
puts [dict get $opts -errorcode]   ;# -> TKUTILS TKUDIALOG OPTION -parnet
```

The message is `unknown option "-parnet"`, with a second line `Known:`
listing the valid options in the order of the code
(`-title -message -icon -detail -buttons -entry -initial -parent -default
-cancel -detailcollapsed -width -maxheight`). If a value is missing, it is
`missing value for option "…"` with the code
`{TKUTILS TKUDIALOG OPTION}`.

---

## Versions

The file **0.2** is gone; `package require tkutils::tkudialog 0.2` loads
0.3 (compatible for plain labels). Doc: `docs/tkudialog.md`.

---

## ctrlutils

`cufileops` has required `tkudialog` 0.3 for confirmations since 0.3;
the current state in ctrlutils 0.5 is `cufileops` 0.6. See *Utils-Stack*.

---

## Summary

- Entry points: `showInfo`, `showWarning`, `showError`, `confirm`,
  `input`, `form`, `build`/`show`, plus `choose`, `result`, `getText`,
  `getDetail`, `copyText`.
- `confirm` → 1/0, `show` → id, `input`/`form` → `""` on cancel.
- Always give `-parent`.

::: {.info}
**Tested with** Tcl/Tk 8.6.14 and 9.0.4 on Linux under Xvfb: all
examples; the modal dialogs were closed with `choose`.

**Not tested:** appearance, focus and placement on a real screen.
:::

---

*Next chapter: [File Widgets](040-datei-widgets.md)*
