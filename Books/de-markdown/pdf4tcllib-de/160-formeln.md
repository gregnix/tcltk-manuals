# Formeln

## Einführung

Ein Prüfbericht mit einer Toleranzformel, ein Datenblatt mit einer
Kennlinie, eine Rechnung mit Hochzahlen: Formeln kommen auch in
Dokumenten vor, die kein Lehrbuch sind. pdf4tcl schreibt Text auf eine
Grundlinie; hochgestellte Zeichen, Brüche und Wurzeln muss man selbst
zusammensetzen. Der Namensraum [math]{.index} in pdf4tcllib tut das für
zwei Schreibweisen: eine kleine Teilmenge von LaTeX und eine ältere
eqn-artige Schreibweise aus dem Tcler's Wiki.

Es ist kein Formelsatz wie in TeX. Für mehrzeilige Gleichungen, Matrizen
oder Klammern, die mit dem Inhalt wachsen, ist ein externes Programm
(etwa KaTeX nach SVG, dann als Bild) der bessere Weg.

---

## Die Schrift

Griechische Buchstaben, `±`, `∑`, `∞` und `√` stehen in keiner der
Standardschriften. Ohne TrueType-Schrift im CID-Modus werden sie zu `?`,
ohne Fehlermeldung:

```tcl
pdf4tcllib::fonts::init -cid 1
```

---

## Die LaTeX-Teilmenge

```tcl
set x [pdf4tcllib::math::renderLatex pdf x y formel \
    ?-size n? ?-font name?]
lassign [pdf4tcllib::math::measureLatex pdf formel ?-size n?] \
    breite oben unten
```

[math::renderLatex]{.index} setzt die Formel mit der Grundlinie auf `y`
und gibt die x-Position dahinter zurück. [math::measureLatex]{.index}
zeichnet nichts und gibt Breite, Höhe über und Tiefe unter der
Grundlinie zurück.

| Eingabe | Ergebnis |
|---|---|
| `x^2`, `a_i`, `x_{i,j}^{2}` | hoch- und tiefgestellt, `{}` für mehr als ein Zeichen |
| `\frac{a}{b}` | Bruch mit Strich, auch geschachtelt |
| `\sqrt{x+1}` | Wurzel mit Strich darüber |
| `\sum_{i=1}^{n}`, `\int_0^1`, `\prod` | große Operatoren mit Grenzen |
| `\alpha` … `\omega`, `\Gamma` … `\Omega` | griechische Buchstaben |
| `\pm \cdot \le \ge \ne \infty` … | Zeichen |
| `\,` `\;` | ein kleiner Abstand |

Nicht dabei: `\text`, `\mathrm`, `\left`/`\right`, `\quad`, Umgebungen,
Matrizen. Ein unbekannter Befehl wird als Text gesetzt, mit Backslash,
und nach stderr gemeldet:

```text
pdf4tcllib::math: unknown symbol '\quad' rendered as literal text
```

### Leerzeichen zählen nicht

Wie in LaTeX werden Leerzeichen in der Eingabe überlesen. Anders als
LaTeX setzt `renderLatex` aber auch keinen Abstand um `=` und `+`: Aus
`a = b` wird `a=b`, eng aneinander. Wo Luft nötig ist, gehört `\,`
hinein:

```tcl
{E \, = \, mc^2}
```

Die dritte abgesetzte Formel im Beispiel zeigt den Unterschied, sie ist
ohne `\,` gesetzt.

### Das Minuszeichen

`-b` setzt einen Bindestrich, kein Minus. Er ist kürzer und steht
tiefer. Wer ein echtes Minus will, schreibt das Zeichen U+2212 selbst
in die Formel, etwa mit `[format %c 0x2212]`.

---

## Im Satz und abgesetzt

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

### Im Satz

Text und Formel wechseln sich ab, und jedes Stück beginnt dort, wo das
vorige aufgehört hat: beim Text über `getStringWidth`, bei der Formel
über den Rückgabewert von `renderLatex`.

Nach `renderLatex` ist die **Schrift verstellt**: Es bleibt die
Größe des letzten hochgestellten Zeichens eingestellt, im Beispiel 7,7
statt 11 Punkt. Darum steht nach jeder Formel ein neues `setFont`.

Ein Bruch im Satz ragt nach oben und unten über die Zeile hinaus. `m =
E/c²` reicht bei 11 Punkt 14 Punkt über und 14 Punkt unter die Grundlinie. Mit dem
üblichen Zeilenabstand von 1,4 ragt er
in die nächste Zeile hinein; für Brüche
im Fließtext ist `a/b` in einer Zeile oft die bessere Wahl.

`text::writeParagraph` kennt keine Formeln. Ein Absatz mit Formeln wird
Stück für Stück gesetzt, wie im Beispiel, und umbricht nicht von selbst.

### Abgesetzt

Für eine Formel in eigener Zeile misst `measureLatex` vorher. Die Breite
gibt die Mitte, `oben` sagt, wie weit die Grundlinie unter der vorigen
Zeile liegen muss, `unten`, wo die nächste beginnen darf. Das Beispiel
rechnet so den Abstand jeder Formel nach ihrer eigenen Höhe.

---

## Die eqn-Schreibweise

```tcl
set x [pdf4tcllib::math::renderFormula pdf x y formel \
    ?-size n? ?-font name?]
```

[math::renderFormula]{.index} ist die ältere Schreibweise, ein Port von
Arjen Markus' „MathFormula“ aus dem Tcler's Wiki. Jedes Element ist
durch Leerzeichen getrennt:

| Zeichen | Bedeutung |
|---|---|
| `^ x` | `x` hochgestellt |
| `_ x` | `x` tiefgestellt |
| `~` | ein Leerzeichen, das stehen bleibt |
| `SUM`, `INT`, `PROD` | große Operatoren |
| `from a`, `to b` | Grenzen nach einem Operator |
| `alpha`, `infty`, `pm` … | Zeichen, ohne Backslash |

`from` und `to` sind **immer** Grenzen; ein Pfeil heißt `rightarrow`.
Brüche und Wurzeln mit Strich kennt diese Schreibweise nicht. Die
Grenzen über `SUM` sind klein und stehen sehr dicht über dem Zeichen
(im Beispiel das `∞`).

`renderFormula` stellt danach die Schrift auf die Grundgröße zurück, in
der normalen Schrift, auch wenn vorher fett eingestellt war.

Für neue Dokumente ist `renderLatex` die bessere Wahl: Es kann mehr, und
die Schreibweise kennen mehr Leser. Die Dokumentation von pdf4tcllib
sagt im Abschnitt über `renderFormula`, Brüche und Wurzeln gingen
nicht; das gilt nur für `renderFormula`.

---

## Zusammenfassung

- Ohne `fonts::init -cid 1` werden Formelzeichen zu `?`.
- `renderLatex` für Hoch, Tief, Bruch, Wurzel, Summe; `measureLatex`
  misst vorher.
- Leerzeichen zählen nicht, Abstände mit `\,`; Minus ist ein
  Bindestrich.
- Nach `renderLatex` die Schrift neu setzen.
- Unbekannte Befehle werden als Text gesetzt.

---

*Nächstes Kapitel: [Treeview](170-treeview.md)*
