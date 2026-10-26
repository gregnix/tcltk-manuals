# Formulas

## Introduction

A test report with a tolerance formula, a data sheet with a
characteristic curve, an invoice with exponents: formulas also turn up
in documents that are not textbooks. pdf4tcl writes text on a baseline;
superscripts, fractions and roots have to be assembled by hand. The
namespace [math]{.index} in pdf4tcllib does this for two notations: a
small subset of LaTeX and an older eqn-like notation from the Tcler's
Wiki.

This is not formula typesetting as in TeX. For multi-line equations,
matrices or brackets that grow with their content, an external program
(for example KaTeX to SVG, then as an image) is the better route.

---

## The Font

Greek letters, `±`, `∑`, `∞` and `√` are not in any of the standard
fonts. Without a TrueType font in CID mode they become `?`, without an
error message:

```tcl
pdf4tcllib::fonts::init -cid 1
```

---

## The LaTeX Subset

```tcl
set x [pdf4tcllib::math::renderLatex pdf x y formel \
    ?-size n? ?-font name?]
lassign [pdf4tcllib::math::measureLatex pdf formel ?-size n?] \
    breite oben unten
```

[math::renderLatex]{.index} sets the formula with its baseline at `y`
and returns the x position after it. [math::measureLatex]{.index} draws
nothing and returns the width, the height above and the depth below the
baseline.

| Input | Result |
|---|---|
| `x^2`, `a_i`, `x_{i,j}^{2}` | superscript and subscript, `{}` for more than one character |
| `\frac{a}{b}` | fraction with a bar, nested as well |
| `\sqrt{x+1}` | root with a bar above |
| `\sum_{i=1}^{n}`, `\int_0^1`, `\prod` | large operators with limits |
| `\alpha` … `\omega`, `\Gamma` … `\Omega` | Greek letters |
| `\pm \cdot \le \ge \ne \infty` … | symbols |
| `\,` `\;` | a small space |

Not included: `\text`, `\mathrm`, `\left`/`\right`, `\quad`,
environments, matrices. An unknown command is set as text, with its
backslash, and reported on stderr:

```text
pdf4tcllib::math: unknown symbol '\quad' rendered as literal text
```

### Spaces Do Not Count

As in LaTeX, spaces in the input are skipped. Unlike LaTeX, however,
`renderLatex` adds no space around `=` and `+` either: `a = b` becomes
`a=b`, set tightly together. Where room is needed, `\,` goes in:

```tcl
{E \, = \, mc^2}
```

The third displayed formula in the example shows the difference; it is
set without `\,`.

### The Minus Sign

`-b` sets a hyphen, not a minus. It is shorter and sits lower. For a
real minus, write the character U+2212 into the formula yourself, for
example with `[format %c 0x2212]`.

---

## Inline and Displayed

