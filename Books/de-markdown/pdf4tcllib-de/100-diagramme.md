# Diagramme

## Einführung

Zu vielen Berichten gehört ein Bild der Zahlen: Umsatz je Monat als
Balken, zwei Jahre als Linien, Anteile als Torte. Das Paket
[pdf4tclchart]{.index} zeichnet diese drei Formen direkt mit pdf4tcl,
ohne Tk und ohne ein Bild zu erzeugen. Es ist keine Bibliothek für
wissenschaftliche Diagramme: keine logarithmischen Achsen, keine
Fehlerbalken, keine zweite y-Achse.

---

## Daten und Kasten

Jede der drei Prozeduren bekommt einen Kasten und die Daten:

```tcl
package require pdf4tclchart
set y [pdf4tcllib::chart::bar  pdf x y breite hoehe daten ?opt ...?]
set y [pdf4tcllib::chart::line pdf x y breite hoehe daten ?opt ...?]
set y [pdf4tcllib::chart::pie  pdf x y breite hoehe daten ?opt ...?]
```

`x y` ist die linke obere Ecke (y nach unten), Breite und Höhe in Punkt.
Zurück kommt die y-Position unter dem Diagramm, so dass Diagramme sich
wie Absätze untereinander stapeln.

Die Daten sind Paare aus Beschriftung und Zahl, flach oder als Liste von
Paaren:

```tcl
{Jan 120 Feb 145 Mär 98}
{{Jan 120} {Feb 145} {Mär 98}}
```

Ein Wert, der keine Zahl ist, ergibt einen Fehler, der die Beschriftung
nennt. Leere Werte sind hier also nicht erlaubt, anders als in
`table::pivot`.

---

## Drei Diagramme auf einer Seite

```tcl
# 100-diagramme.tcl -- Balken, Linien und Torte auf einer Seite
package require pdf4tcl
package require pdf4tcllib
package require pdf4tclchart

pdf4tcllib::fonts::init -cid 1
set ctx [pdf4tcllib::page::context a4 -margin 20]
set pdf [pdf4tcl::new %AUTO% -paper a4 -orient true]
$pdf startPage

set x [dict get $ctx left]
set w [dict get $ctx text_w]
set y [expr {[dict get $ctx top] + 10}]

# Balken: Paare aus Beschriftung und Wert
set y [pdf4tcllib::chart::bar $pdf $x $y $w 180 \
    {Jan 120 Feb 145 Mär 98 Apr 160 Mai -20 Jun 132} \
    -title "Ergebnis je Monat (Tsd. €)" -values 1 -format %.0f]

# Linien: mehrere Reihen, je {Name {Paare}}
set reihen {
    {2025 {Q1 100 Q2 130 Q3 120 Q4 175}}
    {2026 {Q1 140 Q2 120 Q3 165 Q4 190}}
}
set oben [expr {$y + 20}]
set y [pdf4tcllib::chart::line $pdf $x $oben [expr {$w - 80}] 170 \
    $reihen -title "Umsatz je Quartal"]
# Die Linien haben keine eigene Legende; die Reihen selbst beschriften
pdf4tcllib::chart::legend $pdf \
    [expr {$x + $w - 70}] [expr {$oben + 30}] \
    {{2025 0} {2026 0}} [pdf4tcllib::chart::configure]

# Torte mit Legende und Anteilen
set y [pdf4tcllib::chart::pie $pdf $x [expr {$y + 20}] $w 170 \
    {Wartung 42 Neugeräte 31 Ersatzteile 18 Schulung 9} \
    -title "Umsatz nach Bereich" -legend 1]

puts "Skala für 137: [pdf4tcllib::chart::niceScale 0 137]"
puts "unten bei y = [format %.1f $y]"
$pdf endPage
$pdf write -file 100-diagramme.pdf
$pdf destroy
```

```text
Skala für 137: 0.0 150.0 50.0
unten bei y = 626.7
```

### Balken

Ein Balken je Paar, jeder in einer anderen Farbe. Negative Werte stehen
unter der Nulllinie, die Skala reicht dann ins Negative (im Beispiel
Mai mit −20). `-values 1` schreibt den Wert über jeden Balken, im Format
aus `-format`.

