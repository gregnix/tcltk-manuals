# Etikettenbögen

## Einführung

Adressetiketten, Regalschilder, Versandaufkleber: Ein Bogen mit 24
Etiketten ist eine Seite mit 24 Rechtecken, deren Lage auf den
Zehntelmillimeter stimmen muss. Das Paket [pdf4tcllabels]{.index} kennt
die Maße gängiger Bögen, verteilt die Datensätze auf die Positionen und
beginnt neue Bögen. Was auf einem Etikett steht, schreibt der Aufrufer
einmal, als Skript.

---

## Die Bögen

| Name | Raster | je Bogen | Etikett (mm) | Rand l/o (mm) |
|---|---|---|---|---|
| `3427` | 2 × 2 | 4 | 105,0 × 148,0 | 0 / 0 |
| `3474` | 3 × 8 | 24 | 70,0 × 37,0 | 0 / 0 |
| `3475` | 3 × 7 | 21 | 70,0 × 42,3 | 0 / 0,45 |
| `3483` | 3 × 5 | 15 | 70,0 × 50,8 | 0 / 21,5 |
| `4737` | 3 × 9 | 27 | 63,5 × 29,6 | 7,25 / 13,0 |

Alle auf A4. 3427 ist ein A6-Versandetikett, 4737 der einzige Bogen mit
Zwischenräumen zwischen den Etiketten.

[labels::sheet]{.index} gibt die Maße eines Bogens als Dict zurück, in
Punkt zum Rechnen und in Millimetern zum Vergleich mit der Packung:

```tcl
set geo [pdf4tcllib::labels::sheet 3474]
dict get $geo cols            ;# 3
dict get $geo w               ;# 198.425... (Punkt)
dict get $geo wmm             ;# 70.0
```

Ein eigener Bogen kommt mit `labels::define` dazu, in Millimetern:

```tcl
pdf4tcllib::labels::define regal {
    w 48.5 h 25.4 cols 4 rows 10 left 8.0 top 21.5
    pitchx 50.0 pitchy 25.4 desc "Regalschilder aus dem Schrank"
}
```

`pitchx` und `pitchy` sind der Abstand von Etikett zu Etikett, nicht die
Lücke. Bei Bögen ohne Zwischenraum sind sie gleich der Etikettgröße.

---

## Adressen auf zwei Bögen

Dreißig Adressen, der Bogen ist schon angebrochen: Die ersten zwei
Etiketten fehlen.

```tcl
# 130-etiketten.tcl -- Adressetiketten auf Bogen 3474 (3 x 8)
package require pdf4tcl
package require pdf4tcllib
package require pdf4tcllabels

pdf4tcllib::fonts::init -cid 1

set adressen {}
set lang "Gebrüder Hoffmann-Schwarzenbach Metallbau GmbH & Co. KG"
for {set i 1} {$i <= 30} {incr i} {
    lappend adressen [dict create \
        name    [expr {$i == 5 ? $lang : "Firma Beispiel $i"}] \
        strasse "Industriestraße $i" \
        ort     "[expr {10000 + $i}] Musterstadt"]
}

set geo [pdf4tcllib::labels::sheet 3474]
puts "Bogen 3474: [dict get $geo cols] x [dict get $geo rows],\
    [dict get $geo wmm] x [dict get $geo hmm] mm"

set pdf [pdf4tcl::new %AUTO% -paper a4 -orient true]
set bogen [pdf4tcllib::labels::render $pdf 3474 $adressen {x y w h a} {
    set font [pdf4tcllib::fonts::fontSans]
    set fett [pdf4tcllib::fonts::fontSansBold]
    set breit [expr {$w - 16}]
    set name [dict get $a name]
    # Name: kleiner setzen, bis 8 pt; reicht das nicht, zwei Zeilen
    set g [pdf4tcllib::labels::fitSize $pdf $fett $name $breit 11 8]
    $pdf setFont $g $fett
    if {[$pdf getStringWidth $name] <= $breit} {
        set zeilen [list $name]
    } else {
        set zeilen [pdf4tcllib::labels::wrap $pdf $name $breit]
        set zeilen [lrange $zeilen 0 1]
    }
    set ty [expr {$y + 26 - 5 * ([llength $zeilen] - 1)}]
    foreach z $zeilen {
        $pdf text $z -x [expr {$x + 8}] -y $ty
        set ty [expr {$ty + $g + 1}]
    }
    $pdf setFont 10 $font
    set tx [expr {$x + 8}]
    $pdf text [dict get $a strasse] -x $tx -y [expr {$y + 46}]
    $pdf text [dict get $a ort]     -x $tx -y [expr {$y + 60}]
} -start 2 -clip 1 -frame layer]
puts "Bögen: $bogen"
$pdf write -file 130-etiketten.pdf
$pdf destroy
```

```text
Bogen 3474: 3 x 8, 70.0 x 37.0 mm
Bögen: 2
```

Auf dem ersten Bogen bleiben die Positionen 1 und 2 leer, die Adressen 1
bis 22 füllen den Rest, die übrigen acht stehen auf dem zweiten Bogen.

### render

```tcl
set boegen [pdf4tcllib::labels::render pdf bogen datensätze \
    {x y w h satz} skript ?option wert ...?]
```

