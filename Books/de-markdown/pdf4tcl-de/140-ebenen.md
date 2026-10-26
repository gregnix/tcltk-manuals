# Ebenen

## Einführung

Optionale Inhalte ([OCG]{.index}) schaltet der Leser im Viewer an
und aus: Debug-Gitter, Briefkopf, Wasserzeichen. Ebenen gelten
dokumentweit; `beginLayer` / `endLayer` umschließen das Zeichnen
auf einer Seite.

---

## Rezept

```tcl
set pdf [::pdf4tcl::new %AUTO% -paper a4 -orient 1]
set gitter [$pdf addLayer "Debuggitter" -visible 0]
set rumpf [$pdf addLayer "Rumpf" -visible 1]

$pdf startPage

$pdf beginLayer $gitter
$pdf setStrokeColor 0.85 0.85 0.85
for {set x 0} {$x <= 500} {incr x 50} {
    $pdf line $x 0 $x 700
}
$pdf endLayer

$pdf beginLayer $rumpf
$pdf setFont 12 Helvetica
$pdf text "Sichtbarer Rumpf" -x 50 -y 50
$pdf endLayer

$pdf endPage
$pdf write -file ebenen.pdf
$pdf destroy
```

`addLayer` gibt eine ID für `beginLayer` / `endLayer` und für
`-layer` an Annotationen und Formularen.

---

## Optionen (seit 0.9.4.63)

```tcl
$pdf addLayer "Vordruck" -print 0
$pdf addLayer "Detail"   -zoom {2.0 {}}
$pdf addLayer "Kopf DE"  -group kopf
set liste [$pdf layers]
```

| Option | Wirkung |
|--------|---------|
| `-visible` | Anfangszustand (Default 1) |
| `-print 0` | auf dem Schirm, nicht auf Papier |
| `-export` | Zustand beim Speichern in ein Format ohne OCG |
| `-zoom {min max}` | nur in diesem Maßstab an; leer = unbegrenzt |
| `-locked` | Viewer darf nicht umschalten |
| `-group name` | höchstens eine Ebene der Gruppe sichtbar |

`-print 0` schreibt `/Usage << /Print << /PrintState /OFF >> >>`.
ISO 32000-1 8.11.4.4: Usage-Dictionaries gelten für **interaktive**
konforme Leser, nicht für Endform-Ausgabe. Druck aus dem Viewer
ehrt es; ein RIP nicht, und das ist konform. Wo es nicht schiefgehen
darf, die Grafik gar nicht in die Datei legen.

Sobald eine Ebene `/Usage` trägt, bekommt die Default-Konfiguration
ein `/AS`-Array — ohne das wendet kein Viewer `/Usage` an.

---

## Zählen

`endLayer` ohne `beginLayer` ist Fehler (früher eine verirrte `EMC`).
`endPage` lehnt eine Seite mit offener Ebene ab (ISO 32000-1 14.6).

---

## Formulare

Annotationen liegen außerhalb des Content-Streams.
`beginLayer` erreicht sie nicht. `-layer` an `addForm` schreibt
`/OC` ins Annotations-Dictionary.

---

## Zusammenfassung

- `addLayer`, dann `beginLayer` / `endLayer` auf der Seite.
- `-print 0` und `-zoom` über `/Usage`; `/AS` entsteht automatisch.
- Offene Ebene am Seitenende ist Fehler.

---

*Nächstes Kapitel: [Metadaten](150-metadaten.md)*
