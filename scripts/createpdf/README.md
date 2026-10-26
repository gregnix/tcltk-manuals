# createpdf

Builds one PDF from a tree of Tcl/Tk manual pages in Markdown (TIP 700):
title page, table of contents, one chapter per page, subject index and,
at the end, the license terms.

```
createpdf/
    createpdf.tcl
    beispiel.sh
    en-markdown/
        9.0/
            tcl/   after.md  dict.md  puts.md  string.md   license.terms
            tk/    button.md label.md pack.md  ttk_button.md license.terms
```

The sample holds a few pages; for the whole manual, put all pages of
`tcl/` and `tk/` (or of any other tree) in the same layout.

## Requirements

Tcl 8.6 or 9.x and the packages **docir**, **mdstack**, **pdf4tcl** and
**pdf4tcllib**. The script loads them with plain `package require`; if one
is missing it stops with a message. Make them findable for Tcl, for example:

```bash
export TCLLIBPATH="/path/to/pdf4tcl"
export TCL8_6_TM_PATH="/path/to/docir/lib/tm:/path/to/mdstack/lib:/path/to/pdf4tcllib/lib"
# with Tcl 9: TCL9_0_TM_PATH instead of TCL8_6_TM_PATH
```

## Use

```bash
cd createpdf
tclsh createpdf.tcl en-markdown/9.0 -o tcltk-9.0.pdf \
    -title "Tcl/Tk 9.0" -subtitle "Reference manual pages"
```

| Option | Effect |
|---|---|
| `-o FILE` | output PDF (default `<dir name>.pdf`) |
| `-title T`, `-subtitle S`, `-author A`, `-date D` | title page; the title also goes into the header |
| `-lang en\|de` | labels (Contents, Index, Keywords, License) and PDF language |
| `-subject S` | PDF metadata |
| `-license FILE` | license text (repeatable); default: every `license.terms`, `LICENSE`, `LICENSE.txt`, `COPYRIGHT.txt` or `COPYING` below `<dir>` |
| `-note FILE` | text at the start of the license chapter, e.g. who translated the pages (`uebersetzung-de.txt`) |
| `-no-license`, `-no-title-page`, `-no-index`, `-no-header` | leave that part out |
| `-no-groups` | no parts per folder (Tcl, Tk, Ttk), one flat list |
| `-no-cid` | 256-character font subset instead of full Unicode |
| `-md FILE` | also write the merged Markdown |
| `-index-tsv FILE` | also write the printed index as a table |

Each page becomes a chapter named after its file; the index terms are the
command name and the `Keywords:` from the YAML head; the `Copyright:` lines
stay with each page. License files with the same text are printed once.

With `SOURCE_DATE_EPOCH` set, two runs give the same bytes, and the title
page shows that date.

## Combined index (index-gesamt.tcl)

`index-gesamt.tcl` (from bookkit) joins the tables written with
`-index-tsv` into one index PDF; every page number is a link into the
other PDF (`GoToR`, path relative to the index PDF):

```bash
tclsh index-gesamt.tcl -pdf gesamt.pdf -lang en -title "Combined index" \
    tcltk-9.0.index.tsv tcllib.index.tsv ...
```

`build-pdfs.sh` does this for the Tcl family (`tcl-family-index`).

---

## Deutsch

Baut aus einem Baum von Tcl/Tk-Handbuchseiten in Markdown ein PDF mit
Titelseite, Inhaltsverzeichnis, Stichwortverzeichnis und den
Lizenzbedingungen am Ende. Für ein deutsches PDF `-lang de`:

```bash
tclsh createpdf.tcl de-markdown/9.0 -lang de -o tcltk-9.0-de.pdf \
    -title "Tcl/Tk 9.0" -subtitle "Handbuchseiten (deutsch)"
```

Die Pakete werden mit `package require` geladen; wo sie liegen, sagen
`TCLLIBPATH` und `TCL8_6_TM_PATH` bzw. `TCL9_0_TM_PATH` (siehe oben).

Ein Gesamtindex über mehrere PDFs entsteht mit `index-gesamt.tcl` aus den
Tabellen von `-index-tsv` (siehe oben); `build-pdfs.sh` baut ihn für die
Tcl-Familie (`tcl-family-index`).
