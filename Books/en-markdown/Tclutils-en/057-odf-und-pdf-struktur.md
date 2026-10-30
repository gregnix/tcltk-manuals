# ODF and PDF Structure

[tupdf]{.index} 0.2 reads the structure of a PDF: header line, object
numbers, page markers, trailer, info and an indication of ZUGFeRD.
`tupdftext` reads the text of the pages, see the chapter
[Text from PDF Files](055-pdf-text.md).

[tuodf]{.index} 0.2 writes and reads a plain OpenDocument with
paragraphs. [tudocx]{.index} and [tuxlsx]{.index} 0.1 do the same for
Word and Excel files (Office Open XML). All are in the umbrella.

---

## PDF: tupdf

```tcl
package require tclutils::tupdf
::tclutils::tupdf::version  datei
::tclutils::tupdf::objects  datei
::tclutils::tupdf::object   datei nummer
::tclutils::tupdf::trailer  datei
::tclutils::tupdf::metadata datei
::tclutils::tupdf::summary  datei
::tclutils::tupdf::zugferd  datei
```

`version` takes the number after `%PDF-` in the first 1024 bytes.
`objects` returns the numbers from `N G obj`, sorted and unique. The
module unpacks compressed object streams with `zlib` before counting.
`object` returns the raw text from `id gen obj` to `endobj`. `pages` in
`summary` counts `/Type /Page` and leaves out `/Pages`.

The following file has the header `%PDF-1.4`, four objects, one page
and an info object with `Title (Lager)` and `Author (Nord)`.

```tcl
::tclutils::tupdf::version $datei                    ;# -> 1.4
::tclutils::tupdf::objects $datei                    ;# -> 1 2 3 4
dict get [::tclutils::tupdf::summary $datei] pages   ;# -> 1
dict get [::tclutils::tupdf::metadata $datei] Title  ;# -> Lager
```

`summary` also carries `version`, `size`, `objects`, `encrypted`,
`linearized`, `acroform` and `zugferdDetected`. Existing info fields
are in the same dict. Here `encrypted`, `linearized` and `acroform`
are 0, and `zugferdDetected` is 0 as well.

`zugferd` is a search in the file text, not a conformance check.
Without an attachment and without the markers, the lists in the dict
stay empty:

```tcl
dict get [::tclutils::tupdf::zugferd $datei] detected ;# -> 0
dict get [::tclutils::tupdf::zugferd $datei] profile  ;# -> {}
```

The keys are `detected`, `profile`, `attachmentNames`, `mimeTypes` and
`hints`. A match sets `profile` to `factur-x`, `zugferd` or
`unknown`.

| Code | When |
|---|---|
| `{TCLUTILS TUPDF FORMAT}` | no `%PDF-` header, or `endobj` missing after the object |
| `{TCLUTILS TUPDF ARG}` | the object number is not an integer |
| `{TCLUTILS TUPDF NOTFOUND}` | the number does not appear in the text after inflating |

`object $datei x` throws `ARG`. `object $datei 9` on the file above
throws `NOTFOUND`.

---

## ODF: tuodf

```tcl
package require tclutils::tuodf
::tclutils::tuodf::createText datei absätze ?-title T? ?-creator C?
::tclutils::tuodf::parts      datei
::tclutils::tuodf::part       datei name
::tclutils::tuodf::paragraphs datei
::tclutils::tuodf::text       datei
```

`createText` returns the file path. The container is a ZIP.
`mimetype` is the first entry and stays uncompressed. `-title` and
`-creator` go into `meta.xml`.

```tcl
set z [::tclutils::tuodf::createText lager.odt \
    [list {Lager Nord} {a < b} {}] -title Lager -creator Nord]
::tclutils::tuodf::parts $z
    ;# -> mimetype content.xml styles.xml meta.xml META-INF/manifest.xml
::tclutils::tuodf::part $z mimetype
    ;# -> application/vnd.oasis.opendocument.text
::tclutils::tuodf::paragraphs $z          ;# -> {Lager Nord} {a < b} {}
::tclutils::tuodf::text $z                ;# -> Lager Nord\na < b\n
```

