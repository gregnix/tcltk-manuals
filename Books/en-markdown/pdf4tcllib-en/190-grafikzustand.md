# Saving the Graphics State

## Introduction

Every building block sets font and colors the way it needs them and
leaves them that way afterwards. Anyone who set 20 point bold red before
a table goes on writing in 9 point regular black afterwards, without
noticing. In short scripts this shows at once; in a report built from
many procedures, finding the cause takes a long time.

[state::with]{.index} holds the state across a block and restores it
afterwards.

---

## What Gets Lost

```tcl
# 190-zustand.tcl -- Schrift und Farbe ueber einen Baustein retten
package require pdf4tcl
package require pdf4tcllib

pdf4tcllib::fonts::init -cid 1
set ctx [pdf4tcllib::page::context a4 -margin 20]
set pdf [pdf4tcl::new %AUTO% -paper a4 -orient true]
$pdf startPage
set x [dict get $ctx left]
set fett [pdf4tcllib::fonts::fontSansBold]
set cols {{-header Regal} {-header Bestand -align right}}
set rows {{A-01 118} {A-02 80}}

# pdf4tcl hat keine Abfrage fuer die Schrift; die Breite eines
# Probetextes zeigt, welche Groesse gerade eingestellt ist
proc probe {} { format %.1f [$::pdf getStringWidth "Probe"] }

# 1. Ohne Schutz: danach ist die Schrift der Tabelle eingestellt
$pdf setFont 20 $fett
$pdf setFillColor 0.8 0 0
puts "vorher:          [probe]"
set y [pdf4tcllib::table::draw $pdf $x 80 $cols $rows]
puts "nach table:      [probe]"
$pdf text "Nachher (ohne Schutz)" -x $x -y [expr {$y + 30}]

# 2. Mit state::with: Schrift und Farbe bleiben erhalten
$pdf setFont 20 $fett
$pdf setFillColor 0.8 0 0
set y [pdf4tcllib::state::with $pdf [list 20 $fett] {0.8 0 0} {
    pdf4tcllib::table::draw $pdf $x [expr {$y + 60}] $cols $rows
}]
puts "nach state::with: [probe]"
$pdf text "Nachher (mit state::with)" -x $x -y [expr {$y + 30}]

$pdf endPage
$pdf write -file 190-zustand.pdf
$pdf destroy
```

```text
vorher:          59.5
nach table:      22.9
nach state::with: 59.5
```

pdf4tcl cannot tell which font is currently set; there is `setFont`, but
no `getFont`. The example therefore measures the width of the word
"Probe" (sample): 59.5 points in 20 point bold, 22.9 points in the font
that `table::draw` last wrote with. In the PDF the first "Nachher"
(after) line is small and black, the second one large and red.

---

## state::with

```tcl
set ergebnis [pdf4tcllib::state::with pdf {größe schrift} {r g b} \
    skript]
```

The script runs in the caller's scope. Afterwards font and fill color
are the given ones again, even if the script throws an error. The return
value is whatever the script returns; in the example, the `y` of the
table.

Because pdf4tcl does not hand out the state, it has to be **given
explicitly**. `state::with` restores what it is told, not what was set
before. Passing `{20 Helvetica}` while 11 point Sans was actually set
gives 20 point Helvetica afterwards.

Whatever is left out (an empty `{}` instead of font or color) is not
touched. `state` queries line spacing and kerning from pdf4tcl itself
and restores them as well.

### By Hand

```tcl
set z [pdf4tcllib::state::save $pdf 20 $fett {0.8 0 0}]
pdf4tcllib::table::draw $pdf ...
pdf4tcllib::state::restore $pdf $z
```

`save` also takes the stroke color as a fifth argument. It returns a
dict that `restore` puts back in place. An error between the two calls
leaves the state changed; `with` is therefore usually the better choice.

---

## Why Not gsave and grestore

PDF has its own pair for saving the state, `q` and `Q`, in pdf4tcl
`gsave` and `grestore`. Within a page it is the right tool, for example
to lift a clipping path again. Across a page break it does not work:
each page has its own content stream, and a `gsave` on page 1 with the
`grestore` on page 2 gives two unbalanced streams. Neither pdf4tcl nor
qpdf reports this. A table with `-ctx`, however, breaks pages in exactly
this way.

Within a page, `grestore` also restores the font that pdf4tcl keeps for
measuring: after `gsave`, `setFont 9` and `grestore`, "Probe" measures
59.5 points again.

---

## Summary

- Building blocks leave their font and color behind.
- `state::with pdf {größe schrift} {r g b} skript` restores them
  afterwards, even on an error.
- Give the state explicitly; pdf4tcl cannot supply it.
- `gsave`/`grestore` only within a page.

---

*Next chapter: [Measuring and Stacking](200-messen-und-stapeln.md)*
