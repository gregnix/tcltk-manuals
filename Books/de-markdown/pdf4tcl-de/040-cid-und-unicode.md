# CID und Unicode

## Einführung

`createFont` mit WinAnsi deckt Latin-1. Polnisch, Griechisch,
Kyrillisch, Mathematik oder CJK brauchen eine [CID-Schrift]{.index}:
TrueType laden, CID-Spezifikation anlegen, mit `setFont` wählen.

---

## Rezept

```tcl
pdf4tcl::loadBaseTrueTypeFont BaseDejaVu \
        /usr/share/fonts/truetype/dejavu/DejaVuSans.ttf
pdf4tcl::createFontSpecCID BaseDejaVu Uni

set pdf [::pdf4tcl::new %AUTO% -paper a4 -orient 1 -margin 50]
$pdf startPage
$pdf setFont 12 Uni
$pdf text "Grüße aus München, Polska, Ellada" -x 0 -y 24
$pdf endPage
$pdf write -file unicode.pdf
$pdf destroy
```

Drei Schritte: Basis laden, CID-Namen binden, diesen Namen in
`setFont` verwenden. Ohne geladene Basis:

```
createFontSpecCID: base font '…' not loaded (use loadBaseTrueTypeFont first)
```

Farb-Bitmap-Emoji (CBDT/CBLC) und COLR lehnt der Lader ab.
Nur Outline-Schriften.

---

## Zwei Wege, zwei Decken

| Weg | Aufruf | Decke |
|-----|--------|-------|
| kodierte Teilmenge | `createFont` / `createFontSpecEnc` | höchstens 256 Codepunkte |
| CID | `createFontSpecCID` | der benutzte Vorrat, Identity-H |

Seit 0.9.4.57 **subsetten beide Wege**. Vorher wanderte bei CID die
ganze Datei ins PDF. Dateigröße für eine Zeile Griechisch in DejaVu Sans:

| Variante | Datei |
|----------|-------|
| Teilmenge, 5 Codepunkte | 8 860 Byte |
| Teilmenge, 200 Codepunkte | 29 761 Byte |
| CID nach Subset | 50 004 Byte |
| CID vor 0.9.4.57 (ganze Face) | 386 728 Byte |

CFF/OpenType bleibt vollständig; pdf4tcl subsettet TrueType.
Dann steht eine Warnung in `::pdf4tcl::warnings`.

Bei kodierter Teilmenge `?` (63) in die Liste aufnehmen. Zeichen
außerhalb fallen sonst auf Slot 0 — den ersten angegebenen Codepunkt.
Eine Teilmenge, die mit `G` beginnt, macht aus Griechisch `GGGGGG`.

---

## Ersetzungen prüfen

```tcl
$pdf text $zeile -x 0 -y 40
puts [$pdf getSubstCount]
```

`0` heißt: jedes Zeichen hatte ein Glyph. Fragezeichen auf der Seite
ohne Fehler: die Face hat den Codepunkt nicht, oder es lief Base-14.

---

## Tcl 8.6 und Zeichen über U+FFFF

Als Literal in der Quelle:

| | `string length` | erstes Zeichen |
|--|-----------------|----------------|
| Tcl 9 | 1 | U+1F600 |
| Tcl 8.6 | 1 | U+FFFD |

Aus einer UTF-8-Datei lesen beide Generationen korrekt. Keine
`\U`-Escapes über U+FFFF in Code, der unter 8.6 laufen muss.
Breite mit `getStringWidth` messen, nicht mit `string length`.

---

## Verschlüsselung

Eingebettete CID-Schriften in einem AES-Dokument brauchen seit
**0.9.4.67** denselben Schreibweg wie andere Objekte
(`WriteObjectDirect`). Dateien aus 0.9.4.66 neu erzeugen.
Siehe [Verschlüsselung](110-verschluesselung.md).

Die Subset-Datei selbst trägt seit **0.9.4.68** eine gültige cmap
und Tabellen-Prüfsummen. Vertiefung:
[CID-Subset und CMap](170-cid-subset-cmap.md).

---

## Zusammenfassung

- `loadBaseTrueTypeFont`, dann `createFontSpecCID`, dann `setFont`.
- CID subsettet TrueType seit 0.9.4.57; CFF bleibt ganz.
- Kodierte Teilmenge: 256 Codepunkte, `?` in die Liste.
- `getSubstCount` nach dem Zeichnen.

---

*Nächstes Kapitel: [Grafik](050-grafik.md)*
