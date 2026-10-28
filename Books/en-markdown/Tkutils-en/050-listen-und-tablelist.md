# Lists and tablelist

## tkutablelist 0.4

A wrapper around [tablelist]{.index} from tklib: row/column API, sorting
by header click, editable cells, selection helpers, loading and saving
CSV, footer, hierarchy. Not directly in the umbrella, but it comes in
through `tkufilelist`.

```tcl
package require tkutils::tkutablelist
set w [::tkutils::tkutablelist::widget .t -columns {Name Größe Typ}]
pack $w -fill both -expand 1
::tkutils::tkutablelist::setRows $w {
    {a.txt 120 Text} {b.md 80 Markdown} {c.png 4096 Bild}
}
::tkutils::tkutablelist::selectRows $w {0 2}
puts [::tkutils::tkutablelist::selection $w]   ;# -> 0 2
```

Options of `widget`: `-columns`, `-stretch`, `-titlecolumns`,
`-sortable`, `-editable`, `-selectmode` (default `extended`),
`-exportselection` (default **0**), `-stripes`, `-selectcommand`,
`-doublecommand`, `-editendcommand`, `-footer`. Further defaults:
`-stretch all`, `-titlecolumns 0`, `-sortable 1`, `-editable 0`,
`-stripes ""` (no stripes), `-footer 0`. `tableWidget` returns the raw
Tablelist (path `<w>.tbl`).

---

## Why `-exportselection 0`

Tk normally exports the selection of a list widget as the X selection
PRIMARY. When another widget takes PRIMARY — a menu entry, a combobox,
an entry in the toolbar —, the table loses its selection. In a file
manager this means: select several files, right-click, and the
selection is gone before *Copy* acts.

With [exportselection]{.index} 0 the selection stays. Because this
changes observable behavior, the module carries the number **0.4**.

```tcl
package require tkutils::tkutablelist
set w [::tkutils::tkutablelist::widget .alt -columns {A B} \
    -exportselection 1]
puts [[::tkutils::tkutablelist::tableWidget $w] cget -exportselection]   ;# -> 1
```

Anyone who needs the old Tk behavior sets `-exportselection 1`.

---

## Only 0.4

There is only **0.4**. `package require tkutils::tkutablelist 0.3` loads
0.4 (same major version 0); a separate 0.3 is no longer maintained
(`package require … 0.3` returns `0.4`).

Unknown option: `{TKUTILS TKUTABLELIST OPTION -colums}` with the option
name, as with `tkuopts`. The message has two lines:

```text
unknown option "-colums"
Known: -columns -doublecommand -editable -editendcommand -exportselection -footer -selectcommand -selectmode -sortable -stretch -stripes -titlecolumns
```

Up to 0.46.0 the option name and the `Known:` list were missing
(Appendix [Pitfalls](800-anhang-fallen.md)); the module version stayed
0.4. A missing value reports `{TKUTILS TKUTABLELIST OPTION}` with
`missing value for option "-columns"`.

---

## Tablelist Helpers

Sorting, display, clipboard, footer, search, column layout and tree are
in the chapter [Tablelist Helpers](052-tablelist-helfer.md).
`tkutltools` loads all seven. Wrapper and helpers load
`tablelist_tile`; the order relative to the umbrella is free (chapter
[Understanding tkutils](010-tkutils-verstehen.md)).

---

## Summary

- 0.4 for multi-select + context menu; the selection survives menus.
- Old behavior with `-exportselection 1`.
- `require … 0.3` loads 0.4.
- `tkutltools` loads all seven helpers. Commands: chapter
  [Tablelist Helpers](052-tablelist-helfer.md).

::: {.info}
**Tested with** Tcl/Tk 8.6.14 (Tablelist 6.20) and 9.0.4 (Tablelist
7.11) on Linux under Xvfb: all examples and messages of this chapter.
:::

---

*Next chapter: [Tablelist Helpers](052-tablelist-helfer.md)*
