# gsave and Text

## Introduction

`text` leaves the [text object]{.index} open so that several calls
share one `BT`. `q` (`gsave`) and `Q` (`grestore`) are graphics
operators. ISO 32000-1 section 8.2 allows only text operators between
`BT` and `ET`.

---

## The Trap Up to 0.9.4.61

`gsave` and `grestore` wrote `q` / `Q` straight into the open text
object:

```
BT … q … ET Q
```

Poppler, MuPDF and pdftotext rendered the invalid stream anyway.
**Adobe Reader showed a blank page without any message.**
`pdfinfo` reported a healthy file.

Found through `pdf4tcllib::labels::render` with `-clip 1`.
`tests/nesting.test` checks the class of error, not a string.

---

## Since 0.9.4.62

Both methods call `EndTextObj` **before** `q` / `Q`. Nothing changes
at the call. Anyone comparing generated files byte by byte sees `q`
and `Q` outside `BT`/`ET`, and an `ET` may appear where there was
none.

```tcl
$pdf setFont 12 Helvetica
$pdf text "Zeile eins" -x 50 -y 50
$pdf gsave
$pdf clip 40 40 200 80
$pdf rectangle 40 40 200 80 -filled 1
$pdf grestore
$pdf text "Zeile zwei" -x 50 -y 80
```

After `gsave` the next `text` starts a new text object. That is
correct, not a regression.

---

## Other Methods

`clip`, `rectangle` and the line path close the text object
themselves or through `DrawLine`. Only `gsave` / `grestore` did not —
until 0.9.4.62.

Transformations (`translate`, `rotate`, `scale`) belong between
`gsave` and `grestore`. Text set with `Tm` does not follow `cm`; see
[Graphics](050-grafik.md). Still, save the graphics state first;
otherwise the matrix stays skewed for everything that follows.

---

## Rule

After `text` and before any graphics operation that writes `q`, `cm`,
`W` or path operators: either use a drawing method that calls
`EndTextObj` itself, or call `gsave` explicitly. Since 0.9.4.62
`gsave` is enough.

Keep Adobe as a test reader. A page that is full in Poppler and blank
in Acrobat is often exactly this stream.

---

## Tagged Text Since 0.9.4.69

`TagEnsureMC` writes `BDC`/`EMC` outside `BT`/`ET` and may close an
open text object to do so. If the call came between `Tm` and `Tj`,
`Tj` ended up outside:

```
BT / Tm / ET / << /MCID n >> BDC / (…) Tj / EMC
```

ISO 32000-1 9.4: text output belongs between `BT` and `ET`. Adobe
does not draw it outside; Poppler, MuPDF and Chrome do.
Since 0.9.4.69 the marking comes **before** `BeginTextObj`. If
`TagEnsureMC` closes an open text object, `Tm` is written again
(`posSet`).

---

## Summary

- `text` keeps `BT` open.
- `gsave` / `grestore` close `BT` before `q` / `Q` (0.9.4.62).
- Tagged: marking before `BT`, otherwise `Tj` ends up outside (0.9.4.69).
- Adobe: blank page without a message when `q` lands inside `BT` or
  `Tj` outside `BT`/`ET`.

---

*Next chapter: [CID Subset and CMap](170-cid-subset-cmap.md)*
