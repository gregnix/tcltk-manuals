# Grafik

## Einführung

Linien, Flächen, Farbe, Transparenz und Verläufe laufen über
Methoden am Dokument. Farbe teilt seit 0.9.4.39 eine Pipeline:
Füllung, Strich, Verlauf, Formular, Annotation.

---

## Farbe

```tcl
$pdf setFillColor 1 0 0
$pdf setFillColor #cc3300
$pdf setFillColor red
$pdf setFillColor 0 0.5 1 0
$pdf setStrokeColor navy
$pdf setBgColor 1 1 0
```

Komponenten **0.0 .. 1.0**. `255 0 0` ist ein Fehler seit 0.9.4.39
(vorher schrieb die Datei den illegalen Operanden, Viewer klemmten
still). 147 X11/CSS-Namen ohne Tk. Namen außerhalb der Tabelle
fragen `winfo rgb`, wenn Tk da ist.

`setBgColor` gilt nur für `text -bg`, nicht für die Seite. Seitengrund:
vollflächiges Rechteck zuerst zeichnen.

---

## Formen

```tcl
$pdf setStrokeColor 0 0 0
$pdf setLineWidth 1
$pdf line 0 36 250 36

$pdf setFillColor 0.9 0.9 0.9
$pdf rectangle 0 50 250 60 -filled 1
```

Weitere Methoden: `circle`, `oval`, `polygon`, `arc`, `roundedRect`,
`arrow`. Nach farbigem Text die Füllfarbe wieder auf Schwarz setzen,
sonst erbt der nächste Kasten Rot.

---

## Transparenz und Verlauf

```tcl
$pdf setAlpha 0.5
$pdf rectangle 40 40 120 80 -filled 1
$pdf setAlpha 1
```

Unter `-pdfa 1b` / `1a` verletzt Alpha unter 1 PDF/A-1. Seit 0.9.4.22
steht eine Warnung in `::pdf4tcl::warnings`; die Datei entsteht trotzdem.

```tcl
$pdf gsave
$pdf clip 50 100 400 60
$pdf linearGradient 50 130 450 130 red blue
$pdf grestore
$pdf rectangle 50 100 400 60
```

Radial: Innenmittelpunkt/Radius, Außenmittelpunkt/Radius, zwei Farben.
`-extend {0 0}` stoppt am Ende. Mit `-cmyk 1` schreibt die Shading
`/DeviceCMYK`.

```tcl
$pdf setBlendMode Multiply
# überlappende Füllungen
$pdf setBlendMode Normal
```

---

## Transformation

```tcl
$pdf gsave
$pdf translate 200 300
$pdf rotate 45
$pdf line 0 0 80 0
$pdf grestore
```

`rotate`, `scale`, `translate` (seit 0.9.4.20) setzen `cm` und merken
`rawcoords`. Immer mit `gsave` / `grestore` paaren.

**Text folgt `cm` nicht.** `text` setzt `Tm` absolut. Gedrehter Text:
trotzdem `translate` / `rotate`, dann `text` bei `-x 0 -y 0` — und
vorher [gsave und Text](160-gsave-und-text.md) lesen: `gsave` schließt
ein offenes `BT`.

---

## Zusammenfassung

- Farbe 0..1, Namen ohne Tk, Bereichsprüfung seit 0.9.4.39.
- Verlauf clippen, dann `linearGradient` / `radialGradient`.
- Transformationen immer zwischen `gsave` und `grestore`.

---

*Nächstes Kapitel: [Bilder](060-bilder.md)*
