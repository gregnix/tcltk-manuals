# Units and Page Context

## Introduction

pdf4tcl calculates in points (1/72 inch), while forms and letter
templates are dimensioned in millimeters. And every drawing operation
needs the same numbers: where the type area begins on the left, how
wide it is, where it ends at the bottom. [page::context]{.index}
computes these numbers once and returns them as a dict. All building
blocks of pdf4tcllib that place something on the page take this dict.

---

## Converting Units

```tcl
pdf4tcllib::units::mm   10      ;# 28.346...  Millimeter -> Punkt
pdf4tcllib::units::cm   2.5     ;# 70.866...
pdf4tcllib::units::inch 1       ;# 72.0
pdf4tcllib::units::to_mm 72     ;# 25.4       Punkt -> Millimeter
pdf4tcllib::units::to_cm 72     ;# 2.54
pdf4tcllib::units::to_inch 144  ;# 2.0
```

That is all the namespace [units]{.index} does. The results are
floating-point numbers; rounding happens only when drawing.

### Keep pdf4tcl in Points

pdf4tcl can calculate in millimeters itself (`pdf4tcl::new ... -unit mm`).
Not with pdf4tcllib: `page::context` and all building blocks return and
expect points. An object with `-unit mm` takes the point values as
millimeters, and a footer at y = 813 ends up 813 mm down, far below the
page. The PDF is then empty, without an error message.

The same goes for pdf4tcl's `-margin` option: it shifts the origin by
the margin. `page::context` already includes the margin; both together
give twice the margin. A test with 20 mm in both placed the text at
x = 113 pt instead of 57 pt.

Therefore, for pdf4tcllib:

```tcl
# ohne -unit, ohne -margin
set pdf [pdf4tcl::new %AUTO% -paper a4 -orient true]
```

---

## page::context

```tcl
pdf4tcllib::page::context paper ?-margin mm? ?-landscape 0|1? \
    ?-orient 0|1?
```

| Argument | Default | Meaning |
|---|---|---|
| `paper` | – | `a3`, `a4`, `a5`, `b5`, `letter`, `legal` (upper or lower case) |
| `-margin` | `20` | margin in **millimeters**, the same on all four sides |
| `-landscape` | `0` | `1`: landscape, width and height swapped |
| `-orient` | `1` | `1`: y grows downward, `0`: upward |

Any other paper is rejected:

```text
unknown paper size: din-lang (known: letter a3 legal a4 a5 b5)
```

The short form `context a4 20 0` is equivalent to
`context a4 -margin 20 -orient 0`; the second word is therefore the
direction, not landscape. The form with options is easier to read.

### What the Dict Contains

```tcl
# 040-seitenkontext.tcl -- Satzspiegel aus page::context, hoch und quer
package require pdf4tcl
package require pdf4tcllib

pdf4tcllib::fonts::init

proc zeige {ctx} {
    foreach k {paper page_w page_h margin left right top bottom
               text_w text_h} {
        set v [dict get $ctx $k]
        if {[string is double -strict $v]} { set v [format %.2f $v] }
        puts [format "  %-7s %s" $k $v]
    }
}

puts "A4 hoch, 20 mm Rand, y nach unten (orient true):"
set ctx [pdf4tcllib::page::context a4 -margin 20]
zeige $ctx

puts "A4 quer, 15 mm Rand, y nach oben (orient false):"
set quer [pdf4tcllib::page::context a4 -margin 15 -landscape 1 \
    -orient false]
zeige $quer

# Den Satzspiegel einzeichnen: einmal je Richtung, jeweils mit
# passendem pdf4tcl-Objekt
foreach {name c} [list hoch $ctx quer $quer] {
    set pdf [pdf4tcl::new %AUTO% -paper a4 \
        -landscape [dict get $c landscape] \
        -orient [dict get $c orient]]
    $pdf startPage
    set l [dict get $c left]; set r [dict get $c right]
    set t [dict get $c top];  set b [dict get $c bottom]
    $pdf setStrokeColor 0.2 0.4 0.8
    $pdf rectangle $l [expr {min($t, $b)}] \
        [dict get $c text_w] [dict get $c text_h]
    $pdf setFont 10 [pdf4tcllib::fonts::fontSans]
    set y $t
    set mm [pdf4tcllib::units::to_mm [dict get $c text_w]]
    set zeilen [list "Satzspiegel $name" "[format %.0f $mm] mm breit"]
    foreach zeile $zeilen {
        pdf4tcllib::page::_advance $c y 14
        pdf4tcllib::unicode::safeText $pdf $zeile \
            -x [expr {$l + 6}] -y $y
    }
    pdf4tcllib::page::number $pdf $c 1
    $pdf endPage
    $pdf write -file 040-seitenkontext-$name.pdf
    $pdf destroy
}
```

```text
A4 hoch, 20 mm Rand, y nach unten (orient true):
  paper   a4
  page_w  595.28
  page_h  841.89
  margin  56.69
  left    56.69
  right   538.59
  top     56.69
  bottom  785.20
  text_w  481.89
  text_h  728.50
A4 quer, 15 mm Rand, y nach oben (orient false):
  paper   a4
  page_w  841.89
  page_h  595.28
  margin  42.52
  left    42.52
  right   799.37
  top     552.76
  bottom  42.52
  text_w  756.85
  text_h  510.24
```

