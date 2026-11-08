# Zeichenhilfen

## Einführung

Neben Tabellen, Diagrammen und Formularen hat pdf4tcllib eine Reihe
kleiner Helfer, die je eine Sache erledigen: ein Farbverlauf, ein
regelmäßiges Vieleck, ein Stern, gedrehter oder geneigter Text, ein
Exponent. Sie liegen in den Namensräumen [drawing]{.index} und
[text]{.index} und brauchen kein eigenes Paket. Am Ende des Kapitels
stehen die übrigen kleinen Abfragen aus dem Kern, die sonst nirgends im
Buch vorkommen.

Pfeile, Sprechblasen und abgerundete Rechtecke aus demselben Namensraum
stehen im Kapitel [Pfeile und Callouts](150-pfeile-und-callouts.md), das
Wasserzeichen im Kapitel
[Spaltenfluss und Wasserzeichen](070-spaltenfluss-wasserzeichen.md).

---

## Ein Blatt mit allem

```tcl
# 155-zeichenhilfen.tcl -- Verlauf, Formen, gedrehter Text, Exponenten
package require pdf4tcl
package require pdf4tcllib

pdf4tcllib::fonts::init -cid 1
set ctx [pdf4tcllib::page::context a4 -margin 20]
set sans [pdf4tcllib::fonts::fontSans]
set pdf [pdf4tcl::new %AUTO% -paper a4 -orient true]
$pdf startPage
set x [dict get $ctx left]
set y [dict get $ctx top]
set w [dict get $ctx text_w]

# Ein Band mit Farbverlauf als Kopf, darauf weisser Text
pdf4tcllib::drawing::gradient_h $pdf $x $y $w 40 {0.10 0.25 0.45} {0.55 0.75 0.90} 60
$pdf setFillColor 1 1 1
$pdf setFont 18 $sans
$pdf text "Gärtnerei Beispiel" -x [expr {$x + 12}] -y [expr {$y + 27}]
$pdf setFillColor 0 0 0
puts "Mitte des Verlaufs: [pdf4tcllib::drawing::interpolate {0 0 0} {1 0.5 0} 0.5]"

# Formen: Sechseck, Stern, Rahmen, Trennlinie
set y [expr {$y + 90}]
$pdf setFillColor 0.85 0.92 0.80
pdf4tcllib::drawing::polygon $pdf [expr {$x + 40}] $y 30 6 1 1
$pdf setFillColor 0.98 0.80 0.30
pdf4tcllib::drawing::star $pdf [expr {$x + 120}] $y 32 5 0.45 1 1
pdf4tcllib::drawing::star $pdf [expr {$x + 200}] $y 32 8 0.7
$pdf setFillColor 0 0 0
pdf4tcllib::drawing::frame $pdf [expr {$x + 250}] [expr {$y - 30}] 120 60 2
pdf4tcllib::drawing::separator $pdf $x [expr {$y + 50}] $w

# Text gedreht, gestreckt, geneigt
set y [expr {$y + 120}]
pdf4tcllib::drawing::textRotated $pdf "um 30 Grad" $x $y 30 12
pdf4tcllib::drawing::textScaled  $pdf "breit" [expr {$x + 130}] $y 2.0 1.0 12
pdf4tcllib::drawing::textScaled  $pdf "hoch"  [expr {$x + 260}] $y 1.0 2.0 12
pdf4tcllib::drawing::textSkewed  $pdf "geneigt" [expr {$x + 340}] $y 0 20 12

# Hoch- und tiefgestellt: beide geben ihre Breite zurueck
set y [expr {$y + 50}]
$pdf setFont 12 $sans
$pdf text "Fläche 113 cm" -x $x -y $y
set x2 [expr {$x + [pdf4tcllib::text::width "Fläche 113 cm" 12 $sans $pdf]}]
set x2 [expr {$x2 + [pdf4tcllib::text::superscript $pdf 2 $x2 $y 12 $sans]}]
$pdf text ", Wasser H" -x $x2 -y $y
set x3 [expr {$x2 + [pdf4tcllib::text::width ", Wasser H" 12 $sans $pdf]}]
set x3 [expr {$x3 + [pdf4tcllib::text::subscript $pdf 2 $x3 $y 12 $sans]}]
$pdf text "O" -x $x3 -y $y
# Zeichen nach Namen
set m [lmap n {alpha le infty deg} {pdf4tcllib::text::mathSymbol $n}]
$pdf text "Symbole: [join $m {  }]" -x $x -y [expr {$y + 20}]
puts "Symbole: $m"
puts "Namen bekannt: [llength [pdf4tcllib::text::mathSymbolNames]]"
puts "unbekannt: \"[pdf4tcllib::text::mathSymbol aleph]\""
$pdf endPage

# Kleine Helfer ohne Seite
puts "Tabs: \"[pdf4tcllib::text::expandTabs "a\tbc\td" 4]\""
foreach z [list "    set x 1" "Menge: 12 Stück" {puts $wert}] {
    puts [format "%-18s -> %s" $z [pdf4tcllib::text::detectFont $z]]
}

$pdf write -file 155-zeichenhilfen.pdf
$pdf destroy
```

