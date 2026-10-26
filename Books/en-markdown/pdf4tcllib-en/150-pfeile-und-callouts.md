# Arrows and Callouts

## Introduction

A flow diagram, a labeled plan, a note next to a table: these need
boxes, arrows between them and now and then a callout that points at
something. pdf4tcl has lines, rectangles and polygons; the arithmetic
of which direction an arrowhead points in and where the line in front
of it has to stop is done by the namespace [drawing]{.index} in
pdf4tcllib.

---

## The Procedures

Four procedures: [drawing::arrow]{.index}, [drawing::arrowHead]{.index},
[drawing::callout]{.index} and [drawing::roundedRect]{.index}.

| Procedure | draws |
|---|---|
| drawing::arrow `pdf x1 y1 x2 y2 ?option ...?` | a line with a head |
| drawing::arrowHead `pdf x y winkel ?option ...?` | only the head, at a point |
| drawing::callout `pdf x y b h zielX zielY text ?option ...?` | a box with a pointer and text |
| drawing::roundedRect `pdf x y b h r ?rand? ?füllen?` | a rectangle with rounded corners |

Color and line width are the ones currently set; none of the procedures
changes them (except `callout`, see below).

---

## A Flow Diagram

Three boxes in a row, a fourth one below, straight and bent arrows and
two callouts.

```tcl
# 150-pfeile.tcl -- ein Ablaufschema mit Pfeilen und einer Sprechblase
package require pdf4tcl
package require pdf4tcllib

pdf4tcllib::fonts::init -cid 1
set ctx [pdf4tcllib::page::context a4 -margin 20]
set pdf [pdf4tcl::new %AUTO% -paper a4 -orient true]
$pdf startPage

# Ein Kasten mit runden Ecken und Text in der Mitte
proc kasten {x y w h text} {
    global pdf
    $pdf setFillColor 0.88 0.92 0.97
    pdf4tcllib::drawing::roundedRect $pdf $x $y $w $h 6 1 1
    $pdf setFillColor 0 0 0
    $pdf setFont 11 [pdf4tcllib::fonts::fontSansBold]
    $pdf text $text -align center \
        -x [expr {$x + $w / 2.0}] -y [expr {$y + $h / 2.0 + 4}]
}

set top [expr {[dict get $ctx top] + 120}]
set links [dict get $ctx left]
set b 110; set h 40; set abst 50
foreach name {Auftrag Lager Versand} {
    kasten $links $top $b $h $name
    set rechts($name) [expr {$links + $b}]
    set mitte($name)  [expr {$links + $b / 2.0}]
    set links [expr {$links + $b + $abst}]
}
set unten [expr {$top + 110}]
kasten [expr {$mitte(Lager) - $b / 2.0}] $unten $b $h "Rücksendung"

# Gerade Pfeile: von Kante zu Kante, die Spitze endet genau am Kasten
set my [expr {$top + $h / 2.0}]
$pdf setLineWidth 1.2
foreach k {Auftrag Lager} {
    pdf4tcllib::drawing::arrow $pdf \
        $rechts($k) $my [expr {$rechts($k) + $abst}] $my
}

# Geknickt, Versand -> Ruecksendung: Linie selbst ziehen, die
# Spitze mit arrowHead; sie zeigt nach links (Winkel pi)
set yr [expr {$unten + $h / 2.0}]
set xr [expr {$mitte(Lager) + $b / 2.0}]          ;# rechte Kante
$pdf setStrokeColor 0.7 0 0
$pdf setFillColor 0.7 0 0
$pdf line $mitte(Versand) [expr {$top + $h}] $mitte(Versand) $yr
$pdf line $mitte(Versand) $yr [expr {$xr + 8}] $yr
pdf4tcllib::drawing::arrowHead $pdf $xr $yr [expr {acos(-1)}]
# Beidseitig, nur umrissen: Lager <-> Ruecksendung
pdf4tcllib::drawing::arrow $pdf $mitte(Lager) [expr {$top + $h}] \
    $mitte(Lager) $unten -at both -filled 0
$pdf setStrokeColor 0 0 0
$pdf setFillColor 0 0 0

# Sprechblase ueber dem Lager, Zeiger auf die obere Kante
set n [pdf4tcllib::drawing::callout $pdf [expr {$mitte(Lager) + 20}] \
    [expr {$top - 95}] 170 50 $mitte(Lager) $top \
    "Der Bestand wird jeden Morgen um 6 Uhr mit der Buchhaltung\
     abgeglichen." \
    -fill {1 0.97 0.8} -radius 6]
puts "Sprechblase: $n Zeilen"

# Zu viel Text fuer den Kasten: wird kleiner, nicht gekuerzt
set n [pdf4tcllib::drawing::callout $pdf \
    [dict get $ctx left] [expr {$top - 95}] 120 40 \
    $mitte(Auftrag) $top \
    "Aufträge vor 14 Uhr gehen am selben Tag raus, alle anderen am\
     nächsten Werktag." \
    -fill {0.93 0.93 0.93}]
puts "Kleine Blase: $n Zeilen"

$pdf endPage
$pdf write -file 150-pfeile.pdf
$pdf destroy
```

