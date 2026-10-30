# Tablelist Helpers

This chapter continues [Lists and tablelist](050-listen-und-tablelist.md).
The ten modules here work on a finished Tablelist, not on the wrapper
`tkutablelist`. For the wrapper use
`[tkutils::tkutablelist::tableWidget $w]`.

[tkutltools]{.index} 0.3 loads all ten and `tclutils::tunum`. It is
outside the umbrella. If neither `tablelist` nor `tablelist_tile` is
loaded, it requires `tablelist_tile`. If one of the two variants is
already there, it stays. Wrapper and helpers load the same variant; the
order relative to the umbrella is free (chapter
[Understanding tkutils](010-tkutils-verstehen.md)).

| Module | Version | Task |
|---|---|---|
| `tkutlsort` | 0.3 | comparison per column, empty cells |
| `tkutlfmt` | 0.3 | display per column |
| `tkutlclip` | 0.3 | selection as TSV or CSV, Ctrl+C |
| `tkutlfooter` | 0.4 | footer, sum, further aggregates |
| `tkutlfind` | 0.3 | search with highlighting |
| `tkutlstate` | 0.4 | save the column layout and sorting |
| `tkutltree` | 0.3 | nested dicts as a tree, loading on demand |
| `tkutlfilter` | 0.1 | hide rows that do not match |
| `tkutlgroup` | 0.1 | group flat rows, with sums |
| `tkutldrag` | 0.1 | reorder rows with the mouse |

`tkutltools` requires `tkutlfmt` from 0.1; the file in the tree is 0.3.

---

## Sorting: tkutlsort

```tcl
::tkutils::tkutlsort::column  tbl spalte typ ?befehl? ?-empty first|last?
::tkutils::tkutlsort::columns tbl {spalte typ spalte typ ...} ?-empty first|last?
```

| Type | Tablelist mode |
|---|---|
| `string` | `dictionary` |
| `nocase` | `asciinocase` |
| `integer` | `integer` |
| `real` | `real` |
| `num` | command through `tclutils::tunum` |
| `command` | own comparison with two arguments |

`num` reads grouping and currency. Unreadable cells sort after the
numbers. The module only sets the comparison. Sorting happens with
`sortbycolumn` or a click on the column header.

An empty cell in an `integer` or `real` column makes the Tablelist
comparison fail. Since 0.3, `-empty first` or `-empty last` decides where
empty and unreadable cells go, in both directions. `-empty` applies to
`integer`, `real` and `num`; `columns` passes it only to these columns.

```tcl
tablelist::tablelist .t -columns {10 Artikel left 6 Menge right}
.t insertlist end {{Schrauben 100} {Muttern {}} {Dübel 20}}
::tkutils::tkutlsort::column .t 1 integer -empty last
.t sortbycolumn 1 -decreasing
puts [lmap r [.t get 0 end] {lindex $r 1}]   ;# -> 100 20 {}
```

An unknown type raises `{TKUTILS TKUTLSORT TYPE}`, a `command` column
without a command `{TKUTILS TKUTLSORT CMD}`, an odd list for `columns`
`{TKUTILS TKUTLSORT SPEC}`, another value for `-empty`
`{TKUTILS TKUTLSORT EMPTY}` with
`bad -empty "middle": must be first or last`, another option `OPTION`.

---

## Display: tkutlfmt

```tcl
::tkutils::tkutlfmt::column  tbl spalte typ ?option wert ...?
::tkutils::tkutlfmt::columns tbl {spalte typ ?{option wert ...}? ...}
```

The cell keeps the raw value. The display comes through
`-formatcommand`. `integer`, `number`, `currency` and `percent` are
right-aligned unless `-align` is given. `date` formats with `clock`.

| Option | Default | Effect |
|---|---|---|
| `-locale` | `eu` | `eu` with a dot for thousands and a comma for decimals, or `us` |
| `-group` | from `-locale` | thousands separator |
| `-decimal` | from `-locale` | decimal separator |
| `-decimals` | per type | decimal places: `integer` 0, `number` and `currency` 2, `percent` 1 |
| `-symbol` | `€` | currency only |
| `-symbolpos` | `post` | `pre` or `post` |
| `-align` | automatic | `right`, `left`, `center` |
| `-informat` | empty | `clock scan`, otherwise a number or a recognizable time |
| `-outformat` | `%Y-%m-%d` | `clock format` |

