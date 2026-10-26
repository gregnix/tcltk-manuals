# Measuring and Stacking

## Introduction

Every report contains the same loop: draw a block, take the returned
`y`, add a gap, draw the next block. And before a table comes the
question: does it still fit on this page, or does it belong entirely on
the next one? The building blocks of pdf4tcllib do not answer that; they
draw and say afterwards where they stopped.

Two namespaces help: [measure]{.index} measures a block before it is
drawn, and [layout::stack]{.index} places blocks one below the other and
starts a new page when a block no longer fits completely.

---

## Measuring by Drawing

```tcl
set m [pdf4tcllib::measure::block varName skript ?option wert ...?]
```

[measure::block]{.index} really draws the block, but into a throwaway
document that is never written. What is measured is therefore exactly
what comes out later. Inside the script, the throwaway document is held
in the variable whose name is passed (`mp` in the example). The result
is a dict:

| Key | Content |
|---|---|
| `height` | height of the block, from its return value |
| `pages` | pages it ran across |
| `overflow` | `1` if it ran off the bottom of the sheet |
| `value` | what the script returned |
| `sheet` | height of the sheet |

Options: `-paper` (default `a4`), `-orient`, `-landscape`, `-margin`,
`-y`. The height is the distance between `-y` (default 0) and the return
value; the block should therefore start at y = 0 or at the `y` given
with `-y`. If the script does not return a number, `height` is empty.

Fonts loaded by `fonts::init` are known to the throwaway document as
well; they apply to all documents of a process.

### pages and overflow

The page count only goes up if the block breaks pages itself, for
example `table::draw` with `-ctx`. Without `-ctx`, `table::draw` draws
past the edge of the page, and `pages` stays 1. Measure the block the
same way it will be drawn later.

`writeParagraph` never breaks pages. A long paragraph runs off the
bottom of the sheet, `pages` stays 1, and only `overflow` says that
something is wrong. In the example the long paragraph is 896 points
high, the sheet only 842.

[measure::fits]{.index} `platz varName skript` sums this up: `1` if the
block is at most `platz` high, stays on one page and does not overflow.
[measure::height]{.index} returns only the height.

---

## The Example

```tcl
# 200-messen-und-stapeln.tcl -- Hoehe vorab messen, Bloecke stapeln
package require pdf4tcl
package require pdf4tcllib
package require pdf4tclchart

pdf4tcllib::fonts::init -cid 1
set ctx [pdf4tcllib::page::context a4 -margin 20]
set x [dict get $ctx left]
set w [dict get $ctx text_w]

set text "Der Bestand wurde am Monatsende gezählt und mit der Buchung\
    abgeglichen. Abweichungen unter zwei Stück sind ausgebucht."
set cols {
    {-header Regal -width 120}
    {-header Soll  -width 60 -align right}
    {-header Ist   -width 60 -align right}
}
set rows {}
for {set i 1} {$i <= 30} {incr i} {
    set soll [expr {$i * 7}]
    lappend rows [list "Regal $i" $soll [expr {$soll - $i % 3}]]
}

# 1. Messen: wie hoch wird die Tabelle, passt der Absatz?
set m [pdf4tcllib::measure::block mp {
    pdf4tcllib::table::draw $mp 0 0 $cols $rows -maxwidth $w
}]
puts "Tabelle: Höhe [format %.1f [dict get $m height]],\
    Seiten [dict get $m pages], Überlauf [dict get $m overflow]"
set lang [string repeat "$text " 40]
set m [pdf4tcllib::measure::block mp {
    pdf4tcllib::text::writeParagraph $mp $lang 0 0 $w 11
}]
puts "Langer Absatz: Höhe [format %.1f [dict get $m height]],\
    Seiten [dict get $m pages], Überlauf [dict get $m overflow]"
puts "passt in 200 pt: [pdf4tcllib::measure::fits 200 mp {
    pdf4tcllib::text::writeParagraph $mp $text 0 0 $w 11
}]"

# 2. Stapeln: Bloecke untereinander, Tabelle und Diagramm am Stueck
set pdf [pdf4tcl::new %AUTO% -paper a4 -orient true]
proc kopf {} {
    global pdf ctx
    pdf4tcllib::page::header $pdf $ctx "Lagerbericht"
}
$pdf startPage
kopf
# Die Linie der Kopfzeile liegt 2 pt unter top, im Satzspiegel. stack
# beginnt jede Seite bei SY (= top); also SY tiefer, SH kuerzer.
set oben [expr {[dict get $ctx top] + 12}]
set sh   [expr {[dict get $ctx SH] - 12}]
set sctx [dict replace $ctx SY $oben SH $sh]

set absatz  {pdf4tcllib::text::writeParagraph $bpdf $text \
                 $bx $by $bw 11}
set balken  {pdf4tcllib::chart::bar $bpdf $bx $by $bw 200 \
                 {Nord 120 Süd 95 West 60} -title "Bestand je Lager"}
set tabelle {pdf4tcllib::table::draw $bpdf $bx $by $cols $rows \
                 -maxwidth $bw}
set ende    {pdf4tcllib::text::writeParagraph $bpdf "Ende." \
                 $bx $by $bw}
set blocks [list \
    [list script $absatz] \
    [list script $balken keep 1] \
    [list script $absatz] \
    [list script $tabelle keep 1] \
    {gap 10} \
    [list script $ende]]
set r [pdf4tcllib::layout::stack $pdf $x $oben $w $blocks \
    -ctx $sctx -gap 14 -font [list 11 [pdf4tcllib::fonts::fontSans]] \
    -pagecmd kopf]
puts "Seitenwechsel: [dict get $r pages], Ende bei y =\
    [format %.1f [dict get $r y]]"
foreach b [dict get $r boxes] { puts "  [lmap v $b {format %.0f $v}]" }
$pdf endPage
$pdf write -file 200-messen-und-stapeln.pdf
$pdf destroy
```

