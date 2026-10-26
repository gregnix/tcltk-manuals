# Headers, Footers, Page Numbers

## Introduction

Headers and footers appear on every page, and they are written at the
moment a page begins or ends. pdf4tcllib provides the three building
blocks for this (chapter
[Units and Page Context](040-einheiten-und-seitenkontext.md)); when
they are called is decided by your own code. This chapter fixes that
place and answers the question every report eventually asks: "page 2
of how many?"

---

## One Place for the Page Change

Everything that belongs on every page goes into one procedure that
finishes the old page and begins the new one: in the previous chapter,
`neueSeite`. Code that writes header and footer in several places
forgets them in one.

| What | When | Procedure |
|---|---|---|
| footer, page number | before the page ends | `page::footer`, `page::number` |
| header, watermark | after the new page begins | `page::header`, `drawing::watermark` |
| y back to the start | after the header | `dict get $ctx top` |

The footer belongs at the end of a page, not at its beginning: only
then is it certain that the page has content and that its number is
correct.

The three building blocks write into the margin, not into the type
area:

| Building block | Position (y downward) |
|---|---|
| `page::header` | text at half the margin from the top, line 2 pt above `top` |
| `page::footer` | line 2 pt below `bottom`, text at half the margin from the bottom |
| `page::number` | like the footer text, in the middle |

With a 20 mm margin the text of header and footer is 10 mm from the
paper edge. With a smaller margin it moves closer; with a 10 mm margin
it is 5 mm, and that can be too tight for a printer.

---

## Page 2 of 3

How many pages a document has is only settled when it is finished. By
then, however, the footer of the first page has long been written. The
usual solution: set the document twice. The first pass goes into a
document that is only counted and then discarded; the second knows the
number.

```tcl
# 060-seite-x-von-y.tcl -- "Seite 2 von 3": zwei Durchlaeufe
package require pdf4tcl
package require pdf4tcllib

pdf4tcllib::fonts::init -cid 1
set ctx [pdf4tcllib::page::context a4 -margin 20]

# Der ganze Bericht als Prozedur: sie bekommt das Dokument und die
# Gesamtzahl der Seiten ("" im ersten Durchlauf) und hat keine
# Nebenwirkungen -- sie laeuft zweimal.
proc bericht {pdf gesamt} {
    global ctx
    set font [pdf4tcllib::fonts::fontSans]
    set lh   [pdf4tcllib::page::lineheight 11]
    set seite 0
    set y 0
    set neu {
        if {$seite > 0} { rand $pdf $seite $gesamt; $pdf endPage }
        $pdf startPage
        incr seite
        if {$seite > 1} {
            pdf4tcllib::page::header $pdf $ctx "Lagerbericht Oktober"
        }
        set y [dict get $ctx top]
    }
    eval $neu
    for {set i 1} {$i <= 120} {incr i} {
        if {$y + $lh > [dict get $ctx bottom]} { eval $neu }
        set y [expr {$y + $lh}]
        $pdf setFont 11 $font
        pdf4tcllib::unicode::safeText $pdf "Position $i: geprüft" \
            -x [dict get $ctx left] -y $y
    }
    rand $pdf $seite $gesamt
    $pdf endPage
}

proc rand {pdf seite gesamt} {
    global ctx
    set label "Seite %s"
    if {$gesamt ne ""} { append label " von $gesamt" }
    pdf4tcllib::page::footer $pdf $ctx "Vertraulich" $seite 9 \
        -pagelabel $label
}

# Durchlauf 1: in ein Wegwerf-Dokument, nur um die Seiten zu zaehlen
set probe [pdf4tcl::new %AUTO% -paper a4 -orient true]
bericht $probe ""
set gesamt [$probe pageCount]
$probe destroy

# Durchlauf 2: das echte Dokument
set pdf [pdf4tcl::new %AUTO% -paper a4 -orient true]
bericht $pdf $gesamt
$pdf write -file 060-seite-x-von-y.pdf
$pdf destroy
puts "Seiten: $gesamt"
```

```text
Seiten: 3
```

The footers read "Seite 1 von 3", "Seite 2 von 3", "Seite 3 von 3". The
first page has no header, the following ones have "Lagerbericht
Oktober".

What this requires:

- **The content is in a procedure** that receives the document as an
  argument. It runs twice and therefore must not do anything that turns
  out differently the second time: no appending to a file, no
  incrementing a counter outside, no reading from a channel that is
  empty afterwards. Read data that comes from a database once
  beforehand and pass it to the procedure.
- **The page number must not change the line breaks.** "Seite 9 von 9"
  and "Seite 9 von 10" differ in width, but both are in the footer,
  outside the type area. The content breaks the same way in both
  passes. Using the total in the text ("Dieser Bericht hat 3 Seiten",
  this report has 3 pages) can change the number of lines; then check
  the second pass against the first.
- **`-pagelabel` takes a format.** `page::footer` inserts the page
  number with `format`. "Seite %s von 3" gives "Seite 2 von 3". A
  percent sign in the text must therefore be written `%%`.

The throwaway document costs only computing time; it is never written.
`$probe pageCount` counts the finished pages, which is why the first
pass also ends with `endPage`.

The package `pdf4tcltoc` works on the same principle to put the table
of contents with real page numbers in front of the text (chapter
Table of Contents).

---

## Page Number Without a Word

`page::number` writes `- 2 -` or `- 2 / 3 -` in the middle, without any
language. That fits when there is no footer with text:

```tcl
pdf4tcllib::page::number $pdf $ctx [$pdf currentPage] $gesamt
```

With `""` as the total, only the number appears. That is handy in the
first pass, when the total is not known yet.

---

## Summary

- Header, footer, watermark and the start of the page belong in one
  procedure for the page change.
- Footer before `endPage`, header after `startPage`.
- "Page X of Y": set the document twice, take the total from
  `$probe pageCount`; the content as a procedure without side effects.
- `-pagelabel "Seite %s von $gesamt"`; a `%` in the text as `%%`.

---

*Next chapter: [Column Flow and Watermarks](070-spaltenfluss-wasserzeichen.md)*
