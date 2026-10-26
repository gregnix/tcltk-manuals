# Unicode sicher ausgeben

## Einführung

Ein Zeichen, das die Schrift nicht hat, verschwindet im PDF: Es steht
als „?“ da, als leerer Kasten oder gar nicht. Dass es fehlt, merkt man
erst beim Lesen. pdf4tcllib fängt das an einer Stelle ab, in
[unicode::sanitize]{.index}, und zählt mit, was es ersetzen musste.

Dieses Kapitel zeigt, was `sanitize` mit einer Zeile macht, welche
Prozeduren es aufrufen und welche nicht, und woran man erkennt, dass
Zeichen verloren gegangen sind.

---

## Was sanitize tut

```tcl
pdf4tcllib::unicode::sanitize text ?-mono 0|1? ?-tabwidth n?
```

`sanitize` gibt den Text zurück, so wie die geladene Schrift ihn zeigen
kann. Es arbeitet in zwei Stufen:

1. **Bekannte Zeichen ersetzen.** Eine feste Tabelle setzt Zeichen, die
   oft in Texten stehen, auf etwas Darstellbares um: ✅ → ✓, ⚠ → (!),
   ➡ → →, ™ → (TM). Ohne TrueType ersetzt sie mehr: → wird `->`,
   € wird `EUR`, ✓ wird `(OK)`, Rahmenlinien werden `+`, `-` und `|`.
2. **Jedes übrige Zeichen prüfen.** Was die Schrift im jeweiligen Modus
   nicht hat, wird „?“. Unsichtbare Zeichen (Null-Breite-Leerzeichen,
   Variantenwähler, BOM) fallen ganz weg, Tabulatoren werden Leerzeichen
   (`-tabwidth`, Vorgabe 4).

Welche Zeichen die Schrift „hat“, hängt vom Modus aus `fonts::init` ab
(Kapitel [Einrichten und Schriften](020-einrichten-und-schriften.md)):

- ohne TrueType: druckbares ASCII und Latin-1,
- TrueType mit 256 Zeichen: die feste Auswahl aus `fonts::subset`,
- TrueType im CID-Modus: jedes Zeichen, für das die Schrift eine Glyphe
  hat.

Dieselbe Zeile in beiden TrueType-Modi:

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

Die erste Zeile ist normaler Text, die zweite `-mono 1`. Im CID-Modus
bleibt auch das Griechische und die Summe; nur das Kanji fehlt, weil
DejaVu keine chinesischen Zeichen hat. Der Zähler läuft über beide
Aufrufe, darum steht beim 256-Zeichen-Modus 8: je vier Zeichen pro
Zeile.

### Festbreitenschrift: -mono 1

`-mono 1` ist für Code und Tabellen in Festbreitenschrift. Lädt
`fonts::init` keine TrueType-Festbreitenschrift, ist das Courier, und
Courier kennt nur Latin-1; dann gilt die große Ersetzungstabelle wie
ohne TrueType (→ wird `->`). Im CID-Modus mit DejaVu Sans Mono bleibt
Unicode erhalten und wird gegen diese Schrift geprüft. Im
256-Zeichen-Modus ersetzt `-mono 1` immer nach der großen Tabelle, auch
wenn DejaVu Sans Mono geladen ist.

---

## Wer sanitize aufruft

| Prozedur | ruft `sanitize` auf |
|---|---|
| `unicode::safeText` | ja |
| `page::header`, `page::footer`, `page::number`, `page::centerText` | ja, über `safeText` |
| `text::writeParagraph` | **nein**, es ruft `$pdf drawTextBox` direkt |
| `$pdf text`, `$pdf drawTextBox` (pdf4tcl) | nein |

Was nicht durch `sanitize` geht, ersetzt pdf4tcl selbst, wenn die
Schrift ein Zeichen nicht kodieren kann. Auch dann steht „?“ im PDF.
Gezählt wird es an anderer Stelle: in `$pdf getSubstCount`.

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

256-Zeichen-Modus:

```text
pdf4tcllib ersetzt: 1
pdf4tcl ersetzt:    6

pdf4tcl direkt:  ?Zitat?, alpha ?, Pfeil →
safeText:        "Zitat", alpha ?, Pfeil →
writeParagraph:  ?Zitat?, alpha ?, Pfeil →
```

CID-Modus:

```text
pdf4tcllib ersetzt: 0
pdf4tcl ersetzt:    0

pdf4tcl direkt:  „Zitat“, alpha α, Pfeil →
safeText:        "Zitat", alpha α, Pfeil →
writeParagraph:  „Zitat“, alpha α, Pfeil →
```

Zwei Dinge fallen auf:

- Im 256-Zeichen-Modus fehlen die Zeichen auf allen drei Wegen. Nur
  der Zähler unterscheidet sich: `safeText` zählt bei pdf4tcllib, die
  beiden anderen Wege bei pdf4tcl.
- `safeText` macht aus „Zitat“ immer "Zitat", auch im CID-Modus, wo die
  Schrift „ und “ hat. Die erste Stufe von `sanitize` ersetzt die
  typografischen Anführungszeichen („ “ ” ‚ ‘ ’) in jedem Modus durch
  gerade.

