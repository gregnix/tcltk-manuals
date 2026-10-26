# Safe Unicode Output

## Introduction

A character that the font does not have disappears in the PDF: it shows
up as "?", as an empty box, or not at all. That it is missing is only
noticed when reading. pdf4tcllib catches this in one place, in
[unicode::sanitize]{.index}, and counts what it had to replace.

This chapter shows what `sanitize` does with a line, which procedures
call it and which do not, and how to tell that characters have been
lost.

---

## What sanitize Does

```tcl
pdf4tcllib::unicode::sanitize text ?-mono 0|1? ?-tabwidth n?
```

`sanitize` returns the text as the loaded font can show it. It works in
two stages:

1. **Replace known characters.** A fixed table maps characters that
   often occur in texts to something printable: ✅ → ✓, ⚠ → (!),
   ➡ → →, ™ → (TM). Without TrueType it replaces more: → becomes `->`,
   € becomes `EUR`, ✓ becomes `(OK)`, box-drawing lines become `+`, `-`
   and `|`.
2. **Check every remaining character.** Whatever the font does not have
   in the current mode becomes "?". Invisible characters (zero-width
   spaces, variation selectors, BOM) are dropped entirely, tabs become
   spaces (`-tabwidth`, default 4).

Which characters the font "has" depends on the mode from `fonts::init`
(chapter [Setup and Fonts](020-einrichten-und-schriften.md)):

- without TrueType: printable ASCII and Latin-1,
- TrueType with 256 characters: the fixed selection from `fonts::subset`,
- TrueType in CID mode: every character for which the font has a
  glyph.

The same line in both TrueType modes:

```tcl
# 030-unicode.tcl -- was sanitize aus einer Zeile macht
#   tclsh 030-unicode.tcl          256-Zeichen-Modus
#   tclsh 030-unicode.tcl -cid 1   CID-Modus (volle Schrift)
package require pdf4tcl
package require pdf4tcllib

pdf4tcllib::fonts::init {*}$argv

set zeile "Pfeil \u2192, Euro \u20ac, Haken \u2705, alpha \u03b1,\
    Summe \u2211, \u201eZitat\u201c, Schneemann \u2603, Kanji \u6f22"
puts [pdf4tcllib::unicode::sanitize $zeile]
puts [pdf4tcllib::unicode::sanitize $zeile -mono 1]
puts [pdf4tcllib::unicode::substReport]

set pdf [pdf4tcl::new %AUTO% -paper a4 -orient true]
$pdf startPage
$pdf setFont 11 [pdf4tcllib::fonts::fontSans]
pdf4tcllib::unicode::safeText $pdf $zeile -x 50 -y 60
$pdf endPage
set cid [expr {[pdf4tcllib::fonts::isCidMode] ? "-cid" : ""}]
$pdf write -file 030-unicode$cid.pdf
$pdf destroy
```

```text
$ tclsh 030-unicode.tcl
Pfeil →, Euro €, Haken ✓, alpha ?, Summe ?, "Zitat", Schneemann ?, Kanji ?
Pfeil ->, Euro EUR, Haken (OK), alpha ?, Summe ?, "Zitat", Schneemann ?, Kanji ?
count 8 chars {U+03B1 U+2211 U+2603 U+6F22}

$ tclsh 030-unicode.tcl -cid 1
Pfeil →, Euro €, Haken ✓, alpha α, Summe ∑, "Zitat", Schneemann ☃, Kanji ?
Pfeil →, Euro €, Haken ✓, alpha α, Summe ∑, "Zitat", Schneemann ☃, Kanji ?
count 2 chars U+6F22
```

The first line is normal text, the second `-mono 1`. In CID mode the
Greek letter and the sum sign survive as well; only the kanji is
missing, because DejaVu has no Chinese characters. The counter runs
across both calls, which is why the 256-character mode shows 8: four
characters per line.

### Monospaced Font: -mono 1

`-mono 1` is meant for code and tables in a monospaced font. If
`fonts::init` loads no TrueType monospaced font, that font is Courier,
and Courier knows only Latin-1; then the large substitution table
applies, as without TrueType (→ becomes `->`). In CID mode with DejaVu
Sans Mono, Unicode is kept and checked against that font. In
256-character mode `-mono 1` always substitutes according to the large
table, even when DejaVu Sans Mono is loaded.

