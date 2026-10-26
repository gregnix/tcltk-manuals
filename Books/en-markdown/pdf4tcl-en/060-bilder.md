# Images

## Introduction

A raster image gets onto the page in two steps: `addImage` takes the
file into the document, `putImage` places it. The same ID may appear
several times.

---

## PNG, JPEG, TIFF

```tcl
set id [$pdf addImage /pfad/foto.png]
$pdf addImage $pfad -id logo
$pdf putImage $id 50 100 -width 200
```

Without `-height` the height follows the aspect ratio. `-id` assigns
a fixed name instead of a number.

JPEG and many PNG/TIFF variants work. Since **0.9.4.28**
Adam7-interlaced PNG is de-interlaced on embedding. The loader rejects
interlaced PNG below 8 bits with a clear message.

Unsupported format: load it through Tk/Img, then use `addRawImage` /
`putRawImage`.

---

## Reuse

```tcl
set logo [$pdf addImage logo.png -id logo]
$pdf putImage logo 20 20 -width 80
$pdf startPage
$pdf putImage logo 20 20 -width 80
```

The bytes are stored once in the PDF. Each placement is a `Do` on
the same XObject.

---

## Tagged and PDF/UA

Figures need a structure element with `-alt`:

```tcl
$pdf tagBegin Figure -alt "Firmenlogo"
$pdf putImage $id 50 100 -width 120
$pdf tagEnd
```

A form XObject with tagged content may be drawn only **once**
(0.9.4.46). Under PDF/UA, veraPDF rule 7.20-2 forbids every
further placement; pdf4tcl then warns but does not abort.
Reuse remains good PDF — the conformance claim rules it out.

---

## Summary

- `addImage`, then `putImage` with width or height.
- Interlaced PNG since 0.9.4.28; sub-8-bit interlaced remains an error.
- PDF/UA: `Figure` with `-alt`; do not place an XObject more than once
  when UA is claimed.

---

*Next chapter: [Canvas Export](070-canvas-export.md)*