| Key | Meaning | also as |
|---|---|---|
| `page_w`, `page_h` | page in points | `PW`, `PH` |
| `margin` | margin in points | `margin_pt` |
| `margin_mm` | margin, as given | – |
| `left`, `right` | left and right edge of the type area | `SX` for `left` |
| `top`, `bottom` | upper and lower edge, in the chosen direction | `SY` for `top` |
| `text_w`, `text_h` | width and height of the type area | `SW`, `SH` |
| `paper`, `landscape`, `orient` | the inputs | – |

The short names exist for older code. Other spellings
(`pageW`, `textWidth`) do not exist; `dict get` then reports an
error.

### top and bottom Depend on the Direction

`top` is always the upper edge of the type area, `bottom` the lower
one, but in the page's way of counting:

| | `-orient 1` (y downward) | `-orient 0` (y upward) |
|---|---|---|
| `top` | small (margin) | large (height − margin) |
| `bottom` | large (height − margin) | small (margin) |
| next line | y larger | y smaller |

The direction in the context and the direction of the pdf4tcl object
must match. The simplest way is to take it from the context:

```tcl
set pdf [pdf4tcl::new %AUTO% -paper a4 \
    -landscape [dict get $ctx landscape] \
    -orient [dict get $ctx orient]]
```

The building blocks in this book assume `-orient 1`, the default of
both packages. Tables from `table::draw` reject `-orient 0` with an
error (chapter [Tables with Page Breaks](080-tabellen.md)).

### Line by Line

[page::_advance]{.index} moves a y variable in the right direction,
without the code having to know the direction:

```tcl
set y [dict get $ctx top]
foreach zeile $zeilen {
    pdf4tcllib::page::_advance $ctx y 14   ;# erst weiter, dann setzen
    pdf4tcllib::unicode::safeText $pdf $zeile \
        -x [dict get $ctx left] -y $y
}
```

The underscore in the name is misleading: the procedure is documented
and is used by the form building blocks themselves.

The line spacing for a font size comes from
[page::lineheight]{.index}: font size × 1.4, rounded up
(`page::lineheight 10` gives 14). A different factor goes in as the
second argument.

### The First Line

For `$pdf text`, y is the baseline. Text placed at `y = top` sticks out
of the type area into the margin with its ascenders. The first line
therefore starts one font size lower, at `top` plus the font size (in
the `-orient 1` direction). That is exactly what the example above does
with `_advance` before writing.

---

## Header, Footer and Page Number

Three procedures write into the margin, above and below the type
area:

```tcl
# Mitte oben, Linie darunter
pdf4tcllib::page::header $pdf $ctx "Monatsbericht"
# links der Text, rechts "Seite 3"
pdf4tcllib::page::footer $pdf $ctx "Vertraulich" 3
# Mitte unten "- 3 / 10 -"
pdf4tcllib::page::number $pdf $ctx 3 10
```

`page::footer` writes the page number as "Seite 3". That is a default
of the library, not a translation; for an English document:

```tcl
# für alle Aufrufe
set ::pdf4tcllib::page::pageLabelFormat "Page %s"
# nur für diesen Aufruf
pdf4tcllib::page::footer $pdf $ctx "Confidential" 3 9 \
    -pagelabel "Page %s"
```

The font is the loaded TrueType font, Helvetica without TrueType; the
size is the last numeric argument (default 10 for the header, 9 for
footer and page number). All three go through `safeText` (chapter
[Safe Unicode Output](030-unicode-sicher-ausgeben.md)).

A fourth procedure, `page::centerText $pdf $ctx text y ?size? ?font?`,
centers a line, for example a title. Without a font argument it uses
**Helvetica**, not the loaded TrueType font; Helvetica is not embedded,
and the PDF is then no longer suitable for PDF/A. Therefore always pass
the font:

```tcl
pdf4tcllib::page::centerText $pdf $ctx "Jahresbericht" 120 20 \
    [pdf4tcllib::fonts::fontSansBold]
```

How many pages a document has is only known at the end. "Seite 3 von
10" (page 3 of 10) therefore needs a second pass; this is shown in the
chapter [Headers, Footers, Page Numbers](060-kopf-fuss-seitenzahlen.md).

---

## Guide Lines During Development

| Procedure | draws |
|---|---|
| `page::grid $pdf $ctx ?abstand?` | a gray grid over the whole page, with coordinates at the edge (default 50 pt) |
| `page::debugGrid $pdf $ctx ?abstand?` | the same, but only when the environment variable `PDF4TCL_DEBUG` is set |
| `page::orientationLegend $pdf $ctx` | one line in the right corner: paper, direction, position of the origin, unit |

`debugGrid` can stay in the code: without `PDF4TCL_DEBUG=1` it draws
nothing.

```bash
PDF4TCL_DEBUG=1 tclsh bericht.tcl
```

`page::grid` does not divide the page into columns. A grid for columns
is built from `left` and `text_w`; text across several columns is set
by the package `pdf4tclflow` (chapter [Column Flow and Watermarks](070-spaltenfluss-wasserzeichen.md)).

---

## Summary

- pdf4tcllib calculates in points; margins are given in millimeters.
- Create pdf4tcl objects without `-unit` and without `-margin`.
- `page::context` returns `left`, `top`, `text_w` and the rest; the
  direction in the context and in the pdf4tcl object must be the same.
- `page::_advance` and `page::lineheight` for the next line; the
  first line one font size below `top`.
- `page::header`, `page::footer`, `page::number` for the margin;
  adjust "Seite" through `pageLabelFormat`.

---

*Next chapter: [Setting Text](050-text-setzen.md)*
