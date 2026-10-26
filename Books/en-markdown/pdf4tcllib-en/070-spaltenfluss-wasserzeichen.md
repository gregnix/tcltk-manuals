# Column Flow and Watermarks

## Introduction

A circular in two columns, minutes with "ENTWURF" (draft) across every
page: both can be built with the loop from the chapter
[Setting Text](050-text-setzen.md), but the package
[pdf4tclflow]{.index} takes the column arithmetic off your hands. It
fills column after column and page after page until the text is used
up. The watermark is part of the pdf4tcllib core.

---

## Text in Columns

```tcl
package require pdf4tclflow
set r [pdf4tcllib::flow::columns pdf ctx text ?option wert ...?]
```

The text is split into paragraphs at blank lines; line breaks and
multiple spaces within a paragraph become a single space. Between two
paragraphs one blank line remains, except at the top of a column.

| Option | Default | Meaning |
|---|---|---|
| `-columns` | `2` | number of columns |
| `-gap` | `18` | space between the columns in points |
| `-size` | `10` | font size |
| `-font` | from `fonts::init` | font |
| `-top`, `-bottom` | from the context | where each column begins and ends |
| `-firsty` | `-top` | start of the first column, for example below a heading |
| `-newpage` | – | script for the page change |
| `-tag` | `P` | structure type for accessible PDFs, `""` for none |

The columns are of equal width and fill the type area; with two columns
on A4 with a 20 mm margin that is 232 points (82 mm) each.
[flow::boxes]{.index} returns the position of each column as
`{x breite}` (x, width), for an image in column two or a line between
the columns.

```tcl
# 070-spalten.tcl -- zwei Spalten ueber mehrere Seiten, Wasserzeichen
package require pdf4tcl
package require pdf4tcllib
package require pdf4tclflow

pdf4tcllib::fonts::init -cid 1
set ctx [pdf4tcllib::page::context a4 -margin 20]
set pdf [pdf4tcl::new %AUTO% -paper a4 -orient true]

# Ein langer Text; Absaetze durch eine Leerzeile getrennt
set absatz "Die Inventur beginnt am ersten Werktag des Monats. Jedes\
    Regal wird gezählt, die Zahl mit der Buchung verglichen und die\
    Abweichung notiert. Kleine Abweichungen werden sofort ausgebucht,\
    größere gehen an die Lagerleitung."
set text [join [lrepeat 30 $absatz] "\n\n"]

# erste Grundlinie, im Satzspiegel
set oben [expr {[dict get $ctx top] + 10}]

$pdf startPage
pdf4tcllib::drawing::watermark $pdf $ctx "ENTWURF" -size 110
$pdf setFont 16 [pdf4tcllib::fonts::fontSansBold]
pdf4tcllib::unicode::safeText $pdf "Inventur im Lager Nord" \
    -x [dict get $ctx left] -y [expr {$oben + 6}]

set r [pdf4tcllib::flow::columns $pdf $ctx $text -columns 2 -size 10 \
    -top $oben -firsty [expr {$oben + 36}] -newpage {
        pdf4tcllib::page::number $pdf $ctx [$pdf currentPage]
        $pdf endPage
        $pdf startPage
        pdf4tcllib::drawing::watermark $pdf $ctx "ENTWURF" -size 110
        pdf4tcllib::page::header $pdf $ctx "Inventur im Lager Nord"
    }]
pdf4tcllib::page::number $pdf $ctx [$pdf currentPage]
$pdf endPage
puts "Ergebnis: $r"

# Ohne -newpage: was nicht passt, kommt in "rest" zurueck
$pdf startPage
set r2 [pdf4tcllib::flow::columns $pdf $ctx $text \
    -columns 3 -top $oben]
$pdf endPage
puts "ohne -newpage: [dict get $r2 lines] Zeilen gesetzt,\
    [llength [split [dict get $r2 rest] \n]] Zeilen in rest"

$pdf write -file 070-spalten.pdf
$pdf destroy
```

