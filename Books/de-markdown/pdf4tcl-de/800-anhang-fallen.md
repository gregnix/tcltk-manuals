# Fallen

Kurze Liste. Begründung in den Kapiteln.

---

## Text und Schrift

- Helvetica **-Oblique**, Times **-Italic**.
- Base-14: alles außerhalb Latin-1 wird `?`. `getSubstCount` unter
  8.6 oft 0 trotz Fragezeichen.
- Kodierte Teilmenge: `?` (63) in die Liste, sonst Fallback auf
  Slot 0.
- `drawTextBox -newyvar`: Aufrufer-Koordinaten seit 0.9.4.44; alte
  `pageHeight`-Korrektur entfernen.
- Weiches Trennzeichen seit 0.9.4.61 ohne Glyph und ohne Breite.
- CFF/OpenType: CID subsettet nicht, Warnung, ganze Face.

## Grafik

- Farbe 0..1, nicht 0..255 (Fehler seit 0.9.4.39).
- `setBgColor` ist nicht der Seitengrund.
- `q` in offenem `BT`: Adobe leer ohne Meldung. Seit 0.9.4.62
  schließt `gsave` das Textobjekt.
- Tagged vor 0.9.4.69: `Tj` außerhalb von `BT`/`ET`, Adobe leer,
  Poppler voll. Auszeichnung vor `BeginTextObj`.
- Text folgt `cm` nicht.

## Canvas

- `$pdf canvas`: `update`, dann `-bbox`.
- tko-Matrix flach `{a b c d tx ty}`, tkpath verschachtelt.
- `-fontmap`: Canvas ganze Spezifikation, tko nur Familie.
- window oft weg.

## Formulare und Annotationen

- fillForms baut Appearance für einfaches Textfeld (0.9.4.64).
- Comb ohne MaxLen, Kennwort, Auswahl: alter Stream.
- NeedAppearances nur dort, sonst PDFium löscht unberührte Kästchen.
- Feldname `person.city`, nicht `city`.
- Stempel nach `setFont`, sonst PDFium leer.
- Dynamisches XFA: fillForms lehnt ab.

## Ausgabe

- CID plus Encrypt: Dateien vor 0.9.4.67 neu bauen.
- CID-Subset vor 0.9.4.68: Adobe leer (keine cmap / Prüfsumme 0).
- PDF/A: Schrift einbetten; Base-14 nur Warnung, kein gültiges Archiv.
- catPdf: Titel setzen, sonst Titel von Teil 1; XMP seit 0.9.4.51.
- Offene Ebene am `endPage`: Fehler.

---

*Nächstes Kapitel: [API](810-anhang-api.md)*
