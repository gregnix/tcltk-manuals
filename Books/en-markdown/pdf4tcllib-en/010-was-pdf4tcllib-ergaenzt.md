# What pdf4tcllib Adds

## Introduction

[pdf4tcl]{.index} draws: text at a position, a line from here
to there, an image into a rectangle. Anyone who builds a report with it
soon writes the same helper procedures as everyone else: computing page
margins, wrapping text, carrying a table across the page boundary,
setting header and footer, catching special characters.

[pdf4tcllib]{.index} is this layer as a library. It does not draw
itself; it calls the same methods of the pdf4tcl object that
your own code uses. The two can therefore be mixed: a
table from pdf4tcllib, below it a line drawn directly with pdf4tcl.

This book is a workshop book. Each chapter solves a task that
comes up again and again in reports, forms and lists, with an
example that runs exactly as printed. How pdf4tcl itself
works (coordinates, fonts, forms, encryption) is explained in
the book *pdf4tcl*; here it appears only where the task needs it.

---

## What the Examples Use

| Part | Version |
|---|---|
| pdf4tcllib | 0.6.7 |
| pdf4tcl | 0.9.4.73 (pdf4tcllib requires at least 0.9.4.23) |
| Tcl | 8.6 and 9.0 |
| Font | DejaVu Sans Condensed (TrueType) |

All examples are available as scripts in the folder `beispiele/` next to
the book, with the chapter number in the name. The output shown in the
text comes from these scripts.

---

## The Modules

pdf4tcllib is a single file, `pdf4tcllib-0.6.7.tm`, with several
namespaces. Next to it are packages that build on it and are loaded
individually.

| Namespace | Task | Chapter |
|---|---|---|
| `fonts` | find and load a TrueType font, return font names | [Fonts](020-einrichten-und-schriften.md) |
| `unicode` | replace characters the font does not have | [Unicode](030-unicode-sicher-ausgeben.md) |
| `units`, `page` | units, type area, header and footer | [Page context](040-einheiten-und-seitenkontext.md) |
| `text` | wrapping, measuring width, truncating, superscript and subscript | [Setting text](050-text-setzen.md) |
| `table` | tables with page breaks, groups, crosstabs | [Tables](080-tabellen.md) |
| `drawing`, `image` | shapes, gradients, arrows, images | [Images](140-bilder.md), [Arrows](150-pfeile-und-callouts.md) |
| `form` | labeled form fields in rows | [Form layout](120-formular-layout.md) |
| `math` | formulas in text | [Formulas](160-formeln.md) |
| `tag`, `state`, `measure`, `layout` | accessibility, graphics state, measuring height in advance, stacking blocks | [Accessible](180-barrierefreie-pdfs.md), [State](190-grafikzustand.md), [Stacking](200-messen-und-stapeln.md) |

| Package | Task | Chapter |
|---|---|---|
| `pdf4tcltoc` | table of contents with real page numbers | [Table of contents](110-inhaltsverzeichnis.md) |
| `pdf4tclchart` | bar, line and pie charts | [Charts](100-diagramme.md) |
| `pdf4tclflow` | text across columns and pages | [Column flow](070-spaltenfluss-wasserzeichen.md) |
| `pdf4tcllabels` | label sheets | [Label sheets](130-etikettenboegen.md) |
| `pdf4tcltreeview` | a `ttk::treeview` as a table or outline | [Treeview](170-treeview.md) |
| `pdf4tclforms` | fillable forms from a description | only [Appendix B](810-anhang-api.md) |
| `pdf4tcltable` | a `tablelist` widget as PDF | only [Appendix B](810-anhang-api.md) |
| `pdf4tcltext` | a Tk `text` widget as PDF | only [Appendix B](810-anhang-api.md) |
| `pdf4tclcanvas` | a Tk `canvas` drawing as PDF | only [Appendix B](810-anhang-api.md) |

The last four have no chapter of their own in the book; their calls are
in Appendix B, their messages in Appendix D.

---

## A First Report

The smallest useful example: header, heading, a
wrapped paragraph, footer with page number.

```tcl
# 010-erstes-dokument.tcl -- ein Bericht in wenigen Zeilen
package require pdf4tcl
package require pdf4tcllib

pdf4tcllib::fonts::init
set ctx [pdf4tcllib::page::context a4 -margin 20]

set pdf [pdf4tcl::new %AUTO% -paper a4 -orient true]
$pdf startPage
pdf4tcllib::page::header $pdf $ctx "Monatsbericht"

set x [dict get $ctx left]
set y [expr {[dict get $ctx top] + 20}]
set w [dict get $ctx text_w]

$pdf setFont 16 [pdf4tcllib::fonts::fontSansBold]
pdf4tcllib::unicode::safeText $pdf "Umsatz im Oktober" -x $x -y $y
set y [expr {$y + 28}]

set absatz "Der Umsatz stieg gegenüber dem Vormonat um 4 %. Am\
    stärksten wuchs der Bereich Wartung, der jetzt ein Drittel des\
    Umsatzes ausmacht. Die Zahlen sind vorläufig; die Schlussrechnung\
    folgt mit dem Quartal."
set y [pdf4tcllib::text::writeParagraph $pdf $absatz $x $y $w 11]
puts "nächste Zeile bei y = $y"

pdf4tcllib::page::footer $pdf $ctx "Vertraulich" 1
$pdf endPage
$pdf write -file 010-erstes-dokument.pdf
$pdf destroy
```

Output:

```text
pdf4tcllib::fonts: TTF italic faces loaded
pdf4tcllib::fonts: TTF faces loaded from /usr/share/fonts/truetype/dejavu
nächste Zeile bei y = 152.69291338582678
```

The first two lines are written to stderr by `fonts::init`. They say
that a TrueType font was found and where it came from.

What the lines do:

- `fonts::init` searches for a TrueType font once per process and registers
  it with pdf4tcl. After that, `fonts::fontSans`,
  `fonts::fontSansBold` etc. return the names under which it is registered.
- `page::context` computes the type area from paper and margin and
  returns a dict: `left`, `top`, `text_w` and further values, all
  in points.
- `page::header` and `page::footer` set header and footer with a
  thin line, both inside the margin.
- `unicode::safeText` writes text like `$pdf text`, but first replaces
  characters the font does not have.
- `text::writeParagraph` wraps the paragraph to the width `w` and returns
  the y position after the last line. That is where the next element goes.

`-orient true` on `pdf4tcl::new` is part of it: y grows downward, as
in the Tk canvas. `page::context` assumes the same unless told
otherwise. How the two must fit together is covered in the chapter
[Units and Page Context](040-einheiten-und-seitenkontext.md).

---

## How to Read the Book

- **Part 1** (this chapter through chapter 4) sets up what all
  other chapters assume: font, Unicode, page context.
- **Parts 2 to 4** are tasks: text, tables, charts,
  table of contents, labels, forms. They can be read
  individually.
- **Part 5** makes a document accessible and shows how to measure blocks
  in advance and stack them one below the other.
- The **case study** builds a report from the data to the
  table of contents.
- The **appendices** collect pitfalls, the API per module and the messages.

::: {.info}
**Tested with** pdf4tcllib 0.6.7, pdf4tcl 0.9.4.73, Tcl 8.6.18 and
9.0.4, Debian with DejaVu fonts.
:::

---

*Next chapter: [Setup and Fonts](020-einrichten-und-schriften.md)*
