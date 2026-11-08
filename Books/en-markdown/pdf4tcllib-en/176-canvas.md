# Canvas

## Introduction

A diagram a Tk program draws on a `canvas` often belongs in the report
too. pdf4tcl can draw it itself: `$pdf canvas` carries over rectangles,
lines, ovals, polygons and text, also from `tkpath` and `tko::path`. What
remains to be done by hand is everything around it: computing the scale,
aligning the drawing in its frame, setting the caption and putting the
whole into the structure tree of an accessible PDF. That is what
[pdf4tclcanvas]{.index} does.

---

## A Process

The example script is the same as in the German edition; comments and
sample data are German.

```tcl
# 176-canvas.tcl -- eine Canvas-Zeichnung im Rahmen, mit Massstab
package require Tk
package require pdf4tcl
package require pdf4tcllib
package require pdf4tclcanvas

pdf4tcllib::fonts::init -cid 1
set ctx [pdf4tcllib::page::context a4 -margin 20]

# Die Zeichnung: drei Schritte eines Ablaufs, 420 x 120 Pixel
font create kasten -family Helvetica -size 11
canvas .c -width 440 -height 140 -bg white
foreach {i text farbe} {0 Bestellung #dbe8f6  1 Lieferschein #e3f2dc
                        2 Rechnung #fbe7cf} {
    set x [expr {20 + $i * 150}]
    .c create rectangle $x 30 [expr {$x + 110}] 90 -fill $farbe -outline #555555
    .c create text [expr {$x + 55}] 60 -text $text -font kasten
    if {$i < 2} {
        .c create line [expr {$x + 110}] 60 [expr {$x + 150}] 60 -arrow last
    }
}
pack .c
update idletasks

set pdf [pdf4tcl::new %AUTO% -paper a4 -orient true]
$pdf tagged 1
$pdf startPage
set x [dict get $ctx left]
set y [dict get $ctx top]
# Text im Canvas in der TrueType-Schrift, damit Umlaute ankommen
set map [list kasten [pdf4tcllib::fonts::fontSans]]

# Ein Rahmen 300 x 70 mit Unterschrift: die Zeichnung behaelt ihr
# Verhaeltnis, die Unterschrift steht unten im Rahmen
set r1 [pdf4tcllib::canvas::place $pdf .c $x $y 300 70 -border 1 \
    -fontmap $map -alt "Ablauf: Bestellung, Lieferschein, Rechnung" \
    -caption "Abb. 1: Vom Auftrag zur Rechnung"]
puts "Rahmen 300 x 70:  [lmap v $r1 {format %.1f $v}]"

# Ein schmaler, hoher Rahmen: die Breite bestimmt den Massstab
pdf4tcllib::tag::artifact $pdf                 ;# der Rahmen selbst, grau
$pdf setStrokeColor 0.6 0.6 0.6
$pdf rectangle $x [expr {$y + 100}] 150 150
$pdf setStrokeColor 0 0 0
pdf4tcllib::tag::artifactEnd $pdf
set r2 [pdf4tcllib::canvas::place $pdf .c $x [expr {$y + 100}] 150 150 \
    -border 1 -anchor center -fontmap $map]
puts "Rahmen 150 x 150: [lmap v $r2 {format %.1f $v}]"
$pdf endPage

# Seite 2: dieselbe Zeichnung auf die ganze Seite, oben ausgerichtet
$pdf startPage
set r3 [pdf4tcllib::canvas::fitPage $pdf .c $ctx -anchor n -fontmap $map \
    -alt "Ablauf, gross"]
puts "fitPage:          [lmap v $r3 {format %.1f $v}]"
$pdf endPage
puts "ohne Struktur: [$pdf getUntaggedCount]"

$pdf write -file 176-canvas.pdf
$pdf destroy
exit                        ;# sonst wartet Tk auf Ereignisse
```

```text
Rahmen 300 x 70:  56.7 62.1 300.0 45.1
Rahmen 150 x 150: 56.7 220.4 150.0 22.6
fitPage:          56.7 56.7 481.9 72.5
ohne Struktur: 0
```

Page 1 shows the process twice: once 300 points wide with a caption,
once in a square frame of 150 points, where it is only 22.6 points high
and centred. On page 2 it fills the width of the type area.

---

## place

```tcl
set area [pdf4tcllib::canvas::place pdf canvas x y w h ?option value ...?]
```