### Linien

Eine Reihe oder mehrere. Mehrere Reihen sind eine Liste aus
`{Name {Paare}}`; die Beschriftungen der x-Achse kommen aus der ersten
Reihe, die anderen werden an denselben Stellen gezeichnet. Jeder
Datenpunkt bekommt einen Punkt.

Die Namen der Reihen (`2025`, `2026`) zeichnet `line` nicht, und eine
Legende hat es nicht. Ohne Legende weiß der Leser nicht, welche Linie
welches Jahr ist. Das Beispiel macht darum das Diagramm schmaler und
zeichnet daneben eine Legende mit [chart::legend]{.index}, in denselben
Farben:

```tcl
pdf4tcllib::chart::legend $pdf $x $y {{2025 0} {2026 0}} \
    [pdf4tcllib::chart::configure]
```

Das vierte Argument sind die Paare, das fünfte die Optionen (für Größe
und Farben); `chart::configure` ohne Argumente liefert die Vorgaben.

### Torte

Die Stücke laufen im Uhrzeigersinn ab zwölf Uhr, die Anteile rechnet
`pie` aus der Summe. Mit `-legend 1` steht rechts eine Legende mit
Prozentangaben, und der Kreis wird entsprechend kleiner. Negative Werte
oder eine Summe von 0 sind ein Fehler.

---

## Optionen

| Option | Vorgabe | Bedeutung |
|---|---|---|
| `-title` | – | Überschrift über dem Diagramm |
| `-titlesize`, `-labelsize`, `-valuesize` | `11`, `8`, `8` | Schriftgrößen |
| `-values` | `0` | Werte an die Balken schreiben |
| `-format` | `%g` | Format jeder Zahl, auch an der Achse |
| `-colors` | sechs Farben | Liste von Farben, der Reihe nach |
| `-color` | – | eine Farbe für alles |
| `-grid` | `4` | Zahl der Gitterlinien; `0` für keine |
| `-min`, `-max` | aus den Daten | Skala festlegen |
| `-legend` | `0` | nur `pie` |
| `-alt` | `-title` | Ersatztext im barrierefreien PDF |

Die sechs Farben der Vorgabe unterscheiden sich auch in der Helligkeit,
nicht nur im Farbton. Ein Diagramm, das grau gedruckt oder kopiert
wird, bleibt so lesbar. Wer eigene Farben wählt, sollte das
beibehalten.

### Die Skala

Die Achse endet nicht beim größten Wert, sondern bei einer runden Zahl:
[chart::niceScale]{.index} macht aus 137 die Skala 0 bis 150 in Schritten
von 50. Eine Gitterlinie bei 137 hilft niemandem, der den Wert ablesen
will. Für zwei Diagramme, die man vergleichen soll, beiden dieselbe Skala
mit `-min` und `-max` geben; sonst sieht ein kleiner Wert im einen so
groß aus wie ein großer im anderen.

### Zahlen mit Komma

`-format` geht an Tcls `format` und kennt kein Dezimalkomma. `%.0f` und
`%d` sind darum für deutsche Berichte die sichere Wahl; Nachkommastellen
erscheinen mit Punkt.

---

## Barrierefrei

In einem barrierefreien PDF (Teil 5) ist jedes Diagramm ein Element
`Figure` mit dem Ersatztext aus `-alt` oder dem Titel. Balken, Linien und
Beschriftungen sind der Inhalt dieses Elements, und der Ersatztext steht
für sie. Ein Vorleseprogramm sagt also „Abbildung: Ergebnis je Monat“
und nicht die einzelnen Zahlen. Sind die Zahlen
wichtig, gehören sie zusätzlich in eine Tabelle.

---

## Zusammenfassung

- `chart::bar`, `chart::line`, `chart::pie` mit Kasten und Paaren; jede
  gibt die y-Position darunter zurück.
- Mehrere Linien brauchen eine eigene Legende über `chart::legend`.
- Skala mit `-min`/`-max` festlegen, wenn Diagramme verglichen werden.
- `-format` ohne Dezimalkomma.

---

*Nächstes Kapitel: [Inhaltsverzeichnis](110-inhaltsverzeichnis.md)*
