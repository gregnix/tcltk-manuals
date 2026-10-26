# Bilder

## Einführung

Raster liegt in zwei Schritten auf der Seite: `addImage` nimmt die
Datei ins Dokument, `putImage` platziert sie. Dieselbe ID darf
mehrfach stehen.

---

## PNG, JPEG, TIFF

```tcl
set id [$pdf addImage /pfad/foto.png]
$pdf addImage $pfad -id logo
$pdf putImage $id 50 100 -width 200
```

Ohne `-height` folgt die Höhe dem Seitenverhältnis. `-id` vergibt
einen festen Namen statt einer Zahl.

JPEG und viele PNG/TIFF-Varianten laufen. Seit **0.9.4.28** wird
Adam7-interlaced PNG beim Einbetten entflochten. Interlaced PNG
unter 8 Bit lehnt der Lader mit klarer Meldung ab.

Nicht unterstütztes Format: über Tk/Img laden, dann `addRawImage` /
`putRawImage`.

---

## Wiederverwenden

```tcl
set logo [$pdf addImage logo.png -id logo]
$pdf putImage logo 20 20 -width 80
$pdf startPage
$pdf putImage logo 20 20 -width 80
```

Die Bytes stehen einmal im PDF. Jede Platzierung ist ein `Do` auf
dasselbe XObject.

---

## Getaggt und PDF/UA

Abbildungen brauchen ein Strukturelement mit `-alt`:

```tcl
$pdf tagBegin Figure -alt "Firmenlogo"
$pdf putImage $id 50 100 -width 120
$pdf tagEnd
```

Ein Form-XObject mit getaggtem Inhalt darf nur **einmal** gezeichnet
werden (0.9.4.46). Unter PDF/UA verbietet veraPDF Regel 7.20-2 jede
weitere Platzierung; pdf4tcl warnt dann, bricht aber nicht ab.
Wiederverwenden bleibt gutes PDF — die Konformitätsbehauptung schließt
es aus.

---

## Zusammenfassung

- `addImage`, dann `putImage` mit Breite oder Höhe.
- Interlaced PNG seit 0.9.4.28; Sub-8-Bit interlaced bleibt Fehler.
- PDF/UA: `Figure` mit `-alt`; XObject nicht mehrfach setzen, wenn
  UA behauptet wird.

---

*Nächstes Kapitel: [Canvas-Export](070-canvas-export.md)*
