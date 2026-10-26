# CID-Subset und CMap

## Einführung

Seit 0.9.4.57 schreibt pdf4tcl bei CID nur die benutzten Glyphen
(TrueType). Die Teilmenge muss eine gültige TrueType-Datei sein:
Pflichttabellen, cmap, Prüfsummen. Bis **0.9.4.67** fehlten cmap und
echte Tabellen-Prüfsummen. **0.9.4.68** setzt beides.

Aufrufer ändern nichts. `createFontSpecCID` und `setFont` bleiben.
Dieses Kapitel erklärt, warum Adobe eine leere Seite zeigte und
warum `letzteGlyphe` `numGlyphs-1` ist, nicht `0xFFFE`.

---

## cmap ist Pflicht

cmap steht in den Required Tables (Apple TrueType, OpenType). Bis
0.9.4.67 strich `CIDRebuildTtf` sie: Identity-H adressiert Glyphen
direkt. Das gilt für die PDF-Seite — und deshalb merkte es niemand:

- Viewer mit `/CIDToGIDMap /Identity` zeichneten die Glyphen
- `pdftotext` extrahierte den richtigen Text
- `qpdf` fand keinen Syntaxfehler
- **Adobe Reader zeigte eine leere Seite**

Die Teilmenge war einfach keine gültige Schrift. Ob Reader wirklich
aus dieser Tabelle malt, ist nicht geprüft. Die PDF-Norm sagt, für
eingebettetes CIDFontType2 gelte CIDToGIDMap. Die wahrscheinliche
Ursache: Reader prüft das Fontprogramm. Die Korrektur stützt sich
auf die Pflicht der cmap, nicht auf die Vermutung.

---

## Identity, nicht Unicode

Eine Viewer-Schleife durch die cmap läse die Glyph-ID als
Zeichencode. Glyph `0x5A` ist nicht U+005A. Beide Wege müssen
dasselbe Glyph finden. Deshalb schreibt
[`CIDIdentityCmap`]{.index} eine Identity-Abbildung, nicht die
originale Unicode-cmap.

Zwei Segmente, Format 4:

- `0 .. letzteGlyphe` bildet auf sich selbst ab
- `0xFFFF` ist der vorgeschriebene Wächter und zeigt auf Glyph 0

---

## letzteGlyphe ist numGlyphs-1

Ein cmap-Eintrag darf nicht auf ein Glyph zeigen, das es nicht gibt.
Ein früherer Entwurf führte das erste Segment bis `0xFFFE`. Bei
DejaVuSans zeigten dann 59282 Codes ins Leere; fontTools lehnte die
Schrift ab. `cidfont-11.2` hält beide Enden.

`CIDIdentityCmap` begrenzt: unter 0 wird 0, über `0xFFFE` wird
`0xFFFE`. Der Aufruf aus `CIDRebuildTtf`:

```
CIDIdentityCmap [expr {$numGlyphs - 1}]
```

`numGlyphs` steht in `maxp` bei Offset 4.

---

## Prüfsummen (0.9.4.68)

Zwei Stellen:

**checkSumAdjustment** in `head` wird auf 0 gesetzt, bevor die
Tabellensumme läuft. Der Originalwert gehört zur **Originalschrift**
und lügt in einer Teilmenge. Die Norm berechnet die Tabellensumme
von `head` mit diesem Feld auf 0. Der Endwert kommt ganz am Schluss,
wenn die Datei steht.

**Prüfsumme je Tabelle.** Bis 0.9.4.67 stand hier 0. Die erzeugte
Datei war keine gültige TrueType-Datei — so deutlich, dass
`loadBaseTrueTypeFont` sie mit `invalid TTF file checksum` ablehnte.
`MakeTTFSubset` (der andere Schneider) macht das seit jeher richtig;
nur der CID-Weg nicht.

Layout-Tabellen (GPOS, GSUB, GDEF, kern, MATH, FFTM, DSIG) bleiben
draußen: nicht Pflicht, und pdf4tcl hat den Inhalt beim Laden schon
in `BFA`.

---

## CFF

OpenType/CFF wird nicht subsettet. Es gibt eine Warnung, die ganze
Face wandert ins PDF. Derselbe cmap-Fix gilt dort nicht.

---

## Zusammenfassung

- Bis 0.9.4.67: keine cmap im CID-Subset; Adobe leer, andere Viewer voll.
- 0.9.4.68: `CIDIdentityCmap` mit `numGlyphs-1`, nicht `FFFE`.
- Tabellen-Prüfsummen und `checkSumAdjustment` 0, dann Endwert.
- API unverändert.

---

*Nächstes Kapitel: [Fallstudie: Bericht](180-fallstudie-bericht.md)*