`a < b` comes back as text. The XML contains `&lt;`. An empty entry in
the list is an empty paragraph. `text` joins the paragraphs with `\n`,
so the result ends with a newline.
`meta.xml` contains `<dc:title>Lager</dc:title>` and
`<dc:creator>Nord</dc:creator>`.

`paragraphs` reads paragraphs (`text:p`) and, since 0.2, headings
(`text:h`), in document order. It finds paragraphs inside tables and
lists, in the cells of an `.ods` and on the slides of an `.odp` as well;
the structure itself (rows, columns, levels) is not kept. A
missing ZIP file is reported by `tuzip`, not with an error code of
`tuodf`'s own.

---

## Word: tudocx

```tcl
package require tclutils::tudocx
::tclutils::tudocx::createText file paragraphs ?-title T? ?-creator C?
::tclutils::tudocx::parts      file
::tclutils::tudocx::part       file name
::tclutils::tudocx::paragraphs file
::tclutils::tudocx::text       file
```

The commands are named as in `tuodf`. `createText` writes the five parts a
`.docx` needs at least; Word, LibreOffice and python-docx open it. A tab in
a paragraph becomes `w:tab`, a line break `w:br`.

```tcl
set d [::tclutils::tudocx::createText lager.docx \
    [list {Lager Nord} "Regal\t3" {}] -title Lager]
::tclutils::tudocx::parts $d
    ;# -> {[Content_Types].xml} _rels/.rels word/document.xml docProps/core.xml docProps/app.xml
::tclutils::tudocx::paragraphs $d        ;# -> {Lager Nord} {Regal<TAB>3} {}
```

`paragraphs` reads the main part named in `_rels/.rels`, usually
`word/document.xml`: every paragraph in document order, headings, list
items and table cells included. Deleted text of tracked changes
(`w:delText`) and field codes (`w:instrText`) are left out. Headers,
footers, footnotes and comments are in other parts and are not read. A
missing main part is `{TCLUTILS TUDOCX PART …}`.

---

## Excel: tuxlsx

```tcl
package require tclutils::tuxlsx
::tclutils::tuxlsx::writeRows file rows ?-sheet NAME? ?-numbers auto|0? ?-title T? ?-creator C?
::tclutils::tuxlsx::sheets    file
::tclutils::tuxlsx::rows      file ?-sheet NAME|NUMBER?
::tclutils::tuxlsx::text      file
::tclutils::tuxlsx::part      file name
::tclutils::tuxlsx::parts     file
```

`writeRows` writes one sheet. With `-numbers auto` a value that looks like
a decimal number is stored as a number, everything else as text; `007`
stays text.

```tcl
set x [::tclutils::tuxlsx::writeRows lager.xlsx \
    {{Artikel Menge} {Schraube 120} {Mutter 007}} -sheet Lager]
::tclutils::tuxlsx::sheets $x            ;# -> Lager
::tclutils::tuxlsx::rows $x              ;# -> {Artikel Menge} {Schraube 120} {Mutter 007}
::tclutils::tuxlsx::rows $x -sheet Nord  ;# error {TCLUTILS TUXLSX SHEET Nord}
```

`rows` reads any workbook, also those of Excel and LibreOffice. The values
come as the file stores them: text from the shared string table or inline
in the cell, numbers as written, a date as its serial number, booleans as
`1` and `0`, a formula with its last computed value, an error as text
(`#DIV/0!`). Gaps are filled with `""`. `tuxlsx` does not read formats.
`text` returns all sheets, cells separated by a tab, rows by a newline.

---

## In short

- `tupdftext` reads the page text. `tupdf` returns version, objects, info.
- `/Pages` does not count as a page. `zugferd` does not check the file for conformance.
- `tuodf` writes paragraphs. `mimetype` is the first, uncompressed entry.
- `tudocx` and `tuxlsx` are named and work like `tuodf`; `tuxlsx::rows`
  returns values as the file stores them (a date as its serial number).
- An empty paragraph at the end adds a newline to `text`.

---

*Next chapter: [Diagrams](056-diagramme.md)*