```text
Sprechblase: 2 Zeilen
Kleine Blase: 3 Zeilen
```

### Straight Arrows

`arrow` draws the line from `x1 y1` to `x2 y2` and puts the head at the
end. The head **ends** exactly at the target point, and the line stops
one head length before it. If the line ran all the way to the end, it
would stick through the filled head and leave a stroke in its middle.
For arrows between boxes, this means: calculate from edge to edge, not
from center to center.

| Option | Default | Meaning |
|---|---|---|
| `-at` | `end` | `end`, `start` or `both` |
| `-length` | `8` | length of the head |
| `-width` | `6` | width of the head |
| `-filled` | `1` | `0`: head only outlined |

Unknown options and a wrong value for `-at` are errors.

### Bent Arrows

`arrow` draws only straight lines. For a connection around a corner,
draw the lines yourself and put the head at the end with `arrowHead`.
The angle is in radians; 0 points to the right, π to the left. With y
pointing down, π/2 points **down**.

Here too, the last line has to stop before the head, in the example
8 points (the default for `-length`) before the box. For a slanted last
segment, `atan2(dy, dx)` gives the angle.

---

## Callouts

`callout` draws a box with rounded corners, a triangular pointer to the
point `zielX zielY` and the text inside, wrapped to the width. Which side
the pointer sits on follows from the position of the target: if it lies
above the box, at the top; below, at the bottom; otherwise left or
right. The return value is the number of text lines.

| Option | Default | Meaning |
|---|---|---|
| `-fill` | – | fill color `{r g b}`; without it only the outline |
| `-stroke` | `1` | draw the outline |
| `-radius` | `4` | corner radius |
| `-tail` | `12` | width of the pointer at the box |
| `-pad` | `5` | inner padding |
| `-fontsize`, `-font` | `9`, Sans | font |
| `-alt` | – | alternate text; the whole becomes a `Figure` element |

If the text does not fit into the height, it is set smaller, in steps
of 1 point down to 5 points. Nothing is cut: the small callout on the
left holds the whole sentence, in three lines at 7 points instead of 9.
Whether that is still readable is for the caller to decide; the number
of lines in the result is a clue, the font size is not returned.

`callout` sets the fill color to black for the text and leaves it that
way.

Pointer and box are two shapes, each with its own outline. A line
therefore remains where the pointer joins the box; the callout is not
open there as in a comic strip. To avoid this, use `-stroke 0` and a
stronger fill color.

---

## Rounded Corners

```tcl
# Radius 6, mit Umriss, gefüllt
pdf4tcllib::drawing::roundedRect $pdf $x $y $b $h 6 1 1
```

Each corner is made of eight straight segments, not of curves. With
small radii this is invisible; with a radius of 30 points under strong
magnification it shows.

According to the documentation, the option `-clip 1` sets a clipping
path with rounded corners, for example for a photo with rounded
corners. But it clips to the **square-cornered** rectangle. pdf4tcllib
offers no way to get rounded corners around an image.

---

## Accessibility

In the accessible PDF, arrows, heads, boxes and pointers are decoration
(artifacts); a screen reader skips them. The text of a callout is
content and appears as a paragraph in the structure tree. A diagram as
a whole needs an alternate text; otherwise all that remains of it is a
sequence of words without arrows. More on this in Part 5.

---

## Summary

- `drawing::arrow` from edge to edge; the line ends before the head.
- Bent arrows: draw the lines yourself, the head with `arrowHead`, angle
  in radians.
- `drawing::callout` chooses the side of the pointer itself and shrinks
  text that is too long.
- `roundedRect -clip` clips with square corners.

---

*Next chapter: [Formulas](160-formeln.md)*
