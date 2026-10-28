# Tablelist Helpers

This chapter continues [Lists and tablelist](050-listen-und-tablelist.md).
The seven modules here work on a finished Tablelist, not on the wrapper
`tkutablelist`. For the wrapper use
`[tkutils::tkutablelist::tableWidget $w]`.

[tkutltools]{.index} 0.2 loads all seven and `tclutils::tunum`. It is
outside the umbrella. If neither `tablelist` nor `tablelist_tile` is
loaded, it requires `tablelist_tile`. If one of the two variants is
already there, it stays. Wrapper and helpers load the same variant; the
order relative to the umbrella is free (chapter
[Understanding tkutils](010-tkutils-verstehen.md)).

| Module | Version | Task |
|---|---|---|
| `tkutlsort` | 0.2 | comparison per column |
| `tkutlfmt` | 0.3 | display per column |
| `tkutlclip` | 0.2 | selection as TSV or CSV |
| `tkutlfooter` | 0.3 | footer, sum, further aggregates |
| `tkutlfind` | 0.2 | search with highlighting |
| `tkutlstate` | 0.3 | save the column layout |
| `tkutltree` | 0.2 | nested dicts as a tree |

`tkutltools` requires `tkutlfmt` from 0.1 and `tkutlstate` from 0.1. The
files in the tree are 0.3.

---

## Sorting: tkutlsort

```tcl
::tkutils::tkutlsort::column  tbl spalte typ ?befehl?
::tkutils::tkutlsort::columns tbl {spalte typ spalte typ ...}
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

An unknown type raises `{TKUTILS TKUTLSORT TYPE}`, a `command` column
without a command `{TKUTILS TKUTLSORT CMD}`, an odd list for `columns`
`{TKUTILS TKUTLSORT SPEC}`.

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

`copySelection` and `copyAll` return the number of copied rows.
`asText` returns the text and leaves the clipboard alone.
`installBindings` binds `<<Copy>>` to the body of the table.

| Option | Default | Effect |
|---|---|---|
| `-format` | `tsv` | `tsv` or `csv` |
| `-header` | `0` | column titles as the first line |
| `-formatted` | `1` | displayed values; with `0` the raw cells |
| `-columns` | `visible` | `visible` or `all` |

TSV replaces tab and newline in a cell with a space. CSV keeps them.
Error codes: `{TKUTILS TKUTLCLIP OPTION}` (`unknown option "-foo"`,
without the option name in the code and without a `Known:` line),
`FORMAT` (`format must be tsv or csv`), `COLUMNS`.

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
`-titlecolumns`, hidden columns and `-stretch`.

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
`prev` wrap around and call `seecell`. The search runs on the displayed
text, i.e. after `tkutlfmt`. After sorting, `find` is needed again,
because the row numbers change. `clear` restores the background and, if
set, the foreground.

| Option | Default | Effect |
|---|---|---|
| `-columns` | all visible | columns |
| `-mode` | `substring` | `substring`, `exact`, `glob`, `regexp` |
| `-nocase` | `1` | ignore case |
| `-highlightbg` | `#ffe9a8` | background of matches |
| `-highlightfg` | empty | foreground, optional |

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
::tkutils::tkutlstate::autosave        tbl schlüssel setPrefix ?-delay ms?
::tkutils::tkutlstate::cancelAutosave  tbl
```

`save` returns a dict with `version`, `ncols`, `columns` (per column
`width` and `hide`) and `sortcolumn` (`-1` without sorting). `sortorder`
is added only when a column is sorted, `columnorder` only when the
Tablelist knows the option `-columnorder`; Tablelist 6.20 and 7.11 do
not. `restoreFromFile` and `restoreVia` return `1` when a state arrived
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
::tkutils::tkutltree::fromData tbl daten -fields {feld ...} ?-childrenkey children? ?-parent root?
::tkutils::tkutltree::toData   tbl       -fields {feld ...} ?-childrenkey children? ?-node root?
::tkutils::tkutltree::clear    tbl ?-node root?
```

Field *i* fills column *i*. A missing field becomes an empty cell.
`toData` reads the raw cells, not the formatted text. A round trip gives
the same structure. Error codes: `{TKUTILS TKUTLTREE FIELDS}`
(`-fields is required`) and `OPTION`.

---

## In short

- `tkutltools` 0.2 loads the seven helpers and `tunum`.
- Sorting and formatting leave the raw value in the cell.
- The footer does not replace existing horizontal scrolling.
- `tkutlstate` knows only columns that still exist.

::: {.info}
**Tested with** Tcl/Tk 8.6.14 (Tablelist 6.20) and 9.0.4 (Tablelist
7.11) on Linux under Xvfb: loading `tkutltools`, the error codes and
messages, `tkutlstate::save`.
:::

---

*Next chapter: [Geometry and Units](060-geometry-und-units.md)*
