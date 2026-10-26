# Bilder

## Einführung

pdf4tcl setzt ein Bild mit `putImage` in ein Rechteck. Gibt man Breite
und Höhe an, wird das Bild auf genau diese Fläche gezogen; passt das
Seitenverhältnis nicht, ist es verzerrt, und nichts weist darauf hin.
pdf4tcllib hat zwei Prozeduren, die das vermeiden:
[image::place]{.index} passt ein Bild in einen Rahmen, ohne es zu
verzerren, und [image::gallery]{.index} setzt viele Bilder mit
Unterschriften in ein Raster über mehrere Seiten.

Beide arbeiten mit Bildern, die pdf4tcl mit `addImage` geladen hat (PNG,
JPEG). Tk ist dafür nicht nötig.

---

## Laden

```tcl
set id [$pdf addImage datei.png]
lassign [$pdf getImageSize $id] breite hoehe     ;# in Pixel
```

`addImage` gibt eine Kennung zurück. Das Bild steht danach einmal in der
Datei, auch wenn es auf vielen Seiten erscheint.

Eine Eigenheit von pdf4tcl: **Ein JPEG, das vor dem ersten `startPage`
geladen wird, beginnt selbst eine Seite.** Ein PNG tut das nicht. Wer
danach `startPage` aufruft, hat eine leere erste Seite. Darum im
Beispiel erst die Seite, dann die Bilder.

---

## Ein Bild in einen Rahmen

```tcl
lassign [pdf4tcllib::image::place pdf id x y breite hoehe \
    ?option wert ...?] bx by bb bh
```

| Option | Vorgabe | Bedeutung |
|---|---|---|
| `-fit` | `contain` | `contain`, `cover` oder `stretch` |
| `-anchor` | `center` | `nw n ne w center e sw s se` |
| `-dpi` | – | warnen, wenn die Auflösung darunter liegt |
| `-alt` | – | Ersatztext; das Bild wird ein Element `Figure` |
| `-clip` | `1` | bei `cover` den Überstand abschneiden |

- **`contain`**: Das ganze Bild ist zu sehen, ein Rand des Rahmens bleibt
  frei.
- **`cover`**: Der Rahmen ist ganz gefüllt, was übersteht, wird
  abgeschnitten.
- **`stretch`**: wie `putImage` mit Breite und Höhe, also verzerrt.

`-anchor` sagt bei `contain`, wo das Bild im Rahmen sitzt, und bei
`cover`, welcher Teil erhalten bleibt. Ein Porträt mit dem Kopf oben
will `n`.

Zurück kommt die Fläche, die das Bild wirklich einnimmt: bei `contain`
kleiner als der Rahmen, bei `cover` der Rahmen selbst. Darunter geht es
mit der nächsten Zeile weiter.

Bei `cover` wird nur verdeckt, nicht beschnitten: Das ganze Bild steht
in der Datei. Wer einen kleinen Ausschnitt eines großen Fotos braucht,
schneidet vorher zu.

---

## Das Beispiel

Seite 1 setzt dasselbe Hochformat (400 × 600 Pixel) in drei gleiche
Rahmen von 150 × 120 Punkt und darunter ein zu kleines Bild. Seite 2
und 3 sind eine Galerie mit fünf Bildern, vier je Seite.

```tcl
# 140-bilder.tcl -- Bilder einpassen und als Galerie setzen
package require pdf4tcl
package require pdf4tcllib

pdf4tcllib::fonts::init -cid 1
set ctx [pdf4tcllib::page::context a4 -margin 20]
set pdf [pdf4tcl::new %AUTO% -paper a4 -orient true]

# Bilder einmal laden; addImage gibt eine Kennung zurueck.
# Erst die Seite beginnen: ein JPEG vor startPage beginnt selbst eine.
$pdf startPage
set dir [file join [file dirname [info script]] bilder]
foreach name {hochformat.png querformat.jpg quadrat.png
              panorama.jpg klein.png} {
    set bild($name) [$pdf addImage [file join $dir $name]]
}
puts "hochformat.png: [$pdf getImageSize $bild(hochformat.png)] Pixel"

# Seite 1: dasselbe Hochformat in drei gleich grossen Rahmen
set x [dict get $ctx left]
set y [expr {[dict get $ctx top] + 20}]
$pdf setFont 9 [pdf4tcllib::fonts::fontSans]
foreach fit {contain cover stretch} {
    set r [pdf4tcllib::image::place $pdf $bild(hochformat.png) \
        $x $y 150 120 \
        -fit $fit -anchor n -alt "Beispielbild ($fit)"]
    puts [format "%-8s -> %s" $fit [lmap v $r {format %.0f $v}]]
    $pdf setStrokeColor 0.8 0 0
    $pdf rectangle $x $y 150 120              ;# der Rahmen
    $pdf setStrokeColor 0 0 0
    $pdf text "-fit $fit" -x $x -y [expr {$y + 134}]
    set x [expr {$x + 170}]
}

# Zu wenig Aufloesung: 80 x 60 Pixel auf 160 x 120 Punkt sind 36 dpi
pdf4tcllib::image::place $pdf $bild(klein.png) [dict get $ctx left] \
    [expr {$y + 160}] 160 120 -dpi 150
set w [lindex $::pdf4tcl::warnings end]
puts "Warnung: [string map {" (" "\n  ("} $w]"
$pdf endPage

# Seite 2 und 3: Galerie mit Unterschriften, 2 x 2 je Seite
proc kopf {} {
    global pdf ctx
    pdf4tcllib::page::header $pdf $ctx "Bildergalerie"
}
set liste [list \
    [list $bild(querformat.jpg) "Querformat 900 x 500"] \
    [list $bild(hochformat.png) "Hochformat 400 x 600"] \
    [list $bild(quadrat.png)    "Quadrat"] \
    [list $bild(panorama.jpg) \
        "Panorama 1200 x 300, eine sehr lange Unterschrift"] \
    [list $bild(querformat.jpg) "noch einmal quer"]]
$pdf startPage
kopf
set seiten [pdf4tcllib::image::gallery $pdf $liste \
    [dict get $ctx left] [expr {[dict get $ctx top] + 10}] \
    [dict get $ctx text_w] 500 \
    -cols 2 -rows 2 -gap 12 -anchor s -pagecmd kopf]
$pdf endPage
puts "Galerie: $seiten Seiten"

$pdf write -file 140-bilder.pdf
$pdf destroy
```

