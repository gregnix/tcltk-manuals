# Canvas

## Einführung

Ein Schaubild, das ein Tk-Programm auf einem `canvas` zeichnet, gehört oft
auch in den Bericht. Zeichnen kann pdf4tcl das selbst: `$pdf canvas`
überträgt Rechtecke, Linien, Ovale, Polygone und Text, auch aus `tkpath`
und `tko::path`. Was dabei von Hand zu tun bleibt, ist das Drumherum: den
Maßstab ausrechnen, die Zeichnung in ihrem Rahmen ausrichten, die
Bildunterschrift setzen und das Ganze in den Strukturbaum eines
barrierefreien PDFs stellen. Das übernimmt [pdf4tclcanvas]{.index}.

---

## Ein Ablauf

```tcl
# 176-canvas.tcl -- eine Canvas-Zeichnung im Rahmen, mit Massstab
package require Tk
package require pdf4tcl
package require pdf4tcllib
package require pdf4tclcanvas

pdf4tcllib::fonts::init -cid 1
set ctx [pdf4tcllib::page::context a4 -margin 20]

# Die Zeichnung: drei Schritte eines Ablaufs, 420 x 120 Pixel
font create kasten -family Helvetica -size 11
canvas .c -width 440 -height 140 -bg white
foreach {i text farbe} {0 Bestellung #dbe8f6  1 Lieferschein #e3f2dc
                        2 Rechnung #fbe7cf} {
    set x [expr {20 + $i * 150}]
    .c create rectangle $x 30 [expr {$x + 110}] 90 -fill $farbe -outline #555555
    .c create text [expr {$x + 55}] 60 -text $text -font kasten
    if {$i < 2} {
        .c create line [expr {$x + 110}] 60 [expr {$x + 150}] 60 -arrow last
    }
}
pack .c
update idletasks

set pdf [pdf4tcl::new %AUTO% -paper a4 -orient true]
$pdf tagged 1
$pdf startPage
set x [dict get $ctx left]
set y [dict get $ctx top]
# Text im Canvas in der TrueType-Schrift, damit Umlaute ankommen
set map [list kasten [pdf4tcllib::fonts::fontSans]]

# Ein Rahmen 300 x 70 mit Unterschrift: die Zeichnung behaelt ihr
# Verhaeltnis, die Unterschrift steht unten im Rahmen
set r1 [pdf4tcllib::canvas::place $pdf .c $x $y 300 70 -border 1 \
    -fontmap $map -alt "Ablauf: Bestellung, Lieferschein, Rechnung" \
    -caption "Abb. 1: Vom Auftrag zur Rechnung"]
puts "Rahmen 300 x 70:  [lmap v $r1 {format %.1f $v}]"

# Ein schmaler, hoher Rahmen: die Breite bestimmt den Massstab
pdf4tcllib::tag::artifact $pdf                 ;# der Rahmen selbst, grau
$pdf setStrokeColor 0.6 0.6 0.6
$pdf rectangle $x [expr {$y + 100}] 150 150
$pdf setStrokeColor 0 0 0
pdf4tcllib::tag::artifactEnd $pdf
set r2 [pdf4tcllib::canvas::place $pdf .c $x [expr {$y + 100}] 150 150 \
    -border 1 -anchor center -fontmap $map]
puts "Rahmen 150 x 150: [lmap v $r2 {format %.1f $v}]"
$pdf endPage

# Seite 2: dieselbe Zeichnung auf die ganze Seite, oben ausgerichtet
$pdf startPage
set r3 [pdf4tcllib::canvas::fitPage $pdf .c $ctx -anchor n -fontmap $map \
    -alt "Ablauf, gross"]
puts "fitPage:          [lmap v $r3 {format %.1f $v}]"
$pdf endPage
puts "ohne Struktur: [$pdf getUntaggedCount]"

$pdf write -file 176-canvas.pdf
$pdf destroy
exit                        ;# sonst wartet Tk auf Ereignisse
```

```text
Rahmen 300 x 70:  56.7 62.1 300.0 45.1
Rahmen 150 x 150: 56.7 220.4 150.0 22.6
fitPage:          56.7 56.7 481.9 72.5
ohne Struktur: 0
```

Auf Seite 1 steht der Ablauf zweimal: einmal 300 Punkt breit mit
Unterschrift, einmal in einem quadratischen Rahmen von 150 Punkt, dort
nur 22,6 Punkt hoch und mittig. Auf Seite 2 füllt er die Breite des
Satzspiegels.

---

## place

```tcl
set flaeche [pdf4tcllib::canvas::place pdf canvas x y w h ?option wert ...?]
```

[canvas::place]{.index} setzt die Zeichnung in den Rahmen `x y w h` und
gibt die Fläche zurück, die sie wirklich belegt, als `{x y w h}`, ohne
das Band der Unterschrift. Mit dieser Fläche rechnet man weiter: Im
Beispiel ist die erste Zeichnung 45,1 Punkt hoch, nicht 70.

**Der Maßstab.** Die Zeichnung ist so groß wie `$c bbox all`, also die
Fläche, die ihre Elemente belegen, nicht die Größe des Widgets. Im
Beispiel sind das 420 × 60 Pixel, nicht 440 × 140. Wer den weißen Rand
des Widgets mitnehmen will, gibt `-bbox {0 0 440 140}` an. Der Maßstab
ist der kleinere der beiden Faktoren Breite/Breite und Höhe/Höhe; im
Rahmen 300 × 56 (70 minus 14 für die Unterschrift) ist es die Breite.
Ein Canvas ohne Elemente ist kein Fehler; dann gilt die Größe des Widgets.

