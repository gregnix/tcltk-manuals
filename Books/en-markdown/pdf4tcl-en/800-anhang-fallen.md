# Pitfalls

A short list. The reasons are in the chapters.

---

## Text and Fonts

- Helvetica **-Oblique**, Times **-Italic**.
- Base-14: everything outside Latin-1 becomes `?`. Under 8.6
  `getSubstCount` is often 0 despite question marks.
- Encoded subset: put `?` (63) into the list, otherwise the fallback
  is slot 0.
- `drawTextBox -newyvar`: caller coordinates since 0.9.4.44; remove
  the old `pageHeight` correction.
- Soft hyphen since 0.9.4.61 without a glyph and without width.
- CFF/OpenType: CID does not subset, warning, whole face.

## Graphics

- Color 0..1, not 0..255 (error since 0.9.4.39).
- `setBgColor` is not the page background.
- `q` in an open `BT`: Adobe blank without a message. Since 0.9.4.62
  `gsave` closes the text object.
- Tagged before 0.9.4.69: `Tj` outside `BT`/`ET`, Adobe blank,
  Poppler full. Marking before `BeginTextObj`.
- Text does not follow `cm`.

## Canvas

- `$pdf canvas`: `update`, then `-bbox`.
- tko matrix flat `{a b c d tx ty}`, tkpath nested.
- `-fontmap`: canvas the whole specification, tko only the family.
- window items often missing.

## Forms and Annotations

- fillForms builds the appearance for a simple text field (0.9.4.64).
- Comb without MaxLen, password, choice: old stream.
- NeedAppearances only there, otherwise PDFium wipes untouched check boxes.
- Field name `person.city`, not `city`.
- Stamp after `setFont`, otherwise PDFium shows nothing.
- Dynamic XFA: fillForms refuses.

## Output

- CID plus Encrypt: rebuild files from before 0.9.4.67.
- CID subset before 0.9.4.68: Adobe blank (no cmap / checksum 0).
- PDF/A: embed the font; Base-14 gives only a warning, not a valid archive.
- catPdf: set the title, otherwise the title of part 1; XMP since 0.9.4.51.
- Open layer at `endPage`: error.

---

*Next chapter: [API](810-anhang-api.md)*
