# pdf4tcl

*As of: 2026-09-29*

The English translation of the German-language textbook for
[pdf4tcl]{.index} 0.9.4.69: pages, text, CID fonts, graphics, canvas
export, AcroForm, encryption, concatenating PDFs and PDF/A.

pdf4tcl draws. Line wrapping across pages, tables with page breaks
and tables of contents with real page numbers live in
`pdf4tcllib`. This book stays with the drawing API.

## Audience

- Tcl developers who generate reports, forms or archival PDFs
- GUI developers who export a Tk canvas to PDF
- Readers who need appearance streams, CID subsets and AES
  without searching the manpage line by line

## Scope

`book.tcl` is the build reference: **22** chapter files
(18 chapters + 4 appendices).

| Figure | Value |
|---|---|
| Main chapters (Parts 1–4) | 15 |
| In depth (Part 5) | 3 |
| Appendices | 4 |
| **Total** | 22 Markdown files |
| Language | English (translated from German) |
| Package | pdf4tcl 0.9.4.69 |

## Structure

Chapters are stored flat as `NNN-*.md` (bookkit). Contents:
[`BUCHSTRUKTUR.md`](BUCHSTRUKTUR.md), build: [`BOOKKIT.md`](../BOOKKIT.md).
File names are German; they are shared with the German original in
`pdf4tcl-de/`.

## Building PDF and HTML (bookkit)

```bash
cd ..
tclsh bookkit/tools/book-build.tcl book-pdf4tcl/pdf4tcl-en/ -number
```

Output: `pdf4tcl-en.pdf` / `.html` in `book-pdf4tcl/`. The German
edition is built the same way from `book-pdf4tcl/pdf4tcl-de/`.

## Recommended Reading Order

### Getting Started

1. **Part 1** in full — object, page, text, CID
2. **Part 2** — graphics, images, canvas

### Forms and Output

1. **Part 3** — creating fields, filling them, annotations
2. **Part 4** — AES, catPdf, PDF/A, layers, metadata
3. Keep **Appendix A (Pitfalls)** open alongside

### In Depth

1. **Part 5** — `gsave` and the text object, CID cmap, case study

## License

Documentation text: [CC BY-SA 4.0](LICENSE)
Code examples: [MIT](LICENSE)

## Contributing

Corrections and additions are welcome — see [CONTRIBUTING.md](CONTRIBUTING.md).

## Style

- **Imperative and impersonal form** — no direct "you"
- Established technical terms, with the usual English names
- Concrete code examples instead of abstract descriptions
- Cross-references to other chapters and appendices
