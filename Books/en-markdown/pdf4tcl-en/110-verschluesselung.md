# Encryption

## Introduction

A password on the constructor switches on [AES]{.index}. AES-128
(`-encversion 4`, default since 0.9.4.11) and AES-256
(`-encversion 5`, since 0.9.4.16). Without a password the file stays
open.

---

## AES-128

```tcl
set pdf [::pdf4tcl::new %AUTO% -paper a4 -orient 1 \
        -userpassword "oeffnen" \
        -ownerpassword "aendern" \
        -permissions print]
$pdf startPage
$pdf setFont 12 Helvetica
$pdf text "Vertraulich." -x 50 -y 50
$pdf endPage
$pdf write -file geheim.pdf
$pdf destroy
```

Empty `-ownerpassword`: the user password applies to both.
`-permissions` takes symbolic lists, presets or a raw `/P` number.
The default acts as "everything allowed".

| Password | Effect |
|----------|---------|
| user | opens; `/P` applies |
| owner | full rights; `/P` ignored |

`-permissions` alone does **not** lock the file. Without a user
password every viewer opens it; `/P` is a hint to conforming readers.

---

## AES-256

```tcl
set pdf [::pdf4tcl::new %AUTO% -paper a4 \
        -userpassword "oeffnen" -ownerpassword "aendern" \
        -encversion 5]
```

Needs a SHA-384 backend. Pure Tcllib is slow (seconds instead of
milliseconds). In production, prefer a fast crypto package.

---

## CID Fonts: WriteObjectDirect (0.9.4.67)

Up to **0.9.4.66** the five objects of `WriteCIDFontObjects` went
straight into the file, bypassing Encrypt. The document was created,
was fine without a password — and unreadable **with** one:

```
qpdf: inflate: incorrect header check
pdftotext -upw … : (leer)
```

The font stream was byte-identical to the unencrypted file. A reader
that obeys `/Encrypt` decrypts it anyway and gets garbage.

Since **0.9.4.67** `WriteObjectDirect` writes the same objects
through Encrypt (strings and stream, key derived from the object
number). Workarounds (a standard font in encrypted output) can go.
Regenerate files from .66 — the content is in plain text in the old
file, and the embedded font is dead for the reader.

Up to .66, XMP metadata was also written in plain text while the
file claims `/EncryptMetadata true`. `qpdf --check` does not catch
this: the stream is uncompressed, so there is no inflate.

---

## Checking

```bash
qpdf --password=oeffnen --check geheim.pdf
pdftotext geheim.pdf -                 # Incorrect password
pdftotext -upw oeffnen geheim.pdf -    # Text
```

All three count. The first two alone also pass for an encrypted but
broken file — exactly what 0.9.4.66 produced.

---

## Summary

- AES-128: `-encversion 4`. AES-256: `-encversion 5`.
- User password to open, owner password for full rights.
- CID plus Encrypt: readable only from 0.9.4.67 on. Rebuild old files.

---

*Next chapter: [catPdf](120-catpdf.md)*
