# Case Study: Warehouse Report

## Introduction

A report on one month of stock movements in a warehouse, from the raw
data to the finished PDF: subtotals and a crosstab, a chart, a table
across several pages with headers and footers, a table of contents with
real page numbers, and a structure tree. Each part comes from an earlier
chapter; here they come together in one script, and the seams show what
matters.

| Part | Chapter |
|---|---|
| `table::group`, `table::pivot` | [Group Totals and Crosstabs](090-gruppen-und-kreuztabellen.md) |
| `chart::bar` | [Charts](100-diagramme.md) |
| `table::draw` with `-ctx` and `-pagebreakcmd` | [Tables with Page Breaks](080-tabellen.md) |
| `page::header`, `page::footer` | [Headers, Footers, Page Numbers](060-kopf-fuss-seitenzahlen.md) |
| `toc::document`, `toc::heading` | [Table of Contents](110-inhaltsverzeichnis.md) |
| `tagged`, `metadata` | [Accessible PDFs](180-barrierefreie-pdfs.md) |

---

## The Script

```tcl
# 210-fallstudie.tcl -- Lagerbericht: Tabellen, Diagramm, Verzeichnis
package require pdf4tcl
package require pdf4tcllib
package require pdf4tclchart
package require pdf4tcltoc

pdf4tcllib::fonts::init -cid 1

# --- 1. Daten: vor dem Inhalt laden, er laeuft zweimal
# Bewegungen {Lager Gruppe Artikel Menge Wert}, nach Lager sortiert
set bewegungen {}
set nr 0
foreach lager {Nord Süd West} {
    incr nr
    for {set i 1} {$i <= 22} {incr i} {
        set gruppe [lindex {Schrauben Dübel Werkzeug} [expr {$i % 3}]]
        set menge  [expr {($i * 7 + $nr * 11) % 40 - 8}]
        set wert   [format %.2f [expr {$menge * (1.5 + $i % 5)}]]
        lappend bewegungen [list $lager $gruppe \
            [format "%s-%03d" [string index $lager 0] $i] $menge $wert]
    }
}
set g [pdf4tcllib::table::group $bewegungen -by 0 -sum {3 4} \
    -label "Summe %s" -totallabel "Gesamt" -blank 1]
set p [pdf4tcllib::table::pivot $bewegungen -row 0 -col 1 -value 4 \
    -rowlabel Lager -colorder {Schrauben Dübel Werkzeug}]

# Wert je Lager fuer das Diagramm: die Zeile "Gesamt" der Kreuztabelle
# hat die Spaltensummen, die letzte Spalte jeder Zeile die Zeilensumme
set balken {}
foreach z [lrange [dict get $p rows] 0 end-1] {
    lappend balken [lindex $z 0] [lindex $z end]
}

set stile {}
foreach i [dict get $g subtotals] { lappend stile $i {-font bold} }
lappend stile [dict get $g total] {-font bold -bg {0.85 0.85 0.85}}

proc betrag {v} {
    if {[string is double -strict $v]} { return [format %.2f $v] }
    return $v
}

# --- 2. Seitenwechsel: Fuss auf die alte, Kopf auf die neue Seite
# Laeuft im globalen Bereich; dort ist pdf im ersten Durchlauf das
# Wegwerf-Dokument, im zweiten das echte.
proc seitenwechsel {} {
    global pdf ctx
    pdf4tcllib::page::footer $pdf $ctx "Lagerbericht Oktober" \
        [$pdf currentPage]
    $pdf endPage
    $pdf startPage
    pdf4tcllib::page::header $pdf $ctx "Lagerbericht Oktober"
    return [expr {[dict get $ctx top] + 10}]
}

# --- 3. Der Inhalt als Skript
set inhalt {
    set x [dict get $ctx left]
    set w [dict get $ctx text_w]

    $pdf startPage
    set y [dict get $ctx top]
    pdf4tcllib::toc::heading $pdf $ctx y 1 "Überblick"
    set y [pdf4tcllib::text::writeParagraph $pdf "Bewegungen der drei\
        Lager im Oktober, bewertet zum Einstandspreis. Negative Mengen\
        sind Abgänge." $x $y $w 11]
    set y [pdf4tcllib::chart::bar $pdf $x [expr {$y + 10}] $w 160 \
        $balken -title "Wert je Lager (€)" -values 1 -format %.0f \
        -alt "Balkendiagramm: Wert der Bewegungen je Lager"]

    set y [expr {$y + 16}]
    pdf4tcllib::toc::heading $pdf $ctx y 2 "Lager und Warengruppe"
    set kopf [lmap h [dict get $p header] {
        set a right
        if {$h eq "Lager"} { set a left }
        list -header $h -width 90 -align $a
    }]
    set y [pdf4tcllib::table::draw $pdf $x $y $kopf \
        [lmap z [dict get $p rows] { lmap v $z { betrag $v } }] \
        -rowstyles [list [dict get $p total] {-font bold}] \
        -summary "Wert je Lager und Warengruppe"]
    pdf4tcllib::page::footer $pdf $ctx "Lagerbericht Oktober" \
        [$pdf currentPage]
    $pdf endPage

    $pdf startPage
    pdf4tcllib::page::header $pdf $ctx "Lagerbericht Oktober"
    set y [expr {[dict get $ctx top] + 10}]
    pdf4tcllib::toc::heading $pdf $ctx y 1 "Bewegungen"
    set y [pdf4tcllib::table::draw $pdf $x $y {
        {-header Lager   -width 50}
        {-header Gruppe  -width 80}
        {-header Artikel -width 60}
        {-header Menge   -width 50 -align right}
        {-header Wert    -width 70 -align right}
    } [lmap z [dict get $g rows] {
        lset z end [betrag [lindex $z end]]
    }] \
        -ctx $ctx -zebra 1 -rowstyles $stile \
        -pagebreakcmd seitenwechsel -summary "Bewegungen je Lager"]
    pdf4tcllib::page::footer $pdf $ctx "Lagerbericht Oktober" \
        [$pdf currentPage]
    $pdf endPage
}

# --- 4. Dokument: Strukturbaum, Verzeichnis, zwei Durchlaeufe
set pdf [pdf4tcl::new %AUTO% -paper a4 -orient true]
$pdf tagged 1 -lang de-DE
$pdf metadata -title "Lagerbericht Oktober" -author "Lagerverwaltung"
$pdf viewerPreferences -displaydoctitle 1
set ::pdf4tcl::warnings {}
set r [pdf4tcllib::toc::document $pdf a4 $inhalt -title "Inhalt"]

puts "Verzeichnis: [dict get $r tocPages] Seite(n),\
    Inhalt: [dict get $r contentPages] Seiten"
foreach e [dict get $r entries] { puts "  $e" }
puts "ohne Element: [$pdf getUntaggedCount]"
$pdf write -file 210-fallstudie.pdf
$pdf destroy
foreach m $::pdf4tcl::warnings { puts "Warnung: $m" }
```

