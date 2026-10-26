# Group Totals and Crosstabs

## Introduction

A list of bookings is rarely printed the way it comes out of the
database. What is wanted is the total per region, per customer, per
month, or an overview with regions as rows and quarters as columns.
[table::group]{.index} and [table::pivot]{.index} compute this and
return rows that `table::draw` draws directly. Nothing is drawn in the
process; both work on the data only.

---

## The Example

Nine sales figures, sorted by region. One field is empty: for West
(`West`) in the second quarter there is no value.

```tcl
# 090-gruppen.tcl -- Zwischensummen je Gruppe und eine Kreuztabelle
package require pdf4tcl
package require pdf4tcllib

pdf4tcllib::fonts::init -cid 1
set ctx [pdf4tcllib::page::context a4 -margin 20]
set pdf [pdf4tcl::new %AUTO% -paper a4 -orient true]

# Umsatz je Region, Quartal und Vertreter -- nach Region sortiert
set umsatz {
    {Nord Q1 Albers 1200}  {Nord Q2 Albers 1350}  {Nord Q2 Brandt 400}
    {Nord Q4 Brandt 980}   {Süd  Q1 Celik  2100}
    {Süd  Q3 Celik  1875.5}
    {West Q1 Dorn   640}   {West Q2 Dorn   ""}    {West Q3 Dorn   720}
}

# Zahlen fuer die Ausgabe formatieren; leere Felder bleiben leer
proc betrag {v} {
    if {[string is double -strict $v]} { return [format %.2f $v] }
    return $v
}

# 1. Gruppieren: Zwischensumme je Region, Gesamtsumme am Ende
set g [pdf4tcllib::table::group $umsatz -by 0 -sum {3} \
    -label "Summe %s" -totallabel "Gesamt" -blank 1]
puts "Zwischensummen in Zeile: [dict get $g subtotals],\
    Gesamt: [dict get $g total]"

set zeilen [lmap z [dict get $g rows] {
    lset z end [betrag [lindex $z end]]
    set z
}]
set stile {}
foreach i [dict get $g subtotals] {
    lappend stile $i {-font bold -bg {0.93 0.93 0.93}}
}
lappend stile [dict get $g total] {-font bold -bg {0.85 0.85 0.85}}

$pdf startPage
set x [dict get $ctx left]
set y [expr {[dict get $ctx top] + 10}]
set y [pdf4tcllib::table::draw $pdf $x $y {
    {-header Region   -width 80}
    {-header Quartal  -width 50}
    {-header Vertreter -width 80}
    {-header Umsatz   -width 70 -align right}
} $zeilen -rowstyles $stile]

# 2. Kreuztabelle: Regionen als Zeilen, Quartale als Spalten
set p [pdf4tcllib::table::pivot $umsatz -row 0 -col 1 -value 3 \
    -rowlabel Region -colorder {Q1 Q2 Q3 Q4}]
puts "Kopf: [dict get $p header]"
foreach z [dict get $p rows] { puts "  $z" }

set kopf [lmap h [dict get $p header] {
    set a [expr {$h eq "Region" ? "left" : "right"}]
    list -header $h -width 60 -align $a
}]
set zeilen [lmap z [dict get $p rows] { lmap v $z { betrag $v } }]
pdf4tcllib::table::draw $pdf $x [expr {$y + 30}] $kopf $zeilen \
    -rowstyles [list [dict get $p total] {-font bold}]

$pdf endPage
$pdf write -file 090-gruppen.pdf
$pdf destroy
```

```text
Zwischensummen in Zeile: 4 7 11, Gesamt: 12
Kopf: Region Q1 Q2 Q3 Q4 Gesamt
  Nord 1200 1750 {} 980 3930
  Süd 2100 {} 1875.5 {} 3975.5
  West 640 {} 720 {} 1360
  Gesamt 3940 1750 2595.5 980 9265.5
```

The PDF shows the grouped list with highlighted total rows and below it
the crosstab:

```text
Region      Quartal  Vertreter     Umsatz
Nord        Q1       Albers       1200.00
            Q2       Albers       1350.00
            Q2       Brandt        400.00
            Q4       Brandt        980.00
Summe Nord                        3930.00
Süd         Q1       Celik        2100.00
...
Gesamt                            9265.50

Region        Q1       Q2       Q3      Q4   Gesamt
Nord     1200.00  1750.00           980.00  3930.00
Süd      2100.00           1875.50          3975.50
West      640.00            720.00          1360.00
Gesamt   3940.00  1750.00  2595.50  980.00  9265.50
```

