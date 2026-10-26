# Annotationen

## Einführung

Notizen, Stempel, Markierungen und Linien liegen **neben** dem
Content-Stream. Ein Name ist keine Zeichnung. Ob ein Viewer etwas
sieht, hängt vom Typ und vom Appearance-Stream ab.

---

## Übliche Aufrufe

```tcl
$pdf addAnnotNote 100 100 20 20 -content "Prüfen" -author "Lektor" \
        -icon Comment -color {0.6 0.8 1.0}
$pdf addAnnotFreeText 50 200 200 40 "Immer sichtbar" \
        -color {0 0 0} -bgcolor {1 1 0.8}
$pdf addAnnotStamp 300 500 80 30 -name Approved -color {1 0 0}
$pdf addAnnotHighlight 50 300 200 14 -color {1 1 0}
$pdf addAnnotUnderline 50 320 200 14
$pdf addAnnotStrikeOut 50 340 200 14 -color {1 0 0}
$pdf addAnnotLine 50 400 200 400 -color {0 0 0}
```

---

## Was sich selbst zeichnet

| Art | Gezeichnet aus |
|-----|----------------|
| Highlight, Underline, StrikeOut | Fläche und Farbe |
| FreeText | Text und Farben |
| Note | Icon-Satz des Viewers |
| **Stamp** | nur Appearance-Stream |
| **Line** | nur Appearance-Stream |

Ein Stempel nennt, welcher Stempel gemeint war. Acrobat hat Artwork
für die benannten Stempel. **PDFium hat keines**, und PDFium ist der
Viewer in Chrome und Edge. Dasselbe gilt für die Linie: Endpunkte
sagen wo, nicht wie.

Seit **0.9.4.64** schreiben `addAnnotStamp` und `addAnnotLine` einen
Appearance-Stream. Geprüft an `demo/demo-annotations.pdf`: keiner
von sechs Stempeln und fünf Linien war in PDFium sichtbar, alle elf
sind es jetzt. Die Datei wird etwas größer.

---

## Stempel braucht Schrift

Die Erscheinung eines Stempels nennt eine Schrift. Deshalb wird der
Stream **nur nach `setFont`** geschrieben. Ohne gesetzte Schrift
entsteht die Annotation wie vor 0.9.4.64 — der Aufruf schlägt nicht
fehl, PDFium bleibt leer.

Reihenfolge:

```tcl
$pdf setFont 10 Helvetica
$pdf addAnnotStamp 300 500 80 30 -name Approved -color {1 0 0}
```

---

## Pfeilspitzen

Gezeichnet für `OpenArrow`, `ClosedArrow`, `ROpenArrow`,
`RClosedArrow`, `Circle`, `Square`. Jedes andere Ende bleibt eine
glatte Linie. Eine Linie ohne Kopf ist eine halbe Antwort, ein
falsch gezeichneter Kopf eine falsche.

---

## Links

Ein Link ist eine Annotation vom Typ `/Link`: ein Rechteck, das beim
Klick etwas auslöst. Rahmen gibt es nur auf Wunsch.

[hyperlinkAdd]{.index} öffnet eine Adresse (`/S /URI`):

```tcl
$pdf hyperlinkAdd 50 100 200 20 "https://www.tcl-lang.org"
```

Sprünge **im Dokument** gibt es seit **0.9.4.72**. Zwei Methoden gehören
zusammen. [destinationAdd]{.index} legt auf der aktuellen Seite ein
benanntes Ziel an; [linkAdd]{.index} setzt ein Rechteck, das zu diesem
Namen springt:

```tcl
$pdf startPage
$pdf text "1 Einleitung ........ 3" -x 50 -y 100
$pdf linkAdd 50 88 200 14 kap1          ;# Ziel gibt es noch nicht
$pdf endPage
...
$pdf startPage
$pdf text "1 Einleitung" -x 50 -y 60
$pdf destinationAdd kap1 -y 45          ;# Ziel, etwas über der Zeile
```

Der Link trägt nur den Namen (`/Dest /kap1`). Aufgelöst wird er erst
beim Schreiben über das Wörterbuch `/Dests` im Katalog. Deshalb darf das
Ziel **nach** dem Link entstehen — genau das braucht ein
Inhaltsverzeichnis, das vor seinen Kapiteln steht.

- Name: Buchstaben, Ziffern, `.` `_` `-`; je Dokument einmal.
- `-y` (und `-x`) in der aktuellen Einheit; ohne `-y` die Oberkante der
  Seite.
- Rahmen und Hervorhebung wie bei `hyperlinkAdd`: `-borderwidth`
  `-bordercolor` `-borderradius` `-borderdash` `-highlight`.
- Ein Link auf einen Namen, den kein `destinationAdd` anlegt, bricht
  nichts ab. Die Datei entsteht, der Link bleibt wirkungslos, und
  stderr meldet den Namen.
- Unter `-pdfa 2b` erlaubt.

Geprüft mit `tests/linkdest.test` (12 Fälle) und an
docir-Büchern: das Inhaltsverzeichnis des macOS-Buchs, 238 Einträge,
jeder springt auf die gedruckte Seite und dort auf die Überschrift.

---

## Getaggt

Annotationen gehören zum Strukturbaum nur in offenem
`tagBegin Link` oder `tagBegin Annot` … `tagEnd`. Sonst klickbar,
für Hilfstechnik unsichtbar. Seit 0.9.4.39 steht das einmal pro
Dokument in `::pdf4tcl::warnings`. Für PDF/UA die Annotation
einwickeln.

---

## Zusammenfassung

- Stempel und Linie brauchen Appearance (0.9.4.64), sonst PDFium leer.
- Vor `addAnnotStamp` `setFont`.
- Highlight zeichnet sich aus Fläche und Farbe.
- `hyperlinkAdd` für Adressen, `destinationAdd` + `linkAdd` für Sprünge
  im Dokument (0.9.4.72); das Ziel darf nach dem Link kommen.

---

*Nächstes Kapitel: [Verschlüsselung](110-verschluesselung.md)*
