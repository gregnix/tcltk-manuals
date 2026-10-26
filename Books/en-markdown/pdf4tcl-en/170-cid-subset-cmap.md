# CID Subset and CMap

## Introduction

Since 0.9.4.57 pdf4tcl writes only the glyphs used for CID
(TrueType). The subset must be a valid TrueType file: required tables,
cmap, checksums. Up to **0.9.4.67** the cmap and real table checksums
were missing. **0.9.4.68** adds both.

Callers change nothing. `createFontSpecCID` and `setFont` stay the
same. This chapter explains why Adobe showed a blank page and why
`letzteGlyphe` (last glyph) is `numGlyphs-1`, not `0xFFFE`.

---

## cmap Is Required

cmap is listed among the required tables (Apple TrueType, OpenType).
Up to 0.9.4.67 `CIDRebuildTtf` removed it: Identity-H addresses glyphs
directly. That holds for the PDF page — and that is why nobody noticed:

- Viewers with `/CIDToGIDMap /Identity` drew the glyphs
- `pdftotext` extracted the right text
- `qpdf` found no syntax error
- **Adobe Reader showed a blank page**

The subset simply was not a valid font. Whether Reader really draws
from this table has not been checked. The PDF standard says that for
an embedded CIDFontType2 the CIDToGIDMap applies. The likely cause:
Reader validates the font program. The fix rests on the cmap being
required, not on the assumption.

---

## Identity, Not Unicode

A viewer loop through the cmap would read the glyph ID as a character
code. Glyph `0x5A` is not U+005A. Both paths must find the same glyph.
That is why [`CIDIdentityCmap`]{.index} writes an identity mapping,
not the original Unicode cmap.

Two segments, format 4:

- `0 .. letzteGlyphe` maps onto itself
- `0xFFFF` is the mandatory sentinel and points to glyph 0

---

## letzteGlyphe Is numGlyphs-1

A cmap entry must not point to a glyph that does not exist. An earlier
draft ran the first segment up to `0xFFFE`. With DejaVuSans, 59282
codes then pointed into nothing; fontTools rejected the font.
`cidfont-11.2` covers both ends.

`CIDIdentityCmap` clamps: below 0 becomes 0, above `0xFFFE` becomes
`0xFFFE`. The call from `CIDRebuildTtf`:

```
CIDIdentityCmap [expr {$numGlyphs - 1}]
```

`numGlyphs` is in `maxp` at offset 4.

---

## Checksums (0.9.4.68)

Two places:

**checkSumAdjustment** in `head` is set to 0 before the table checksum
is computed. The original value belongs to the **original font** and
is wrong for a subset. The standard computes the table checksum of
`head` with this field set to 0. The final value comes at the very
end, once the file is complete.

**Checksum per table.** Up to 0.9.4.67 this was 0. The generated file
was not a valid TrueType file — so clearly that
`loadBaseTrueTypeFont` rejected it with `invalid TTF file checksum`.
`MakeTTFSubset` (the other subsetter) has always done this correctly;
only the CID path did not.

Layout tables (GPOS, GSUB, GDEF, kern, MATH, FFTM, DSIG) are left out:
they are not required, and pdf4tcl already has their content in `BFA`
from loading.

---

## CFF

OpenType/CFF is not subset. There is a warning, and the whole face
goes into the PDF. The same cmap fix does not apply there.

---

## Summary

- Up to 0.9.4.67: no cmap in the CID subset; Adobe blank, other viewers full.
- 0.9.4.68: `CIDIdentityCmap` with `numGlyphs-1`, not `FFFE`.
- Table checksums and `checkSumAdjustment` 0, then the final value.
- API unchanged.

---

*Next chapter: [Case Study: Report](180-fallstudie-bericht.md)*
