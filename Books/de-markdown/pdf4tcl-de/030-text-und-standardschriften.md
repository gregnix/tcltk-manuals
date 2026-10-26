# Text und Standardschriften

## Einführung

Vierzehn [Standardschriften]{.index} (Base-14) braucht niemand
einzubetten: Helvetica, Times, Courier je in vier Schnitten, plus
Symbol und ZapfDingbats. Der Zeichenvorrat ist WinAnsi / CP1252.
Alles außerhalb wird `?`.

---

## Schrift setzen und schreiben

```tcl
$pdf setFont 18 Helvetica-Bold
$pdf text "Titel" -x 0 -y 24
$pdf setFont 12 Times-Roman
$pdf text "Fließtext mit Umlauten: äöü ÄÖÜ ß" -x 0 -y 50
$pdf setFont 10 Courier
$pdf text "mono 0123456789" -x 0 -y 70
```

Schnitte genau so nennen: Helvetica **-Oblique**, Times **-Italic**.
`Helvetica-Italic` gibt es nicht.

`text` lässt das [Textobjekt]{.index} (`BT` … `ET`) absichtlich offen,
damit mehrere Aufrufe einen Block teilen. Andere Zeichenmethoden
schließen ihn. Details: [gsave und Text](160-gsave-und-text.md).

---

## ToUnicode

Seit 0.9.4.9 tragen Standardschriften eine ToUnicode-CMap für
WinAnsi. Kopieren und `pdftotext` liefern lateinische Umlaute
korrekt. Griechisch und Kyrillisch bleiben `?` — dafür
[CID und Unicode](040-cid-und-unicode.md).

`getSubstCount` zählt Ersetzungen — **unter Tcl 9**. Unter 8.6
substituiert `encoding convertto` still, der Zähler bleibt 0. Die
Seite sieht in beiden Generationen gleich aus.

---

## Breite und Kasten

```tcl
set w [$pdf getStringWidth "Rechnung 2026"]
set w [$pdf getStringWidth "Probe" -font Helvetica -size 12]
```

Ohne vorheriges `setFont` die Variante mit `-font` / `-size`
(seit 0.9.4.23).

```tcl
$pdf drawTextBox 0 80 400 120 $absatz -align left -newyvar nextY
$pdf line 0 $nextY 400 $nextY
```

`-newyvar` liefert Y in den Koordinaten des Aufrufers. Vor 0.9.4.44
kam bei `-orient 1` eine interne Seitenkoordinate; wer damals
`pageHeight - $nextY` gerechnet hat, muss die Korrektur entfernen.

Weiches Trennzeichen `U+00AD`: seit 0.9.4.61 Vorschlag, kein Glyph.
`text`, `drawTextBox` und `getStringWidth` behandeln es gleich.
`Sil\u00ADben` ist so breit wie `Silben`.

---

## PDF/A und Standardschriften

Base-14 hat kein einbettbares Fontprogramm. PDF/A und PDF/UA
verlangen eines. Seit 0.9.4.41 steht das in
`::pdf4tcl::warnings`; die Datei entsteht trotzdem und fällt in
veraPDF durch. Archiv: TrueType laden, siehe nächstes Kapitel.

---

## Zusammenfassung

- Base-14 ohne Einbettung, nur Latin-1.
- Schnitte: `-Oblique` bei Helvetica, `-Italic` bei Times.
- `drawTextBox -newyvar` in Aufrufer-Koordinaten (0.9.4.44).
- Weiches Trennzeichen seit 0.9.4.61 unsichtbar und ohne Breite.

---

*Nächstes Kapitel: [CID und Unicode](040-cid-und-unicode.md)*