```tcl
# 160-formeln.tcl -- Formeln im Text und abgesetzt
package require pdf4tcl
package require pdf4tcllib

pdf4tcllib::fonts::init -cid 1      ;# Griechisch und Operatoren
set ctx [pdf4tcllib::page::context a4 -margin 20]
set pdf [pdf4tcl::new %AUTO% -paper a4 -orient true]
$pdf startPage
set font [pdf4tcllib::fonts::fontSans]
set x0 [dict get $ctx left]
set y  [expr {[dict get $ctx top] + 20}]

# 1. Eine Formel mitten im Satz: Text, Formel, Text
$pdf setFont 11 $font
$pdf text "Die Energie ist " -x $x0 -y $y
set x [expr {$x0 + [$pdf getStringWidth "Die Energie ist "]}]
set x [pdf4tcllib::math::renderLatex $pdf $x $y {E \, = \, mc^2} \
    -size 11]
$pdf setFont 11 $font       ;# renderLatex verstellt die Schrift
$pdf text ", die Masse also " -x $x -y $y
set x [expr {$x + [$pdf getStringWidth ", die Masse also "]}]
set x [pdf4tcllib::math::renderLatex $pdf $x $y \
    {m \, = \, \frac{E}{c^2}} -size 11]
$pdf setFont 11 $font
$pdf text "." -x $x -y $y

# 2. Abgesetzte Formeln, mittig, mit Abstand nach ihrer Hoehe.
#    \, ist ein kleiner Abstand; Leerzeichen zaehlen nicht.
set w [dict get $ctx text_w]
set y [expr {$y + 30}]
set nr 0
foreach f {
    {x \, = \, \frac{-b \pm \sqrt{b^2 - 4ac}}{2a}}
    {\sum_{i=1}^{n} i \, = \, \frac{n(n+1)}{2}}
    {\alpha + \beta + \gamma = \pi}
} {
    lassign [pdf4tcllib::math::measureLatex $pdf $f -size 14] \
        fb oben unten
    set y [expr {$y + $oben}]
    set xm [expr {$x0 + ($w - $fb) / 2.0}]
    pdf4tcllib::math::renderLatex $pdf $xm $y $f -size 14
    puts [format "Formel %d: Breite %5.1f  oben %4.1f  unten %4.1f" \
        [incr nr] $fb $oben $unten]
    set y [expr {$y + $unten + 16}]
}

# 3. Die eqn-Schreibweise: Zeichen durch Leerzeichen getrennt
set y [expr {$y + 10}]
pdf4tcllib::math::renderFormula $pdf $x0 $y \
    "H _ 2 O ~ + ~ CO _ 2" -size 12
set y [expr {$y + 24}]
pdf4tcllib::math::renderFormula $pdf $x0 $y \
    "SUM from i=0 to infty ~ a _ i x ^ i" -size 12

$pdf endPage
$pdf write -file 160-formeln.pdf
$pdf destroy
```

```text
Formel 1: Breite  95.1  oben 23.4  unten 12.9
Formel 2: Breite  79.6  oben 17.1  unten 14.7
Formel 3: Breite  63.0  oben 10.1  unten  2.8
```

### Inline

Text and formula alternate, and each piece starts where the previous one
ended: for text via `getStringWidth`, for a formula via the return value
of `renderLatex`.

After `renderLatex`, the **font is changed**: the size of the last
superscript character stays set, in the example 7.7 instead of
11 points. That is why each formula is followed by a new `setFont`.

A fraction inside a sentence reaches above and below the line. `m =
E/c²` at 11 points extends 14 points above and 14 points below the
baseline. With the usual line spacing of 1.4, it reaches
into the next line; for fractions
in running text, `a/b` on one line is often the better choice.

`text::writeParagraph` knows nothing about formulas. A paragraph with
formulas is set piece by piece, as in the example, and does not wrap by
itself.

### Displayed

For a formula on a line of its own, `measureLatex` measures first. The
width gives the center, `oben` (above) says how far below the previous
line the baseline must lie, `unten` (below) where the next line may
start. This way the example calculates the spacing of each formula from
its own height.

---

## The eqn Notation

```tcl
set x [pdf4tcllib::math::renderFormula pdf x y formel \
    ?-size n? ?-font name?]
```

[math::renderFormula]{.index} is the older notation, a port of Arjen
Markus' "MathFormula" from the Tcler's Wiki. Each element is separated
by spaces:

| Token | Meaning |
|---|---|
| `^ x` | `x` as superscript |
| `_ x` | `x` as subscript |
| `~` | a space that is kept |
| `SUM`, `INT`, `PROD` | large operators |
| `from a`, `to b` | limits after an operator |
| `alpha`, `infty`, `pm` … | symbols, without a backslash |

`from` and `to` are **always** limits; an arrow is called `rightarrow`.
This notation has no fractions or roots with a bar. The limits above
`SUM` are small and sit very close above the symbol (the `∞` in the
example).

Afterwards, `renderFormula` resets the font to the base size, in the
regular font, even if bold was set before.

For new documents, `renderLatex` is the better choice: it can do more,
and more readers know the notation. The pdf4tcllib documentation says
in the section on `renderFormula` that fractions and roots are not
supported; that applies to `renderFormula` only.

---

## Summary

- Without `fonts::init -cid 1`, formula symbols become `?`.
- `renderLatex` for superscript, subscript, fraction, root, sum;
  `measureLatex` measures beforehand.
- Spaces do not count, spacing with `\,`; minus is a hyphen.
- Set the font again after `renderLatex`.
- Unknown commands are set as text.

---

*Next chapter: [Treeview](170-treeview.md)*
