# Tablelist

## Introduction

This part is about Tk programs that already show their data in a widget:
a `tablelist`, a `text`, a `canvas` or a `ttk::treeview`. "Give me that as
a PDF" then means: exactly what is in the window, in the order it is
there. For each of the four widgets there is a package, and all four are
**adapters**: they read the widget and leave the drawing to a part of
pdf4tcllib that needs no Tk. All four need Tk and so a display.

The first is [pdf4tcltable]{.index} for the `tablelist` by Csaba
Nemethi. It reads columns, values, colours, fonts and the tree depth
from the widget and hands them to `table::draw` (chapter
[Tables with Page Breaks](080-tabellen.md)). Whoever has the data as Tcl
lists and no widget calls `table::draw` directly.

---

## An Order

The example script is the same as in the German edition; comments and
sample data are German.

```tcl
# 172-tablelist.tcl -- eine tablelist als PDF: Farben, Format, Fusszeile
package require Tk
package require tablelist_tile
package require pdf4tcl
package require pdf4tcllib
package require pdf4tcltable

pdf4tcllib::fonts::init -cid 1
set ctx [pdf4tcllib::page::context a4 -margin 20]

# Eine Zahl so zeigen, wie sie im Fenster stehen soll
proc euro {wert} {
    if {![string is double -strict $wert]} { return $wert }
    return [string map {. ,} [format "%.2f €" $wert]]
}

tablelist::tablelist .tbl -stripebackground "#eef3fb" \
    -columns {6 "Pos" right  28 "Artikel" left  8 "Menge" right
              12 "Preis" right  12 "Summe" right}
.tbl columnconfigure 3 -formatcommand euro
.tbl columnconfigure 4 -formatcommand euro
pack .tbl -fill both -expand 1

set gesamt 0.0
foreach {artikel menge preis} {
    "Tontopf, natur, 12 cm"   40  1.20
    "Tontopf, natur, 18 cm"   25  2.90
    "Untersetzer 18 cm"       25  0.80
    "Blumenerde, 20 l"        12  4.50
    "Rankhilfe, Bambus"       30  0.65
} {
    set summe [expr {$menge * $preis}]
    set gesamt [expr {$gesamt + $summe}]
    .tbl insert end [list [expr {[.tbl size] + 1}] $artikel $menge $preis $summe]
}
update idletasks
# Hervorheben wie auf dem Bildschirm: eine Zeile, eine Zelle
.tbl rowconfigure 3 -background "#fff2cc"
.tbl cellconfigure 1,4 -foreground "#b00000" -font {Helvetica 9 bold}

set pdf [pdf4tcl::new %AUTO% -paper a4 -orient true]
$pdf startPage
set x [dict get $ctx left]
set y [dict get $ctx top]
pdf4tcllib::tablelist::render $pdf .tbl $x $y \
    -maxwidth [dict get $ctx text_w] -ctx $ctx -yvar y \
    -footer [list "" "Gesamt" "" "" [euro $gesamt]]
puts "Tabelle endet bei y = [format %.1f $y]"
puts "Bericht: [pdf4tcllib::tablelist::report]"

# Dieselbe Tabelle ohne Formatierung: die Rohwerte
pdf4tcllib::tablelist::render $pdf .tbl $x [expr {$y + 20}] \
    -maxwidth [dict get $ctx text_w] -formatted 0 -zebra 0 -yvar y
puts "Rohwerte enden bei y = [format %.1f $y]"

# Eine umbrechende Spalte: im Fenster mehrzeilig, im PDF nicht
.tbl columnconfigure 1 -wrap 1 -width 12
update idletasks
pdf4tcllib::tablelist::renderRange $pdf .tbl $x [expr {$y + 20}] \
    -maxwidth 300 -firstrow 0 -lastrow 1 -yvar y
puts "Bericht: [pdf4tcllib::tablelist::report]"
$pdf endPage

$pdf write -file 172-tablelist.pdf
$pdf destroy
exit                        ;# sonst wartet Tk auf Ereignisse
```

```text
Tabelle endet bei y = 168.7
Bericht: images 0 cells {} wrapped 0 windows 0
Rohwerte enden bei y = 284.7
Bericht: images 0 cells {0,1 1,1} wrapped 2 windows 0
```

The first table as text:

```text
Pos Artikel                 Menge   Preis    Summe
  1 Tontopf, natur, 12 cm      40   1,20 €   48,00 €
  2 Tontopf, natur, 18 cm      25   2,90 €   72,50 €
  3 Untersetzer 18 cm          25   0,80 €   20,00 €
  4 Blumenerde, 20 l           12   4,50 €   54,00 €
  5 Rankhilfe, Bambus          30   0,65 €   19,50 €
    Gesamt                                  214,00 €
```

The commands live in the namespace `pdf4tcllib::tablelist`; the package
also creates `pdf4tcltable::render` and `pdf4tcltable::renderRange` as
equivalent names.

### The Script Needs a Display

Like every script in this part it ends with `exit`, otherwise Tk waits
for events after the last command. On a server without a screen it runs
with `xvfb-run tclsh 172-tablelist.tcl`. Tk translates colour names such
as `lightblue` with `winfo rgb`, which needs a window that is not
withdrawn; hex colours such as `#fff2cc` always work.

`update idletasks` comes before the first `cellconfigure`: the tablelist
creates its cells only then; before that, `cellconfigure` reports an
error about an unknown tag.

