# Layers

## Introduction

The reader switches optional content ([OCG]{.index}, optional content
groups) on and off in the viewer: debug grid, letterhead, watermark.
Layers apply to the whole document; `beginLayer` / `endLayer` enclose
the drawing on a page.

---

## Recipe

```tcl
set pdf [::pdf4tcl::new %AUTO% -paper a4 -orient 1]
set gitter [$pdf addLayer "Debuggitter" -visible 0]
set rumpf [$pdf addLayer "Rumpf" -visible 1]

$pdf startPage

$pdf beginLayer $gitter
$pdf setStrokeColor 0.85 0.85 0.85
for {set x 0} {$x <= 500} {incr x 50} {
    $pdf line $x 0 $x 700
}
$pdf endLayer

$pdf beginLayer $rumpf
$pdf setFont 12 Helvetica
$pdf text "Sichtbarer Rumpf" -x 50 -y 50
$pdf endLayer

$pdf endPage
$pdf write -file ebenen.pdf
$pdf destroy
```

`addLayer` returns an ID for `beginLayer` / `endLayer` and for
`-layer` on annotations and forms.

---

## Options (since 0.9.4.63)

```tcl
$pdf addLayer "Vordruck" -print 0
$pdf addLayer "Detail"   -zoom {2.0 {}}
$pdf addLayer "Kopf DE"  -group kopf
set liste [$pdf layers]
```

| Option | Effect |
|--------|---------|
| `-visible` | initial state (default 1) |
| `-print 0` | on screen, not on paper |
| `-export` | state when saving to a format without OCG |
| `-zoom {min max}` | on only at this magnification; empty = unlimited |
| `-locked` | the viewer must not toggle it |
| `-group name` | at most one layer of the group visible |

`-print 0` writes `/Usage << /Print << /PrintState /OFF >> >>`.
ISO 32000-1 8.11.4.4: usage dictionaries apply to **interactive**
conforming readers, not to final-form output. Printing from the viewer
honors it; a RIP does not, and that is conforming. Where it must not
go wrong, do not put the graphics into the file at all.

As soon as a layer carries `/Usage`, the default configuration gets an
`/AS` array — without it no viewer applies `/Usage`.

---

## Counting

`endLayer` without `beginLayer` is an error (formerly a stray `EMC`).
`endPage` rejects a page with an open layer (ISO 32000-1 14.6).

---

## Forms

Annotations lie outside the content stream.
`beginLayer` does not reach them. `-layer` on `addForm` writes
`/OC` into the annotation dictionary.

---

## Summary

- `addLayer`, then `beginLayer` / `endLayer` on the page.
- `-print 0` and `-zoom` via `/Usage`; `/AS` is created automatically.
- An open layer at the end of a page is an error.

---

*Next chapter: [Metadata](150-metadaten.md)*
