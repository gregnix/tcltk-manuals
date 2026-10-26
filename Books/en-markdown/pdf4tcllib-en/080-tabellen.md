# Tables with Page Breaks

## Introduction

In pdf4tcl a table is a series of rectangles, lines and texts whose
positions you compute yourself. For one page that works; for a list of
unknown length it no longer does: at some point the page ends, the
header row must be repeated on the next one, and the total belongs at
the end. [table::draw]{.index} handles this from simple data: a list
of columns and a list of rows.

pdf4tcllib also has older table procedures (`table::render`,
`table::simpleTable`). This book uses only `table::draw`; it is the
procedure on which the export of `tablelist` widgets is built as well.

---

## Columns and Rows

```tcl
set y [pdf4tcllib::table::draw pdf x y spalten zeilen \
    ?option wert ...?]
```

**Columns** (`spalten`) are a list, one option list per column:

| Option | Default | Meaning |
|---|---|---|
| `-header` | – | text of the header cell |
| `-width` | `auto` | width in points or `auto` (by the widest content) |
| `-align` | `left` | `left`, `center`, `right` |
| `-font` | `reg` | `reg`, `bold`, `italic`, `bolditalic`, `mono` |
| `-notruncate` | `0` | `1`: never truncate text in this column (see below) |

**Rows** (`zeilen`) are a list of lists of plain text. Formatting is not
in the data but in separate options that address row and column by
number (from 0, not counting the header row).

`table::draw` returns the y position below the table.

---

## A List Across Two Pages

```tcl
# 080-tabelle.tcl -- eine Artikelliste ueber mehrere Seiten
package require pdf4tcl
package require pdf4tcllib

pdf4tcllib::fonts::init -cid 1
set ctx [pdf4tcllib::page::context a4 -margin 20]
set pdf [pdf4tcl::new %AUTO% -paper a4 -orient true]

# Daten: 70 Artikel, jede Zeile eine Liste von Texten
set data {}
for {set i 1} {$i <= 70} {incr i} {
    set preis [expr {($i * 37 % 500) + 0.5}]
    set text "Schraube M$i, verzinkt, Packung zu 100 Stück"
    lappend data [list [format "A-%04d" $i] $text \
        [expr {$i * 3 % 40}] [format %.2f $preis]]
}
set summe 0.0
foreach z $data { set summe [expr {$summe + [lindex $z 3]}] }

set cols {
    {-header "Nr."         -width auto}
    {-header "Bezeichnung" -width auto}
    {-header "Bestand"     -width 50 -align right}
    {-header "Preis €"     -width 60 -align right}
}

# Seitenwechsel: laeuft im globalen Bereich und muss die neue
# y-Position liefern
proc tabellenUmbruch {} {
    global pdf ctx
    pdf4tcllib::page::footer $pdf $ctx "Artikelliste" \
        [$pdf currentPage]
    $pdf endPage
    $pdf startPage
    pdf4tcllib::page::header $pdf $ctx "Artikelliste (Fortsetzung)"
    return [dict get $ctx top]
}

$pdf startPage
$pdf setFont 16 [pdf4tcllib::fonts::fontSansBold]
pdf4tcllib::unicode::safeText $pdf "Artikelliste" \
    -x [dict get $ctx left] -y [expr {[dict get $ctx top] + 16}]

set y [pdf4tcllib::table::draw $pdf [dict get $ctx left] \
    [expr {[dict get $ctx top] + 30}] $cols $data \
    -ctx $ctx -zebra 1 -fontsize 9 \
    -pagebreakcmd tabellenUmbruch \
    -cellstyles {4,2 {-fg {0.8 0 0} -font bold}} \
    -footer [list "" "Summe" "" [format %.2f $summe]]]

pdf4tcllib::page::footer $pdf $ctx "Artikelliste" [$pdf currentPage]
$pdf endPage
puts "Seiten: [$pdf pageCount], Tabelle endet bei y = [format %.1f $y]"
$pdf write -file 080-tabelle.pdf
$pdf destroy
```

```text
Seiten: 2, Tabelle endet bei y = 542.7
```

The header row appears on both pages, the total at the end, and the
row `A-0005` has its stock (`Bestand`) in red bold.

### What the Page Break Needs

- **`-ctx`** turns page breaking on. Without a context, `table::draw`
  draws all rows on the current page, even beyond the margin.
- **`-pagebreakcmd`** is your own page change: footer of the old page,
  new page, header. The procedure must return the y position at which
  the table continues.

Two things differ from `-newpage` of `flow::columns`:

- The command runs in the **global** scope, not in the caller's scope.
  It does not see local variables of the calling procedure; that is why
  the example has `global pdf ctx`.
- It must **return** the new y position. If it returns nothing,
  `table::draw` takes `top` from the context.

Without `-pagebreakcmd`, `table::draw` breaks the page itself: it
writes `- 1 -` at the bottom right of the old page and begins a new
one, without header and footer. The last page gets no number. For a
report that is rarely right; `-pagebreakcmd` is the normal case.

---

## Appearance