```text
Mitte des Verlaufs: 0.5 0.25 0.0
Symbole: α ≤ ∞ °
Namen bekannt: 69
unbekannt: ""
Tabs: "a   bc  d"
    set x 1        -> Pdf4tclMono
Menge: 12 Stück    -> Pdf4tclSans
puts $wert         -> Pdf4tclMono
```

Auf der Seite stehen ein Kopfband mit Verlauf von Dunkel- nach Hellblau,
ein grünes Sechseck, ein gelber und ein leerer Stern, ein Rahmen, eine
graue Linie, viermal verformter Text und eine Zeile mit cm², H₂O und den
vier Zeichen.

---

## Farbverläufe

```tcl
pdf4tcllib::drawing::gradient_h pdf x y w h farbe1 farbe2 ?schritte?
pdf4tcllib::drawing::gradient_v pdf x y w h farbe1 farbe2 ?schritte?
```

[drawing::gradient_h]{.index} läuft von links nach rechts,
[drawing::gradient_v]{.index} von oben nach unten. Farben sind
`{r g b}` mit Werten von 0 bis 1. Ein PDF-Verlauf ist das nicht: Die
Fläche wird in `schritte` Streifen (Vorgabe 100) geteilt, jeder in seiner
Farbe gefüllt. Im Beispiel reichen 60 auf 482 Punkt Breite; Streifen von
8 Punkt sieht man nicht.

Im barrierefreien PDF ist der Verlauf ein Artefakt, also Schmuck. Text
darauf zeichnet man danach, wie im Beispiel; die Füllfarbe muss man dafür
selbst setzen und wieder zurücksetzen.

[drawing::interpolate]{.index} ist die Rechnung dahinter: die Farbe an
der Stelle `t` zwischen 0 und 1. Das Beispiel fragt nach der Mitte
zwischen Schwarz und Orange.

---

## Formen

```tcl
pdf4tcllib::drawing::polygon pdf cx cy radius ecken ?rand? ?füllen?
pdf4tcllib::drawing::star    pdf cx cy radius ?zacken? ?verhältnis? ?rand? ?füllen?
pdf4tcllib::drawing::frame     pdf x y w h ?linienbreite?
pdf4tcllib::drawing::separator pdf x y w ?farbe? ?linienbreite?
```

[drawing::polygon]{.index} zeichnet ein regelmäßiges Vieleck um den
Mittelpunkt `cx cy`; `radius` ist der Abstand zu den Ecken, die erste
Ecke zeigt nach oben. [drawing::star]{.index} hat `zacken` Spitzen
(Vorgabe 5); `verhältnis` ist der innere Radius im Verhältnis zum
äußeren, 0,5 als Vorgabe. Der achtzackige Stern im Beispiel hat 0,7 und
wirkt darum stumpf. `rand` und `füllen` sind 0 oder 1, die Farben die
aktuellen von `setStrokeColor` und `setFillColor`.

[drawing::frame]{.index} ist ein Rechteck nur mit Rand, in der
angegebenen Linienbreite. [drawing::separator]{.index} ist eine
waagrechte Linie, hellgrau und 0,5 Punkt breit, wenn nichts anderes
angegeben ist; danach steht die Linienfarbe wieder auf Schwarz.

Beide setzen die Linienbreite und lassen sie so stehen. Wer danach
andere Linien will, setzt sie mit `setLineWidth` neu.

---

## Text verformen

```tcl
pdf4tcllib::drawing::textRotated pdf text x y winkel größe ?schrift?
pdf4tcllib::drawing::textScaled  pdf text x y sx sy größe ?schrift?
pdf4tcllib::drawing::textSkewed  pdf text x y neigungX neigungY größe ?schrift?
```

Ohne `schrift` nehmen alle drei die Schrift aus `fonts::init`.

- [drawing::textRotated]{.index} dreht um `winkel` Grad gegen den
  Uhrzeigersinn, um den Anfang der Grundlinie.
- [drawing::textScaled]{.index} streckt um `sx` waagrecht und `sy`
  senkrecht. Breite und Höhe ändern sich, die Schriftgröße bleibt.