**Die Ausrichtung.** Was in der anderen Richtung frei bleibt, verteilt
`-anchor`: `nw`, `n`, `ne`, `w`, `center` (Vorgabe), `e`, `sw`, `s`, `se`.

**Die Schrift.** Text auf dem Canvas übersetzt `$pdf canvas` nach seiner
Tk-Schrift. `-fontmap` ordnet einer Tk-Schrift eine PDF-Schrift zu; im
Beispiel bekommt die benannte Schrift `kasten` die TrueType-Schrift aus
`fonts::init`. Ohne Zuordnung sucht pdf4tcl eine PDF-Schrift, die unter
dem Tk-Familiennamen angemeldet ist, wie im Kapitel
[Text-Widget](174-text-widget.md), sonst nimmt es eine der
Standardschriften. Die kennen nur Latin-1; was darüber hinausgeht, wird
ohne Fehlermeldung zu „?“. Text wird mit der Zeichnung verkleinert; im
schmalen Rahmen ist er kaum noch zu lesen. `-textscale` reicht einen
eigenen Faktor an `$pdf canvas` durch.

**`-fit stretch`** gibt den Rahmen unverändert an `$pdf canvas` weiter.
Verzerrt wird dabei nicht: `$pdf canvas` hält das Verhältnis selbst und
setzt die Zeichnung oben links in den Rahmen. Verloren gehen nur die
Ausrichtung und die genaue Fläche: `-border` umrahmt dann den ganzen
Rahmen, und der Rückgabewert ist der Rahmen.

| Option | Vorgabe | Bedeutung |
|---|---|---|
| `-fit` | `contain` | `stretch`: Rahmen unverändert an `$pdf canvas` |
| `-anchor` | `center` | Lage im Rahmen |
| `-alt` | – | Beschreibung; macht die Zeichnung zur `Figure` |
| `-caption` | – | Unterschrift unten im Rahmen |
| `-captionH` | `14` | Höhe des Bandes für die Unterschrift |
| `-fontsize`, `-font` | `9`, aus `fonts::init` | Schrift der Unterschrift |
| `-bbox` | `bbox all` | eigener Ausschnitt in Canvas-Koordinaten |
| `-fontmap`, `-textscale` | – | an `$pdf canvas` durchgereicht |
| `-border` | `0` | Linie um die Zeichnung |

### Die Unterschrift

Die Unterschrift steht unten im Rahmen, mittig über die ganze Breite
`w`, nicht direkt unter der Zeichnung. Darum hat der erste Rahmen im
Beispiel 70 Punkt Höhe: 56 für die Zeichnung, 14 für die Zeile darunter.
Ein Rahmen, der viel höher ist als die Zeichnung, lässt eine Lücke; dann
hilft `-anchor s`.

Ist die Unterschrift zu breit, wird sie kleiner gesetzt statt gekürzt,
bis 5 Punkt, mit `text::fitSize` (Kapitel
[Text setzen](050-text-setzen.md)).

### Im Strukturbaum

`$pdf canvas` allein hinterlässt Zeichenbefehle außerhalb des
Strukturbaums. `place` fasst sie ein:

- mit `-alt` als `Figure` mit dieser Beschreibung,
- ohne `-alt`, aber mit `-caption`, als `Figure`, die Unterschrift als
  Beschreibung,
- ohne beides als Artefakt, also als Schmuck, den ein Vorleseprogramm
  übergeht.

Die Unterschrift steht als `Caption` innerhalb der `Figure`.
`getUntaggedCount` ist am Ende 0. Der graue Rahmen im Beispiel ist mit
`tag::artifact` gefasst; ohne das wäre es 1 (Kapitel
[Barrierefreie PDFs](180-barrierefreie-pdfs.md)).

---

## fitPage

```tcl
set flaeche [pdf4tcllib::canvas::fitPage pdf canvas ctx ?option wert ...?]
```

[canvas::fitPage]{.index} ist `place` mit dem Satzspiegel aus dem
Seitenkontext als Rahmen, `SX SY SW SH`. Es nimmt dieselben Optionen. Ein
breiter Ablauf wird so breit wie der Satzspiegel; `-anchor n` setzt ihn
oben hin statt in die Mitte der Seite.

---

## Was nicht geht

- `place` fügt keine Elementtypen hinzu; was ankommt, entscheidet
  `$pdf canvas`. Ein eingebettetes Fenster (`create window`) überträgt es
  nur als Bildschirmfoto, wenn das Paket Img da ist und das Fenster auf
  dem Bildschirm steht, sonst als schwarzes Rechteck.
- `-orient true` ist Pflicht, wie überall in pdf4tcllib.
- Eine Zeichnung, die höher ist als die Seite, wird nicht auf mehrere
  Seiten verteilt, sondern verkleinert.

---

## Zusammenfassung

- `canvas::place` setzt einen Canvas in einen Rahmen, im Verhältnis, und
  gibt die belegte Fläche zurück.
- Gemessen wird `bbox all`; `-bbox` für einen anderen Ausschnitt.
- `-fontmap` für Umlaute und Euro im Canvas-Text.
- `-alt` oder `-caption` machen eine `Figure`, sonst ein Artefakt.
- `canvas::fitPage` für eine Zeichnung über den Satzspiegel.

---

*Nächstes Kapitel: [Treeview](170-treeview.md)*
