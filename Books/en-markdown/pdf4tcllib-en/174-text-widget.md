# Text Widget

## Introduction

A Tk `text` with tags is a small type area: heading, bold words, code,
links, indented paragraphs. The package [pdf4tcltext]{.index} reads the
widget with `$t dump -all`, character by character with the tags in
force there, and sets the text into the PDF with those properties. It
breaks the lines itself, at word boundaries, within the width
`-maxwidth`.

---

## A Care Note

The example script is the same as in the German edition; comments and
sample data are German.

```tcl
# 174-text-widget.tcl -- ein Tk-Text mit Tags als PDF
package require Tk
package require pdf4tcl
package require pdf4tcllib
package require pdf4tcltext

pdf4tcllib::fonts::init -cid 1
set ctx [pdf4tcllib::page::context a4 -margin 20]

# Die TrueType-Schrift aus fonts::init ein zweites Mal anmelden, unter
# dem Tk-Familiennamen des Widgets: so findet das Paket sie, statt auf
# Helvetica auszuweichen
pdf4tcl::createFontSpecCID _Pdf4tcl_Base_Regular "DejaVu Sans"
pdf4tcl::createFontSpecCID _Pdf4tcl_Base_Bold    "DejaVu Sans-Bold"

# Schriften mit Leerzeichen im Namen: als benannte Schrift
font create normal -family "DejaVu Sans" -size 11
font create titel  -family "DejaVu Sans" -size 16 -weight bold
font create fett   -family "DejaVu Sans" -size 11 -weight bold
font create klein  -family "DejaVu Sans" -size 8

text .t -width 70 -height 20 -wrap word -font normal
.t tag configure h1     -font titel -foreground "#1a2f5a" \
    -spacing1 8 -spacing3 6 -justify center
.t tag configure fett   -font fett
.t tag configure code   -font {Courier 10} -background "#eeeeee"
.t tag configure link   -foreground "#0044aa" -underline 1
.t tag configure alt    -overstrike 1 -foreground "#888888"
.t tag configure hoch   -font klein -offset 4
.t tag configure zitat  -lmargin1 30 -lmargin2 30 -foreground "#555555"
.t tag configure intern -elide 1

.t insert end "Pflegehinweis Tontöpfe\n" h1
.t insert end "Neue Töpfe vor dem Bepflanzen "
.t insert end "zwei Stunden" fett
.t insert end " wässern. Der Preis sinkt von "
.t insert end "2,90 €" alt
.t insert end " auf 2,50 €. Fläche des Bodens: 113 cm"
.t insert end "2" hoch
.t insert end ". Datenblatt: "
.t insert end "pflege.pdf" link
.t insert end ", Artikelnummer "
.t insert end "TT-18" code
.t insert end ".\n"
.t insert end "Ton atmet; im Winter frostfrei lagern, sonst platzt die\
 Glasur. Das gilt auch für Untersetzer.\n" zitat
.t insert end "Nur für den Laden: Einkauf 1,10 €\n" intern
pack .t
update idletasks

set pdf [pdf4tcl::new %AUTO% -paper a4 -orient true]
$pdf startPage
set x [dict get $ctx left]
set y [pdf4tcllib::textwidget::render $pdf .t $x [dict get $ctx top] \
    -maxwidth 300]
puts "Text endet bei y = [format %.1f $y]"
# Mit dem ausgeblendeten Text
set y [pdf4tcllib::textwidget::render $pdf .t $x [expr {$y + 30}] \
    -maxwidth 300 -skipelided 0]
puts "mit -skipelided 0 bis y = [format %.1f $y]"
$pdf endPage

$pdf write -file 174-text-widget.pdf
$pdf destroy
exit                        ;# sonst wartet Tk auf Ereignisse
```

```text
Text endet bei y = 180.8
mit -skipelided 0 bis y = 352.5
```

The first pass as text:

```text
        Pflegehinweis Tontöpfe
Neue Töpfe vor dem Bepflanzen zwei Stunden wässern.
Der Preis sinkt von 2,90 € auf 2,50 €. Fläche des Bodens:
113 cm2. Datenblatt: pflege.pdf, Artikelnummer TT-18.
    Ton atmet; im Winter frostfrei lagern, sonst platzt die
    Glasur. Das gilt auch für Untersetzer.
```

In the PDF the heading is blue and centred, "zwei Stunden" bold, the old
price grey and struck through, the "2" raised, the link blue and
underlined, the article number in Courier on a grey ground and the last
paragraph indented. The line "Nur für den Laden" is missing because its
tag has `-elide 1`; the second pass with `-skipelided 0` shows it.

`textwidget::render` returns the y position after the last line. The
package also creates `pdf4tcltext::render` as an equivalent name.

---

## The Fonts

This is the one place where some thought is needed.