- [drawing::textSkewed]{.index} neigt: `neigungX` kippt die
  Grundlinie, `neigungY` lehnt die Zeichen schräg, wie eine Kursive. Es
  sind `-xangle` und `-yangle` von `$pdf text`. Im Beispiel ist es
  `0 20`.

Die Breite eines verformten Textes misst `text::width` nicht mit; sie
gilt für die unverformte Zeile.

---

## Hoch, tief und Zeichen nach Namen

```tcl
set breite [pdf4tcllib::text::superscript pdf text x y größe schrift]
set breite [pdf4tcllib::text::subscript   pdf text x y größe schrift]
```

[text::superscript]{.index} und [text::subscript]{.index} setzen
den Text in 70 % der Größe, um 35 % der Größe höher oder um 20 % tiefer
als die Grundlinie `y`. Sie geben die Breite zurück, damit der nächste
Text dahinter anschließt, und stellen danach die Größe zurück. Für mehr
als einen Exponenten ist `math::renderLatex` der bequemere Weg (Kapitel
[Formeln](160-formeln.md)).

[text::mathSymbol]{.index} gibt zu einem Namen wie in LaTeX das
Zeichen zurück: `alpha` α, `le` ≤, `infty` ∞, `deg` °. Ein unbekannter
Name gibt einen leeren String. `text::mathSymbolNames` listet die
69 Namen: griechische Buchstaben, Operatoren, Pfeile, Mengenzeichen.
Die Zeichen brauchen eine Schrift, die sie hat, also `fonts::init`.

---

## Kleine Helfer

Das Ende des Beispiels läuft ohne Seite:

- [text::expandTabs]{.index} ersetzt Tabulatoren durch Leerzeichen bis
  zur nächsten Spalte, die ein Vielfaches von 4 ist (oder des zweiten
  Arguments). PDF kennt keine Tabulatoren.
- [text::detectFont]{.index} rät, ob eine Zeile Code ist, und gibt die
  dicktengleiche oder die normale Schrift aus `fonts::` zurück. Code ist
  eine Zeile mit Tabulator, mit vier Leerzeichen am Anfang, mit `|` am
  Anfang oder mit `$name`, `::`, `->` oder `{…}` darin.

Dazu kommen Abfragen, die im Beispiel nicht vorkommen:

| Befehl | gibt zurück |
|---|---|
| `fonts::ready` | 1, wenn `fonts::init` gelaufen ist |
| `fonts::isMonospace name` | 1 für die dicktengleiche Schrift und Courier |
| `fonts::widthFactor name` | mittlere Zeichenbreite je Punkt Schriftgröße, 0,52 wenn unbekannt |
| `fonts::subset`, `fonts::inSubset cp` | die 256 Codepunkte des 256-Zeichen-Modus; ob ein Codepunkt dazugehört |
| `unicode::preprocessBytes daten` | rohe UTF-8-Bytes mit Emoji durch ASCII ersetzt, vor `encoding convertfrom` (Tcl 8.6 kennt keine Zeichen über U+FFFF) |
| `tag::isActive pdf` | 1, wenn das Dokument mit `$pdf tagged 1` angelegt ist |
| `tag::depth pdf` | wie viele Strukturelemente gerade offen sind |
| `tag::forget pdf` | vergisst die zwischengespeicherte Antwort zu einem Dokument |
| `table::breakPoints zeilen ?-fontsize -rowheight -header -groups?` | Zeilenhöhen und die Zeilen, vor denen nicht umbrochen werden soll, für einen eigenen Umbruch |
| `form::fieldHeight`, `form::rowHeight` | die eingestellte Feld- und Zeilenhöhe von `form::` |
| `math::pdfBackend pdf`, `math::canvasBackend canvas` | ein Ziel für Formeln: PDF oder Tk-Canvas |
| `math::renderLatexOn ziel x y formel`, `math::measureLatexOn ziel formel` | eine Formel auf diesem Ziel setzen oder messen |

Die `…On`-Befehle sind derselbe Formelsatz wie `math::renderLatex`, nur
mit wählbarem Ziel. Mit `math::canvasBackend` erscheint eine Formel auf
einem Tk-Canvas genau so, wie sie im PDF stünde.

---

## Zusammenfassung

- Verläufe sind Streifen; `gradient_h` und `gradient_v` zeichnen sie als
  Artefakt.
- `polygon` und `star` um einen Mittelpunkt, `frame` und `separator` für
  Rahmen und Linien.
- `textRotated`, `textScaled`, `textSkewed` verformen Text; geneigt wie
  kursiv ist `0 winkel`.
- `superscript` und `subscript` geben ihre Breite zurück;
  `mathSymbol` liefert Zeichen nach Namen.

---

*Nächstes Kapitel: [Formeln](160-formeln.md)*
