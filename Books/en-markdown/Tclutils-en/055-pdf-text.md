# Text from PDF Files

[tupdftext]{.index} 0.1 is new in tclutils 0.67.0. It reads the text of
a PDF page by page, in pure Tcl. Tcl's `zlib` unpacks the streams.
Neither poppler nor a C extension is needed. It is intended for
full-text search: words, spaces and line breaks. Columns and tables
come in the order of the content stream.

The sister module `tupdf` reads the structure of a PDF (version,
objects, trailer, metadata, ZUGFeRD). `tupdftext` reads the text.

---

## Commands

```tcl
package require tclutils::tupdftext
::tclutils::tupdftext::pages   datei ?-notext error|empty?
::tclutils::tupdftext::text    datei ?-separator s? ?-notext error|empty?
::tclutils::tupdftext::summary datei
```

`pages` returns a list with one string per page, in page order. Lines
are separated by `\n`, runs of spaces are collapsed, ligatures (`ﬁ`,
`ﬂ`) are spelled out, and soft hyphens are removed.

`text` joins the pages with `-separator`. The default is the form feed
`\f`, as in `pdftotext`. A single page has no
separator.

`summary` returns a dict:

| Key | Meaning |
|---|---|
| `pages` | number of pages |
| `encrypted` | 1 if an `/Encrypt` entry is present |
| `version` | version from the header line, such as `1.4` |
| `textPages` | pages with at least one character |
| `unmapped` | glyphs that came out as U+FFFD (two-byte font without `/ToUnicode`) |
| `fonts` | list of dicts `name`, `subtype`, `toUnicode` |

With `-notext empty`, a PDF without text yields a list of empty
strings, one per page. Without the option this is the error
`NOTEXT`.

The command is called `summary`, not `info`. A procedure `info` in the
module's namespace would have hidden Tcl's `info` from all procedures
of the module.

```tcl
set seiten [::tclutils::tupdftext::pages $datei]
llength $seiten                                          ;# -> 1
lindex $seiten 0                                         ;# -> Lager Nord, Regal 3\nGroesse: 12 Stueck
dict get [::tclutils::tupdftext::summary $datei] version ;# -> 1.4
dict get [::tclutils::tupdftext::summary $datei] unmapped
                                                         ;# -> 0
::tclutils::tupdftext::text $zweiSeiten                  ;# -> Seite eins\fSeite zwei
```

The comments apply to two files created with pdf4tcl: one page in
Helvetica with the two lines above, and two pages with "Seite eins" and
"Seite zwei". The same, but empty, page without the option throws
`{TCLUTILS TUPDFTEXT NOTEXT}`; with `-notext empty` the list is one
empty element. A missing file yields `FILE`, a file without a
`%PDF-` header `FORMAT`. Tcl 8.6 and Tcl 9 return the same text.

---

## Errors

Every error carries `-errorcode {TCLUTILS TUPDFTEXT grund}`:

| Reason | When |
|---|---|
| `FILE` | the file is not readable |
| `FORMAT` | no `%PDF-` header, no objects or no pages |
| `ENCRYPTED` | the file is encrypted; even an empty user password is not read |
| `NOTEXT` | no page has text: a scan without OCR, or images only |
| `OPTION` | unknown option or missing value |

---

## What Comes Through

The module looks for objects as `N G obj` at the start of a line. It
does not need the cross-reference table; a damaged one does no harm. A
later definition of the same number wins, as in an incremental update.
Objects in object streams (`/ObjStm`) fill numbers that do not appear
directly.

Filters: `FlateDecode` (also with PNG predictor), `ASCIIHexDecode`,
`ASCII85Decode`, `LZWDecode`, and chains of these. Pages come from the
page tree starting at `/Root`, with inherited `/Resources`. Without a
usable tree: all `/Type /Page` objects in file order.

Text operators: `Tj`, `TJ`, `'`, `"` with `Tf`, `Tc`, `Tw`, `Tz`, `TL`,
`Ts`, `Td`, `TD`, `Tm`, `T*`, `q`, `Q`, `cm`. Form XObjects (`Do`) with
their own resources and their own matrix, up to depth 8; a form that
draws itself, once. Embedded images are skipped.

Fonts: Type0 (two-byte codes, `Identity-H`/`-V` or an embedded CMap),
Type1, TrueType, Type3. Unicode from `/ToUnicode` (`bfchar`,
`bfrange`), otherwise from `/Encoding` (`WinAnsiEncoding`,
`MacRomanEncoding`, `StandardEncoding`, `PDFDocEncoding` and
`/Differences` with glyph names). Spaces and line breaks come from the
positions: a jump of half a line downward is a new line, a gap of more
than 0.15 em within the line is a space.

---

## What It Does Not Do

- decrypt (`ENCRYPTED`)
- read text from images
- map a two-byte font without `/ToUnicode` (U+FFFD, counted in
  `unmapped`)
- keep columns apart
- join words that are hyphenated at the end of a line (`pdftotext`
  does this)

Compared with `pdftotext` (poppler 24.02) on 13 PDFs, recorded in
`docs/tupdftext.md`: 99.5 to 100 % of the words for eleven files, 91 %
for two pages of formulas. A book with 108 pages takes about 3.6 s
under Tcl 8.6.14. Tcl 9.0.4 returns the same text there; characters
outside the BMP are one character under Tcl 9 and a surrogate pair
under Tcl 8.6. This comparison was not rerun here. No encrypted file
was created in this run; the module description names `ENCRYPTED` for
it.

---

## Command Line

```sh
tclsh bin/tupdf.tcl text doc.pdf
tclsh bin/tupdf.tcl text doc.pdf -page 3
```

`book-search.tcl` and mdserver use the module for the text in PDFs.

---

## In short

- `pages` per page, `text` with `\f` in between, `summary` for the key figures.
- A scan and an encrypted file are errors, not a silent empty string.
- `-notext empty` turns the error into an empty page string.
- Columns, hyphenation at the end of a line and text in images stay out.

---

*Next chapter: [ODF and PDF Structure](057-odf-und-pdf-struktur.md)*
