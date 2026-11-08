# Drawing Helpers

## Introduction

Besides tables, charts and forms, pdf4tcllib has a number of small
helpers that each do one thing: a gradient, a regular polygon, a star,
rotated or slanted text, an exponent. They live in the namespaces
[drawing]{.index} and [text]{.index} and need no package of their
own. At the end of the chapter are the remaining small queries from the
core that do not appear anywhere else in the book.

Arrows, callouts and rounded rectangles from the same namespace are in
the chapter [Arrows and Callouts](150-pfeile-und-callouts.md), the
watermark in the chapter
[Column Flow and Watermarks](070-spaltenfluss-wasserzeichen.md).

---

## One Sheet with Everything

The example script is the same as in the German edition; comments and
sample data are German.

```tcl
# 155-zeichenhilfen.tcl -- Verlauf, Formen, gedrehter Text, Exponenten
package require pdf4tcl
package require pdf4tcllib

pdf4tcllib::fonts::init -cid 1
set ctx [pdf4tcllib::page::context a4 -margin 20]
set sans [pdf4tcllib::fonts::fontSans]
set pdf [pdf4tcl::new %AUTO% -paper a4 -orient true]
$pdf startPage
set x [dict get $ctx left]
set y [dict get $ctx top]
set w [dict get $ctx text_w]

# Ein Band mit Farbverlauf als Kopf, darauf weisser Text
pdf4tcllib::drawing::gradient_h $pdf $x $y $w 40 {0.10 0.25 0.45} {0.55 0.75 0.90} 60
$pdf setFillColor 1 1 1
$pdf setFont 18 $sans
$pdf text "Gärtnerei Beispiel" -x [expr {$x + 12}] -y [expr {$y + 27}]
$pdf setFillColor 0 0 0
puts "Mitte des Verlaufs: [pdf4tcllib::drawing::interpolate {0 0 0} {1 0.5 0} 0.5]"

# Formen: Sechseck, Stern, Rahmen, Trennlinie
set y [expr {$y + 90}]
$pdf setFillColor 0.85 0.92 0.80
pdf4tcllib::drawing::polygon $pdf [expr {$x + 40}] $y 30 6 1 1
$pdf setFillColor 0.98 0.80 0.30
pdf4tcllib::drawing::star $pdf [expr {$x + 120}] $y 32 5 0.45 1 1
pdf4tcllib::drawing::star $pdf [expr {$x + 200}] $y 32 8 0.7
$pdf setFillColor 0 0 0
pdf4tcllib::drawing::frame $pdf [expr {$x + 250}] [expr {$y - 30}] 120 60 2
pdf4tcllib::drawing::separator $pdf $x [expr {$y + 50}] $w

# Text gedreht, gestreckt, geneigt
set y [expr {$y + 120}]
pdf4tcllib::drawing::textRotated $pdf "um 30 Grad" $x $y 30 12
pdf4tcllib::drawing::textScaled  $pdf "breit" [expr {$x + 130}] $y 2.0 1.0 12
pdf4tcllib::drawing::textScaled  $pdf "hoch"  [expr {$x + 260}] $y 1.0 2.0 12
pdf4tcllib::drawing::textSkewed  $pdf "geneigt" [expr {$x + 340}] $y 0 20 12

# Hoch- und tiefgestellt: beide geben ihre Breite zurueck
set y [expr {$y + 50}]
$pdf setFont 12 $sans
$pdf text "Fläche 113 cm" -x $x -y $y
set x2 [expr {$x + [pdf4tcllib::text::width "Fläche 113 cm" 12 $sans $pdf]}]
set x2 [expr {$x2 + [pdf4tcllib::text::superscript $pdf 2 $x2 $y 12 $sans]}]
$pdf text ", Wasser H" -x $x2 -y $y
set x3 [expr {$x2 + [pdf4tcllib::text::width ", Wasser H" 12 $sans $pdf]}]
set x3 [expr {$x3 + [pdf4tcllib::text::subscript $pdf 2 $x3 $y 12 $sans]}]
$pdf text "O" -x $x3 -y $y
# Zeichen nach Namen
set m [lmap n {alpha le infty deg} {pdf4tcllib::text::mathSymbol $n}]
$pdf text "Symbole: [join $m {  }]" -x $x -y [expr {$y + 20}]
puts "Symbole: $m"
puts "Namen bekannt: [llength [pdf4tcllib::text::mathSymbolNames]]"
puts "unbekannt: \"[pdf4tcllib::text::mathSymbol aleph]\""
$pdf endPage

# Kleine Helfer ohne Seite
puts "Tabs: \"[pdf4tcllib::text::expandTabs "a\tbc\td" 4]\""
foreach z [list "    set x 1" "Menge: 12 Stück" {puts $wert}] {
    puts [format "%-18s -> %s" $z [pdf4tcllib::text::detectFont $z]]
}

$pdf write -file 155-zeichenhilfen.pdf
$pdf destroy
```