---

## table::group

```tcl
set g [pdf4tcllib::table::group zeilen ?option wert ...?]
```

| Option | Default | Meaning |
|---|---|---|
| `-by` | `0` | column to group by |
| `-sum` | – | list of the columns to be summed |
| `-label` | `Summe %s` | text of the subtotal; `%s` becomes the group value |
| `-total` | `1` | append a grand total (only with `-sum`) |
| `-totallabel` | `Gesamt` | text of the grand total |
| `-header` | `0` | `1`: a row with the group value before each group |
| `-blank` | `0` | `1`: show the group value only in the first row of the group |
| `-strict` | `0` | `1`: raise an error for unsorted data |

The result is a dict:

| Key | Content |
|---|---|
| `rows` | the rows with subtotals inserted |
| `subtotals` | the numbers of the subtotal rows |
| `groups` | the numbers of the group header rows (with `-header 1`) |
| `total` | the number of the grand total row, otherwise `-1` |

The numbers fit directly into `-rowstyles` of `table::draw`; that is
how the totals in the example get bold text and a gray background.

### The Data Must Be Sorted

`group` does not sort by itself; the order of the rows stays as it
comes. If equal values are not next to each other, a group falls apart
into several blocks, and each gets its own subtotal. `group` notices
this, but raises an error only with `-strict 1`. Without it, the
warning ends up in `$::pdf4tcl::warnings`, where only someone who looks
will see it. Therefore sort beforehand:

```tcl
set umsatz [lsort -index 0 $umsatz]
```

### Empty Fields Are Not Zero

A value that is not a number (empty, "k. A." for "not available") is
skipped when summing, not counted as 0. For a sum that makes no
difference; for an average in the crosstab it does.

### The Label Spans Several Columns

The subtotal begins with a merged cell (`colspan`) that reaches up to
the first sum column. Since pdf4tcllib 0.6.7, `table::draw` no longer
draws a line through it (chapter
[Tables with Page Breaks](080-tabellen.md)). With older versions the
first column must be as wide as the longest label, in the example 80
points for "Summe West", otherwise the line runs through the text.

### Formatting Totals

`group` and `pivot` calculate with `expr`. What comes out is a number
in Tcl notation: `3930`, `3975.5`, for some amounts also
`1234.5000000000002`. For output, a `format` belongs in front; in the
example `betrag` does this for every cell that is a number. Neither
package sets a decimal comma:

```tcl
proc betrag {v} {
    if {![string is double -strict $v]} { return $v }
    string map {. ,} [format %.2f $v]
}
```

---

## table::pivot

```tcl
set p [pdf4tcllib::table::pivot zeilen ?option wert ...?]
```

| Option | Default | Meaning |
|---|---|---|
| `-row` | `0` | column whose values become the rows |
| `-col` | `1` | column whose values become the columns |
| `-value` | `2` | column with the numbers |
| `-agg` | `sum` | `sum`, `count`, `avg`, `min`, `max` |
| `-empty` | `""` | what goes into a field without a value |
| `-colorder` | sorted | order of the columns |
| `-rowlabel` | `""` | header of the first column |
| `-total` | `1` | append a total column and a total row |
| `-totallabel` | `Gesamt` | their label |

The result contains `header` (the header row), `rows`, `cols` (the
column values without header and total) and `total` (number of the
total row). The header row is a list of texts; for `table::draw` it has
to be turned into a column description, in the example with `lmap`.

Every crosstab makes three decisions, and `pivot` leaves them to the
caller:

- **Which columns.** They result from the data. A quarter without a
  single value is missing; to see all four, pass
  `-colorder {Q1 Q2 Q3 Q4}`. Without `-colorder` the columns are sorted
  alphabetically, and month names then become "Apr Aug Dez …".
- **What goes into an empty cell.** The default is nothing, not 0. "No
  sales" and "no data" are different statements; for 0, set
  `-empty 0`.
- **What happens with several values per field.** Nord has two sales in
  Q2 (Albers and Brandt); `-agg sum` adds them up to 1750.

With `-agg avg` the total row is the average over all values of the
column, not the sum of the averages.

---

## Summary

- `table::group` inserts subtotals and tells in which rows they are;
  the numbers go to `-rowstyles`.
- Sort by the group column beforehand, or use `-strict 1`.
- `table::pivot` for crosstabs; `-colorder` for the columns, `-empty`
  for empty fields.
- Format numbers before drawing, the decimal comma included.

---

*Next chapter: [Charts](100-diagramme.md)*