### Deutsche Anführungszeichen

Für deutsche Texte heißt das: CID-Modus, und Text mit „…“ nicht über
`safeText` ausgeben, sondern über `text::writeParagraph` oder
`$pdf text`. Beide lassen die Zeichen stehen. Im 256-Zeichen-Modus gibt
es keinen Weg zu „…“; dort bleiben nur gerade Anführungszeichen oder
» « (die sind in Latin-1).

Die Kopf- und Fußzeilen aus `page::header` und `page::footer` gehen über
`safeText`; ein „Titel“ darin verliert seine Anführungszeichen auch im
CID-Modus.

---

## Die Schrift beim Zeichnen ist nicht die, nach der sanitize fragt

`sanitize` richtet sich nach dem, was `fonts::init` geladen hat, nicht
nach der Schrift, die gerade mit `setFont` gesetzt ist. Wer nach
`fonts::init` für einen Absatz Helvetica setzt, bekommt Zeichen
durchgereicht, die Helvetica nicht kennt:

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

Unter Tcl 8.6 bleiben beide Zähler bei 0, und trotzdem fehlen im
zweiten Satz zwei Zeichen. Unter Tcl 9 meldet wenigstens pdf4tcl sie
(`pdf4tcl ersetzt: 2`). Nach `fonts::init` also nur noch die Schriften aus
`fonts::fontSans` und den anderen Zugriffsprozeduren setzen. Wer Courier
oder Helvetica wirklich braucht, gibt den Text mit `-mono 1` aus; dann
gilt die große Ersetzungstabelle, und aus → wird `->` statt „?“.

---

## Emoji

Zeichen oberhalb von U+FFFF, also die meisten Emoji, ersetzt `sanitize`
durch eine Umschrift aus ASCII: 😀 wird `:-)`, 👍 wird `(+1)`, 🔒 wird
`[L]`. Unbekannte Emoji werden `(?)`. Diese Umschrift zählt nicht als
Verlust und erscheint nicht in `substReport`.

```text
$ tclsh 030-emoji.tcl
Tcl 8.6, direkt gelesen: Gruss :-) und (+1)
Tcl 8.6, mit readFile:   Gruss :-) und (+1)
```

Tcl 8.6.14 und Tcl 9.0 lesen die Emoji aus einer UTF-8-Datei richtig
ein. [unicode::readFile]{.index} liest die Datei binär und setzt die
Umschrift ein, bevor Tcl die Bytes umwandelt; das ist für ältere
8.6-Fassungen gedacht, die solche Zeichen beim Lesen zu U+FFFD machen.
Ein U+FFFD im Text wird `(?)`, das ursprüngliche Zeichen ist dann nicht
mehr zu erkennen.

---

## Wissen, was gefehlt hat

`sanitize` zählt jedes Zeichen, das es durch „?“ ersetzt, und merkt sich
bis zu zwölf verschiedene davon:

```tcl
pdf4tcllib::unicode::substCount   ;# 8
pdf4tcllib::unicode::substReport  ;# count 8 chars {U+03B1 U+2211 ...}
pdf4tcllib::unicode::resetSubst
```

Beim ersten Mal schreibt es zusätzlich eine Warnung nach stderr:

```text
pdf4tcllib::unicode: sanitize: at least one character is missing from the
font and was replaced with '?' (first: U+03B1). Ask
::pdf4tcllib::unicode::substReport for the list, or load a font that has
it -- fonts::init -cid 1 for Greek and mathematical symbols.
```

Für ein Programm, das PDFs ohne Aufsicht erzeugt, gehören beide Zähler
an das Ende jedes Dokuments:

```tcl
set verloren [expr {[pdf4tcllib::unicode::substCount]
                    + [$pdf getSubstCount]}]
if {$verloren} {
    puts stderr "Warnung: $verloren Zeichen ersetzt\
        ([dict get [pdf4tcllib::unicode::substReport] chars])"
}
```

`substCount` zählt über alle Dokumente des Prozesses; vor jedem neuen
Dokument `resetSubst` aufrufen. `$pdf getSubstCount` gilt für das eine
pdf4tcl-Objekt. Den Fall aus dem vorigen Abschnitt (Helvetica nach
`fonts::init`) meldet unter Tcl 8.6 keiner der beiden.

---

## Zusammenfassung

- Text mit Sonderzeichen über `unicode::safeText` ausgeben, Absätze über
  `text::writeParagraph`, beides mit Schriften aus den
  Zugriffsprozeduren.
- Für Griechisch, Mathematik und deutsche Anführungszeichen
  `fonts::init -cid 1`.
- `safeText` ersetzt „ “ immer durch "; für „…“ `writeParagraph` oder
  `$pdf text` nehmen.
- Am Ende `unicode::substCount` und `$pdf getSubstCount` prüfen.

---

*Nächstes Kapitel: [Einheiten und Seitenkontext](040-einheiten-und-seitenkontext.md)*
