# Einheiten und Seitenkontext

## Einführung

pdf4tcl rechnet in Punkt (1/72 Zoll), Formulare und Briefvorlagen sind
in Millimetern bemaßt. Und jede Zeichenoperation braucht dieselben
Zahlen: wo der Satzspiegel links beginnt, wie breit er ist, wo unten
Schluss ist. [page::context]{.index} rechnet diese Zahlen einmal aus und
gibt sie als Dict zurück. Alle Bausteine aus pdf4tcllib, die auf der
Seite etwas platzieren, nehmen dieses Dict.

---

## Einheiten umrechnen

```tcl
pdf4tcllib::units::mm   10      ;# 28.346...  Millimeter -> Punkt
pdf4tcllib::units::cm   2.5     ;# 70.866...
pdf4tcllib::units::inch 1       ;# 72.0
pdf4tcllib::units::to_mm 72     ;# 25.4       Punkt -> Millimeter
pdf4tcllib::units::to_cm 72     ;# 2.54
pdf4tcllib::units::to_inch 144  ;# 2.0
```

Das ist alles, was der Namensraum [units]{.index} tut. Die Ergebnisse
sind Gleitkommazahlen; gerundet wird erst beim Zeichnen.

### pdf4tcl in Punkt lassen

pdf4tcl kann selbst in Millimetern rechnen (`pdf4tcl::new ... -unit mm`).
Mit pdf4tcllib nicht: `page::context` und alle Bausteine liefern und
erwarten Punkt. Ein Objekt mit `-unit mm` nimmt die Punktwerte als
Millimeter, und eine Fußzeile bei y = 813 landet 813 mm tief, weit
unter der Seite. Das PDF ist dann leer, ohne Fehlermeldung.

Ebenso die Option `-margin` von pdf4tcl: Sie verschiebt den Nullpunkt um
den Rand. `page::context` rechnet den Rand schon ein; beides zusammen
ergibt den doppelten Rand. Ein Versuch mit 20 mm in beiden setzte den
Text bei x = 113 pt statt bei 57 pt.

Darum für pdf4tcllib:

```tcl
# ohne -unit, ohne -margin
set pdf [pdf4tcl::new %AUTO% -paper a4 -orient true]
```

---

## page::context

```tcl
pdf4tcllib::page::context paper ?-margin mm? ?-landscape 0|1? \
    ?-orient 0|1?
```

| Argument | Vorgabe | Bedeutung |
|---|---|---|
| `paper` | – | `a3`, `a4`, `a5`, `b5`, `letter`, `legal` (groß oder klein geschrieben) |
| `-margin` | `20` | Rand in **Millimetern**, auf allen vier Seiten gleich |
| `-landscape` | `0` | `1`: Querformat, Breite und Höhe getauscht |
| `-orient` | `1` | `1`: y wächst nach unten, `0`: nach oben |

Ein anderes Papier lehnt es ab:

```text
unknown paper size: din-lang (known: letter a3 legal a4 a5 b5)
```

Die Kurzform `context a4 20 0` ist gleichbedeutend mit
`context a4 -margin 20 -orient 0`; das zweite Wort ist also die
Richtung, nicht das Querformat. Besser lesbar ist die Form mit Optionen.

### Was im Dict steht

```tcl
# 040-seitenkontext.tcl -- Satzspiegel aus page::context, hoch und quer
package require pdf4tcl
package require pdf4tcllib

pdf4tcllib::fonts::init

proc zeige {ctx} {
    foreach k {paper page_w page_h margin left right top bottom
               text_w text_h} {
        set v [dict get $ctx $k]
        if {[string is double -strict $v]} { set v [format %.2f $v] }
        puts [format "  %-7s %s" $k $v]
    }
}

puts "A4 hoch, 20 mm Rand, y nach unten (orient true):"
set ctx [pdf4tcllib::page::context a4 -margin 20]
zeige $ctx

puts "A4 quer, 15 mm Rand, y nach oben (orient false):"
set quer [pdf4tcllib::page::context a4 -margin 15 -landscape 1 \
    -orient false]
zeige $quer

# Den Satzspiegel einzeichnen: einmal je Richtung, jeweils mit
# passendem pdf4tcl-Objekt
foreach {name c} [list hoch $ctx quer $quer] {
    set pdf [pdf4tcl::new %AUTO% -paper a4 \
        -landscape [dict get $c landscape] \
        -orient [dict get $c orient]]
    $pdf startPage
    set l [dict get $c left]; set r [dict get $c right]
    set t [dict get $c top];  set b [dict get $c bottom]
    $pdf setStrokeColor 0.2 0.4 0.8
    $pdf rectangle $l [expr {min($t, $b)}] \
        [dict get $c text_w] [dict get $c text_h]
    $pdf setFont 10 [pdf4tcllib::fonts::fontSans]
    set y $t
    set mm [pdf4tcllib::units::to_mm [dict get $c text_w]]
    set zeilen [list "Satzspiegel $name" "[format %.0f $mm] mm breit"]
    foreach zeile $zeilen {
        pdf4tcllib::page::_advance $c y 14
        pdf4tcllib::unicode::safeText $pdf $zeile \
            -x [expr {$l + 6}] -y $y
    }
    pdf4tcllib::page::number $pdf $c 1
    $pdf endPage
    $pdf write -file 040-seitenkontext-$name.pdf
    $pdf destroy
}
```