An unknown type raises `{TKUTILS TKUTLFMT TYPE}`, an unknown option
`{TKUTILS TKUTLFMT OPTION -name}` and names the known ones, a foreign
`-locale` `{TKUTILS TKUTLFMT LOCALE}` with `locale must be eu or us`.

---

## Clipboard: tkutlclip

```tcl
::tkutils::tkutlclip::copySelection   tbl ?option wert ...?
::tkutils::tkutlclip::copyAll         tbl ?option wert ...?
::tkutils::tkutlclip::asText          tbl zeilen ?option wert ...?
::tkutils::tkutlclip::installBindings tbl ?option wert ...?
```

`copySelection` and `copyAll` return the number of copied rows;
`copyAll` takes only visible rows, no hidden ones and none in collapsed
nodes. `asText` returns the text and leaves the clipboard alone.
`installBindings` binds `<<Copy>>` to the body of the table (`bodytag`)
and ends the binding with `break`. Without `break`, Tablelist's own
`<<Copy>>` binding ran afterwards and overwrote the clipboard with its
TSV; up to 0.2 Ctrl+C therefore never delivered the chosen format.
`installBindings` checks the options at once, not on the first Ctrl+C.

| Option | Default | Effect |
|---|---|---|
| `-format` | `tsv` | `tsv` or `csv` |
| `-header` | `0` | column titles as the first line |
| `-formatted` | `1` | displayed values; with `0` the raw cells |
| `-columns` | `visible` | `visible` or `all` |
| `-separator` | `,` | separator for CSV, one character; TSV always uses a tab |

```tcl
::tkutils::tkutlclip::installBindings .t -format csv -separator {;} -header 1
puts [::tkutils::tkutlclip::asText .t {0 1} -format csv -separator {;}]
```

TSV replaces tab and newline in a cell with a space. CSV keeps them and
always goes through `tclutils::tucsv` 0.2, as `tkutablelist::toCsv` does:
the same row gives the same text in both.
Error codes: `{TKUTILS TKUTLCLIP OPTION}` (`unknown option "-foo"`,
without the option name in the code and without a `Known:` line),
`FORMAT` (`format must be tsv or csv`), `COLUMNS`, `SEPARATOR`
(`separator must be one character`).

---

## Footer: tkutlfooter

```tcl
::tkutils::tkutlfooter::attach  haupt fuss ?-autowire 1?
::tkutils::tkutlfooter::update  haupt fuss
::tkutils::tkutlfooter::setvals fuss {wert ...}
::tkutils::tkutlfooter::autosum haupt fuss ?-columns {1 2}? ?-label SUM:? ?-format %.2f?
::tkutils::tkutlfooter::autoagg haupt fuss ?-columns {1 sum ...}? ?-label text? ?-format %.2f?
::tkutils::tkutlfooter::detach  haupt fuss
```

`attach` turns `fuss` (the footer) into a single row without selection
and takes over the columns of `haupt` (the main table). `-autowire 1`
chains horizontal scrolling to the existing `-xscrollcommand` of the
main table instead of replacing it. Since 0.2 the footer also takes over
`-titlecolumns`, hidden columns and `-stretch`. `attach` schedules the
first alignment for idle time; `detach` cancels it, and if one of the
tables is destroyed by then it does nothing (0.4; before, a background
error `invalid command name` came up).

`autosum` sums the given columns, by default all, and writes `-label`
into column 0. Numbers are read by `tclutils::tunum`. After a data
change, run `autosum` again. `autoagg` takes `sum`, `avg`, `min`, `max`,
`count` or `countnum` per column. Counts stay integers. Errors carry
`{TKUTILS TKUTLFOOTER <GRUND>}`, for example `SPEC` for an odd
`-columns` list in `autoagg` and `FUNC` for an unknown aggregate. The
module does not check unknown options: `attach`, `autosum` and `autoagg`
skip them without an error.

---

## Searching: tkutlfind