| Option | Default | Meaning |
|---|---|---|
| `-fontsize` | `9` | font size |
| `-rowheight` | `0` | row height; `0` means 1.8 × font size |
| `-pad` | `4` | inner padding of the cells |
| `-border` | `1` | draw lines |
| `-header` | `1` | draw the header row |
| `-headerbg`, `-headerfg` | light blue, black | colors of the header row |
| `-zebra` | `0` | shade every second row; `-zebracolor` |
| `-maxwidth` | `text_w` from `-ctx`, otherwise 480 | maximum width of the table |
| `-footer` | – | total row, one value per column, bold |

`-width auto` measures the widest content of the column, header
included. Fixed widths apply as given. If all widths together exceed
`-maxwidth`, they are scaled down in the same proportion. A table never
becomes wider than needed; one spanning the whole type area needs fixed
widths that add up to `text_w`.

### Individual Rows and Cells

```tcl
-rowstyles  {3 {-bg {1 0.95 0.8} -font bold}}
-cellstyles {4,2 {-fg {0.8 0 0} -font bold} 7,1 {-align right}}
-rowindent  {1 14 2 14}
```

`-rowstyles` takes `-bg`, `-fg` and `-font`, `-cellstyles` in addition
`-align` and `-notruncate`. The cell beats the row, the row beats the
zebra pattern. `-rowindent` indents the first column of a row, for
example for sub-items below a bold group row.

---

## One Row, One Value: Truncation

A row in `table::draw` is **one** line of text high. Whatever is wider
than the column is truncated and ends in "...", in the header row too.
There is no wrapping inside a cell.

For remarks and article names that is acceptable. For values that
someone types in from the printout (passwords, serial numbers, account
numbers) it is dangerous: the sheet looks complete. For such columns
use `-notruncate 1`, for individual cells the same in `-cellstyles`.
Then the whole value is shown, if necessary beyond the column edge. The
column must therefore be wide enough; `table::widths` tells in advance
how wide (section [How Wide Will the Table Be?](#how-wide-will-the-table-be)).

```text
Text                          Betrag
Kennwort: Xk9-7Rt-22pQ-...      1.00      ohne -notruncate
Kennwort: Xk9-7Rt-22pQ-88aZ     1.00      mit -notruncate
```

---

## Merged Cells

Instead of a text, a cell may be a dict with `text` and `colspan` or
`rowspan`:

```tcl
set zeilen [list \
    [list [dict create text Nord rowspan 2] Q1 120] \
    [list Q2 90] \
    [list [dict create text Summe colspan 2] 210]]
```

```text
R       Q     W
        Q1   120
Nord
        Q2    90
Summe        210
```

With `colspan` the cell spans several columns, and the row has
correspondingly fewer elements. With `rowspan` it occupies its column
in the following rows; there it is simply left out, as in HTML: `Q2` is
the first element of its row and still stands in the second column.
The next chapter uses `colspan` for subtotals.

What `table::draw` does with them:

- No line runs through a merged cell, and a cell with `rowspan` has the
  background of the row in which it begins over its whole height. Its
  text is centered in the block.
- Rows joined by `rowspan` are not split across two pages; the whole
  block moves to the next page. If it is taller than a page,
  `table::draw` aborts with an error.
- In an accessible PDF the cell carries `/ColSpan` or `/RowSpan`.

Up to pdf4tcllib 0.6.6, `table::draw` did not know `rowspan` (the
following row slipped one column to the left) and also drew the lines
through a merged cell ("Summe No|rd").

---

## How Wide Will the Table Be?

To know before drawing how wide a table will be, or whether it fits
next to an image, ask [table::widths]{.index}:

```tcl
set b [pdf4tcllib::table::widths $cols $data -fontsize 9 -pdf $pdf]
dict get $b natural       ;# je Spalte: so breit, dass nichts fehlt
dict get $b min           ;# je Spalte: das längste Wort
dict get $b naturalTotal  ;# Summe
```

And how many rows fit into the rest of the page,
[table::fitRows]{.index}:

```tcl
set platz [expr {[dict get $ctx bottom] - $y}]
set n [pdf4tcllib::table::fitRows $platz $data -fontsize 9]
```

With this a table can be split up by hand, for example to insert a
remark after the first `n` rows.

---

## Worth Knowing

- **Unknown options are an error.** `-zebar 1` instead of `-zebra 1`
  aborts with "unknown option -zebar" and the list of allowed options.
  Up to pdf4tcllib 0.6.6 the typo passed silently: no stripes, no
  message.
- **`-orient 0` does not work.** `table::draw` reads the direction from
  the document and aborts with an error when y points upward.
- **The caller formats numbers.** `table::draw` writes the text as it
  is in the data; `format %.2f` belongs before it.
- **Text goes through `sanitize`.** The quotation marks „“ become
  straight (chapter [Safe Unicode Output](030-unicode-sicher-ausgeben.md)).

---

## Summary

- `table::draw` with columns and plain text rows; formatting through
  `-rowstyles` and `-cellstyles`.
- For several pages `-ctx` and `-pagebreakcmd`; the command runs
  globally and returns the new y position.
- Cells are single-line and get truncated; `-notruncate` for values
  that are typed in from the printout.
- Merged cells with `colspan` and `rowspan`; a `rowspan` block stays on
  one page.

---

*Next chapter: [Group Totals and Crosstabs](090-gruppen-und-kreuztabellen.md)*