---

## What Comes from the Widget

| In the widget | In the PDF |
|---|---|
| `-columns`, `-title`, `-align` | header row, alignment |
| `-width` of the column (characters) | share of `-maxwidth` |
| `-hide 1` | column left out |
| `-formatcommand` | the formatted value |
| `-stripebackground` | zebra stripes |
| `rowconfigure`, `cellconfigure` (`-background`, `-foreground`, `-font`) | colour and font of the row, the cell |
| `insertchild`, tree depth | indentation by `-indentW` per level |

**Widths are proportions.** The tablelist gives widths in characters.
The package scales them to `-maxwidth`: in the example that is
6 + 28 + 8 + 12 + 12 = 66 characters, and the column "Artikel" gets
28/66 of the width. `-width 0` (automatic) counts as 5 characters.

**Cell before row before zebra.** If a cell has its own colour, it wins;
otherwise the row's, otherwise the stripe. In the example row 3 is yellow
and the total in row 1 is red and bold.

**Fonts.** With `fonts::init` the TrueType fonts are ready, and cells,
header and footer use them: the euro sign arrives. A Tk font in a cell
(`{Helvetica 9 bold}`) is mapped to the matching face, regular, bold,
italic or monospaced. `-font` and `-boldfont` set the two faces for one
call.

### -formatcommand

The columns "Preis" and "Summe" have a `-formatcommand`. The tablelist
calls it with **one** argument, the value of the cell; a procedure with
two parameters leads to `wrong # args`. Whoever needs more passes a
prefix: `-formatcommand {format_with EUR}`.

With `-formatted 1`, the default, the formatted value goes into the PDF,
with `-formatted 0` the stored one. The second table in the example shows
`48.0` instead of `48,00 €`.

### The Footer

`-footer` takes a list of values, one per column, or a second tablelist
widget whose row 0 supplies the values. The footer is bold, below a
heavier line.

A list does **not** go through `-formatcommand`. That is why the example
puts `[euro $gesamt]` in the list; with `$gesamt` alone, `214.0` would
stand under a column of euro amounts.

---

## What Does Not Arrive

Three things the export cannot carry over:

| In the widget | In the PDF |
|---|---|
| `cellconfigure -image` | nothing |
| `cellconfigure -window` | nothing; the cell's value as text |
| `columnconfigure -wrap 1` | one line, shortened with `...` |

The last one costs the most. In the window the article stands on two
lines after `-wrap 1`; in the PDF it reads "Tontopf, natur...".

So that this does not happen silently, the package counts.
[tablelist::report]{.index} returns what was missing in the **last**
call: images, windows, shortened cells, and the cells as `row,column`.
One line also goes to `::pdf4tcl::warnings`. A wrapping column alone
does not count; what counts is a value longer than the column.

An embedded widget such as a checkbutton appears as its value: `0` or
`1`.

---

## Over Several Pages

With `-ctx`, `render` breaks at the bottom margin, using the built-in
break of `table::draw`: the table header stands on every page, `- 1 -`
at the bottom right, but no page header or footer. `render` does not
pass `-pagebreakcmd` on. `-pagevar` takes the page number and returns
it.

Whoever wants to control the break, for instance for a page header of
their own, takes [tablelist::renderRange]{.index} with `-firstrow` and
`-lastrow` and counts the rows per page. `renderRange` draws a header
row per call, but no footer, and does not break.

```tcl
set rh [expr {int(9 * 1.8)}]          ;# row height at -fontsize 9
set perPage [expr {int(([dict get $ctx bottom] - $y) / $rh) - 1}]
for {set from 0} {$from < [.tbl size]} {incr from $perPage} {
    if {$from > 0} { $pdf endPage; $pdf startPage; set y [dict get $ctx top] }
    pdf4tcllib::tablelist::renderRange $pdf .tbl $x $y -yvar y \
        -firstrow $from -lastrow [expr {$from + $perPage - 1}]
}
```

---

## Options

| Option | Default | Meaning |
|---|---|---|
| `-maxwidth` | `480` | table width |
| `-fontsize` | `9` | font size |
| `-rowheight` | `0` | row height; `0` means 1.8 × size |
| `-zebra`, `-border` | `1`, `1` | stripes, lines |
| `-tree`, `-indentW` | `1`, `12` | indent the tree, per level |
| `-formatted` | `1` | values through `-formatcommand` |
| `-headerbg`, `-headerfg` | from the widget | header colours, `{r g b}` |
| `-footer` | – | values or widget (`render` only) |
| `-footerbg`, `-footerbold` | light grey, `1` | footer |
| `-ctx` | – | page context; turns on the page break (`render` only) |
| `-yvar`, `-pagevar` | – | variables for y and page number |
| `-font`, `-boldfont` | from `fonts::init` | fonts for this call |
| `-firstrow`, `-lastrow` | `0`, `-1` | `renderRange` only |

An unknown option raises an error listing the known ones.

---

## Summary

- `tablelist::render` draws the tablelist as it stands in the window,
  through `table::draw`.
- Widths become proportions; colours apply cell before row before zebra.
- `-formatcommand` takes one argument; a footer given as a list is not
  formatted.
- Images, windows and wrapped cells do not arrive; `tablelist::report`
  says what was missing.
- `-ctx` for the built-in break, `renderRange` for your own.

---

*Next chapter: [Text Widget](174-text-widget.md)*