```tcl
::tkutils::tkutlfind::find    tbl text ?option wert ...?
::tkutils::tkutlfind::next    tbl
::tkutils::tkutlfind::prev    tbl
::tkutils::tkutlfind::matches tbl
::tkutils::tkutlfind::clear   tbl
```

`find` returns the number of matches and colors the cells. `next` and
`prev` wrap around and call `seecell`; they return `{row column}` with the
current row number. The search runs on the displayed text, i.e. after
`tkutlfmt`. Since 0.3 the module keeps the matches as row keys: after
sorting, `matches`, `next` and `prev` stay right, deleted rows drop out.
`find` skips hidden rows, for example from `tkutlfilter`, unless
`-hidden 1`. If a match lies in a collapsed node, `next` expands its
ancestors. `clear` restores the cell colors set before `find`.

| Option | Default | Effect |
|---|---|---|
| `-columns` | all visible | columns |
| `-mode` | `substring` | `substring`, `exact`, `glob`, `regexp` |
| `-nocase` | `1` | ignore case |
| `-highlightbg` | `#ffe9a8` | background of matches |
| `-highlightfg` | empty | foreground, optional |
| `-hidden` | `0` | `1`: hidden rows too |

```tcl
::tkutils::tkutlfind::find .t schr      ;# -> 1
.t sortbycolumn 0 -increasing
::tkutils::tkutlfind::next .t           ;# -> 2 0  (Schrauben is now at the bottom)
```

Error codes: `{TKUTILS TKUTLFIND MODE}` (`unknown mode "xx"`) and
`OPTION` (`unknown option "-foo"`, without the option name in the code).

---

## Saving the Layout: tkutlstate

```tcl
::tkutils::tkutlstate::save            tbl
::tkutils::tkutlstate::restore         tbl zustand
::tkutils::tkutlstate::saveToFile      tbl pfad
::tkutils::tkutlstate::restoreFromFile tbl pfad
::tkutils::tkutlstate::saveVia         tbl schlüssel setPrefix
::tkutils::tkutlstate::restoreVia      tbl schlüssel getPrefix
::tkutils::tkutlstate::autosave        tbl schlüssel setPrefix ?-delay ms? ?-onerror befehl?
::tkutils::tkutlstate::cancelAutosave  tbl
::tkutils::tkutlstate::lastError       tbl
```

Since 0.4, `save` returns a dict of version 2: `version`, `ncols`,
`columns` in display order (per column `id`, `width`, `hide`) and `sort`
with all sort columns and directions. The `id` is the column name
(`-name`), otherwise `#` and the title. Width and visibility thus belong
to the column, not to its number; `restore` brings the order back with
`movecolumn`.

```tcl
.t columnconfigure 0 -name artikel
::tkutils::tkutlstate::save .t
;# -> version 2 ncols 3 columns {{id artikel width 10 hide 0}
;#    {id #Menge width 6 hide 0} {id #Preis width 8 hide 0}}
;#    sort {columns {{#Menge}} orders decreasing}
```

`restore` still applies version-1 states from 0.1 to 0.3 (by column
number). `autosave` also saves after hiding and sorting. If saving fails,
`autosave` sends `<<TkutlStateSaveFailed>>` to the table (`%d` is the
message), calls `-onerror` with the table and the message and keeps the
message for `lastError` until a save succeeds; before, the error vanished
in a `catch`.
`restoreFromFile` and `restoreVia` return `1` when a state arrived
and `0` when it is missing. `saveVia` appends key and dict to the command
prefix. `restore` changes only columns that occur in both states. A
value that is not a state raises `{TKUTILS TKUTLSTATE STATE}` with
`not a tkutlstate dict`. An unknown option to `autosave` reports
`{TKUTILS TKUTLSTATE badoption}` — the only reason in the module written
in lower case.

---

## Tree: tkutltree

A node is a dict of the fields plus an optional `children`, a list of
further nodes. The top level is a list of nodes.

```tcl
::tkutils::tkutltree::fromData tbl daten -fields {feld ...} ?option wert ...?
::tkutils::tkutltree::toData   tbl       -fields {feld ...} ?-childrenkey children? ?-node root? ?-idfield f?
::tkutils::tkutltree::clear    tbl ?-node root?
::tkutils::tkutltree::lazy     tbl ladebefehl -fields {feld ...} ?option wert ...?
::tkutils::tkutltree::reveal   tbl index
::tkutils::tkutltree::findId   tbl id
```

