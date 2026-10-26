# Setting Text

## Introduction

pdf4tcl puts a line where it is told to. If the line is too long, it
runs over the margin. For everything beyond that, the namespace
[text]{.index} has four tools: measure width, wrap, truncate, shrink.
In addition there is `writeParagraph` for a whole paragraph in one go.

This chapter shows the four tools and builds from them a small
procedure that sets text across any number of pages.

---

## Measuring Width

```tcl
pdf4tcllib::text::width text size font ?pdf?
```

With the pdf4tcl object as the last argument, `width` asks pdf4tcl for
the real metrics of the font. Without the object it estimates by
character class: narrow letters such as `i` and `l` count less, `m`
and `W` more.

```tcl
# 050-messen-und-umbrechen.tcl -- messen, umbrechen, kuerzen
package require pdf4tcl
package require pdf4tcllib

pdf4tcllib::fonts::init -cid 1
set font [pdf4tcllib::fonts::fontSans]
set pdf  [pdf4tcl::new %AUTO% -paper a4 -orient true]

# Breite: geschaetzt (ohne pdf) und gemessen (mit pdf)
set t "Lieferung Mo 17.08. Spedition Nord"
puts [format "geschaetzt %.1f pt, gemessen %.1f pt" \
    [pdf4tcllib::text::width $t 10 $font] \
    [pdf4tcllib::text::width $t 10 $font $pdf]]

# Umbrechen: am Leerzeichen und nach einem Bindestrich
set lang "Die Muster-Beispiel-Stadt liegt an der Bundesstrasse."
foreach z [pdf4tcllib::text::wrap $lang 90 10 $font 0 $pdf] {
    puts "  |$z|"
}

# Ein Wort, das allein zu breit ist: gekuerzt oder zerlegt
set name "pdf4tcllib::unicode::substReport"
set ohne [pdf4tcllib::text::wrap $name 80 10 $font 0 $pdf]
set mit  [pdf4tcllib::text::wrap $name 80 10 $font 0 $pdf 1]
puts "ohne hardBreak: $ohne"
puts "mit hardBreak:  $mit"

# Kuerzen mit "..." oder kleiner setzen
set k "Tour Sped1 Nord"
puts "truncate: [pdf4tcllib::text::truncate $k 60 10 $font $pdf]"
puts "fitSize:  [pdf4tcllib::text::fitSize $k 60 10 $font -pdf $pdf]"
puts "fits:     [pdf4tcllib::text::fits $k 60 7 $font $pdf]"
$pdf destroy
```

```text
geschaetzt 156.0 pt, gemessen 159.7 pt
  |Die Muster-Beispiel-|
  |Stadt liegt an der|
  |Bundesstrasse.|
ohne hardBreak: pdf4tcllib::unic...
mit hardBreak:  pdf4tcllib::unicod e::substReport
truncate: Tour Sped1...
fitSize:  8
fits:     1
```

For this sentence the estimate is off by 2 %, for other texts with
DejaVu by up to about 6 %. That is enough to wrap a line that would
have fit, or to let one through that sticks out. That is why all calls
in this book append the object `$pdf`. The estimate exists only for the
case that no document exists yet.

`width` needs no `setFont` beforehand: font and size are part of the
call.

---

## Wrapping

```tcl
pdf4tcllib::text::wrap line maxW size font \
    ?code? ?pdf? ?hardBreak? ?trenner?
```

`wrap` returns a list of lines, each at most `maxW` wide. Nothing is
drawn. The order of the arguments is unusual: `pdf` comes sixth, after
`code`.

| Argument | Default | Meaning |
|---|---|---|
| `code` | `0` | `1`: every wrapped line except the last ends in ` \`, like a continued Tcl line |
| `pdf` | – | object for exact widths |
| `hardBreak` | `0` | what happens to a word that is too wide on its own (see below) |
| `trenner` | `{- /}` | characters at which a break is also allowed inside a word |

Lines are broken at spaces and after a hyphen or slash between two
letters or digits. The separator stays at the end of the line
("Muster-Beispiel-"), so the reader sees that the word continues. A
dash at the start of a word does not break: "-5 Euro" stays together.
pdf4tcl breaks lines in `drawTextBox` by the same rules.

### A Word That Does Not Fit

What happens to a word that on its own is wider than the line is
decided by `hardBreak`:

- `0` (default): the word is **truncated** and ends in "...". The rest
  is gone.
- `1`: the word is split character by character; nothing is lost.

The default is meant for running text, in which such a word is rare.
In table cells with paths, package names or item numbers it is wrong:
`pdf4tcllib::unicode::substReport` becomes `pdf4tcllib::unic...`. Set
`hardBreak 1` there.

---

## Truncating or Shrinking

```tcl
pdf4tcllib::text::truncate text maxW size font ?pdf?
pdf4tcllib::text::fitSize  text maxW size font ?-min n? ?-pdf obj?
pdf4tcllib::text::fits     text maxW size font ?pdf?
```

[text::truncate]{.index} cuts off and appends three dots.
[text::fitSize]{.index} instead looks for the largest font size at
which the text fits completely, in steps of 1 point downward to `-min`
(default 6). If it does not fit even there, `-min` is returned and the
caller decides.

Which is better depends on the content. "Tour Sped1 Nord" truncated is
"Tour Sped1...": whether it was "Nord" or "Süd" (north or south) is no
longer there. For names, routes, amounts and identifiers a smaller font
is better than a cut-off end. A remark that is only a note anyway may
be truncated.

With `fitSize` the object is called `-pdf`; with the others it is the
last argument, without a name.

---

## A Paragraph in One Go

```tcl
set y [pdf4tcllib::text::writeParagraph pdf text x y width \
    ?size? ?align? ?tag?]
