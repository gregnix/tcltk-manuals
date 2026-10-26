# PDF/A

## Introduction

[`-pdfa`]{.index} on the constructor sets the conformance level.
Without an embedded font the file fails in veraPDF — Base-14 is not
enough.

---

## Level B

```tcl
pdf4tcl::loadBaseTrueTypeFont BaseDejaVu /pfad/DejaVuSans.ttf
pdf4tcl::createFont BaseDejaVu Body iso8859-1

set pdf [::pdf4tcl::new %AUTO% -paper a4 -orient 1 -margin 50 \
        -pdfa 2b]
$pdf metadata -title "Archivprobe" -author "pdf4tcl"
$pdf startPage
$pdf setFont 12 Body
$pdf text "Diese Datei behauptet PDF/A-2b." -x 0 -y 24
$pdf endPage
$pdf write -file archiv-2b.pdf
$pdf destroy
```

Optional: `-pdfa-icc /pfad/srgb.icc`. Otherwise pdf4tcl searches for a
profile.

| Level | Typical use |
|-------|-------------------|
| `1b` / `1a` | older archive; no transparency; no embedded files |
| `2b` / `2a` | modern archive; XRef stream; PDF 1.7 |
| `3b` / `3a` | plus embedded files (Factur-X / ZUGFeRD) |

`1b` writes `%PDF-1.4` and a classic xref table. `2b`/`3b`:
XRef stream and `%PDF-1.7` (since 0.9.4.22).

---

## Level U (since 0.9.4.56)

Between B and A: appearance preservable **and** text extractable as
Unicode, without tagging.

```tcl
set pdf [::pdf4tcl::new %AUTO% -paper a4 -pdfa 3u]
```

No `1u`: the level came with part 2. CID fonts carry ToUnicode;
whatever passes B with an embedded font passes U. Use: an archive
without a structure tree, typically scan plus OCR.

---

## Level A (since 0.9.4.41)

A requires tagged PDF and a document language. Both are checked at
`finish`; if one is missing, no file with a false
`pdfaid:conformance A` is produced:

```tcl
set pdf [::pdf4tcl::new %AUTO% -paper a4 -pdfa 3a]
$pdf tagged 1 -lang de-DE -ua 1
$pdf metadata -title "Zugängliches Archiv"
$pdf viewerPreferences -displaydoctitle 1
$pdf startPage
$pdf setFont 12 Body
$pdf tagText H1 "Titel" -x 0 -y 24
$pdf tagBegin P
$pdf text "Getaggter Fließtext." -x 0 -y 50
$pdf tagEnd
```

A does not check whether the tagging makes sense — only that it is
there. Every paragraph a `/P` and every heading an `/H1` validates and
tells a reader nothing useful.

---

## Pitfalls

- Standard font under `-pdfa`: warning since 0.9.4.41, the file fails
  in veraPDF.
- `setAlpha` below 1 with PDF/A-1: warning since 0.9.4.22.
- Embedded files with PDF/A-1: error. Factur-X: `3b`/`3a`.
- Check marks: vector under conformance, see
  [Creating Forms](080-formulare-erzeugen.md).

```bash
verapdf -f 2b archiv-2b.pdf
verapdf -f 3a archiv-3a.pdf
verapdf -f ua1 archiv-3a.pdf
```

---

## Summary

- `-pdfa 1b|2b|3b|1a|2a|3a|2u|3u`, always with an embedded font.
- A: `tagged 1 -lang …` before `finish`.
- U: Unicode without a structure tree.

---

*Next chapter: [Layers](140-ebenen.md)*