Field *i* fills column *i*. A missing field becomes an empty cell.
`toData` reads the raw cells, not the formatted text. A round trip gives
the same structure. `fromData` inserts each level with one
`insertchildlist` and since 0.3 returns the keys of the top-level nodes
(up to 0.2 the table path).

| Option of `fromData` | Effect |
|---|---|
| `-childrenkey` | key of the child list, default `children` |
| `-parent` | node to insert under, default `root` |
| `-idfield f` | the value of field `f` becomes the row's `-name` |
| `-expand` | `none` all collapsed, `all` all expanded, a number `N`: `N` levels visible; without it as Tablelist inserts (expanded) |
| `-lazykey f` | a node with a true field `f` and no children gets an arrow and loads later |

`lazy` sets the table's `-expandcommand` and `-populatecommand`. On the
first expand of such a node, or when `searchcolumn -descend` reaches it,
it calls `ladebefehl tbl key` once and inserts the returned nodes.

```tcl
proc ladeOrdner {tbl key} {
    set dir [$tbl rowcget $key -name]
    lmap f [lsort [glob -nocomplain -directory $dir *]] {
        list pfad $f name [file tail $f] lazy [file isdirectory $f]
    }
}
tablelist::tablelist .baum -columns {30 Name left} -treecolumn 0
::tkutils::tkutltree::lazy .baum ladeOrdner -fields {name} \
    -idfield pfad -lazykey lazy
::tkutils::tkutltree::fromData .baum [list [list pfad $start name $start lazy 1]] \
    -fields {name} -idfield pfad -lazykey lazy
```

`findId` looks for an id in the whole tree (`findrowname -descend`),
`reveal` expands the ancestors of a row and scrolls to it. Error codes:
`{TKUTILS TKUTLTREE FIELDS}` (`-fields is required`), `OPTION` and
`EXPAND` (`bad -expand "x": must be none, all or a level count`).

---

## Filtering: tkutlfilter

[tkutlfilter]{.index} hides the rows that do not match. The rows stay in
the table; ids, attributes and embedded windows are kept.

```tcl
::tkutils::tkutlfilter::filter tbl text ?option wert ...?
::tkutils::tkutlfilter::later  tbl ms text ?option wert ...?
::tkutils::tkutlfilter::clear  tbl
::tkutils::tkutlfilter::query  tbl
```

A row stays visible when the text occurs in one of the columns, every
condition from `-where` matches and `-command` returns 1. `filter`
returns the number of matching rows. An empty text without `-where` and
`-command` removes the filter. `later` filters only after `ms`
milliseconds of quiet and then sends `<<TkutlFilterApplied>>` to the
table; this suits `<KeyRelease>` on an entry. If the table is destroyed
first, the pending call is dropped.

| Option | Default | Effect |
|---|---|---|
| `-columns` | all visible | columns for the text |
| `-mode` | `substring` | `substring`, `exact`, `glob`, `regexp` |
| `-nocase` | `1` | ignore case |
| `-where` | empty | `{column text ...}`, all must match; column as number, `-name` or title |
| `-command` | empty | own test `command tbl key row`, returns 0 or 1 |

```tcl
::tkutils::tkutlfilter::filter .t "" -where {Artikel u}   ;# -> 2
puts [lmap r [.t get 0 end -viewable] {lindex $r 0}]      ;# -> Muttern Schrauben
::tkutils::tkutlfilter::clear .t
```

The dict that [tkufilterbar]{.index} passes to its `-command` fits
`-where` directly. Rows the application hid itself stay hidden and do not
count. In a tree a parent stays visible while a descendant matches.
`size` and `get 0 end` still count all rows; `get 0 end -viewable`
returns the visible ones. `tkutablelist::toCsv` and
`tkutlclip::copyAll` take only visible rows. Error codes:
`{TKUTILS TKUTLFILTER <REASON>}` with `OPTION`, `MODE`, `REGEXP`,
`WHERE`, `COLUMN`.