```text
Ergebnis: column 1 y 472.6929133858268 pages 1 lines 150 rest {}
ohne -newpage: 136 Zeilen gesetzt, 116 Zeilen in rest
```

The result is a dict:

| Key | Meaning |
|---|---|
| `column` | column in which the text ends (from 0) |
| `y` | y below the last line |
| `pages` | number of page changes |
| `lines` | lines set |
| `rest` | what was not set, empty if everything fit |

### The Page Change Belongs to the Caller

When the last column is full, `columns` runs the script from `-newpage`
in the caller's scope. It must close the old page, open a new one, and
write into it everything a new page needs: page number, header,
watermark. Afterwards `columns` restores font and size itself.

**Without `-newpage`, `columns` stops** when the columns of the page are
full, and returns the remainder in `rest`. In the example, 136 lines fit
on the page in three columns; 116 lines, including the blank lines
between the paragraphs, are in `rest`. Code that does not check `rest`
loses the rest of the text without any message.

### The First Baseline

`columns` sets the first line of each column with its baseline on
`-top`. If not given, that is `top` from the context, and the ascenders
stick into the margin. The example therefore gives `-top` 10 points
lower.

`-firsty` applies only to the first column of the first page. The
second column next to it starts at `-top` again. A heading across both
columns therefore needs `-firsty` **and** enough space in the second
column; in the example it stands only above the first.

### What Does Not Work

- `-align` is among the defaults (`flow::configure`) but has no effect:
  every line is set left-aligned.
- Font, size and line spacing apply to the whole text. A subheading in
  the flow is only possible by splitting the text and calling `columns`
  several times, with `-firsty` from the `y` of the previous call.
- The text goes through `safeText`; typographic quotation marks become
  straight ones (chapter [Safe Unicode Output](030-unicode-sicher-ausgeben.md)).

More columns do not save pages. Narrow columns wrap more often and
leave more space free at the end of the line. Columns are a matter of
readability: a line of 60 to 80 characters is easier to read than one
of 130.

`flow::configure` changes the defaults for all later calls in the
program. A library that uses `columns` therefore passes its options
with the call instead of changing its caller's defaults.

---

## Watermarks

```tcl
pdf4tcllib::drawing::watermark pdf ctx text ?-size pt? ?-angle grad? \
    ?-color {r g b}? ?-font name?
```

[drawing::watermark]{.index} writes a text in gray diagonally across
the middle of the page. It returns the font size used.

| Option | Default | Meaning |
|---|---|---|
| `-size` | `0` | `0`: large enough for the text to fill most of the diagonal |
| `-angle` | `45` | angle counterclockwise |
| `-color` | `{0.86 0.86 0.86}` | shade of gray |
| `-font` | from `fonts::init` | font |

**Draw it first.** pdf4tcl has no transparency; the watermark is opaque
light gray. Whatever comes after it lies on top. In the example it
therefore comes right after `startPage`, in the `-newpage` script as
well.

With `-size 0`, "ENTWURF" on A4 becomes about 180 points high and
reaches from the left almost to the right paper edge. A fixed size of
around 110 points leaves a margin and looks calmer.

The watermark is built for pages with `-orient 1`. With `-orient 0` it
ends up outside the page.

`pdftotext` returns rotated text scrambled. Whether the watermark is
placed correctly can only be seen in a viewer.

---

## Summary

- `flow::columns` sets text in columns across pages; the caller
  provides the page change as a `-newpage` script.
- Without `-newpage` the remainder is in `rest`; always check it.
- `-top` one line below `top`, otherwise the first line sticks into the
  margin.
- `-align` has no effect; columns do not save pages.
- `drawing::watermark` first on every page, with a fixed size of around
  110 points, only with `-orient 1`.

---

*Next chapter: [Tables with Page Breaks](080-tabellen.md)*