[canvas::place]{.index} sets the drawing into the frame `x y w h` and
returns the area it really occupies, as `{x y w h}`, without the caption
band. This is the area to keep calculating with: in the example the
first drawing is 45.1 points high, not 70.

**The scale.** The drawing is as large as `$c bbox all`, the area its
items occupy, not the size of the widget. In the example that is
420 × 60 pixels, not 440 × 140. Whoever wants the white margin of the
widget passes `-bbox {0 0 440 140}`. The scale is the smaller of the two
factors width/width and height/height; in the frame 300 × 56 (70 minus
14 for the caption) it is the width. A canvas without items is not an
error; the size of the widget applies then.

**The alignment.** Whatever stays free in the other direction is
distributed by `-anchor`: `nw`, `n`, `ne`, `w`, `center` (default), `e`,
`sw`, `s`, `se`.

**The font.** `$pdf canvas` translates canvas text by its Tk font.
`-fontmap` assigns a PDF font to a Tk font; in the example the named font
`kasten` gets the TrueType font from `fonts::init`. Without a mapping,
pdf4tcl looks for a PDF font registered under the Tk family name, as in
the chapter [Text Widget](174-text-widget.md), otherwise it takes one of
the standard fonts. Those know only Latin-1; anything beyond becomes "?"
without an error. Text shrinks with the drawing; in the narrow frame it
can hardly be read. `-textscale` passes a factor of its own to
`$pdf canvas`.

**`-fit stretch`** hands the frame unchanged to `$pdf canvas`. Nothing
is distorted: `$pdf canvas` keeps the ratio itself and puts the drawing
at the top left of the frame. What is lost is the alignment and the exact
area: `-border` then frames the whole frame, and the return value is the
frame.

| Option | Default | Meaning |
|---|---|---|
| `-fit` | `contain` | `stretch`: frame unchanged to `$pdf canvas` |
| `-anchor` | `center` | position in the frame |
| `-alt` | – | description; makes the drawing a `Figure` |
| `-caption` | – | caption at the bottom of the frame |
| `-captionH` | `14` | height of the caption band |
| `-fontsize`, `-font` | `9`, from `fonts::init` | caption font |
| `-bbox` | `bbox all` | own section in canvas coordinates |
| `-fontmap`, `-textscale` | – | passed on to `$pdf canvas` |
| `-border` | `0` | line around the drawing |

### The Caption

The caption stands at the bottom of the frame, centred across the whole
width `w`, not directly below the drawing. That is why the first frame
in the example is 70 points high: 56 for the drawing, 14 for the line
below. A frame much taller than the drawing leaves a gap; `-anchor s`
helps then.

If the caption is too wide, it is set smaller instead of cut, down to
5 points, with `text::fitSize` (chapter [Setting Text](050-text-setzen.md)).

### In the Structure Tree

`$pdf canvas` alone leaves drawing operations outside the structure
tree. `place` wraps them:

- with `-alt` as a `Figure` with this description,
- without `-alt` but with `-caption` as a `Figure` with the caption as
  description,
- without either as an artifact, decoration a screen reader skips.

The caption stands as `Caption` inside the `Figure`. `getUntaggedCount`
is 0 at the end. The grey frame in the example is wrapped with
`tag::artifact`; without it the count would be 1 (chapter
[Accessible PDFs](180-barrierefreie-pdfs.md)).

---

## fitPage

```tcl
set area [pdf4tcllib::canvas::fitPage pdf canvas ctx ?option value ...?]
```

[canvas::fitPage]{.index} is `place` with the type area from the page
context as frame, `SX SY SW SH`. It takes the same options. A wide
process becomes as wide as the type area; `-anchor n` puts it at the top
instead of the middle of the page.

---

## What Does Not Work

- `place` adds no item types; what arrives is decided by `$pdf canvas`.
  An embedded window (`create window`) is carried over only as a
  screenshot when the package Img is present and the window is on
  screen, otherwise as a black rectangle.
- `-orient true` is required, as everywhere in pdf4tcllib.
- A drawing taller than the page is not spread over several pages but
  scaled down.

---

## Summary

- `canvas::place` sets a canvas into a frame, keeping the ratio, and
  returns the occupied area.
- What is measured is `bbox all`; `-bbox` for another section.
- `-fontmap` for umlauts and the euro sign in canvas text.
- `-alt` or `-caption` make a `Figure`, otherwise an artifact.
- `canvas::fitPage` for a drawing across the type area.

---

*Next chapter: [Treeview](170-treeview.md)*
