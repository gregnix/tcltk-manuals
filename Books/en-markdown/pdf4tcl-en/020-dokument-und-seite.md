# Document and Page

## Introduction

A [document]{.index} is created in the constructor. Each page starts with
`startPage` and ends with `endPage`. Options on the constructor act
as defaults; `startPage` may override paper, margin and orientation.

---

## Constructor

```tcl
set pdf [::pdf4tcl::new %AUTO% \
        -paper a4 \
        -orient 1 \
        -margin 50 \
        -compress 1]
```

Common options:

| Option | Default | Meaning |
|--------|---------|-----------|
| `-paper` | `a4` | format name or `{breite höhe}` (width height) |
| `-orient` | `1` | Y from the top |
| `-landscape` | `0` | swap width and height |
| `-margin` | `0` | one, two or four values |
| `-unit` | `p` | `p`, `mm`, `cm`, `i` |
| `-compress` | `1` | compress content streams |
| `-cmyk` | `0` | DeviceCMYK instead of RGB |
| `-pdfa` | `""` | conformance level, see [PDF/A](130-pdfa.md) |
| `-userpassword` | `""` | see [Encryption](110-verschluesselung.md) |

Paper sizes: the A series, since 0.9.4.25 also the B and C series as
well as 4A0 and 2A0. The A3 height is **1191.0** pt (previously 1190.0).
Tests that hard-code the old number should use `getPaperSize`.

```tcl
lassign [pdf4tcl::getPaperSize a3] w h
lassign [$pdf getPageSize] pw ph
```

`getPageSize` returns the current page in the document unit.

---

## Page

```tcl
$pdf startPage
# zeichnen
$pdf endPage
$pdf startPage -paper a5 -margin 20
# zweite Seite kleiner
$pdf endPage
```

`startPage` on an open page calls `endPage` itself. An
[optional content group]{.index} (layer) that is still open
(`beginLayer` without `endLayer`) makes `endPage` fail.

---

## Writing

```tcl
$pdf write -file bericht.pdf
$pdf write -chan $ch
$pdf write
```

`-file` opens and closes the file. `-chan` writes to an
open channel (since 0.9.4.25). Without an option the output goes to
stdout. Then `destroy`.

`finish` closes the document; `write` calls it internally. Do not
continue drawing after `finish`.

---

## Margin and Origin

`-margin 50` sets all four sides. Two values: left/right,
top/bottom. Four values: left, right, top, bottom — in the
document unit.

With `-orient 1`, `-x 0 -y 0` is the top left corner of the type area,
not of the paper. Without a margin the two coincide.

---

## Summary

- The constructor sets defaults; `startPage` may deviate.
- `-orient 1`: Y at the top. Default unit is the point.
- `write -file` or `write -chan`, then `destroy`.

---

*Next chapter: [Text and Standard Fonts](030-text-und-standardschriften.md)*