```text
Mitte des Verlaufs: 0.5 0.25 0.0
Symbole: α ≤ ∞ °
Namen bekannt: 69
unbekannt: ""
Tabs: "a   bc  d"
    set x 1        -> Pdf4tclMono
Menge: 12 Stück    -> Pdf4tclSans
puts $wert         -> Pdf4tclMono
```

The page shows a header band with a gradient from dark to light blue, a
green hexagon, a yellow and an empty star, a frame, a grey line, text
deformed four ways, and a line with cm², H₂O and the four symbols.

---

## Gradients

```tcl
pdf4tcllib::drawing::gradient_h pdf x y w h colour1 colour2 ?steps?
pdf4tcllib::drawing::gradient_v pdf x y w h colour1 colour2 ?steps?
```

[drawing::gradient_h]{.index} runs from left to right,
[drawing::gradient_v]{.index} from top to bottom. Colours are
`{r g b}` with values from 0 to 1. This is not a PDF shading: the area
is divided into `steps` strips (default 100), each filled in its colour.
In the example 60 are enough for 482 points of width; strips of
8 points cannot be seen.

In an accessible PDF the gradient is an artifact, that is decoration.
Text on it is drawn afterwards, as in the example; the fill colour has
to be set and reset for that.

[drawing::interpolate]{.index} is the calculation behind it: the colour
at position `t` between 0 and 1. The example asks for the middle between
black and orange.

---

## Shapes

```tcl
pdf4tcllib::drawing::polygon pdf cx cy radius corners ?stroke? ?fill?
pdf4tcllib::drawing::star    pdf cx cy radius ?points? ?ratio? ?stroke? ?fill?
pdf4tcllib::drawing::frame     pdf x y w h ?linewidth?
pdf4tcllib::drawing::separator pdf x y w ?colour? ?linewidth?
```

[drawing::polygon]{.index} draws a regular polygon around the centre
`cx cy`; `radius` is the distance to the corners, and the first corner
points up. [drawing::star]{.index} has `points` spikes (default 5);
`ratio` is the inner radius relative to the outer, 0.5 by default. The
eight-pointed star in the example has 0.7 and looks blunt. `stroke` and
`fill` are 0 or 1, the colours those of `setStrokeColor` and
`setFillColor`.

[drawing::frame]{.index} is a rectangle with outline only, in the
given line width. [drawing::separator]{.index} is a horizontal line,
light grey and 0.5 points wide unless given otherwise; afterwards the
stroke colour is black again.

Both set the line width and leave it so. Whoever wants other lines
afterwards sets it again with `setLineWidth`.

---

## Deforming Text

```tcl
pdf4tcllib::drawing::textRotated pdf text x y angle size ?font?
pdf4tcllib::drawing::textScaled  pdf text x y sx sy size ?font?
pdf4tcllib::drawing::textSkewed  pdf text x y skewX skewY size ?font?
```

