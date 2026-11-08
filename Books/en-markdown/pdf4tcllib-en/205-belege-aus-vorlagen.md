# Documents from Templates

## Introduction

A delivery note, a quotation, a letter: at the top a few blocks at fixed
places, sender, address, number and date. Then a table that runs over as
many pages as it needs. After it come blocks that follow the table
wherever it ends: total, remark, closing. The loop from the chapter
[Measuring and Stacking](200-messen-und-stapeln.md) can do this, but every
document type writes it anew.

The package [pdf4tcltemplate]{.index} splits the document into two
dicts: the **template**, where each block sits and how it looks, and the
**data**, what it shows. The template stays the same for every delivery
note and can live in a file or a table; the data is made per document.

---

## Template and Data

```tcl
package require pdf4tcltemplate
set r [pdf4tcllib::template::render pdf template data ?option value ...?]
```

The example script is the same as in the German edition; comments and
sample data are German.

```tcl
# 205-vorlagen.tcl -- Lieferschein aus Vorlage und Daten, Seite n von m
package require pdf4tcl
package require pdf4tcllib
package require pdf4tcltemplate

pdf4tcllib::fonts::init -cid 1

# Die Vorlage: wo die Bloecke stehen und wie sie aussehen, in mm
set vorlage {
    paper a4  margin 20  size 10
    theme {accent {0.15 0.30 0.20} muted {0.40 0.40 0.40}}
    blocks {
        firma     {x 20 y 18 w 110 size 18 bold 1 color accent}
        absender  {x 20 y 45 w 85 size 7 color muted}
        anschrift {x 20 y 50 w 85 size 11 list 1}
        angaben   {type pairs x 125 y 50 w 65 labelw 30 size 9}
        titel     {x 20 y 95 w 170 size 15 bold 1 color accent
                   text "Lieferschein {nummer}"}
        positionen {type table x 20 y 108 w 170 size 9 zebra 1
                    cols {{key pos title Pos w 12 align right}
                          {key text title Bezeichnung}
                          {key menge title Menge w 22 align right}
                          {key einheit title Einheit w 16}}}
        hinweis   {x 20 y 0 w 170 gap 8 color muted}
        fuss      {x 20 y 285 w 170 size 8 color muted page all
                   align center text "Seite {page} von {pages}"}
    }
}

# Die Daten: ein Lieferschein, alles schon als Text
set zeilen {}
for {set i 1} {$i <= 40} {incr i} {
    lappend zeilen [dict create pos $i text "Tontopf, natur, Nr. $i" \
        menge [expr {$i * 12}] einheit Stk]
}
set daten [dict create \
    firma     "Gärtnerei Beispiel" \
    absender  "Gärtnerei Beispiel · Gartenweg 1 · 12345 Grünfeld" \
    anschrift {"Blumenhaus Müller" "" "Hauptstraße 5" "54321 Stadt"} \
    angaben   {Nummer LS-2026-0007 Datum 08.11.2026 Kunde K12 Bestellung {}} \
    nummer    LS-2026-0007 \
    positionen $zeilen \
    hinweis   "Bitte prüfen Sie die Ware.\nVielen Dank für Ihren Auftrag."]

set pdf [pdf4tcl::new %AUTO% -paper a4 -orient true]
set r [pdf4tcllib::template::render $pdf $vorlage $daten]
$pdf write -file 205-vorlagen.pdf
$pdf destroy
puts "Ergebnis: $r"

# Dieselbe Vorlage fuer einen anderen Kunden: einen Block ausblenden
dict set vorlage blocks absender show 0
set pdf [pdf4tcl::new %AUTO% -paper a4 -orient true]
set r2 [pdf4tcllib::template::render $pdf $vorlage \
    [dict replace $daten positionen [lrange $zeilen 0 4]]]
$pdf destroy
puts "fünf Zeilen: $r2"

# Fehler in der Vorlage melden sich vor dem Zeichnen
catch {pdf4tcllib::template::check {blocks {a {type kreis}}}} m o
puts "[dict get $o -errorcode]: $m"
```

```text
Ergebnis: pages 2 y 88.4472222222222
fünf Zeilen: pages 1 y 155.9372222222222
PDF4TCLLIB TEMPLATE TYPE: template: block "a": unknown type "kreis", known: text, pairs, table, image, rule
```

