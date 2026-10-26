# Glossary

---

## A

**AES-128 / AES-256**
: Encryption via `-encversion 4` or `5`. The user password opens, the
  owner password grants full rights.

**Appearance stream**
: The drawing of a field or an annotation. Without it PDFium does not
  show stamps. fillForms rebuilds it for a simple text field.

## B

**Base-14**
: Fourteen standard fonts, not embeddable. WinAnsi only.

## C

**catPdf**
: Concatenates PDFs. Structure since 0.9.4.40, forms since
  0.9.4.44.

**CID font**
: Type 0 with Identity-H, Unicode via TrueType. Subset since 0.9.4.57.

**CIDIdentityCmap**
: Identity cmap of the subset since 0.9.4.68. `letzteGlyphe` (last
  glyph) = `numGlyphs-1`.

**cmap**
: Required TrueType table mapping characters to glyphs. Removed from
  the CID subset up to 0.9.4.67.

## N

**NeedAppearances**
: Flag on the AcroForm: the viewer should rebuild appearances.
  fillForms sets it only where the stream stays old.

## O

**OCG**
: Optional content group, layer. `addLayer` / `beginLayer` /
  `endLayer`.

**orient**
: `-orient 1` (default): Y from the top.

## P

**PDF/A**
: Archival format. Embed fonts. Levels B, U, A; parts 1–3.

**PDFium**
: The viewer in Chrome and Edge. Stamps and lines without an
  appearance are invisible. NeedAppearances empties Off check boxes.

## T

**Text object**
: `BT` … `ET`. `text` keeps it open. Since 0.9.4.62 `gsave` closes it
  before `q`.

**ToUnicode**
: Mapping from glyph to Unicode for extraction. Base-14 since 0.9.4.9
  for WinAnsi; CID always.

## W

**WriteObjectDirect**
: Writes an object through Encrypt. Required for CID font objects
  since 0.9.4.67.

## X

**XMP**
: Metadata packet on the catalog. `metadata` and `catPdf -title` write
  `/Info` and XMP (catPdf since 0.9.4.51).