```

[text::writeParagraph]{.index} wraps and draws in one step, through
pdf4tcl's `drawTextBox`. It returns the y position below the last line.
`align` is `left`, `right`, `center` or `justify`.

Three things are worth knowing:

- The font is always the regular one from `fonts::init` (Helvetica
  without TrueType). Bold or italic is not possible with it.
- There is no page break. A paragraph that no longer fits at the bottom
  runs past the margin.
- The text does not go through `sanitize` (chapter
  [Safe Unicode Output](030-unicode-sicher-ausgeben.md)).

For a short paragraph at a known position `writeParagraph` is the right
choice. Text of unknown length needs wrapping across pages.

---

## Text Across Pages

The following procedure `absatz` (paragraph) wraps a paragraph with
`wrap` and sets it line by line. If the next line no longer fits above
`bottom`, `neueSeite` (new page) starts a new page with a footer. Font
and size can be chosen freely, bold included.

```tcl
# 050-text-ueber-seiten.tcl -- Fliesstext mit eigenem Seitenumbruch
package require pdf4tcl
package require pdf4tcllib

pdf4tcllib::fonts::init -cid 1
set ctx [pdf4tcllib::page::context a4 -margin 20]
set pdf [pdf4tcl::new %AUTO% -paper a4 -orient true]

# Der Zustand der Seite: wo die naechste Zeile steht
set y 0

proc neueSeite {} {
    global pdf ctx y
    if {[$pdf currentPage] > 0} {
        set n [$pdf currentPage]
        pdf4tcllib::page::footer $pdf $ctx "Lagerbericht" $n
        $pdf endPage
    }
    $pdf startPage
    set y [dict get $ctx top]
}

# Einen Absatz setzen: umbrechen, Zeile fuer Zeile, bei Bedarf eine
# neue Seite
proc absatz {text {size 11} {font ""}} {
    global pdf ctx y
    if {$font eq ""} { set font [pdf4tcllib::fonts::fontSans] }
    set lh [pdf4tcllib::page::lineheight $size]
    set breite [dict get $ctx text_w]
    foreach zeile [pdf4tcllib::text::wrap $text $breite \
            $size $font 0 $pdf 1] {
        if {$y + $lh > [dict get $ctx bottom]} { neueSeite }
        set y [expr {$y + $lh}]
        $pdf setFont $size $font
        pdf4tcllib::unicode::safeText $pdf $zeile \
            -x [dict get $ctx left] -y $y
    }
    set y [expr {$y + $lh / 2}]
}

neueSeite
absatz "Bestand am Monatsende" 16 [pdf4tcllib::fonts::fontSansBold]
for {set i 1} {$i <= 40} {incr i} {
    absatz "Regal $i: Der Bestand wurde gezählt und mit der Buchung\
        abgeglichen. Abweichungen unter zwei Stück sind ausgebucht,\
        größere gehen an die Lagerleitung zur Klärung."
}
pdf4tcllib::page::footer $pdf $ctx "Lagerbericht" [$pdf currentPage]
$pdf endPage
puts "Seiten: [$pdf pageCount]"
$pdf write -file 050-text-ueber-seiten.pdf
$pdf destroy
```

```text
Seiten: 3
```

What the procedure does right:

- It checks **before** each line whether the line still fits, not
  after. The last line of a page then still lies inside the type area.
- It advances y **before** writing, one line height below `top`. That
  way the first line of a page does not stick into the margin
  (chapter [Units and Page Context](040-einheiten-und-seitenkontext.md)).
- It sets the font again before every line. `neueSeite` sets a
  different font in the footer, and without the new `setFont` the
  paragraph would continue on the new page in the footer's font.
- It uses `hardBreak 1`, so that no word is truncated.

The page number comes from `$pdf currentPage`; after the last `endPage`,
`$pdf pageCount` tells how many pages there are.

What the procedure does not do: it does not prevent a single line at
the top of a page or a heading at the bottom. For that, the height of a
block must be known before setting it; this is shown in the chapter on
`measure` and `layout`.

---

## Summary

- Always call `text::width`, `text::wrap`, `text::truncate`, `text::fits`
  with the pdf4tcl object; otherwise they estimate.
- `wrap` truncates a word that is too wide; use `hardBreak 1` where
  nothing may be lost.
- `fitSize` instead of `truncate` for names, identifiers and amounts.
- `writeParagraph` for a short paragraph in the regular font; for
  longer text, a loop of your own with page breaks.

---

*Next chapter: [Headers, Footers, Page Numbers](060-kopf-fuss-seitenzahlen.md)*