```text
Verzeichnis: 1 Seite(n), Inhalt: 3 Seiten
  1 Überblick 2
  2 {Lager und Warengruppe} 2
  1 Bewegungen 3
ohne Element: 0
```

The PDF has four pages:

| Page | Content |
|---|---|
| 1 | table of contents "Inhalt" (contents) with three entries |
| 2 | "Überblick" (overview): paragraph, bar chart, crosstab |
| 3 | "Bewegungen" (movements): header, table up to "S-018" |
| 4 | header, continuation of the table with the column header row repeated, "Summe West" (subtotal) and "Gesamt" (grand total) |

The script consists of four parts, numbered in the comments.

---

## 1. The Data First

`toc::document` runs the content twice
([Table of Contents](110-inhaltsverzeichnis.md)). Everything that may
happen only once therefore comes before it: creating, grouping and
reshaping the data. In the report of a real program, the database query
would go here; a second read from the same channel would find it empty.

One list yields three views:

- `table::group` inserts a subtotal per warehouse and the grand total at
  the end, for the long table. The rows must be sorted by warehouse;
  `group` does not sort.
- `table::pivot` turns it into the crosstab of warehouse by product
  group. `-colorder` fixes the columns; otherwise they would be in
  alphabetical order.
- The chart needs pairs of name and value. The crosstab already
  supplies them: the last column of each row is the row total, and the
  last row ("Gesamt") is left out.

