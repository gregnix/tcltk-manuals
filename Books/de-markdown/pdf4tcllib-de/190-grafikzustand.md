# Grafikzustand sichern

## Einführung

Jeder Baustein stellt Schrift und Farben so ein, wie er sie braucht, und
lässt sie danach so stehen. Wer vor einer Tabelle 20 Punkt fett rot
eingestellt hat, schreibt danach in 9 Punkt normal schwarz weiter, ohne
es bemerkt zu haben. In kurzen Skripten fällt das sofort auf; in einem
Bericht aus vielen Prozeduren sucht man den Grund lange.

[state::with]{.index} hält den Zustand über einen Block fest und stellt
ihn danach wieder her.

---

## Was verloren geht

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

pdf4tcl kann nicht sagen, welche Schrift gerade eingestellt ist; es gibt
`setFont`, aber kein `getFont`. Das Beispiel misst darum die Breite des
Wortes „Probe“: 59,5 Punkt in 20 Punkt fett, 22,9 Punkt in der Schrift,
mit der `table::draw` zuletzt geschrieben hat. Im PDF steht die erste
Zeile „Nachher“ klein und schwarz, die zweite groß und rot.

---

## state::with

```tcl
set ergebnis [pdf4tcllib::state::with pdf {größe schrift} {r g b} \
    skript]
```

Das Skript läuft im Bereich des Aufrufers. Danach sind Schrift und
Füllfarbe wieder die angegebenen, auch wenn das Skript einen Fehler
wirft. Zurück kommt, was das Skript zurückgibt; im Beispiel das `y` der
Tabelle.

Weil pdf4tcl den Zustand nicht herausgibt, muss man ihn **selbst
angeben**. `state::with` stellt wieder her, was man ihm sagt, nicht was
vorher eingestellt war. Wer `{20 Helvetica}` angibt, während in
Wirklichkeit 11 Punkt Sans eingestellt war, bekommt danach 20 Punkt
Helvetica.

Was man weglässt (ein leeres `{}` statt Schrift oder Farbe), wird nicht
angefasst. Zeilenabstand und Unterschneidung fragt `state` bei pdf4tcl
selbst ab und stellt sie mit her.

### Von Hand

```tcl
set z [pdf4tcllib::state::save $pdf 20 $fett {0.8 0 0}]
pdf4tcllib::table::draw $pdf ...
pdf4tcllib::state::restore $pdf $z
```

`save` nimmt als fünftes Argument noch die Strichfarbe. Es gibt ein Dict
zurück, das `restore` wieder einsetzt. Ein Fehler zwischen den beiden
Aufrufen lässt den Zustand verstellt; `with` ist darum meist die bessere
Wahl.

---

## Warum nicht gsave und grestore

PDF hat ein eigenes Paar zum Sichern des Zustands, `q` und `Q`, in
pdf4tcl `gsave` und `grestore`. Innerhalb einer Seite ist es das
richtige Werkzeug, etwa um einen Beschneidungspfad wieder aufzuheben.
Über einen Seitenwechsel hinweg geht es nicht: Jede Seite hat ihren
eigenen Datenstrom, ein `gsave` auf Seite 1 und das `grestore` auf
Seite 2 ergeben zwei unausgeglichene Ströme. Weder pdf4tcl noch qpdf
melden das. Eine Tabelle mit `-ctx` bricht aber genau so um.

Innerhalb einer Seite stellt `grestore` auch die Schrift wieder her,
die pdf4tcl sich zum Messen merkt: Nach `gsave`, `setFont 9` und
`grestore` misst „Probe“ wieder 59,5 Punkt.

---

## Zusammenfassung

- Bausteine hinterlassen ihre Schrift und Farbe.
- `state::with pdf {größe schrift} {r g b} skript` stellt sie danach
  wieder her, auch bei einem Fehler.
- Den Zustand selbst angeben; pdf4tcl kann ihn nicht liefern.
- `gsave`/`grestore` nur innerhalb einer Seite.

---

*Nächstes Kapitel: [Messen und stapeln](200-messen-und-stapeln.md)*