[labels::render]{.index} öffnet und schließt die Seiten selbst; ein
`startPage` davor ist falsch. Für jeden Datensatz läuft das Skript im
Bereich des Aufrufers, mit den fünf Variablen aus der Liste: linke obere
Ecke, Breite und Höhe in Punkt, und der Datensatz, so wie er in der
Liste steht. Zurück kommt die Zahl der Bögen.

| Option | Vorgabe | Bedeutung |
|---|---|---|
| `-start N` | `0` | die ersten N Positionen frei lassen |
| `-only {i j ...}` | – | genau diese Positionen benutzen, für Nachdrucke |
| `-offsetx`, `-offsety` | `0.0` | Druckerversatz in Millimetern |
| `-clip` | `0` | `1`: nichts über den Rand des Etiketts hinaus zeichnen |
| `-frame` | `0` | `1`: Umrisse fest drucken, `layer`: Umrisse als abschaltbare Ebene |
| `-tag` | `Sect` | Strukturelement je Etikett im barrierefreien PDF |

Unbekannte Optionen sind ein Fehler.

`-start` gilt nur für den ersten Bogen. Wie viele Etiketten schon fehlen,
weiß nur, wer den Bogen in der Hand hat; ein Programm, das danach fragt,
spart einen halben Bogen je Druck.

### Umrisse zum Prüfen

`-frame 1` zeichnet die Umrisse jedes Etiketts in die Seite, unter den
Inhalt. Das ist ein Probedruck auf Papier, nicht für die Etiketten
selbst. `-frame layer` legt die Umrisse in eine Ebene „Label grid“, über
den Inhalt; der Betrachter kann sie abschalten, gedruckt wird sie nicht.
So sieht man am Bildschirm, ob alles im Etikett liegt, und druckt
dieselbe Datei. `-frame layer` verlangt pdf4tcl 0.9.4.70 oder neuer und
geht nicht mit PDF/A.

---

## Text, der zu lang ist

Ein Etikett ist schmal: 70 mm sind bei 11 Punkt etwa 35 Zeichen. Ein
langer Firmenname läuft sonst über den Rand auf das Nachbaretikett. Das
Paket hat drei Hilfen, [labels::fitSize]{.index}, `labels::wrap` und
`labels::ellipsize`, alle mit echter Breitenmessung:

| Prozedur | tut |
|---|---|
| labels::fitSize `pdf schrift text maxB größe ?min?` | verkleinert in Schritten von 0,5 pt, nicht unter `min` (Vorgabe 6) |
| `labels::wrap pdf text maxB` | bricht an Leerzeichen in Zeilen um, mit der aktuellen Schrift |
| `labels::ellipsize pdf text maxB ?ende?` | kürzt und hängt `…` an |

Das Beispiel geht zweistufig vor: erst verkleinern bis 8 Punkt; passt der
Name dann immer noch nicht, zwei Zeilen. Etikett 5 („Gebrüder
Hoffmann-Schwarzenbach Metallbau GmbH & Co. KG“) steht so in zwei
Zeilen zu 8 Punkt.

`fitSize` hört bei `min` auf, auch wenn der Text dann noch nicht passt.
Das Ergebnis muss man darum nachmessen, wie im Beispiel mit
`getStringWidth`. `wrap` misst mit der Schrift, die gerade eingestellt
ist; vorher `setFont`.

`ellipsize` ist für Bemerkungen und Referenzen. Eine gekürzte Straße ist
keine Adresse.

`text::fitSize` aus Kapitel [Text setzen](050-text-setzen.md) tut
dasselbe wie `labels::fitSize`, aber mit anderer Reihenfolge der
Argumente und in ganzen Punkten. Beide nicht verwechseln.

### -clip als Sicherung

`-clip 1` schneidet alles ab, was über den Rand des Etiketts reicht. Das
ersetzt nicht das Anpassen, denn der Rest des Namens fehlt dann einfach.
Es verhindert aber, dass ein vergessener Fall den Nachbarn beschriftet.

---

## Den Drucker vermessen

Kaum ein Drucker setzt auf den Millimeter genau. Ein bis zwei Millimeter
Versatz sind üblich, und auf einem Bogen ohne Rand wie 3474 rutscht die
erste Zeile damit halb vom Etikett.

```tcl
set pdf [pdf4tcl::new %AUTO% -paper a4 -orient true]
pdf4tcllib::labels::calibration $pdf 3474
$pdf write -file kalibrierung.pdf
```

`calibration` schreibt einen Bogen mit Millimeterskala an den Rändern
und den Umrissen aller Etiketten. Ausdrucken, auf einen echten Bogen
legen, gegen das Licht halten, Versatz ablesen. Die zwei Zahlen gehen
von da an als `-offsetx` und `-offsety` an `render`, einmal je Drucker.

Gedruckt wird in **tatsächlicher Größe**. „An Seite anpassen“ verkleinert
um ein paar Prozent: in der ersten Zeile unsichtbar, in der letzten
mehrere Millimeter.

---

## Zusammenfassung

- `labels::render` mit Bogenname, Datensätzen und einem Skript je
  Etikett; es macht die Seiten selbst.
- `-start` für angebrochene Bögen, `-only` für Nachdrucke.
- Lange Namen mit `fitSize` und `wrap` anpassen, `-clip 1` als
  Sicherung.
- Den Drucker einmal mit `calibration` vermessen und den Versatz
  angeben.

---

*Nächstes Kapitel: [Bilder](140-bilder.md)*
