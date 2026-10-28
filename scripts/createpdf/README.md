# createpdf

Builds one PDF from a tree of Tcl/Tk manual pages in Markdown (TIP 700),
or from a folder of HTML pages: title page, table of contents, one
chapter per page, subject index and, at the end, the license terms.

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
| `-index-terms auto\|keywords\|all` | where the index terms come from (default `auto`, see below) |
| `-html`, `-no-html` | read the HTML pages even if there are `.md` files, or never (default: HTML only if there is no `.md`) |
| `-keep-md DIR` | keep the Markdown converted from HTML in `DIR` (default: temporary folder, removed) |

Each page becomes a chapter named after its file; the index terms are the
command name and the `Keywords:` from the YAML head; the `Copyright:` lines
stay with each page. License files with the same text are printed once.
A link to another page (`other.md`, `other.md#anchor`, also as reference
`[x]: other.md`) jumps to that chapter, or to the heading of the anchor
if that heading is on that page.

### HTML pages

A folder with `.html`/`.htm` files and no `.md` (searched recursively) is
read as HTML; `-html` forces this, `-no-html` turns it off. In a folder
with both, only the `.md` pages are read, with a note.

```bash
tclsh createpdf.tcl /path/to/tablelist7.12/doc -o tablelist.pdf
```

The pages are converted to Markdown with docir (`docir::htmlSource`, then
`docir::md`), the same way as `docir/bin/h2md --batch`: links to `.html`
become `.md`, links to an id go to the heading before it (Markdown has no
other anchors), images (`png`, `gif`, `jpg`, `svg`) are copied, missing
ones are left out with a note. Unlike h2md the whole tree is converted at
once, so links between folders work too. The result goes to a temporary
folder below `$TMPDIR` (else `/tmp`), removed at the end; `-keep-md DIR`
keeps it. From there it is the normal build: a chapter per page, a part
per folder, index terms from the text (`-index-terms auto`: the pages
have no YAML head), `-index-tsv`, and the license files (`license.terms`,
`LICENSE`, `COPYING`, `COPYRIGHT.txt` ...) found in the HTML folder.

- **Order:** sorted by file name, as with Markdown, but `index.html` (or
  `index.htm`) first in its folder. In package documentation it is the
  start page: title, author and the list of contents (Csaba Nemethi's
  packages, Wcb, TclWS); sorted by name it would land anywhere (BWidget:
  after `ArrowButton`). Frameset pages (BWidget's `index.html`) have no
  text and are left out.
- **Title:** the `<title>` of `index.html` in the folder, else the folder
  name; `-title` comes first.
- **Encoding:** UTF-8, or the `charset` of a `<meta>` tag (ISO-8859-1,
  -15, Windows-1252).
- **Finding docir:** `docir::htmlSource` is loaded like the other
  packages (`package require`, the docir on the module path). If that
  fails, an `h2md` script is run with the same `tclsh`: `$H2MD`, else
  `$DOCIR_HOME/bin/h2md`, else `bin/h2md` of the docir that is loaded.
  Both ways need the package **tdom**; without it createpdf stops with a
  message.

### Index terms from the page

With `-index-terms auto` (default) pages without a YAML head, i.e. pages
converted from HTML, also get index terms from their text; `all` does
this for every page, `keywords` never (the behaviour before). A term is
taken from

- definition terms (the line before `: …`, and lines before it that end in
  a hard line break): options (`-arrowstyle`),
  commands (`tablelist::tablelist`), subcommands and methods. Italic
  parts and `?…?` are arguments and drop out, and so does `pathName` in
  front: `pathName cellconfigure cellIndex ?option?` gives `cellconfigure`.
  If the page has `pathName header option ?arg …?`, a subcommand keeps its
  second word (`header bbox`). A label in capitals (`ROW INDICES`) or a
  short one in words is taken whole;
- headings from level 2 on, without common ones (Contents, Description,
  Examples, See also … in English and German), the title block of the
  HTML pages (version, “by”, author) and questions. “The `x` Command”
  gives `x`, “name - text” gives `name`;
- words the page marks itself, `[word]{.index}`.

Each term counts once per page, at its first place, and the index jumps
there (docir puts a jump target at every marker). The marker shows its
text, so a term is always a piece of text the page shows: in a code span
the term leaves the code (`` `pathName` [cellconfigure]{.index} `cellIndex` ``,
printed bold in a definition term). The index is flat, term and pages,
and the combined index adds the manual, so a term stands on its own
(`cellconfigure`, not `pathName cellconfigure`). A heading with a marker
gets a new anchor (`x-index`); links to the old one are moved along.
The terms go into `-index-tsv` like all others.

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

Stichwörter: Befehlsname und `Keywords:` aus dem YAML-Kopf. Mit
`-index-terms auto` (Vorgabe) bekommen Seiten ohne YAML-Kopf (aus HTML)
dazu Begriffe aus dem Text: Optionen und Befehle der Definitionslisten,
Überschriften ab Ebene 2 (ohne Inhalt, Beschreibung, Beispiele …) und
markierte `[Wort]{.index}`; jeder springt an seine Stelle. `keywords`:
nur Befehlsname und Keywords (wie früher), `all`: bei jeder Seite
ableiten (siehe „Index terms from the page“).

HTML-Doku direkt: Ein Ordner mit `.html`/`.htm` und ohne `.md` wird als
HTML gelesen (`-html` erzwingt, `-no-html` verbietet es; gemischte
Ordner: nur Markdown, mit Hinweis). Die Seiten werden wie mit
`h2md --batch` (docir, braucht tdom) in einen temporären Ordner
umgewandelt, `-keep-md DIR` behält sie; danach der normale Ablauf mit
abgeleiteten Stichwörtern. `index.html` kommt zuerst (Startseite der
Paketdoku), der Titel kommt aus ihrem `<title>`, Links zwischen den Seiten
springen ins jeweilige Kapitel (siehe „HTML pages“).

Ein Gesamtindex über mehrere PDFs entsteht mit `index-gesamt.tcl` aus den
Tabellen von `-index-tsv` (siehe oben); `build-pdfs.sh` baut ihn für die
Tcl-Familie (`tcl-family-index`).
