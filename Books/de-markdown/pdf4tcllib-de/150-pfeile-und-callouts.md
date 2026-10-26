# Pfeile und Callouts

## Einführung

Ein Ablaufschema, ein beschrifteter Plan, ein Hinweis neben einer
Tabelle: Dafür braucht man Kästen, Pfeile zwischen ihnen und
gelegentlich eine Sprechblase, die auf etwas zeigt. pdf4tcl hat Linien,
Rechtecke und Vielecke; die Rechnung, in welche Richtung eine
Pfeilspitze zeigt und wo die Linie davor aufhören muss, macht der
Namensraum [drawing]{.index} in pdf4tcllib.

---

## Die Prozeduren

Vier Prozeduren: [drawing::arrow]{.index}, [drawing::arrowHead]{.index},
[drawing::callout]{.index} und [drawing::roundedRect]{.index}.

| Prozedur | zeichnet |
|---|---|
| drawing::arrow `pdf x1 y1 x2 y2 ?option ...?` | eine Linie mit Spitze |
| drawing::arrowHead `pdf x y winkel ?option ...?` | nur die Spitze, an einem Punkt |
| drawing::callout `pdf x y b h zielX zielY text ?option ...?` | einen Kasten mit Zeiger und Text |
| drawing::roundedRect `pdf x y b h r ?rand? ?füllen?` | ein Rechteck mit runden Ecken |

Farbe und Linienstärke sind die, die gerade eingestellt sind; keine der
Prozeduren ändert sie (außer `callout`, siehe unten).

---

## Ein Ablaufschema

Drei Kästen in einer Reihe, ein vierter darunter, gerade und geknickte
Pfeile und zwei Sprechblasen.

```tcl
# 150-pfeile.tcl -- ein Ablaufschema mit Pfeilen und einer Sprechblase
package require pdf4tcl
package require pdf4tcllib

pdf4tcllib::fonts::init -cid 1
set ctx [pdf4tcllib::page::context a4 -margin 20]
set pdf [pdf4tcl::new %AUTO% -paper a4 -orient true]
$pdf startPage

# Ein Kasten mit runden Ecken und Text in der Mitte
proc kasten {x y w h text} {
    global pdf
    $pdf setFillColor 0.88 0.92 0.97
    pdf4tcllib::drawing::roundedRect $pdf $x $y $w $h 6 1 1
    $pdf setFillColor 0 0 0
    $pdf setFont 11 [pdf4tcllib::fonts::fontSansBold]
    $pdf text $text -align center \
        -x [expr {$x + $w / 2.0}] -y [expr {$y + $h / 2.0 + 4}]
}

set top [expr {[dict get $ctx top] + 120}]
set links [dict get $ctx left]
set b 110; set h 40; set abst 50
foreach name {Auftrag Lager Versand} {
    kasten $links $top $b $h $name
    set rechts($name) [expr {$links + $b}]
    set mitte($name)  [expr {$links + $b / 2.0}]
    set links [expr {$links + $b + $abst}]
}
set unten [expr {$top + 110}]
kasten [expr {$mitte(Lager) - $b / 2.0}] $unten $b $h "Rücksendung"

# Gerade Pfeile: von Kante zu Kante, die Spitze endet genau am Kasten
set my [expr {$top + $h / 2.0}]
$pdf setLineWidth 1.2
foreach k {Auftrag Lager} {
    pdf4tcllib::drawing::arrow $pdf \
        $rechts($k) $my [expr {$rechts($k) + $abst}] $my
}

# Geknickt, Versand -> Ruecksendung: Linie selbst ziehen, die
# Spitze mit arrowHead; sie zeigt nach links (Winkel pi)
set yr [expr {$unten + $h / 2.0}]
set xr [expr {$mitte(Lager) + $b / 2.0}]          ;# rechte Kante
$pdf setStrokeColor 0.7 0 0
$pdf setFillColor 0.7 0 0
$pdf line $mitte(Versand) [expr {$top + $h}] $mitte(Versand) $yr
$pdf line $mitte(Versand) $yr [expr {$xr + 8}] $yr
pdf4tcllib::drawing::arrowHead $pdf $xr $yr [expr {acos(-1)}]
# Beidseitig, nur umrissen: Lager <-> Ruecksendung
pdf4tcllib::drawing::arrow $pdf $mitte(Lager) [expr {$top + $h}] \
    $mitte(Lager) $unten -at both -filled 0
$pdf setStrokeColor 0 0 0
$pdf setFillColor 0 0 0

# Sprechblase ueber dem Lager, Zeiger auf die obere Kante
set n [pdf4tcllib::drawing::callout $pdf [expr {$mitte(Lager) + 20}] \
    [expr {$top - 95}] 170 50 $mitte(Lager) $top \
    "Der Bestand wird jeden Morgen um 6 Uhr mit der Buchhaltung\
     abgeglichen." \
    -fill {1 0.97 0.8} -radius 6]
puts "Sprechblase: $n Zeilen"

# Zu viel Text fuer den Kasten: wird kleiner, nicht gekuerzt
set n [pdf4tcllib::drawing::callout $pdf \
    [dict get $ctx left] [expr {$top - 95}] 120 40 \
    $mitte(Auftrag) $top \
    "Aufträge vor 14 Uhr gehen am selben Tag raus, alle anderen am\
     nächsten Werktag." \
    -fill {0.93 0.93 0.93}]
puts "Kleine Blase: $n Zeilen"

$pdf endPage
$pdf write -file 150-pfeile.pdf
$pdf destroy
```

