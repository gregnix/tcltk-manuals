# Annotations

## Introduction

Notes, stamps, markup and lines lie **next to** the content stream. A
name is not a drawing. Whether a viewer shows anything depends on the
type and on the appearance stream.

---

## Common Calls

```tcl
$pdf addAnnotNote 100 100 20 20 -content "Prüfen" -author "Lektor" \
        -icon Comment -color {0.6 0.8 1.0}
$pdf addAnnotFreeText 50 200 200 40 "Immer sichtbar" \
        -color {0 0 0} -bgcolor {1 1 0.8}
$pdf addAnnotStamp 300 500 80 30 -name Approved -color {1 0 0}
$pdf addAnnotHighlight 50 300 200 14 -color {1 1 0}
$pdf addAnnotUnderline 50 320 200 14
$pdf addAnnotStrikeOut 50 340 200 14 -color {1 0 0}
$pdf addAnnotLine 50 400 200 400 -color {0 0 0}
```

---

## What Draws Itself

| Kind | Drawn from |
|-----|----------------|
| Highlight, Underline, StrikeOut | area and color |
| FreeText | text and colors |
| Note | the viewer's icon set |
| **Stamp** | appearance stream only |
| **Line** | appearance stream only |

A stamp names which stamp was meant. Acrobat has artwork for the named
stamps. **PDFium has none**, and PDFium is the viewer in Chrome and
Edge. The same holds for the line: end points say where, not how.

Since **0.9.4.64** `addAnnotStamp` and `addAnnotLine` write an
appearance stream. Checked on `demo/demo-annotations.pdf`: none of six
stamps and five lines was visible in PDFium; all eleven are now. The
file gets slightly larger.

---

## A Stamp Needs a Font

The appearance of a stamp names a font. Therefore the stream is
written **only after `setFont`**. Without a font set, the annotation
is created as before 0.9.4.64 — the call does not fail, PDFium shows
nothing.

Order:

```tcl
$pdf setFont 10 Helvetica
$pdf addAnnotStamp 300 500 80 30 -name Approved -color {1 0 0}
```

---

## Arrowheads

Drawn for `OpenArrow`, `ClosedArrow`, `ROpenArrow`,
`RClosedArrow`, `Circle`, `Square`. Every other line ending stays a
plain line. A line without a head is half an answer, a wrongly drawn
head a wrong one.

---

## Links

A link is an annotation of type `/Link`: a rectangle that triggers
something when clicked. A border is drawn only on request.

[hyperlinkAdd]{.index} opens an address (`/S /URI`):

```tcl
$pdf hyperlinkAdd 50 100 200 20 "https://www.tcl-lang.org"
```

Jumps **within the document** exist since **0.9.4.72**. Two methods
belong together. [destinationAdd]{.index} creates a named destination
on the current page; [linkAdd]{.index} places a rectangle that jumps
to that name:

```tcl
$pdf startPage
$pdf text "1 Einleitung ........ 3" -x 50 -y 100
$pdf linkAdd 50 88 200 14 kap1          ;# Ziel gibt es noch nicht
$pdf endPage
...
$pdf startPage
$pdf text "1 Einleitung" -x 50 -y 60
$pdf destinationAdd kap1 -y 45          ;# Ziel, etwas über der Zeile
```

The link carries only the name (`/Dest /kap1`). It is resolved only
when the file is written, through the `/Dests` dictionary in the
catalog. Therefore the destination may be created **after** the link —
exactly what a table of contents placed before its chapters needs.

- Name: letters, digits, `.` `_` `-`; once per document.
- `-y` (and `-x`) in the current unit; without `-y`, the top edge of
  the page.
- Border and highlighting as with `hyperlinkAdd`: `-borderwidth`
  `-bordercolor` `-borderradius` `-borderdash` `-highlight`.
- A link to a name that no `destinationAdd` creates does not abort
  anything. The file is written, the link has no effect, and stderr
  reports the name.
- Allowed under `-pdfa 2b`.

Checked with `tests/linkdest.test` (12 cases) and on docir books: the
table of contents of the macOS book, 238 entries, each jumping to the
printed page and there to the heading.

---

## Tagged

Annotations belong to the structure tree only inside an open
`tagBegin Link` or `tagBegin Annot` … `tagEnd`. Otherwise they are
clickable but invisible to assistive technology. Since 0.9.4.39 this
appears once per document in `::pdf4tcl::warnings`. For PDF/UA, wrap
the annotation.

---

## Summary

- Stamp and line need an appearance (0.9.4.64), otherwise PDFium shows nothing.
- `setFont` before `addAnnotStamp`.
- Highlight draws itself from area and color.
- `hyperlinkAdd` for addresses, `destinationAdd` + `linkAdd` for jumps
  within the document (0.9.4.72); the destination may come after the link.

---

*Next chapter: [Encryption](110-verschluesselung.md)*
