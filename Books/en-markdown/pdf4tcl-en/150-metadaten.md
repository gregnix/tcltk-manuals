# Metadata

## Introduction

Title, author and subject are stored twice: in the classic `/Info` and
in the XMP packet the catalog points to. `metadata` writes both.
Acrobat prefers to read XMP.

---

## Setting

```tcl
$pdf metadata \
        -title "Jahresbericht 2026" \
        -author "Muster GmbH" \
        -subject "Kennzahlen" \
        -keywords "Bericht, 2026" \
        -creator "bericht.tcl" \
        -producer "pdf4tcl"
```

Unknown option:

```
unknown metadata option "-foo"
```

Values that are empty after `string trim` are ignored. Dates:

```tcl
$pdf metadata -creationdate 0 -moddate 0
```

`0` means "now" (`clock seconds`). Otherwise a PDF date that
`_ValidatePdfDate` accepts.

---

## Viewer

```tcl
$pdf viewerPreferences -displaydoctitle 1 -pagemode UseOutlines
```

`-displaydoctitle 1` shows the document title in the title bar instead
of the file name. PDF/A level A and PDF/UA often expect this.

Further switches: `-pagelayout`, `-hidetoolbar`, `-fitwindow`,
`-centerwindow`, `-direction L2R|R2L`.

---

## Attachments

```tcl
$pdf addEmbeddedFile "notizen.txt" \
        -contents "Beilage\n" \
        -mimetype "text/plain" \
        -description "Nebennotizen" \
        -afrelationship Data
```

`-afrelationship`: `Alternative`, `Data`, `Source`, `Supplement`,
`Unspecified`. Forbidden under `-pdfa 1b` (error). PDF/A-3b enters the
file into `/AF` automatically. Factur-X: use the `facturx` method, do
not build the packet by hand.

---

## Encryption

Since 0.9.4.67 the XMP stream also goes through Encrypt when the file
sets `/EncryptMetadata true`. Up to 0.9.4.66 the title was in plain
text in a supposedly encrypted file.
`qpdf --check` does not see this.

---

## catPdf

Concatenation takes over the catalog of the first part. Set the title
of the combined file with `catPdf -title …`; otherwise the title of
part 1 remains — in XMP too, since 0.9.4.51. See [catPdf](120-catpdf.md).

---

## Summary

- `metadata` fills `/Info` and XMP.
- `viewerPreferences -displaydoctitle 1` for archive and UA.
- Attachments: PDF/A-3, not PDF/A-1.

---

*Next chapter: [gsave and Text](160-gsave-und-text.md)*
