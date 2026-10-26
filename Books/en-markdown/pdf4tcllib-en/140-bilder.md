# Images

## Introduction

pdf4tcl places an image into a rectangle with `putImage`. If width and
height are given, the image is stretched to exactly that area; if the
aspect ratio does not match, it is distorted, and nothing points this
out. pdf4tcllib has two procedures that avoid this:
[image::place]{.index} fits an image into a frame without distorting
it, and [image::gallery]{.index} places many images with captions in a
grid across several pages.

Both work with images that pdf4tcl has loaded with `addImage` (PNG,
JPEG). Tk is not needed for this.

---

## Loading

```tcl
set id [$pdf addImage datei.png]
lassign [$pdf getImageSize $id] breite hoehe     ;# in Pixel
```

`addImage` returns an identifier. The image is then stored once in the
file, even if it appears on many pages.

A peculiarity of pdf4tcl: **a JPEG that is loaded before the first
`startPage` starts a page by itself.** A PNG does not. Calling
`startPage` afterwards leaves an empty first page. That is why the
example starts the page first and then loads the images.

---

## An Image in a Frame

```tcl
lassign [pdf4tcllib::image::place pdf id x y breite hoehe \
    ?option wert ...?] bx by bb bh
```

| Option | Default | Meaning |
|---|---|---|
| `-fit` | `contain` | `contain`, `cover` or `stretch` |
| `-anchor` | `center` | `nw n ne w center e sw s se` |
| `-dpi` | – | warn if the resolution is below this |
| `-alt` | – | alternate text; the image becomes a `Figure` element |
| `-clip` | `1` | with `cover`, cut off the overhang |

- **`contain`**: The whole image is visible; part of the frame stays
  empty.
- **`cover`**: The frame is filled completely; whatever sticks out is
  cut off.
- **`stretch`**: like `putImage` with width and height, i.e. distorted.

With `contain`, `-anchor` says where the image sits in the frame; with
`cover`, it says which part is kept. A portrait with the head at the top
wants `n`.

The return value is the area the image actually occupies: with
`contain` smaller than the frame, with `cover` the frame itself. The
next line continues below it.

With `cover`, the image is only hidden, not cropped: the whole image is
stored in the file. To use a small part of a large photo, crop it
beforehand.

---

## The Example

Page 1 places the same portrait image (400 × 600 pixels) into three
equal frames of 150 × 120 points, with an image that is too small below
them. Pages 2 and 3 are a gallery with five images, four per page.

```tcl
# 140-bilder.tcl -- Bilder einpassen und als Galerie setzen
package require pdf4tcl
package require pdf4tcllib

pdf4tcllib::fonts::init -cid 1
set ctx [pdf4tcllib::page::context a4 -margin 20]
set pdf [pdf4tcl::new %AUTO% -paper a4 -orient true]

# Bilder einmal laden; addImage gibt eine Kennung zurueck.
# Erst die Seite beginnen: ein JPEG vor startPage beginnt selbst eine.
$pdf startPage
set dir [file join [file dirname [info script]] bilder]
foreach name {hochformat.png querformat.jpg quadrat.png
              panorama.jpg klein.png} {
    set bild($name) [$pdf addImage [file join $dir $name]]
}
puts "hochformat.png: [$pdf getImageSize $bild(hochformat.png)] Pixel"

# Seite 1: dasselbe Hochformat in drei gleich grossen Rahmen
set x [dict get $ctx left]
set y [expr {[dict get $ctx top] + 20}]
$pdf setFont 9 [pdf4tcllib::fonts::fontSans]
foreach fit {contain cover stretch} {
    set r [pdf4tcllib::image::place $pdf $bild(hochformat.png) \
        $x $y 150 120 \
        -fit $fit -anchor n -alt "Beispielbild ($fit)"]
    puts [format "%-8s -> %s" $fit [lmap v $r {format %.0f $v}]]
    $pdf setStrokeColor 0.8 0 0
    $pdf rectangle $x $y 150 120              ;# der Rahmen
    $pdf setStrokeColor 0 0 0
    $pdf text "-fit $fit" -x $x -y [expr {$y + 134}]
    set x [expr {$x + 170}]
}

# Zu wenig Aufloesung: 80 x 60 Pixel auf 160 x 120 Punkt sind 36 dpi
pdf4tcllib::image::place $pdf $bild(klein.png) [dict get $ctx left] \
    [expr {$y + 160}] 160 120 -dpi 150
set w [lindex $::pdf4tcl::warnings end]
puts "Warnung: [string map {" (" "\n  ("} $w]"
$pdf endPage

# Seite 2 und 3: Galerie mit Unterschriften, 2 x 2 je Seite
proc kopf {} {
    global pdf ctx
    pdf4tcllib::page::header $pdf $ctx "Bildergalerie"
}
set liste [list \
    [list $bild(querformat.jpg) "Querformat 900 x 500"] \
    [list $bild(hochformat.png) "Hochformat 400 x 600"] \
    [list $bild(quadrat.png)    "Quadrat"] \
    [list $bild(panorama.jpg) \
        "Panorama 1200 x 300, eine sehr lange Unterschrift"] \
    [list $bild(querformat.jpg) "noch einmal quer"]]
$pdf startPage
kopf
set seiten [pdf4tcllib::image::gallery $pdf $liste \
    [dict get $ctx left] [expr {[dict get $ctx top] + 10}] \
    [dict get $ctx text_w] 500 \
    -cols 2 -rows 2 -gap 12 -anchor s -pagecmd kopf]
$pdf endPage
puts "Galerie: $seiten Seiten"

$pdf write -file 140-bilder.pdf
$pdf destroy
```