---

## Grouping: tkutlgroup

[tkutlgroup]{.index} turns flat rows into a tree: one parent row per value
of a key column, the rows themselves as its children.

```tcl
::tkutils::tkutlgroup::group   tbl zeilen schlüsselspalte ?option wert ...?
::tkutils::tkutlgroup::ungroup tbl
```

```tcl
set orders {
    {{Tämo GmbH} Schrauben 100 200,00}
    {{Quarz KG}  Muttern    50  50,00}
    {{Tämo GmbH} Dübel      20  60,50}
}
tablelist::tablelist .o -treecolumn 0 \
    -columns {12 Kunde left 10 Artikel left 6 Menge right 8 Betrag right 4 N right}
::tkutils::tkutlgroup::group .o $orders 0 -sum {2 3} -count 4
puts [.o get 0]      ;# -> {Tämo GmbH} {} 120 260.50 2
```

| Option | Default | Effect |
|---|---|---|
| `-sum` | empty | columns with a sum in the parent row |
| `-count` | empty | column for the number of rows |
| `-blank` | `1` | key column empty in the child rows |
| `-format` | `%.2f` | `format` for sums that are not integers |
| `-font` | bold | font of the parent rows |
| `-expand` | `1` | `0`: groups collapsed |
| `-replace` | `1` | remove all rows first; `0` appends the groups |

A second call of `group` replaces the groups; before, it stacked them
below the first ones. `tclutils::tunum` reads numbers like `200,00`. A cell without a number
counts as 0. Groups appear in the order in which their key first occurs.
When sorting, Tablelist sorts the parent rows by their sums and the
children within each group; the groups stay together. `ungroup` returns
the rows in display order, with the key column filled in. Error codes:
`{TKUTILS TKUTLGROUP OPTION}` and `COLUMN`
(`bad column "9": must be 0..4`).

---

## Dragging: tkutldrag

[tkutldrag]{.index} lets the user reorder rows with the mouse and reports
each move.

```tcl
::tkutils::tkutldrag::enable  tbl ?option wert ...?
::tkutils::tkutldrag::disable tbl
::tkutils::tkutldrag::order   tbl ?eltern?
```

`enable` sets `-movablerows`. This works only in select mode `single`
or `multiple`; `enable` turns `browse` into `single` and `extended` into
`multiple` and returns the mode. `order` returns the ids (`-name`) of the
children of `eltern` (default `root`) in display order, the key for rows
without an id.

| Option | Default | Effect |
|---|---|---|
| `-command` | empty | after the drop: `command tbl id parent position` |
| `-samelevel` | `1` | reorder only among siblings, no new parents |
| `-acceptchild` | empty | own `-acceptchildcommand`, replaces `-samelevel` |
| `-acceptdrop` | empty | own `-acceptdropcommand`, replaces `-samelevel` |

```tcl
proc verschoben {tbl id eltern pos} {
    speichereReihenfolge [::tkutils::tkutldrag::order $tbl]
}
::tkutils::tkutldrag::enable .t -command verschoben
```

Escape cancels the drag. With `-samelevel 1` a row in a tree may only
land before a sibling; the end of a child list below the top level is
then no target. An unknown option raises `{TKUTILS TKUTLDRAG OPTION}`.

---

## In short

- `tkutltools` 0.3 loads the ten helpers and `tunum`.
- Sorting and formatting leave the raw value in the cell.
- Empty cells in number columns: `tkutlsort … -empty last`.
- Ctrl+C with your own format: `tkutlclip::installBindings`, effective
  since 0.3.
- The footer does not replace existing horizontal scrolling.
- `tkutlstate` knows only columns that still exist; with `-name` a column
  survives a new title too.
- Filtering hides, searching highlights; both count by keys.

::: {.info}
**Tested with** Tcl/Tk 8.6.14 (Tablelist 6.20) and 9.0.4 (Tablelist
7.11) on Linux under Xvfb: loading `tkutltools`, the examples, the
error codes and messages. Dragging with the mouse is checked only through
the event `<<TablelistRowMoved>>`, not with a real mouse.
:::

---

*Next chapter: [Geometry and Units](060-geometry-und-units.md)*