```text
hochformat.png: 400 600 Pixel
contain  -> 92 77 80 120
cover    -> 227 77 150 120
stretch  -> 397 77 150 120
Warnung: image::place: image11 at 36 dpi
  (80x60 pixels on 160.0x120.0 points), below 150
Galerie: 2 Seiten
```

Bei `contain` ist das Bild 80 Punkt breit und steht mittig im Rahmen;
links und rechts bleiben je 35 Punkt frei. Bei `cover` füllt es den
Rahmen, mit `-anchor n` bleibt der obere Teil, die Beschriftung „hoch“
am unteren Rand fällt weg. Bei `stretch` ist der Kreis eine Ellipse.

### Auflösung

80 × 60 Pixel auf 160 × 120 Punkt sind 36 dpi; gedruckt ist das
treppig. `-dpi 150` schreibt dann eine Warnung nach
`$::pdf4tcl::warnings`. Sie geht nicht auf den Bildschirm; wer sie sehen
will, gibt die Liste am Ende aus. pdf4tcl warnt selbst schon unter
150 dpi; mit `-dpi` gilt die eigene Schwelle, und die Warnung kommt nur
einmal.

---

## Galerie

```tcl
set seiten [pdf4tcllib::image::gallery pdf bilder x y breite hoehe \
    ?option wert ...?]
```

Jeder Eintrag in `bilder` ist `{id "Unterschrift"}` oder nur `id`. Der
Kasten `x y breite hoehe` wird in `-cols` × `-rows` Zellen geteilt; ist
eine Seite voll, beginnt `gallery` die nächste und setzt dort an
dieselbe Stelle. Zurück kommt die Zahl der Seiten.

| Option | Vorgabe | Bedeutung |
|---|---|---|
| `-cols`, `-rows` | `2`, `3` | Raster je Seite |
| `-gap` | `8` | Abstand zwischen den Zellen |
| `-caption` | `unten` | `unten` oder `keine` |
| `-captionH` | `14` | Höhe des Bandes für die Unterschrift |
| `-fontsize`, `-font` | `8`, Sans | Schrift der Unterschrift |
| `-fit`, `-anchor`, `-dpi` | wie bei `place` | je Bild |
| `-pagecmd` | – | läuft nach jedem neuen `startPage` |

`-caption` erwartet die deutschen Wörter. Jeder andere Wert, auch
`below`, schaltet die Unterschriften stillschweigend ab.

Die Unterschrift steht am unteren Rand der Zelle, das Bild mit
`-anchor center` in der Mitte darüber. Bei einem Querformat in einer
hohen Zelle liegt dazwischen eine Lücke. Mit `-anchor s` steht jedes
Bild direkt auf seiner Unterschrift, wie im Beispiel.

Eine Unterschrift, die breiter als die Zelle ist, wird kleiner gesetzt
(bis 5 Punkt), nicht gekürzt. Bei der Panorama-Unterschrift im Beispiel
ist das zu sehen.

`-pagecmd` läuft im Bereich des Aufrufers. Das erste `startPage` und
seine Kopfzeile macht der Aufrufer selbst, das letzte `endPage` auch.

Ist der Kasten zu klein für das Raster, bricht `gallery` mit
`the frame is too small for 2x3 cells` ab (Zahlen je nach Raster). Bis
pdf4tcllib 0.6.6 kam wegen eines Fehlers in der Meldung stattdessen
`invalid command name "2"`.

---

## Bilder aus Tk

Für ein Bild, das als Tk-`photo` vorliegt (aus einem Canvas, aus einer
Kamera), gibt es `image::insert` und `image::insertAt`. Sie brauchen Tk,
skalieren auf eine Breite und beginnen bei Bedarf eine neue Seite, haben
aber zwölf Argumente. Wenn das Bild auch als Datei vorliegt, ist
`addImage` mit `place` einfacher.

---

## Zusammenfassung

- Bilder mit `addImage` laden, erst nach dem ersten `startPage`.
- `image::place` mit `-fit contain` oder `cover`, nie verzerrt;
  `-anchor` wählt Lage oder Ausschnitt.
- `-dpi` warnt bei zu geringer Auflösung, in `$::pdf4tcl::warnings`.
- `image::gallery` für Raster über mehrere Seiten; `-anchor s` setzt die
  Bilder auf die Unterschrift.

---

*Nächstes Kapitel: [Pfeile und Callouts](150-pfeile-und-callouts.md)*
