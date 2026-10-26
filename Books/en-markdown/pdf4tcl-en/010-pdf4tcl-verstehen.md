# Understanding pdf4tcl

## Introduction

[pdf4tcl]{.index} writes PDF from Tcl. One class, methods on the
document object, output through `write`. This chapter establishes what
the package is good for and where other layers take over.

The book describes **0.9.4.69**: tagged text stays inside `BT`/`ET`.
On top of that come the links within the document from **0.9.4.72**
(chapter [Annotations](100-annotationen.md)).
CID subset with identity CMap and table checksums since 0.9.4.68,
encrypted CID fonts through `WriteObjectDirect` since 0.9.4.67,
appearance streams for stamps and `fillForms`.

---

## First Document

```tcl
package require pdf4tcl 0.9.4.69

set pdf [::pdf4tcl::new %AUTO% -paper a4 -orient true -compress 1]
$pdf startPage
$pdf setFont 12 Helvetica
$pdf text "Hallo Welt" -x 50 -y 50
$pdf endPage
$pdf write -file ausgabe.pdf
$pdf destroy
```

`%AUTO%` assigns the object name. `-orient true` (default) puts Y
at the top, as in Tk. `-compress 1` (default) compresses content
streams.

Without `startPage`, the first drawing operation starts the page itself.
Still set `startPage` / `endPage` explicitly: margin, paper and
open layers then stay easy to follow.

---

## What pdf4tcl Is — and What It Is Not

Suitable:

- Pages with text, vectors, images
- Unicode through a [CID font]{.index}
- Creating AcroForms and filling them later
- Canvas export, AES encryption, PDF/A, layers
- Appending several PDFs to one another (`catPdf`)

Not suitable as the only layer:

- Tables with page breaks, running text across columns, label sheets
- `pdf4tcllib` provides that on top of the same drawing API

pdf4tcl draws. Layout remains the job of the caller or of the
companion library.

---

## Coordinates and Units

The default unit is the point (`-unit p`). Millimeters: `-unit mm`.
With `-orient 1` the origin lies at the top left of the type area
(after `-margin`). Internally PDF counts Y from the bottom; the class
converts.

Colors range over **0.0 .. 1.0**, not 0..255. Since 0.9.4.39 a value
outside that range raises an error instead of being written silently.

---

## Warnings

Some defects do not interrupt: a standard font under `-pdfa`,
alpha under PDF/A-1. Check the list after `write`:

```tcl
if {[llength $::pdf4tcl::warnings]} {
    puts $::pdf4tcl::warnings
}
```

---

## Related Sources

- Manpage `pdf4tcl.md` — every method
- `pdf4tcl/doc/en/howtos/` — one task per file, with a script
- `pdf4tcl/UPGRADING.md` — what changes for existing code
- `pdf4tcl/demo/` — one feature per program

This book presents the material as a textbook. The howtos remain the
runnable test.

---

## Summary

- `pdf4tcl::new`, page, draw, `write`, `destroy`.
- Version **0.9.4.69** for tagged text in `BT`/`ET`, CID cmap,
  AES with embedded font and appearance streams.
- Layout helpers live outside this package.

---

*Next chapter: [Document and Page](020-dokument-und-seite.md)*
