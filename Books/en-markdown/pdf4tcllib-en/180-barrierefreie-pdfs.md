# Accessible PDFs

## Introduction

A screen reader does not see a page but a tree: heading, paragraph,
table with rows and cells, figure with a description. If this
[structure tree]{.index} is not in the PDF, the program reads the page
in the order in which the texts lie in the content stream, page number,
header and table lines included. Public authorities and many companies
therefore require accessible PDFs according to [PDF/UA]{.index}
(ISO 14289).

pdf4tcl writes the structure tree when it is switched on. pdf4tcllib
makes sure that its building blocks fill it correctly: a table becomes
`Table` with `TR` and `TD`, a header becomes decoration. Whatever is
drawn by hand has to be classified by hand. This chapter shows both
with a report.

---

## What a Document Needs for PDF/UA

| Requirement | in pdf4tcl |
|---|---|
| structure tree | `$pdf tagged 1` |
| language of the document | `tagged 1 -lang de-DE` |
| title, shown in the window instead of the file name | `metadata -title ...`, `viewerPreferences -displaydoctitle 1` |
| embedded fonts | `fonts::init`; none of the 14 standard fonts |
| all content in an element or marked as decoration | pdf4tcllib building blocks, own drawing with `tag::` |
| alternate text for figures | `-alt` |
| identification as PDF/UA | `tagged 1 -ua 1` |

`-ua 1` only writes the claim into the metadata that the document
conforms to PDF/UA-1. pdf4tcl cannot check this. A document that makes
the claim and does not live up to it is worse than one that claims
nothing; that is why `-ua` is not the default.

`-displaydoctitle` is not the default either, and `-ua 1` does not set
it. PDF/UA requires it, though: without it, the viewer shows the file
name instead of the title.

---

## A Report with a Structure Tree

```tcl
# 180-barrierefrei.tcl -- ein Bericht mit Strukturbaum fuer PDF/UA
package require pdf4tcl
package require pdf4tcllib
package require pdf4tclchart

pdf4tcllib::fonts::init -cid 1           ;# eingebettete Schrift
set ctx [pdf4tcllib::page::context a4 -margin 20]
set pdf [pdf4tcl::new %AUTO% -paper a4 -orient true]

# Strukturbaum an, Sprache, Anspruch auf PDF/UA-1, Titel
$pdf tagged 1 -lang de-DE -ua 1
$pdf metadata -title "Lagerbericht Oktober" -author "Lager Nord"
$pdf viewerPreferences -displaydoctitle 1      ;# Titel statt Dateiname
set ::pdf4tcl::warnings {}

$pdf startPage
set x [dict get $ctx left]
set w [dict get $ctx text_w]
pdf4tcllib::page::header $pdf $ctx "Lagerbericht Oktober"

# Ueberschrift: writeParagraph mit dem Typ H1 statt des Vorgabe-P
set y [pdf4tcllib::text::writeParagraph $pdf "Bestand am Monatsende" \
    $x [expr {[dict get $ctx top] + 20}] $w 16 left H1]
set y [pdf4tcllib::text::writeParagraph $pdf "Der Bestand wurde am\
    Monatsende gezählt. Die Tabelle nennt die Abweichungen je Regal." \
    $x [expr {$y + 6}] $w 11]

# Eine Tabelle: Table, TR, TH, TD von selbst
set y [pdf4tcllib::table::draw $pdf $x [expr {$y + 10}] {
    {-header Regal -width 80}
    {-header Soll -width 60 -align right}
    {-header Ist -width 60 -align right}
} {{A-01 120 118} {A-02 80 80} {B-01 45 47}} \
    -summary "Soll und Ist je Regal"]

# Ein Diagramm: ein Element Figure mit Ersatztext
set y [pdf4tcllib::chart::bar $pdf $x [expr {$y + 20}] 300 150 \
    {A-01 -2 A-02 0 B-01 2} -title "Abweichung je Regal" \
    -alt "Balkendiagramm: A-01 minus 2, A-02 null, B-01 plus 2"]

# Selbst gezeichnet: Text als P, die Linie als Schmuck
pdf4tcllib::tag::begin $pdf P
$pdf setFont 9 [pdf4tcllib::fonts::fontSans]
$pdf text "Gezählt von: M. Albers" -x $x -y [expr {$y + 20}]
pdf4tcllib::tag::end $pdf
pdf4tcllib::tag::artifact $pdf -type Layout
$pdf line $x [expr {$y + 26}] [expr {$x + $w}] [expr {$y + 26}]
pdf4tcllib::tag::artifactEnd $pdf

pdf4tcllib::page::footer $pdf $ctx "Intern" 1
puts "ohne Element: [$pdf getUntaggedCount]"
$pdf endPage
$pdf write -file 180-barrierefrei.pdf
$pdf destroy
foreach m $::pdf4tcl::warnings { puts "Warnung: $m" }
```

```text
ohne Element: 0
```

Up to pdf4tclchart 0.1.1, a warning appeared below this: "the Figure
element is empty". Back then the chart was marked entirely as an
artifact, and the `Figure` had no content. Since 0.1.2, the drawing is
its content, and the warning is gone.

The structure tree of the result, read out with a PDF tool:

```text
Document
  H1          [Inhalt]
  P           [Inhalt]
  Table       Summary="Soll und Ist je Regal"
    TR
      TH  TH  TH        Scope=Column
    TR
      TD  TD  TD
    TR  ...
  Figure      Alt="Balkendiagramm: A-01 minus 2, A-02 null,
                   B-01 plus 2"  [Inhalt]
  P           [Inhalt]
```

Header, footer and the line below "Gezählt von" ("counted by") are not
in the tree. They are marked as an [artifact]{.index}: decoration that
a screen reader skips.

The table lines, on the other hand, hang as content on the `Table`
element. The pdf4tcllib documentation calls them artifacts; in the
content stream they appear with a content number below `Table`. A
screen reader does not read lines aloud, and `getUntaggedCount` does
not count them. Whether a checker objects to content directly below
`Table` has not been tested here.

---

## What the Building Blocks Do Themselves

| Building block | in the structure tree |
|---|---|
| `text::writeParagraph` | `P`, or the type in the last argument |
| `table::draw` | `Table`, `TR`, `TH` with `Scope=Column`, `TD`; `-summary` |
| `chart::bar`, `line`, `pie` | `Figure` with alternate text from `-alt` or `-title`; bars and axes are its content |
| `image::place`, `gallery` | `Figure` with `-alt`; caption as `Caption` |
| `toc::heading`, `toc::render` | `H1` to `H6`; `TOC` and `TOCI` |
| `form::labelField`, `row` | `Form` with label and field |
| `labels::render` | one `Sect` per label |
| `drawing::callout` | text as `P`, box and pointer as artifacts |
| `page::header`, `footer`, `number`, `drawing::watermark` | artifact (pagination) |

If `tagged` is off, the building blocks do none of this. The same code
then produces an ordinary PDF.

### Headings

`writeParagraph` sets `P` if nothing else is given. For a heading, the
type goes in as the eighth argument, with size and alignment before it:

```tcl
pdf4tcllib::text::writeParagraph $pdf "Bestand" $x $y $w 16 left H1
```

`writeParagraph` always sets the regular font; a `setFont` with bold
before it has no effect. The heading in the example is therefore only
larger, not bold. For a bold heading with a structure element, draw it
yourself (section
[Classifying Your Own Drawing](#classifying-your-own-drawing)).

The levels must not skip: after `H1` comes `H2`, not `H3` straight
away. pdf4tcl does not check this.

### Charts

A chart becomes a `Figure` with alternate text; bars, axes and labels
are its content. A screen reader speaks the alternate text, not the
individual strokes. The title is usually too little as
alternate text: "Abweichung je Regal" ("deviation per shelf") does not
say what the deviation looks like. In the example, the values are in
the alternate text.

A reader gets nothing from the chart beyond the alternate text. If the
numbers matter, they belong in a table as well.

### Tables

`-summary` describes the table in one sentence before the cells come.
The header row becomes `TH` with `Scope=Column`; this way a reader
knows for each cell which column it belongs to.

---

## Classifying Your Own Drawing

Whatever is drawn directly with pdf4tcl belongs to nothing until it is
classified. For this there are four procedures in the namespace
[tag]{.index}:

| Procedure | does |
|---|---|
| `tag::begin pdf typ ?-alt text?` | open an element (`P`, `H2`, `Figure` …) |
| `tag::end pdf` | close it |
| `tag::artifact pdf ?-type Layout\|Pagination?` | start decoration |
| `tag::artifactEnd pdf` | end decoration |

A bold heading, set by hand:

```tcl
pdf4tcllib::tag::begin $pdf H2
$pdf setFont 13 [pdf4tcllib::fonts::fontSansBold]
$pdf text "Abweichungen" -x $x -y $y
pdf4tcllib::tag::end $pdf
```

All four do nothing when `tagged` is off. They can therefore stay in
code that also produces ordinary PDFs.

`Layout` is decoration on the page (lines, areas, frames); `Pagination`
belongs to the page design (header, page number, watermark).

### getUntaggedCount

`$pdf getUntaggedCount` counts the drawing commands that are neither in
an element nor in an artifact. Zero is the goal. Without the four
`tag::` lines in the example, it would be 2: the text "Gezählt von" and
the line. pdf4tcl then also writes a warning to `$::pdf4tcl::warnings`
when saving.

Only what is drawn is counted. A color or font outside an element does
no harm.

---

## Checking

Zero in `getUntaggedCount` only means that everything is classified.
Whether the classification is right, the number does not say. Three
levels:

1. **`getUntaggedCount` and `$::pdf4tcl::warnings`** in the program, on
   every run. The example prints both.
2. **A checker** for the standard. [veraPDF]{.index} checks PDF/UA-1:

   ```bash
   verapdf -f ua1 bericht.pdf
   ```

   `qpdf --check` only checks whether the file is cleanly built, not
   the standard.
3. **A person with a screen reader** (NVDA, JAWS, Orca). A document can
   meet every rule and still be read aloud in an order that makes no
   sense.

---

## Summary

- `tagged 1 -lang de-DE`, title with `metadata -title` and
  `viewerPreferences -displaydoctitle 1`, embedded font.
- The building blocks fill the structure tree themselves; headings need
  the type as an argument.
- Own drawing with `tag::begin`/`end` or as an artifact.
- `getUntaggedCount` must be 0; after that, veraPDF and a person.
- `-ua 1` is a claim, not a check.

---

*Next chapter: [Saving the Graphics State](190-grafikzustand.md)*