The totals from `group` and `pivot` are raw Tcl numbers. `betrag`
formats them only when drawing, so that the data itself stays numeric.

---

## 2. The Page Break

`-pagebreakcmd` runs in the global scope
([Tables with Page Breaks](080-tabellen.md)). The procedure
`seitenwechsel` therefore gets `pdf` and `ctx` with `global`. This works
here because `toc::document` sets the variable `pdf` in the caller's
scope: in the first pass it holds the throwaway document, in the second
the real one. A procedure that kept the document in a variable of its
own instead would write into the wrong one in the first pass.

The page number in the footer is `[$pdf currentPage]`. In the first
pass the table of contents page is missing, so the numbers there are
one too small. That does no harm: the footer does not shift anything,
and only the second pass is printed. There the table of contents is
counted, and the footer says "Seite 2" where the table of contents says
"Überblick ... 2".

---

## 3. The Content

The script starts and ends its pages itself. The first content page has
no header, only the footer; from the second page on the script sets
both, and on the continuation pages of the table `seitenwechsel` does
it.

Two gaps are set by hand: 10 points before the chart and 16 points
after it. `chart::bar` returns the bottom edge of its box, and
`toc::heading` puts the heading exactly there. Without the gap, "Lager
und Warengruppe" (warehouse and product group) sticks to the axis
labels.

The row "Summe Nord" starts with a cell merged across three columns.
Since pdf4tcllib 0.6.7, `table::draw` no longer draws a vertical rule
through it; before that, the row read "Summe No|rd".

---

## 4. The Document

Three lines make the report accessible:

- `tagged 1 -lang de-DE` turns on the structure tree and names the
  language;
- `metadata -title` gives the title;
- `viewerPreferences -displaydoctitle 1` makes the viewer show the title
  instead of the file name.

The building blocks do the rest: `toc::heading` sets `H1` and `H2`,
`text::writeParagraph` a `P`, `table::draw` the tables with header
cells, `chart::bar` a `Figure` with alternate text, and headers and
footers are artifacts. `getUntaggedCount` reports 0. The throwaway
document of the first pass has no structure tree; there the building
blocks do none of this.

`::pdf4tcl::warnings` stays empty. With pdf4tclchart 0.1.1 this still
said "the Figure element is empty": the chart was marked entirely as an
artifact, and the `Figure` had no content.

---

## What Is Deliberately Missing

- **"Page X of Y".** `toc::document` gives the total only afterwards
  (`contentPages` plus `tocPages`), when the footers have already been
  drawn. The manual route from
  [Table of Contents](110-inhaltsverzeichnis.md) knows it earlier:
  after the trial run with `toc::collect`, the throwaway document has
  `pageCount` pages, plus the pages from `toc::pageCount`.
- **A cover page.** `toc::document` writes the table of contents as the
  first page. A cover page before it is only possible by hand, with
  `collect`, `pageCount` and `render`.
- **Multi-line cells.** `table::draw` truncates texts that are too
  long; for remarks, `table::render` would be the choice.
- **Numbers with a decimal comma.** `format %.2f` writes a period. For a
  German report, a `string map {. ,}` belongs in `betrag`; in the chart
  this is not possible, `-format` knows no decimal comma.

---

## Summary

- Load and reshape the data before `toc::document`; the content runs
  twice.
- `group` for the long table, `pivot` for the overview, the chart
  values from the crosstab.
- `-pagebreakcmd` with `global pdf`: the throwaway document in the
  first pass, the real one in the second.
- Gaps around charts by hand; `chart::bar` ends at its bottom edge.
- `tagged`, `metadata -title`, `displaydoctitle`; the building blocks
  do the rest.

---

*Next chapter: [Pitfalls](800-anhang-fallen.md)*
