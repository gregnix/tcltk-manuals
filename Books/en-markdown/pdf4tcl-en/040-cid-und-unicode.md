# CID and Unicode

## Introduction

`createFont` with WinAnsi covers Latin-1. Polish, Greek,
Cyrillic, mathematics or CJK need a [CID font]{.index}:
load TrueType, create a CID specification, select it with `setFont`.

---

## Recipe

```tcl
pdf4tcl::loadBaseTrueTypeFont BaseDejaVu \
        /usr/share/fonts/truetype/dejavu/DejaVuSans.ttf
pdf4tcl::createFontSpecCID BaseDejaVu Uni

set pdf [::pdf4tcl::new %AUTO% -paper a4 -orient 1 -margin 50]
$pdf startPage
$pdf setFont 12 Uni
$pdf text "Grüße aus München, Polska, Ellada" -x 0 -y 24
$pdf endPage
$pdf write -file unicode.pdf
$pdf destroy
```

Three steps: load the base, bind the CID name, use that name in
`setFont`. Without a loaded base:

```
createFontSpecCID: base font '…' not loaded (use loadBaseTrueTypeFont first)
```

The loader rejects color bitmap emoji (CBDT/CBLC) and COLR.
Outline fonts only.

---

## Two Paths, Two Ceilings

| Path | Call | Ceiling |
|-----|--------|-------|
| encoded subset | `createFont` / `createFontSpecEnc` | at most 256 code points |
| CID | `createFontSpecCID` | the repertoire actually used, Identity-H |

Since 0.9.4.57 **both paths subset**. Before that, CID put the
whole file into the PDF. File size for one line of Greek in DejaVu Sans:

| Variant | File |
|----------|-------|
| subset, 5 code points | 8 860 bytes |
| subset, 200 code points | 29 761 bytes |
| CID after subsetting | 50 004 bytes |
| CID before 0.9.4.57 (whole face) | 386 728 bytes |

CFF/OpenType stays complete; pdf4tcl subsets TrueType.
In that case a warning appears in `::pdf4tcl::warnings`.

With an encoded subset, include `?` (63) in the list. Characters
outside it otherwise fall back to slot 0 — the first code point given.
A subset that starts with `G` turns Greek into `GGGGGG`.

---

## Checking Substitutions

```tcl
$pdf text $zeile -x 0 -y 40
puts [$pdf getSubstCount]
```

`0` means: every character had a glyph. Question marks on the page
without an error: the face lacks the code point, or Base-14 was in use.

---

## Tcl 8.6 and Characters Above U+FFFF

As a literal in the source:

| | `string length` | first character |
|--|-----------------|----------------|
| Tcl 9 | 1 | U+1F600 |
| Tcl 8.6 | 1 | U+FFFD |

Read from a UTF-8 file, both generations get it right. No
`\U` escapes above U+FFFF in code that must run under 8.6.
Measure width with `getStringWidth`, not with `string length`.

---

## Encryption

Since **0.9.4.67**, embedded CID fonts in an AES document take
the same write path as other objects
(`WriteObjectDirect`). Regenerate files from 0.9.4.66.
See [Encryption](110-verschluesselung.md).

Since **0.9.4.68** the subset file itself carries a valid cmap
and table checksums. In depth:
[CID Subset and CMap](170-cid-subset-cmap.md).

---

## Summary

- `loadBaseTrueTypeFont`, then `createFontSpecCID`, then `setFont`.
- CID subsets TrueType since 0.9.4.57; CFF stays whole.
- Encoded subset: 256 code points, `?` in the list.
- `getSubstCount` after drawing.

---

*Next chapter: [Graphics](050-grafik.md)*