```text
A4 hoch, 20 mm Rand, y nach unten (orient true):
  paper   a4
  page_w  595.28
  page_h  841.89
  margin  56.69
  left    56.69
  right   538.59
  top     56.69
  bottom  785.20
  text_w  481.89
  text_h  728.50
A4 quer, 15 mm Rand, y nach oben (orient false):
  paper   a4
  page_w  841.89
  page_h  595.28
  margin  42.52
  left    42.52
  right   799.37
  top     552.76
  bottom  42.52
  text_w  756.85
  text_h  510.24
```

| Schlüssel | Bedeutung | auch als |
|---|---|---|
| `page_w`, `page_h` | Seite in Punkt | `PW`, `PH` |
| `margin` | Rand in Punkt | `margin_pt` |
| `margin_mm` | Rand, wie angegeben | – |
| `left`, `right` | linke und rechte Kante des Satzspiegels | `SX` für `left` |
| `top`, `bottom` | obere und untere Kante, in der gewählten Richtung | `SY` für `top` |
| `text_w`, `text_h` | Breite und Höhe des Satzspiegels | `SW`, `SH` |
| `paper`, `landscape`, `orient` | die Eingaben | – |

Die Kurznamen gibt es für älteren Code. Andere Schreibweisen
(`pageW`, `textWidth`) gibt es nicht; `dict get` meldet dann einen
Fehler.

### top und bottom hängen an der Richtung

`top` ist immer die obere Kante des Satzspiegels, `bottom` die untere,
aber in der Zählweise der Seite:

| | `-orient 1` (y nach unten) | `-orient 0` (y nach oben) |
|---|---|---|
| `top` | klein (Rand) | groß (Höhe − Rand) |
| `bottom` | groß (Höhe − Rand) | klein (Rand) |
| nächste Zeile | y größer | y kleiner |

Die Richtung im Kontext und die Richtung des pdf4tcl-Objekts müssen
übereinstimmen. Am einfachsten nimmt man sie aus dem Kontext:

```tcl
set pdf [pdf4tcl::new %AUTO% -paper a4 \
    -landscape [dict get $ctx landscape] \
    -orient [dict get $ctx orient]]
```

Die Bausteine dieses Buchs gehen von `-orient 1` aus, der Vorgabe beider
Pakete. Tabellen aus `table::draw` lehnen `-orient 0` mit einem Fehler
ab (Kapitel [Tabellen mit Seitenumbruch](080-tabellen.md)).

### Zeile für Zeile weiter

[page::_advance]{.index} schiebt eine y-Variable in die richtige
Richtung, ohne dass der Code die Richtung kennen muss:

```tcl
set y [dict get $ctx top]
foreach zeile $zeilen {
    pdf4tcllib::page::_advance $ctx y 14   ;# erst weiter, dann setzen
    pdf4tcllib::unicode::safeText $pdf $zeile \
        -x [dict get $ctx left] -y $y
}
```

Der Unterstrich im Namen täuscht: Die Prozedur ist dokumentiert und wird
von den Formular-Bausteinen selbst benutzt.

Der Zeilenabstand zu einer Schriftgröße kommt aus
[page::lineheight]{.index}: Schriftgröße × 1,4, aufgerundet
(`page::lineheight 10` ergibt 14). Ein anderer Faktor geht als zweites
Argument.

### Die erste Zeile