```text
Sprechblase: 2 Zeilen
Kleine Blase: 3 Zeilen
```

### Gerade Pfeile

`arrow` zieht die Linie von `x1 y1` nach `x2 y2` und setzt die Spitze an
das Ende. Die Spitze **endet** genau am Zielpunkt, und die Linie hört
eine Spitzenlänge davor auf. Läge die Linie bis zum Ende, ragte sie
durch die gefüllte Spitze und hinterließe einen Strich in ihrer Mitte.
Für Pfeile zwischen Kästen heißt das: von Kante zu Kante rechnen, nicht
von Mitte zu Mitte.

| Option | Vorgabe | Bedeutung |
|---|---|---|
| `-at` | `end` | `end`, `start` oder `both` |
| `-length` | `8` | Länge der Spitze |
| `-width` | `6` | Breite der Spitze |
| `-filled` | `1` | `0`: Spitze nur umrissen |

Unbekannte Optionen und ein falscher Wert für `-at` sind Fehler.

### Geknickte Pfeile

`arrow` zeichnet nur gerade Linien. Für eine Verbindung um die Ecke
zieht man die Linien selbst und setzt die Spitze mit `arrowHead` an das
Ende. Der Winkel ist im Bogenmaß, 0 zeigt nach rechts, π nach links.
Mit y nach unten zeigt π/2 nach **unten**.

Auch hier muss die letzte Linie vor der Spitze aufhören, im Beispiel
8 Punkt (die Vorgabe für `-length`) vor dem Kasten. Für eine schräge
letzte Strecke gibt `atan2(dy, dx)` den Winkel.

---

## Sprechblasen

`callout` zeichnet einen Kasten mit runden Ecken, einen dreieckigen
Zeiger zum Punkt `zielX zielY` und den Text darin, umbrochen auf die
Breite. Auf welcher Seite der Zeiger sitzt, ergibt sich aus der Lage des
Ziels: liegt es über dem Kasten, oben; darunter, unten; sonst links oder
rechts. Zurück kommt die Zahl der Textzeilen.

| Option | Vorgabe | Bedeutung |
|---|---|---|
| `-fill` | – | Füllfarbe `{r g b}`; ohne nur der Umriss |
| `-stroke` | `1` | Umriss zeichnen |
| `-radius` | `4` | Eckenradius |
| `-tail` | `12` | Breite des Zeigers am Kasten |
| `-pad` | `5` | Innenabstand |
| `-fontsize`, `-font` | `9`, Sans | Schrift |
| `-alt` | – | Ersatztext; das Ganze wird ein Element `Figure` |

Passt der Text nicht in die Höhe, wird er kleiner gesetzt, in Schritten
von 1 Punkt bis 5 Punkt. Gekürzt wird nicht: In der kleinen Blase links
steht der ganze Satz, in drei Zeilen zu 7 Punkt statt 9. Ob das noch lesbar
ist, entscheidet der Aufrufer; die Zahl der Zeilen im Ergebnis ist ein
Anhaltspunkt, die Schriftgröße bekommt man nicht zurück.

`callout` setzt die Füllfarbe für den Text auf Schwarz und lässt sie so
stehen.

Zeiger und Kasten sind zwei Formen, jede mit eigenem Umriss. Am Ansatz
des Zeigers bleibt darum eine Linie stehen; die Blase ist dort nicht
offen wie in einem Comic. Wer das nicht will, nimmt `-stroke 0` und eine
kräftigere Füllfarbe.

---

## Runde Ecken

```tcl
# Radius 6, mit Umriss, gefüllt
pdf4tcllib::drawing::roundedRect $pdf $x $y $b $h 6 1 1
```

Die Ecken sind aus je acht geraden Stücken zusammengesetzt, nicht aus
Kurven. Bei kleinen Radien sieht man das nicht, bei einem Radius von
30 Punkt in starker Vergrößerung schon.

Die Option `-clip 1` soll laut Dokumentation einen Beschneidungspfad mit
runden Ecken setzen, etwa für ein Foto mit runden Ecken. Sie beschneidet
aber auf das **eckige** Rechteck. Für runde Ecken um ein Bild gibt es in
pdf4tcllib keinen Weg.

---

## Barrierefrei

Pfeile, Spitzen, Kästen und Zeiger sind im barrierefreien PDF
Zierrat (Artefakte); ein Vorleseprogramm überspringt sie. Der Text einer
Sprechblase ist Inhalt und steht als Absatz im Strukturbaum. Ein
Schaubild als Ganzes braucht einen Ersatztext, sonst bleibt von ihm nur
eine Folge von Wörtern ohne Pfeile; mehr dazu in Teil 5.

---

## Zusammenfassung

- `drawing::arrow` von Kante zu Kante; die Linie endet vor der Spitze.
- Geknickte Pfeile: Linien selbst, Spitze mit `arrowHead`, Winkel im
  Bogenmaß.
- `drawing::callout` wählt die Seite des Zeigers selbst und verkleinert
  zu langen Text.
- `roundedRect -clip` beschneidet eckig.

---

*Nächstes Kapitel: [Formeln](160-formeln.md)*
