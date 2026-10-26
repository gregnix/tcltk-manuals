# Metadaten

## Einführung

Titel, Autor, Betreff stehen zweimal: im klassischen `/Info` und im
XMP-Paket, auf das der Katalog zeigt. `metadata` schreibt beide.
Acrobat liest bevorzugt XMP.

---

## Setzen

```tcl
$pdf metadata \
        -title "Jahresbericht 2026" \
        -author "Muster GmbH" \
        -subject "Kennzahlen" \
        -keywords "Bericht, 2026" \
        -creator "bericht.tcl" \
        -producer "pdf4tcl"
```

Unbekannte Option:

```
unknown metadata option "-foo"
```

Leere Werte nach `string trim` werden ignoriert. Datum:

```tcl
$pdf metadata -creationdate 0 -moddate 0
```

`0` bedeutet „jetzt“ (`clock seconds`). Sonst ein PDF-Datum, das
`_ValidatePdfDate` akzeptiert.

---

## Viewer

```tcl
$pdf viewerPreferences -displaydoctitle 1 -pagemode UseOutlines
```

`-displaydoctitle 1` zeigt den Dokumenttitel in der Titelleiste
statt des Dateinamens. PDF/A-A und PDF/UA erwarten das oft.

Weitere Schalter: `-pagelayout`, `-hidetoolbar`, `-fitwindow`,
`-centerwindow`, `-direction L2R|R2L`.

---

## Anhänge

```tcl
$pdf addEmbeddedFile "notizen.txt" \
        -contents "Beilage\n" \
        -mimetype "text/plain" \
        -description "Nebennotizen" \
        -afrelationship Data
```

`-afrelationship`: `Alternative`, `Data`, `Source`, `Supplement`,
`Unspecified`. Verboten unter `-pdfa 1b` (Fehler). PDF/A-3b trägt
die Datei automatisch in `/AF`. Factur-X: Methode `facturx`, nicht
das Paket von Hand bauen.

---

## Verschlüsselung

Seit 0.9.4.67 läuft auch der XMP-Stream über Encrypt, wenn die Datei
`/EncryptMetadata true` setzt. Bis 0.9.4.66 stand der Titel im
Klartext in einer angeblich verschlüsselten Datei.
`qpdf --check` sieht das nicht.

---

## catPdf

Zusammenfügen übernimmt den Katalog des ersten Teils. Titel der
Gesamtdatei mit `catPdf -title …` setzen, sonst bleibt der Titel
von Teil 1 — auch in XMP seit 0.9.4.51. Siehe [catPdf](120-catpdf.md).

---

## Zusammenfassung

- `metadata` füllt `/Info` und XMP.
- `viewerPreferences -displaydoctitle 1` für Archiv und UA.
- Anhänge: PDF/A-3, nicht PDF/A-1.

---

*Nächstes Kapitel: [gsave und Text](160-gsave-und-text.md)*