y ist bei `$pdf text` die Grundlinie. Text, der bei `y = top` steht,
ragt mit seinen Oberlängen über den Satzspiegel in den Rand. Die erste
Zeile beginnt darum eine Schriftgröße tiefer, bei `top` plus
Schriftgröße (in Richtung `-orient 1`). Genau das tut das Beispiel oben
mit `_advance` vor dem Schreiben.

---

## Kopf, Fuß und Seitenzahl

Drei Prozeduren schreiben in den Rand, oberhalb und unterhalb des
Satzspiegels:

```tcl
# Mitte oben, Linie darunter
pdf4tcllib::page::header $pdf $ctx "Monatsbericht"
# links der Text, rechts "Seite 3"
pdf4tcllib::page::footer $pdf $ctx "Vertraulich" 3
# Mitte unten "- 3 / 10 -"
pdf4tcllib::page::number $pdf $ctx 3 10
```

`page::footer` schreibt die Seitenzahl als „Seite 3“. Das ist eine
Vorgabe aus der Bibliothek, keine Übersetzung; für ein englisches
Dokument:

```tcl
# für alle Aufrufe
set ::pdf4tcllib::page::pageLabelFormat "Page %s"
# nur für diesen Aufruf
pdf4tcllib::page::footer $pdf $ctx "Confidential" 3 9 \
    -pagelabel "Page %s"
```

Die Schrift ist die geladene TrueType-Schrift, ohne TrueType Helvetica;
die Größe ist das letzte Zahlenargument (Vorgabe 10 für den Kopf, 9 für
Fuß und Seitenzahl). Alle drei gehen über `safeText` (Kapitel
[Unicode sicher ausgeben](030-unicode-sicher-ausgeben.md)).

Eine vierte Prozedur, `page::centerText $pdf $ctx text y ?size? ?font?`,
setzt eine Zeile mittig, etwa einen Titel. Ohne Schriftargument nimmt sie
**Helvetica**, nicht die geladene TrueType-Schrift; Helvetica wird nicht
eingebettet, und das PDF taugt nicht mehr für PDF/A. Darum die Schrift
immer mitgeben:

```tcl
pdf4tcllib::page::centerText $pdf $ctx "Jahresbericht" 120 20 \
    [pdf4tcllib::fonts::fontSansBold]
```

Wie viele Seiten ein Dokument hat, weiß man erst am Ende. „Seite 3
von 10“ braucht darum einen zweiten Durchlauf; das zeigt das Kapitel
[Kopf- und Fußzeilen, Seitenzahlen](060-kopf-fuss-seitenzahlen.md).

---

## Hilfslinien beim Entwickeln

| Prozedur | zeichnet |
|---|---|
| `page::grid $pdf $ctx ?abstand?` | ein graues Raster über die ganze Seite, mit Koordinaten am Rand (Vorgabe 50 pt) |
| `page::debugGrid $pdf $ctx ?abstand?` | dasselbe, aber nur wenn die Umgebungsvariable `PDF4TCL_DEBUG` gesetzt ist |
| `page::orientationLegend $pdf $ctx` | eine Zeile in der rechten Ecke: Papier, Richtung, Lage des Nullpunkts, Einheit |

`debugGrid` kann im Code bleiben: Ohne `PDF4TCL_DEBUG=1` zeichnet es
nichts.

```bash
PDF4TCL_DEBUG=1 tclsh bericht.tcl
```

`page::grid` teilt die Seite nicht in Spalten. Ein Raster für Spalten
baut man aus `left` und `text_w` selbst; Text über mehrere Spalten setzt
das Paket `pdf4tclflow` (Kapitel [Spaltenfluss und Wasserzeichen](070-spaltenfluss-wasserzeichen.md)).

---

## Zusammenfassung

- pdf4tcllib rechnet in Punkt; Ränder gibt man in Millimetern an.
- pdf4tcl-Objekte ohne `-unit` und ohne `-margin` anlegen.
- `page::context` liefert `left`, `top`, `text_w` und den Rest; die
  Richtung im Kontext und im pdf4tcl-Objekt muss gleich sein.
- `page::_advance` und `page::lineheight` für die nächste Zeile, die
  erste Zeile eine Schriftgröße unter `top`.
- `page::header`, `page::footer`, `page::number` für den Rand;
  „Seite“ über `pageLabelFormat` anpassen.

---

*Nächstes Kapitel: [Text setzen](050-text-setzen.md)*
