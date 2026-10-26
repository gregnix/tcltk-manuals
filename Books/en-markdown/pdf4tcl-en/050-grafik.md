# Graphics

## Introduction

Lines, areas, color, transparency and gradients are handled by
methods on the document. Since 0.9.4.39 color shares one pipeline:
fill, stroke, gradient, form, annotation.

---

## Color

```tcl
$pdf setFillColor 1 0 0
$pdf setFillColor #cc3300
$pdf setFillColor red
$pdf setFillColor 0 0.5 1 0
$pdf setStrokeColor navy
$pdf setBgColor 1 1 0
```

Components **0.0 .. 1.0**. `255 0 0` has been an error since 0.9.4.39
(before that the file contained the illegal operand and viewers
clamped silently). 147 X11/CSS names without Tk. Names outside the
table are looked up with `winfo rgb` when Tk is present.

`setBgColor` applies only to `text -bg`, not to the page. Page
background: draw a full-page rectangle first.

---

## Shapes

```tcl
$pdf setStrokeColor 0 0 0
$pdf setLineWidth 1
$pdf line 0 36 250 36

$pdf setFillColor 0.9 0.9 0.9
$pdf rectangle 0 50 250 60 -filled 1
```

Further methods: `circle`, `oval`, `polygon`, `arc`, `roundedRect`,
`arrow`. After colored text, set the fill color back to black,
otherwise the next box inherits red.

---

## Transparency and Gradients

```tcl
$pdf setAlpha 0.5
$pdf rectangle 40 40 120 80 -filled 1
$pdf setAlpha 1
```

Under `-pdfa 1b` / `1a`, alpha below 1 violates PDF/A-1. Since 0.9.4.22
a warning appears in `::pdf4tcl::warnings`; the file is still created.

```tcl
$pdf gsave
$pdf clip 50 100 400 60
$pdf linearGradient 50 130 450 130 red blue
$pdf grestore
$pdf rectangle 50 100 400 60
```

Radial: inner center/radius, outer center/radius, two colors.
`-extend {0 0}` stops at the ends. With `-cmyk 1` the shading writes
`/DeviceCMYK`.

```tcl
$pdf setBlendMode Multiply
# überlappende Füllungen
$pdf setBlendMode Normal
```

---

## Transformation

```tcl
$pdf gsave
$pdf translate 200 300
$pdf rotate 45
$pdf line 0 0 80 0
$pdf grestore
```

`rotate`, `scale`, `translate` (since 0.9.4.20) set `cm` and record
`rawcoords`. Always pair them with `gsave` / `grestore`.

**Text does not follow `cm`.** `text` sets `Tm` absolutely. Rotated text:
still use `translate` / `rotate`, then `text` at `-x 0 -y 0` — and
read [gsave and Text](160-gsave-und-text.md) first: `gsave` closes
an open `BT`.

---

## Summary

- Color 0..1, names without Tk, range check since 0.9.4.39.
- Clip the gradient area, then `linearGradient` / `radialGradient`.
- Transformations always between `gsave` and `grestore`.

---

*Next chapter: [Images](060-bilder.md)*
