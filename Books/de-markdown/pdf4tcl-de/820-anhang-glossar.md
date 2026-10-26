# Glossar

---

## A

**AES-128 / AES-256**
: Verschlüsselung über `-encversion 4` bzw. `5`. User öffnet, Owner
  hat volle Rechte.

**Appearance-Stream**
: Zeichnung eines Felds oder einer Annotation. Ohne ihn zeigt PDFium
  Stempel nicht. fillForms baut ihn für einfaches Textfeld neu.

## B

**Base-14**
: Vierzehn Standardschriften, nicht einbettbar. Nur WinAnsi.

## C

**catPdf**
: PDFs aneinanderhängen. Struktur seit 0.9.4.40, Formulare seit
  0.9.4.44.

**CID-Schrift**
: Type-0 mit Identity-H, Unicode über TrueType. Subset seit 0.9.4.57.

**CIDIdentityCmap**
: Identity-cmap der Teilmenge seit 0.9.4.68. `letzteGlyphe` =
  `numGlyphs-1`.

**cmap**
: Pflicht-TrueType-Tabelle Zeichen nach Glyph. Bis 0.9.4.67 im
  CID-Subset gestrichen.

## N

**NeedAppearances**
: Flagge am AcroForm: Viewer soll Erscheinungen neu bauen. fillForms
  setzt sie nur, wo der Stream alt bleibt.

## O

**OCG**
: Optional Content Group, Ebene. `addLayer` / `beginLayer` /
  `endLayer`.

**orient**
: `-orient 1` (Default): Y von oben.

## P

**PDF/A**
: Archivformat. Schrift einbetten. Stufen B, U, A; Teile 1–3.

**PDFium**
: Viewer in Chrome und Edge. Stempel und Linie ohne Appearance unsichtbar.
  NeedAppearances leert Off-Kästchen.

## T

**Textobjekt**
: `BT` … `ET`. `text` hält es offen. `gsave` schließt es seit
  0.9.4.62 vor `q`.

**ToUnicode**
: Abbildung Glyph nach Unicode für Extraktion. Base-14 seit 0.9.4.9
  für WinAnsi; CID immer.

## W

**WriteObjectDirect**
: Schreibt ein Objekt über Encrypt. Pflicht für CID-Schriftobjekte
  seit 0.9.4.67.

## X

**XMP**
: Metadatenpaket am Katalog. `metadata` und `catPdf -title` schreiben
  `/Info` und XMP (catPdf seit 0.9.4.51).