```text
Tabelle: Höhe 502.2, Seiten 1, Überlauf 0
Langer Absatz: Höhe 896.0, Seiten 1, Überlauf 1
passt in 200 pt: 1
Seitenwechsel: 1, Ende bei y = 625.9
  57 69 482 32
  57 115 482 200
  57 329 482 32
  57 69 482 502
  57 595 482 17
```

Page 1 holds paragraph, chart and paragraph. The table (502 points) no
longer fits into the type area from y = 375; with `keep 1` it moves
entirely to page 2, with a header. After it comes "Ende." (end).

---

## layout::stack

```tcl
set r [pdf4tcllib::layout::stack pdf x y breite blöcke \
    ?option wert ...?]
```

Each entry in `blöcke` is one of two kinds:

| Entry | Meaning |
|---|---|
| `script skript ?keep 1?` | a block |
| `gap n` | n points of space before the next block |

Four variables are available in the script: `$bpdf`, `$bx`, `$by`,
`$bw`, that is the document, the top left corner and the width. Like
every building block, the script returns the `y` below it (or an area
`{x y b h}`).

**In the script, `$bpdf`, not `$pdf`.** While measuring, `$bpdf` is the
throwaway document. A script that uses `$pdf` draws into the real
document while measuring, and the block appears twice.

The script runs in the caller's scope and sees its variables (`$text`,
`$cols`, `$rows`). That is why the scripts in the example are in curly
braces: the variables are substituted only when the script runs. A
script spanning several lines needs `\` at the end of the line, like
any other Tcl command.

| Option | Meaning |
|---|---|
| `-ctx` | page context; without it there is never a page break |
| `-gap` | space after each block |
| `-font {größe schrift}`, `-fill {r g b}` | set before each block, restored afterwards |
| `-pagecmd` | runs after each page break, in the caller's scope |
| `-paper` | paper used for measuring |

The result is a dict with `y` (below the last block), `pages` (number
of page breaks that `stack` made itself) and `boxes`, `{x y b h}` per
block.

### What keep Does and What It Does Not

Only blocks with `keep 1` are measured. If such a block no longer fits
above the bottom margin, `stack` ends the page, starts a new one, calls
`-pagecmd` and places the block at the top.

Blocks **without** `keep` are neither measured nor checked. A paragraph
without `keep` at the end of the page runs past the bottom margin, even
with `-ctx`. That is why `keep 1` pays off for short blocks as well,
when it is not known where they will land.

A block taller than a whole page does not fit on the new page either.
`stack` places it there anyway; the block then has to break pages
itself (a table with `-ctx`). The pages it starts in doing so are not
counted in `pages`, and `boxes` does not say which page a block is on.

### The Header and the Top Margin

`stack` starts each new page at `SY` from the context, which is `top`.
`page::header`, however, draws its rule 2 points **below** `top`, that
is inside the type area. A paragraph starting exactly at `top` gets
struck through by the rule. The example therefore gives `stack` a
context in which `SY` is 12 points lower and `SH` correspondingly
shorter:

```tcl
set oben [expr {[dict get $ctx top] + 12}]
set sh   [expr {[dict get $ctx SH] - 12}]
set sctx [dict replace $ctx SY $oben SH $sh]
```

`SY` and `SH` are the keys that `stack` reads; the other building blocks
use `top` and `bottom`. The modified copy therefore applies only to
`stack`.

---

## Summary

- `measure::block` draws as a trial and returns height, pages and
  overflow; `overflow` sees what `pages` does not.
- `layout::stack` places blocks one below the other; in the scripts use
  `$bpdf`, `$bx`, `$by`, `$bw`.
- Only `keep 1` blocks are measured and moved to the next page when
  needed.
- For room below the header, adjust `SY` and `SH` in the context for
  `stack`.

---

*Next chapter: [Case Study: Warehouse Report](210-fallstudie-bericht.md)*