Without `font` all three take the font from `fonts::init`.

- [drawing::textRotated]{.index} rotates by `angle` degrees
  counter-clockwise, around the start of the baseline.
- [drawing::textScaled]{.index} stretches by `sx` horizontally and `sy`
  vertically. Width and height change; the font size stays.
- [drawing::textSkewed]{.index} slants: `skewX` tilts the baseline,
  `skewY` leans the glyphs, like an italic. These are `-xangle` and
  `-yangle` of `$pdf text`. In the example it is `0 20`.

`text::width` does not measure the deformation; it applies to the
undeformed line.

---

## Up, Down and Symbols by Name

```tcl
set width [pdf4tcllib::text::superscript pdf text x y size font]
set width [pdf4tcllib::text::subscript   pdf text x y size font]
```

[text::superscript]{.index} and [text::subscript]{.index} set the
text at 70 % of the size, 35 % of the size above or 20 % below the
baseline `y`. They return the width so the next text can follow, and
restore the size afterwards. For more than one exponent,
`math::renderLatex` is the easier way (chapter [Formulas](160-formeln.md)).

[text::mathSymbol]{.index} returns the character for a name as in
LaTeX: `alpha` α, `le` ≤, `infty` ∞, `deg` °. An unknown name returns an
empty string. `text::mathSymbolNames` lists the 69 names: Greek letters,
operators, arrows, set symbols. The characters need a font that has
them, so `fonts::init`.

---

## Small Helpers

The end of the example runs without a page:

- [text::expandTabs]{.index} replaces tabs with spaces up to the next
  column that is a multiple of 4 (or of the second argument). PDF knows
  no tabs.
- [text::detectFont]{.index} guesses whether a line is code and
  returns the monospaced or the normal font from `fonts::`. Code is a
  line with a tab, with four spaces at the start, with `|` at the start,
  or with `$name`, `::`, `->` or `{…}` in it.

Then there are queries the example does not use:

| Command | returns |
|---|---|
| `fonts::ready` | 1 when `fonts::init` has run |
| `fonts::isMonospace name` | 1 for the monospaced font and Courier |
| `fonts::widthFactor name` | average character width per point of font size, 0.52 if unknown |
| `fonts::subset`, `fonts::inSubset cp` | the 256 code points of the 256-character mode; whether a code point belongs to it |
| `unicode::preprocessBytes data` | raw UTF-8 bytes with emoji replaced by ASCII, before `encoding convertfrom` (Tcl 8.6 knows no characters above U+FFFF) |
| `tag::isActive pdf` | 1 when the document was created with `$pdf tagged 1` |
| `tag::depth pdf` | how many structure elements are open right now |
| `tag::forget pdf` | forgets the cached answer for a document |
| `table::breakPoints rows ?-fontsize -rowheight -header -groups?` | row heights and the rows before which no break should happen, for a page break of your own |
| `form::fieldHeight`, `form::rowHeight` | the configured field and row height of `form::` |
| `math::pdfBackend pdf`, `math::canvasBackend canvas` | a target for formulas: PDF or Tk canvas |
| `math::renderLatexOn target x y formula`, `math::measureLatexOn target formula` | set or measure a formula on this target |

The `…On` commands are the same formula engine as `math::renderLatex`,
only with a selectable target. With `math::canvasBackend` a formula
appears on a Tk canvas exactly as it would in the PDF.

---

## Summary

- Gradients are strips; `gradient_h` and `gradient_v` draw them as an
  artifact.
- `polygon` and `star` around a centre, `frame` and `separator` for
  frames and lines.
- `textRotated`, `textScaled`, `textSkewed` deform text; slanted like an
  italic is `0 angle`.
- `superscript` and `subscript` return their width; `mathSymbol` returns
  characters by name.

---

*Next chapter: [Formulas](160-formeln.md)*
