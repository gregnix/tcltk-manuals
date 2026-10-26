# catPdf

## Introduction

[`catPdf`]{.index} concatenates finished PDFs. No document object.
Since 0.9.4.40 the logical structure is preserved. Since 0.9.4.44
forms are merged.

---

## Recipe

```tcl
package require pdf4tcl 0.9.4.69
pdf4tcl::catPdf teil1.pdf teil2.pdf gesamt.pdf
```

Options go **before** the file names (since 0.9.4.48):

```tcl
::pdf4tcl::catPdf -title "Gesamtdatei" -author "" \
        teil1.pdf teil2.pdf gesamt.pdf
```

`-title -author -subject -keywords -creator -producer`. An empty value
deletes the entry. Entries not named keep what the first document had.

Since 0.9.4.51 the values go into `/Info` **and** into XMP. Before
that only `/Info` — Acrobat (which prefers XMP) kept showing the title
of part 1. The packet is **edited, not rebuilt**, so that extension
schemas (such as Factur-X `fx:`) are preserved.

ISO 19005-1 clause 6.7.3 requires `/Info` and XMP to match. Check
against **1b**, not 2b: PDF/A-2/3 dropped the rule. The same
inconsistent file: veraPDF 1b FAIL, 2b PASS.

---

## Mixing Tagged Files

Both inputs tagged: one structure tree, with the elements of the
second document attached to the first. Page markers are kept.

Tagged plus untagged does not work cleanly. pdf4tcl writes valid PDF
and appends to `::pdf4tcl::warnings`:

- tagged + untagged → later pages outside the tree
- untagged + tagged → the structure of the second document is dropped

Tag all parts the same way beforehand.

---

## Forms (0.9.4.44)

The field list is the union. Before, only the form of the first
document survived: the widgets of the others sat on the pages, but no
reader offered them for filling.

**Names are not made unique.** Two fields with the same name are one
field with a shared value (ISO 32000-1 12.7.3.2). A collision is
reported in `::pdf4tcl::warnings`.

---

## XRef Streams

Cross-reference table as a stream (PDF 1.5+): ISO 19005-1 forbids the
form, PDF/A-2 and -3 require it. Since 0.9.4.49/50 catPdf reads both,
object streams included.

| Input | Concatenation |
|---------|---------------|
| ordinary PDF from pdf4tcl | yes |
| PDF/A-1b | yes |
| PDF/A-2b, -3b, -3a | since 0.9.4.49 |
| objects in containers | since 0.9.4.50 |

`qpdf --object-streams=generate` without `--newline-before-endstream`
violates ISO 19005-2 6.1.7.1. The **input** fails in veraPDF, and so
does the result — pdf4tcl passes streams through unchanged.

---

## Limits

- Font dictionaries remain duplicated; identical font streams are
  shared.
- Catalog and Pages objects of appended documents remain as dead
  objects (a few hundred bytes).
- Orphans (unreachable `/Info` of the appended files) are dropped
  since 0.9.4.50.

---

## Summary

- `catPdf ?optionen? eingabe … ausgabe` (options, inputs, output).
- Title since 0.9.4.48, XMP since 0.9.4.51.
- Structure since 0.9.4.40, forms since 0.9.4.44, XRef stream since
  0.9.4.49.

---

*Next chapter: [PDF/A](130-pdfa.md)*