---

## Who Calls sanitize

| Procedure | calls `sanitize` |
|---|---|
| `unicode::safeText` | yes |
| `page::header`, `page::footer`, `page::number`, `page::centerText` | yes, through `safeText` |
| `text::writeParagraph` | **no**, it calls `$pdf drawTextBox` directly |
| `$pdf text`, `$pdf drawTextBox` (pdf4tcl) | no |

Whatever does not pass through `sanitize` is replaced by pdf4tcl itself
when the font cannot encode a character. In that case, too, "?" appears
in the PDF. It is counted elsewhere: in `$pdf getSubstCount`.

```tcl
# 030-drei-wege.tcl -- dieselbe Zeile auf drei Wegen
#   tclsh 030-drei-wege.tcl          256-Zeichen-Modus
#   tclsh 030-drei-wege.tcl -cid 1   CID-Modus
package require pdf4tcl
package require pdf4tcllib

pdf4tcllib::fonts::init {*}$argv
set t "\u201eZitat\u201c, alpha \u03b1, Pfeil \u2192"

set pdf [pdf4tcl::new %AUTO% -paper a4 -orient true]
$pdf startPage
$pdf setFont 11 [pdf4tcllib::fonts::fontSans]
$pdf text "pdf4tcl direkt:  $t" -x 50 -y 60
pdf4tcllib::unicode::safeText $pdf "safeText:        $t" -x 50 -y 80
pdf4tcllib::text::writeParagraph $pdf "writeParagraph:  $t" \
    50 100 400 11
set bericht [pdf4tcllib::unicode::substReport]
puts "pdf4tcllib ersetzt: [dict get $bericht count]"
puts "pdf4tcl ersetzt:    [$pdf getSubstCount]"
set cid [expr {[pdf4tcllib::fonts::isCidMode] ? "-cid" : ""}]
$pdf write -file 030-drei-wege$cid.pdf
$pdf destroy
```

256-character mode:

```text
pdf4tcllib ersetzt: 1
pdf4tcl ersetzt:    6

pdf4tcl direkt:  ?Zitat?, alpha ?, Pfeil →
safeText:        "Zitat", alpha ?, Pfeil →
writeParagraph:  ?Zitat?, alpha ?, Pfeil →
```

CID mode:

```text
pdf4tcllib ersetzt: 0
pdf4tcl ersetzt:    0

pdf4tcl direkt:  „Zitat“, alpha α, Pfeil →
safeText:        "Zitat", alpha α, Pfeil →
writeParagraph:  „Zitat“, alpha α, Pfeil →
```

Two things stand out:

- In 256-character mode the characters are missing on all three paths.
  Only the counter differs: `safeText` counts with pdf4tcllib, the
  other two paths with pdf4tcl.
- `safeText` always turns „Zitat“ into "Zitat", even in CID mode, where
  the font has „ and “. The first stage of `sanitize` replaces the
  typographic quotation marks („ “ ” ‚ ‘ ’) with straight ones in every
  mode.

### German Quotation Marks

For German texts this means: CID mode, and text with „…“ is not output
through `safeText` but through `text::writeParagraph` or `$pdf text`.
Both leave the characters alone. In 256-character mode there is no way
to „…“; there only straight quotation marks or » « (which are in
Latin-1) remain.

The headers and footers from `page::header` and `page::footer` go
through `safeText`; a „Titel“ (title) in them loses its quotation marks
even in CID mode.

---

## The Font Used for Drawing Is Not the One sanitize Asks About

`sanitize` goes by what `fonts::init` has loaded, not by the font that
is currently set with `setFont`. Setting Helvetica for a paragraph after
`fonts::init` lets characters through that Helvetica does not know:

```tcl
# 030-falle-schrift.tcl -- sanitize folgt fonts::init, nicht setFont
package require pdf4tcl
package require pdf4tcllib

pdf4tcllib::fonts::init
set t "Pfeil \u2192, Euro \u20ac, Haken \u2713"

set pdf [pdf4tcl::new %AUTO% -paper a4 -orient true]
$pdf startPage
$pdf setFont 12 [pdf4tcllib::fonts::fontSans]
pdf4tcllib::unicode::safeText $pdf "fontSans:  $t" -x 50 -y 60
$pdf setFont 12 Helvetica
pdf4tcllib::unicode::safeText $pdf "Helvetica: $t" -x 50 -y 80
set bericht [pdf4tcllib::unicode::substReport]
puts "pdf4tcllib ersetzt: [dict get $bericht count]"
puts "pdf4tcl ersetzt:    [$pdf getSubstCount]"
$pdf write -file 030-falle-schrift.pdf
$pdf destroy
```

```text
pdf4tcllib ersetzt: 0
pdf4tcl ersetzt:    0

fontSans:  Pfeil →, Euro €, Haken ✓
Helvetica: Pfeil ?, Euro €, Haken ?
```

Under Tcl 8.6 both counters stay at 0, and still two characters are
missing in the second line. Under Tcl 9 at least pdf4tcl reports them
(`pdf4tcl ersetzt: 2`). After `fonts::init`, therefore, set only the
fonts from `fonts::fontSans` and the other accessor procedures. Where
Courier or Helvetica is really needed, output the text with `-mono 1`;
then the large substitution table applies, and → becomes `->` instead
of "?".

---

## Emoji

Characters above U+FFFF, that is most emoji, are replaced by `sanitize`
with an ASCII transcription: 😀 becomes `:-)`, 👍 becomes `(+1)`, 🔒
becomes `[L]`. Unknown emoji become `(?)`. This transcription does not
count as a loss and does not appear in `substReport`.

```text
$ tclsh 030-emoji.tcl
Tcl 8.6, direkt gelesen: Gruss :-) und (+1)
Tcl 8.6, mit readFile:   Gruss :-) und (+1)
```

Tcl 8.6.14 and Tcl 9.0 read the emoji from a UTF-8 file correctly.
[unicode::readFile]{.index} reads the file in binary mode and inserts
the transcription before Tcl converts the bytes; it is meant for older
8.6 releases that turn such characters into U+FFFD when reading. A
U+FFFD in the text becomes `(?)`, and the original character can then
no longer be recognized.

---

## Knowing What Was Missing

`sanitize` counts every character it replaces with "?" and remembers
up to twelve different ones:

```tcl
pdf4tcllib::unicode::substCount   ;# 8
pdf4tcllib::unicode::substReport  ;# count 8 chars {U+03B1 U+2211 ...}
pdf4tcllib::unicode::resetSubst
```

The first time, it also writes a warning to stderr:

```text
pdf4tcllib::unicode: sanitize: at least one character is missing from the
font and was replaced with '?' (first: U+03B1). Ask
::pdf4tcllib::unicode::substReport for the list, or load a font that has
it -- fonts::init -cid 1 for Greek and mathematical symbols.
```

For a program that produces PDFs unattended, both counters belong at
the end of every document:

```tcl
set verloren [expr {[pdf4tcllib::unicode::substCount]
                    + [$pdf getSubstCount]}]
if {$verloren} {
    puts stderr "Warnung: $verloren Zeichen ersetzt\
        ([dict get [pdf4tcllib::unicode::substReport] chars])"
}
```

`substCount` counts across all documents of the process; call
`resetSubst` before each new document. `$pdf getSubstCount` applies to
the one pdf4tcl object. The case from the previous section (Helvetica
after `fonts::init`) is reported by neither of them under Tcl 8.6.

---

## Summary

- Output text with special characters through `unicode::safeText`,
  paragraphs through `text::writeParagraph`, both with fonts from the
  accessor procedures.
- For Greek, mathematics and German quotation marks use
  `fonts::init -cid 1`.
- `safeText` always replaces „ “ with "; for „…“ use `writeParagraph` or
  `$pdf text`.
- At the end check `unicode::substCount` and `$pdf getSubstCount`.

---

*Next chapter: [Units and Page Context](040-einheiten-und-seitenkontext.md)*