**Every Tk font is looked up.** For text without a font tag that is the
widget's `-font`; for a tag with `-font` it is the tag's font. The
package reads family, size, bold and italic from it and looks for a PDF
font:

1. a font registered under exactly this family name, for bold with
   `-Bold`, for italic with `-Italic` or `-Oblique` appended
   (`DejaVu Sans-Bold`);
2. otherwise one of the 14 standard fonts: Courier for Courier and
   anything with "Mono", Times for Times, Georgia and `serif`, otherwise
   Helvetica.

The standard fonts know only Latin-1. `fonts::init` registers its fonts
under names of its own (`Pdf4tclSans` and relatives, chapter
[Setup and Fonts](020-einrichten-und-schriften.md)), not under
`DejaVu Sans`. That is why the example registers the TrueType font from
`fonts::init` a second time with `createFontSpecCID`, under the names the
widget uses: `DejaVu Sans` and `DejaVu Sans-Bold`.
`_Pdf4tcl_Base_Regular` and `_Pdf4tcl_Base_Bold` are the names under
which `fonts::init` loaded the files; the chapter
[Form Layout](120-formular-layout.md) takes the same route for cp1252.
Then the whole text is in the TrueType font, euro sign included.

**`-fontfamily` and `-fontsize`** fix the font for text without a font
tag instead of taking it from the widget. `-fontfamily` may be a PDF
font name (`Pdf4tclSans`) or a Tk family name, looked up as above. The
widget's size comes in points, as Tk resolves it; a size in pixels is
converted.

**Family names with spaces** belong in a named font (`font create`) or in
the option form `{-family "DejaVu Sans" -size 11}`. In the list form
`{DejaVu Sans 11 bold}`, "Sans" is read as the size.

---

## What Comes from the Tags

| Tag option | In the PDF |
|---|---|
| `-font` | font and size, as above |
| `-foreground`, `-background` | text colour, area behind it |
| `-underline`, `-overstrike` | line in the text colour |
| `-offset` | baseline up (positive) or down (negative) |
| `-justify` | `center`, `right` within `-maxwidth` |
| `-lmargin1` | indentation, for all lines of the paragraph |
| `-spacing1`, `-spacing3` | space before and after the paragraph |
| `-elide` | text left out, unless `-skipelided 0` |

**Pixels become points.** `-lmargin1`, `-spacing1`, `-spacing3` and
`-offset` are pixels in the widget. The package converts with 0.75,
that is 96 dpi: an indentation of 30 pixels becomes 22.5 points.

**Several tags on one word** are merged by the widget's priority: a tag
created later wins; `tag raise` and `tag lower` change that.

**Raised does not mean smaller.** `-offset` only moves the baseline. The
example gives the tag `hoch` the smaller font itself, as is needed on
screen too.

**`-justify` applies per line.** The first piece of a line decides, as in
Tk.

**Colour names** such as `red` are translated by Tk with `winfo rgb`,
which needs a window that is not withdrawn. Hex colours always work.

---

## What Does Not Arrive

| In the widget | In the PDF |
|---|---|
| `-lmargin2`, `-rmargin`, `-spacing2` | not read; `-linespacing` instead of `-spacing2` |
| `-wrap none` or `char` | lines always break at word boundaries |
| embedded window | `[Widget]` |
| embedded image | `[Bild: name]` |
| `-relief`, `-borderwidth`, selection | nothing |

A word wider than `-maxwidth` is not cut off but sticks out.

**No page break.** `render` writes downwards in one column, even past
the bottom margin. Whoever has more text than one page splits it: into
several widgets, one per section, or sets longer running text without a
widget with `text::writeParagraph` or `flow::columns` (chapters
[Setting Text](050-text-setzen.md),
[Column Flow](070-spaltenfluss-wasserzeichen.md)).

In an accessible PDF each line becomes a `P` with `Span` for the pieces;
areas and lines are artifacts.

---

## Options

| Option | Default | Meaning |
|---|---|---|
| `-maxwidth` | `480` | width; lines break here |
| `-fontsize` | from the widget | size for text without a font tag |
| `-fontfamily` | from the widget | font for text without a font tag: PDF font name or Tk family |
| `-linespacing` | `2` | extra line spacing in points |
| `-skipelided` | `1` | leave out elided text |
| `-skipinternal` | `1` | skip the marks `sel` and `insert` |
| `-ctx` | – | page context |
| `-yvar` | – | variable for the y position |

---

## Summary

- `textwidget::render` sets a Tk text with its tags and breaks lines
  within `-maxwidth`.
- The widget's font and the tags' fonts are looked up under their family
  name, otherwise among the standard fonts; for Unicode, register the
  TrueType font under that name.
- `-fontfamily` and `-fontsize` fix the font for text without a tag.
- Pixels × 0.75 = points.
- No page break; split longer texts.

---

*Next chapter: [Canvas](176-canvas.md)*