```text
hochformat.png: 400 600 Pixel
contain  -> 92 77 80 120
cover    -> 227 77 150 120
stretch  -> 397 77 150 120
Warnung: image::place: image11 at 36 dpi
  (80x60 pixels on 160.0x120.0 points), below 150
Galerie: 2 Seiten
```

With `contain`, the image is 80 points wide and sits in the middle of
the frame; 35 points stay free on the left and on the right. With
`cover`, it fills the frame; with `-anchor n` the upper part is kept,
and the label "hoch" ("portrait") at the bottom edge is lost. With
`stretch`, the circle is an ellipse.

### Resolution

80 × 60 pixels on 160 × 120 points are 36 dpi; printed, that looks
jagged. `-dpi 150` then writes a warning to `$::pdf4tcl::warnings`. It
does not go to the screen; to see it, print the list at the end.
pdf4tcl itself already warns below 150 dpi; with `-dpi` the caller's
own threshold applies, and the warning comes only once.

---

## Gallery

```tcl
set seiten [pdf4tcllib::image::gallery pdf bilder x y breite hoehe \
    ?option wert ...?]
```

Each entry in `bilder` is `{id "Unterschrift"}` or just `id`. The box
`x y breite hoehe` is divided into `-cols` × `-rows` cells; when a page
is full, `gallery` starts the next one and continues at the same
position there. The return value is the number of pages.

| Option | Default | Meaning |
|---|---|---|
| `-cols`, `-rows` | `2`, `3` | grid per page |
| `-gap` | `8` | spacing between the cells |
| `-caption` | `unten` | `unten` or `keine` |
| `-captionH` | `14` | height of the band for the caption |
| `-fontsize`, `-font` | `8`, Sans | font of the caption |
| `-fit`, `-anchor`, `-dpi` | as for `place` | per image |
| `-pagecmd` | – | runs after each new `startPage` |

`-caption` expects the German words (`unten` "below", `keine` "none").
Any other value, `below` included, silently switches the captions off.

The caption sits at the bottom edge of the cell, the image with
`-anchor center` in the middle above it. For a landscape image in a
tall cell, this leaves a gap in between. With `-anchor s`, each image
sits directly on its caption, as in the example.

A caption wider than the cell is set smaller (down to 5 points), not
shortened. The panorama caption in the example shows this.

`-pagecmd` runs in the caller's scope. The caller does the first
`startPage` and its header line, and the last `endPage` as well.

If the box is too small for the grid, `gallery` aborts with
`the frame is too small for 2x3 cells` (numbers depending on the grid).
Up to pdf4tcllib 0.6.6, a bug in the message produced
`invalid command name "2"` instead.

---

## Images from Tk

For an image that exists as a Tk `photo` (from a canvas, from a camera),
there are `image::insert` and `image::insertAt`. They need Tk, scale to
a width and start a new page if needed, but take twelve arguments. If
the image also exists as a file, `addImage` with `place` is simpler.

---

## Summary

- Load images with `addImage`, only after the first `startPage`.
- `image::place` with `-fit contain` or `cover`, never distorted;
  `-anchor` chooses the position or the visible part.
- `-dpi` warns of too low a resolution, in `$::pdf4tcl::warnings`.
- `image::gallery` for grids across several pages; `-anchor s` places
  the images on their captions.

---

*Next chapter: [Arrows and Callouts](150-pfeile-und-callouts.md)*
