# Charts

## Introduction

Many reports include a picture of the numbers: revenue per month as
bars, two years as lines, shares as a pie. The package
[pdf4tclchart]{.index} draws these three forms directly with pdf4tcl,
without Tk and without creating an image. It is not a library for
scientific charts: no logarithmic axes, no error bars, no second
y-axis.

---

## Data and Box

Each of the three procedures takes a box and the data:

```tcl
package require pdf4tclchart
set y [pdf4tcllib::chart::bar  pdf x y breite hoehe daten ?opt ...?]
set y [pdf4tcllib::chart::line pdf x y breite hoehe daten ?opt ...?]
set y [pdf4tcllib::chart::pie  pdf x y breite hoehe daten ?opt ...?]
```

`x y` is the top left corner (y pointing down), width and height in
points. The return value is the y position below the chart, so charts
stack one below the other like paragraphs.

The data are pairs of label and number, flat or as a list of pairs:

```tcl
{Jan 120 Feb 145 Mär 98}
{{Jan 120} {Feb 145} {Mär 98}}
```

A value that is not a number raises an error that names the label.
Empty values are therefore not allowed here, unlike in
`table::pivot`.

---

## Three Charts on One Page

```tcl
# 100-diagramme.tcl -- Balken, Linien und Torte auf einer Seite
package require pdf4tcl
package require pdf4tcllib
package require pdf4tclchart

pdf4tcllib::fonts::init -cid 1
set ctx [pdf4tcllib::page::context a4 -margin 20]
set pdf [pdf4tcl::new %AUTO% -paper a4 -orient true]
$pdf startPage

set x [dict get $ctx left]
set w [dict get $ctx text_w]
set y [expr {[dict get $ctx top] + 10}]

# Balken: Paare aus Beschriftung und Wert
set y [pdf4tcllib::chart::bar $pdf $x $y $w 180 \
    {Jan 120 Feb 145 Mär 98 Apr 160 Mai -20 Jun 132} \
    -title "Ergebnis je Monat (Tsd. €)" -values 1 -format %.0f]

# Linien: mehrere Reihen, je {Name {Paare}}
set reihen {
    {2025 {Q1 100 Q2 130 Q3 120 Q4 175}}
    {2026 {Q1 140 Q2 120 Q3 165 Q4 190}}
}
set oben [expr {$y + 20}]
set y [pdf4tcllib::chart::line $pdf $x $oben [expr {$w - 80}] 170 \
    $reihen -title "Umsatz je Quartal"]
# Die Linien haben keine eigene Legende; die Reihen selbst beschriften
pdf4tcllib::chart::legend $pdf \
    [expr {$x + $w - 70}] [expr {$oben + 30}] \
    {{2025 0} {2026 0}} [pdf4tcllib::chart::configure]

# Torte mit Legende und Anteilen
set y [pdf4tcllib::chart::pie $pdf $x [expr {$y + 20}] $w 170 \
    {Wartung 42 Neugeräte 31 Ersatzteile 18 Schulung 9} \
    -title "Umsatz nach Bereich" -legend 1]

puts "Skala für 137: [pdf4tcllib::chart::niceScale 0 137]"
puts "unten bei y = [format %.1f $y]"
$pdf endPage
$pdf write -file 100-diagramme.pdf
$pdf destroy
```

```text
Skala für 137: 0.0 150.0 50.0
unten bei y = 626.7
```

### Bars

One bar per pair, each in a different color. Negative values sit below
the zero line, and the scale then extends into the negative range (in
the example, Mai (May) with −20). `-values 1` writes the value above
each bar, in the format given by `-format`.

### Lines

One series or several. Several series are a list of
`{Name {Paare}}` (name and pairs); the x-axis labels come from the first
series, and the others are drawn at the same positions. Each data point
gets a dot.

`line` does not draw the series names (`2025`, `2026`), and it has no
legend. Without a legend, the reader cannot tell which line is which
year. The example therefore makes the chart narrower and draws a legend
next to it with [chart::legend]{.index}, in the same colors:

```tcl
pdf4tcllib::chart::legend $pdf $x $y {{2025 0} {2026 0}} \
    [pdf4tcllib::chart::configure]
```

The fourth argument is the pairs, the fifth the options (for size and
colors); `chart::configure` without arguments returns the defaults.

### Pie

The slices run clockwise from twelve o'clock; `pie` computes the shares
from the total. With `-legend 1`, a legend with percentages appears on
the right, and the circle becomes smaller accordingly. Negative values
or a total of 0 are an error.

---

## Options

| Option | Default | Meaning |
|---|---|---|
| `-title` | – | heading above the chart |
| `-titlesize`, `-labelsize`, `-valuesize` | `11`, `8`, `8` | font sizes |
| `-values` | `0` | write the values on the bars |
| `-format` | `%g` | format of every number, including on the axis |
| `-colors` | six colors | list of colors, used in order |
| `-color` | – | one color for everything |
| `-grid` | `4` | number of grid lines; `0` for none |
| `-min`, `-max` | from the data | fix the scale |
| `-legend` | `0` | `pie` only |
| `-alt` | `-title` | alternate text in the accessible PDF |

The six default colors differ in lightness as well, not only in hue. A
chart that is printed or copied in gray thus stays readable. Custom
colors are best chosen the same way.

### The Scale

The axis does not end at the largest value but at a round number:
[chart::niceScale]{.index} turns 137 into the scale 0 to 150 in steps
of 50. A grid line at 137 helps nobody who wants to read off the value.
For two charts meant to be compared, give both the same scale with
`-min` and `-max`; otherwise a small value in one looks as large as a
large value in the other.

### Numbers with a Decimal Comma

`-format` is passed to Tcl's `format`, which knows no decimal comma.
`%.0f` and `%d` are therefore the safe choice for German reports;
decimal places appear with a point.

---

## Accessibility

In an accessible PDF (Part 5), each chart is a `Figure` element with
the alternate text from `-alt` or the title. Bars, lines and labels are
the content of this element, and the alternate text stands for them. A
screen reader therefore says "Abbildung: Ergebnis je Monat" ("Figure:
result per month") and not the individual numbers. If the numbers
matter, they belong in a table as well.

---

## Summary

- `chart::bar`, `chart::line`, `chart::pie` with a box and pairs; each
  returns the y position below the chart.
- Several lines need a legend of their own via `chart::legend`.
- Fix the scale with `-min`/`-max` when charts are compared.
- `-format` without a decimal comma.

---

*Next chapter: [Table of Contents](110-inhaltsverzeichnis.md)*
