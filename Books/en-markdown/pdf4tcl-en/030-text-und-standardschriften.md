# Text and Standard Fonts

## Introduction

Fourteen [standard fonts]{.index} (Base-14) never need to be
embedded: Helvetica, Times, Courier, each in four styles, plus
Symbol and ZapfDingbats. The character repertoire is WinAnsi / CP1252.
Everything outside it becomes `?`.

---

## Setting a Font and Writing

```tcl
$pdf setFont 18 Helvetica-Bold
$pdf text "Titel" -x 0 -y 24
$pdf setFont 12 Times-Roman
$pdf text "Fließtext mit Umlauten: äöü ÄÖÜ ß" -x 0 -y 50
$pdf setFont 10 Courier
$pdf text "mono 0123456789" -x 0 -y 70
```

Name the styles exactly: Helvetica **-Oblique**, Times **-Italic**.
`Helvetica-Italic` does not exist.

`text` deliberately leaves the [text object]{.index} (`BT` … `ET`) open,
so that several calls share one block. Other drawing methods
close it. Details: [gsave and Text](160-gsave-und-text.md).

---

## ToUnicode

Since 0.9.4.9 standard fonts carry a ToUnicode CMap for
WinAnsi. Copying and `pdftotext` return Latin umlauts
correctly. Greek and Cyrillic remain `?` — for those see
[CID and Unicode](040-cid-und-unicode.md).

`getSubstCount` counts substitutions — **under Tcl 9**. Under 8.6
`encoding convertto` substitutes silently and the counter stays 0. The
page looks the same in both generations.

---

## Width and Box

```tcl
set w [$pdf getStringWidth "Rechnung 2026"]
set w [$pdf getStringWidth "Probe" -font Helvetica -size 12]
```

Without a preceding `setFont`, use the variant with `-font` / `-size`
(since 0.9.4.23).

```tcl
$pdf drawTextBox 0 80 400 120 $absatz -align left -newyvar nextY
$pdf line 0 $nextY 400 $nextY
```

`-newyvar` returns Y in the caller's coordinates. Before 0.9.4.44,
with `-orient 1` it returned an internal page coordinate; code that
computed `pageHeight - $nextY` back then must remove that correction.

Soft hyphen `U+00AD`: since 0.9.4.61 a break suggestion, not a glyph.
`text`, `drawTextBox` and `getStringWidth` treat it the same way.
`Sil\u00ADben` is as wide as `Silben`.

---

## PDF/A and Standard Fonts

Base-14 has no embeddable font program. PDF/A and PDF/UA
require one. Since 0.9.4.41 this is reported in
`::pdf4tcl::warnings`; the file is still created and fails
veraPDF. For archiving: load TrueType, see the next chapter.

---

## Summary

- Base-14 without embedding, Latin-1 only.
- Styles: `-Oblique` for Helvetica, `-Italic` for Times.
- `drawTextBox -newyvar` in caller coordinates (0.9.4.44).
- Soft hyphen invisible and without width since 0.9.4.61.

---

*Next chapter: [CID and Unicode](040-cid-und-unicode.md)*
