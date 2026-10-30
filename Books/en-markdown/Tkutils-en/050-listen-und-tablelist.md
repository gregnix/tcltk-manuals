# Lists and tablelist

## tkutablelist 0.5

A wrapper around [tablelist]{.index} from tklib: row/column API, sorting
by header click, editable cells, selection helpers, row ids, loading
and saving CSV, footer, hierarchy. Not directly in the umbrella, but it comes in
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

With [exportselection]{.index} 0 the selection stays. This default came
with **0.4**.

```tcl
package require tkutils::tkutablelist
set w [::tkutils::tkutablelist::widget .alt -columns {A B} \
    -exportselection 1]
puts [[::tkutils::tkutablelist::tableWidget $w] cget -exportselection]   ;# -> 1
```

Anyone who needs the old Tk behavior sets `-exportselection 1`.

---

## Row Ids and Sorting

A row number holds only until the user sorts. Since **0.5** every row can
carry an id in its row option `-name`. `setRows` takes the ids with
`-ids`, `insert` as its third argument.

```tcl
::tkutils::tkutablelist::setRows $w {
    {c.png 4096 Bild} {a.txt 120 Text} {b.md 80 Markdown}
} -ids {f3 f1 f2}
::tkutils::tkutablelist::sortBy $w 0
puts [::tkutils::tkutablelist::findId $w f3]          ;# -> 2
puts [::tkutils::tkutablelist::selectIds $w {f2 f9}]  ;# -> f2
puts [::tkutils::tkutablelist::selectedIds $w]        ;# -> f2
```

| Command | Effect |
|---|---|
| `rowId w index` | id of the row, empty without an id |
| `findId w id` | current row number, `-1` if not found |
| `selectedIds w` | ids of the selected rows; a row without an id is left out, `curselection` gives all |
| `selectIds w ids` | selects these rows, activates the first and scrolls to it; returns the ids found |

`setRows` inserts all rows with one `insertlist` and then restores the
sorting the user chose last. If the number of ids does not match the
number of rows, it raises `{TKUTILS TKUTABLELIST IDS}` with
`-ids needs one id per row (2 rows, 1 ids)`. `selectRows` also activates
the first row and scrolls to it.

With `-sortable 1` (default) a click on the header sorts through
`tablelist::sortByColumn`: the second click reverses the direction, the
arrow appears, `<<TablelistColumnSorted>>` arrives. Shift+click adds a
further column (`tablelist::addToSortColumns`).

---

## CSV

`toCsv` returns what the user sees: visible rows, visible columns, raw
cell values. `saveCsv` writes the same as UTF-8.

```tcl
set tbl [::tkutils::tkutablelist::tableWidget $w]
::tkutils::tkutablelist::setRows $w {
    {a.txt 120 Text} {b.md 80 Markdown} {c.png 4096 Bild}
}
$tbl rowconfigure 1 -hide 1
$tbl columnconfigure 2 -hide 1
puts [::tkutils::tkutablelist::toCsv $w]
;# Name,Größe
;# a.txt,120
;# c.png,4096
::tkutils::tkutablelist::saveCsv $w liste.csv -profile excel-de
```

| Option | Default | Effect |
|---|---|---|
| `-header` | `1` | column titles as the first line |
| `-all` | `0` | `1`: all rows and columns, hidden ones too |
| `-formatted` | `0` | `1`: displayed values instead of raw values |
| `-encoding` | `utf-8` | `saveCsv` only |

All other options go to `tclutils::tucsv::text`, for example
`-delimiter ;` or `-profile excel-de` (semicolon, CRLF, BOM). For this
`tkutablelist` needs `tclutils::tucsv` 0.2 from tclutils 0.69.0.

---

## Versions

There is only **0.5**. `package require tkutils::tkutablelist 0.4` and
`… 0.3` load 0.5 (same major version 0). If an old
`tkutablelist-0.4.tm` is still in the tree, `package require` still loads
the higher version; delete the old file when copying over.

Unknown option: `{TKUTILS TKUTABLELIST OPTION -colums}` with the option
name, as with `tkuopts`. The message has two lines:

```text
unknown option "-colums"
Known: -columns -doublecommand -editable -editendcommand -exportselection -footer -selectcommand -selectmode -sortable -stretch -stripes -titlecolumns
```

Up to 0.46.0 the option name and the `Known:` list were missing
(Appendix [Pitfalls](800-anhang-fallen.md)). A missing value reports
`{TKUTILS TKUTABLELIST OPTION}` with
`missing value for option "-columns"`.

---

## Tablelist Helpers

Sorting, display, clipboard, footer, search, column layout, tree,
filtering, grouping and dragging are in the chapter
[Tablelist Helpers](052-tablelist-helfer.md). `tkutltools` loads all
ten. Wrapper and helpers load
`tablelist_tile`; the order relative to the umbrella is free (chapter
[Understanding tkutils](010-tkutils-verstehen.md)).

---

## Summary

- The selection survives menus (`-exportselection 0`); old behavior with
  `-exportselection 1`.
- Row ids with `setRows -ids`; `findId`, `selectIds` hold after sorting
  too.
- `toCsv` and `saveCsv` export only what is visible; `-all 1` takes
  everything.
- `require … 0.4` loads 0.5.
- `tkutltools` loads all ten helpers. Commands: chapter
  [Tablelist Helpers](052-tablelist-helfer.md).

::: {.info}
**Tested with** Tcl/Tk 8.6.14 (Tablelist 6.20) and 9.0.4 (Tablelist
7.11) on Linux under Xvfb: all examples and messages of this chapter.
:::

---

*Next chapter: [Tablelist Helpers](052-tablelist-helfer.md)*