`render` opens the first page itself and closes the last. The result is a
dict: `pages`, the number of pages, and `y`, the space below the last
block in millimeters. The 40 rows need two pages; the remark stands on
the second, below the last row.

**The package computes nothing.** Quantities, prices and totals arrive
as finished text. Whoever prints amounts computes them in one place, and
the PDF cannot round differently.

---

## The Template

| Key | Default | Meaning |
|---|---|---|
| `paper` | `a4` | `a4`, `a5`, `letter` or `{width height}` in mm |
| `margin` | `20` | mm; `x` and `w` of a block that gives none |
| `top` | `margin` | mm; where the flow starts on a new page |
| `bottom` | page height − `margin` | mm; where the flow ends |
| `size` | `10` | font size in points |
| `theme` | – | color names → `{r g b}` |
| `blocks` | – | block ID → block, drawn in this order |

A block has a type:

| `type` | Value in the data |
|---|---|
| `text` (default) | text; a newline starts a new line. With `list 1` a list of lines, empty ones are dropped |
| `pairs` | `label value label value …`; labels in the first `labelw` mm, pairs without a value are dropped |
| `table` | list of rows, each a dict with the column keys or a list in column order |
| `image` | image file; fitted into `w` × `h`, aspect ratio kept |
| `rule` | none; a line across `w` |

Further keys: `x y w h` in mm, `show`, `page` (`first`, `all`, `rest`,
`last`), `gap`, `size`, `bold`, `color`, `align`, `leading`, `field`
(data key, otherwise the block ID) and `text` (used when the data has no
value). In a text of the template, `{key}` is replaced from the data,
`{page}` and `{pages}` by the page numbers.

For tables `cols` names the columns, each a key or
`{key k title t w mm align a}`. Columns without `w` share what is left of
the block width. A cell wraps inside its column, a row is never split,
the head stands on every page. `zebra 1` shades every second row.

A full-page image at `x 0 y 0` with `page all`, as the first block, is a
letterhead.

---

## The Flow

A block with a fixed `y` stands where it says. A block with `y 0` stands
`gap` mm below the block before it in the order, usually the table. If a
short block no longer fits above `bottom`, it moves to the next page as a
whole; a long text block breaks between lines.

A block with `page all` stands on every page, `rest` from the second on,
`last` on the last one. Such blocks need a fixed `y`.

---

## Page n of m

`{pages}` is known only after the last page. If the template uses it,
`render` first draws the document into a throw-away document with the
same paper, unit and fonts and counts the pages. The principle is the
same as in the chapter
[Headers, Footers, Page Numbers](060-kopf-fuss-seitenzahlen.md).

---

## Options, Unit and Fonts

| Option | Default | Meaning |
|---|---|---|
| `-font` | from `fonts::init` | font for normal text |
| `-fontbold` | its bold face, else `-font` | font for `bold 1` |
| `-startpage` | `1` | `0`: the caller has a page open and closes it himself |
| `-newpage` | – | script after each page break, in the caller's scope |

The document may have any `-unit`; the blocks end up in the same place.
It must have `-orient true` (y from the top), otherwise `render` reports
`{PDF4TCLLIB TEMPLATE ORIENT}`.

For PDF/A pass embedded fonts. If another library builds the document
and loads the fonts, pass their names on with `-font` and `-fontbold`.

`template::check template` checks a template and returns it with the
defaults filled in, without drawing; errors carry
`{PDF4TCLLIB TEMPLATE <kind>}`.

---

## What Does Not Work

- Cells spanning columns and total rows inside the table; totals go in
  a `pairs` block in the flow.
- Blocks taller than a page, except text blocks.
- A PDF as letterhead; convert it into an image first.
- `render` passes the text to pdf4tcl unchanged. Characters the font
  lacks are not replaced as `safeText` does (chapter
  [Safe Unicode Output](030-unicode-sicher-ausgeben.md)).

Editing a template on screen: `tkutils::tkutemplate`, book *tkutils*.

---

## Summary

- `template::render` draws a document from template and data; the
  package computes nothing.
- Fixed blocks stand at their `y`, blocks with `y 0` follow the block
  before them.
- `{page}`, `{pages}` and `{key}` in texts of the template; `{pages}`
  costs a trial run.
- Any unit, but `-orient true`; embedded fonts for PDF/A.

---

*Next chapter: [Case Study: Warehouse Report](210-fallstudie-bericht.md)*
