# tcltk-manuals

*English · [Deutsch](README.de.md)*

Manual pages for Tcl/Tk, Tcllib, Tklib and further extensions as Markdown
and PDF, in English (original) and German (translation), plus books on Tcl
libraries.

> **Unofficial.** An independent collection, not a publication of the
> projects. The original texts are by their authors and under their
> licenses; the English pages are only converted to Markdown. Please report
> conversion or translation errors here, not to the projects.
>
> The German translation was made with the help of DeepL and AI tools and
> reviewed and revised by hand. The scripts were developed with the help of
> AI tools and are reviewed and tested by the author.

## Contents

Three groups, each with `en-markdown/`, `de-markdown/`, `en-pdf/` and
`de-pdf/`.

| Group | Folders | PDFs |
|---|---|---|
| `Tcl-family/` | `9.0/`, `8.6/` (Tcl and Tk; in English also the C API in `tcl-c/`, `tk-c/`), `tcllib/`, `tklib/`, `pakete/` (Csaba Nemethi: tablelist, mentry, scrollutil, wcb, tsw) | `tcltk-9.0`, `tcltk-8.6`, `tcltk-*-capi` (en), `tcllib`, `tklib`, `tablelist`, `mentry`, `scrollutil`, `wcb`, `tsw`; **`tcl-family-index`**, **`nemethi-index`** |
| `Extensions/` | TDBC, Thread, [incr Tcl], BWidget, tDOM, tcltls, tclvfs, tcludp, tclhttpd, expect, mpexpr, mclistbox, tclws | `erweiterungen`, `bwidget` (BWidget only) |
| `Books/` | `Tclutils-de`, `Tclutils-en`, `pdf4tcl-de`, `pdf4tcl-en`, `pdf4tcllib-de`, `pdf4tcllib-en`, `Tkutils-de`, `Tkutils-en`, `Mdserver-de`, `Mdserver-en` | same names |

**Combined index:** `Tcl-family/en-pdf/tcl-family-index-en.pdf` and
`Tcl-family/de-pdf/tcl-family-index-de.pdf` gather the keywords of all
Tcl family PDFs in one index; every page number jumps into that PDF. Keep
the PDFs in one folder, as in the repository. Acrobat, Okular and Evince
follow the jumps; some viewers in the browser do not.

**Partial indexes:** an index may also cover only some manuals, such as
`nemethi-index` (`Tcl-family/LANG-pdf/nemethi-index-LANG.pdf`) for the five
packages by Csaba Nemethi. Add a line with `art` = `index` to
`scripts/katalog.tsv` and list the manuals in its `quelle` column, separated
by commas (`tablelist,mentry,scrollutil,wcb,tsw`, in that order; each one a
manual of the same group). `-` means every manual of the group (as for
`tcl-family-index`). It is built like the combined index, from the existing
`.index.tsv` files; a missing table is left out with a message.

`scripts/` holds the tools: `createpdf/` (with `index-gesamt.tcl`),
`build-pdfs.sh`, `hole-lizenzen.sh` and the GUI `pdfgui.tcl`. The list of
PDFs is `scripts/katalog.tsv`, read by both `build-pdfs.sh` and the GUI.

The pages in TIP 700 format carry the command name, section, keywords and
the copyright lines of the original in their YAML head.

The Markdown pages follow the format of TIP 700, which `man2markdown.tcl`
in the Tcl sources also uses. They were converted with `n2md` from the
[man-viewer](https://github.com/gregnix/man-viewer) project. This
independently developed tool supports Tcl/Tk 8.6, Tcllib, Tklib and further
extensions as well as Tcl/Tk 9. `n2md` is meant as a complementary tool and
does not claim to replace `man2markdown.tcl`.

## Adding a book

In the GUI: set "Books" to the book tree, press "Add book…", pick the
output folder (with `book.tcl`, e.g. `book-tkutils/Tkutils-de`) or the
book folder above it (`book-tkutils`, then every output in it). The
language comes from `set lang` in `book.tcl`, else from the suffix
`-de`/`-en`, else the GUI asks. It shows the new lines for
`scripts/katalog.tsv` (names already there are not added twice), appends
them and can copy the pages right away. Steps 3 and 4 remain. The folder
must lie inside the book tree; the catalog holds relative paths only.

By hand:

1. One line per language in `scripts/katalog.tsv` (tab separated, see the
   header there), e.g.
   `Tkutils-de  buch  Books  Tkutils-de  *  de  book-tkutils/Tkutils-de  -  -`.
2. Copy the pages: in the GUI select the book, set "Books" to the book tree,
   "Copy pages". Or by hand: copy the book folder to
   `Books/de-markdown/Tkutils-de`, without `*.pdf`, `*.html`, `.gitignore`,
   `nogit/`, `CONTRIBUTING.md`, `BUCHSTRUKTUR.md`. It needs `book.tcl` and `LICENSE`.
3. Add the book to the table above and to [LICENSES.md](LICENSES.md).
4. Build: `BOOKKIT=/path/to/bookkit bash scripts/build-pdfs.sh Tkutils-de`.

Check: `tclsh scripts/tests/katalog-test.tcl /path/to/books` reads the
catalog, tests adding a book on a copy and test-mirrors the books into a
temporary folder.

## Licenses

Each part is under the license of its original; the German translations
under the same terms as their original. Overview: [LICENSES.md](LICENSES.md).

## Building the PDFs

```bash
# fetch the license texts from the Fossil clones (once, and after new sources)
bash scripts/hole-lizenzen.sh /path/to/fossil /path/to/nemethi

# all PDFs, or one language / single PDFs
bash scripts/build-pdfs.sh
bash scripts/build-pdfs.sh -en tcltk-9.0 erweiterungen

# after single Tcl family PDFs, rebuild the combined index
bash scripts/build-pdfs.sh -en tcllib tcl-family-index

# the books need bookkit
BOOKKIT=/path/to/bookkit bash scripts/build-pdfs.sh Tclutils-en pdf4tcllib-en

# index terms of the manuals (default auto)
bash scripts/build-pdfs.sh -index-terms keywords tablelist
```

**Index terms:** the subject index of a manual takes the command name and
the `Keywords:` of the YAML head. Pages without a YAML head (converted from
HTML: the Nemethi packages, BWidget, TclWS, mpexpr, mclistbox) also get
terms from their text: options and commands of the definition lists
(`-arrowstyle`, `cellconfigure`, `header bbox`), headings from level 2 on
(without common ones such as Contents or Examples) and words marked
`[word]{.index}`; each jumps to its place. `-index-terms` chooses: `auto`
(default) as described, `keywords` only command name and keywords (as
before), `all` terms from the text of every page. Details:
[scripts/createpdf/README.md](scripts/createpdf/README.md).

**HTML documentation directly as PDF:** `createpdf.tcl` also reads a
folder of HTML pages (package documentation such as
`tablelist7.12/doc`), converts them with docir's HTML reader into a
temporary folder and builds the PDF as from Markdown, index terms
included:
`tclsh scripts/createpdf/createpdf.tcl /path/to/tablelist7.12/doc -o tablelist.pdf`
(needs tdom; see
[scripts/createpdf/README.md](scripts/createpdf/README.md), "HTML pages").

Requires Tcl 8.6 or 9.x and the packages docir, mdstack, pdf4tcl and
pdf4tcllib; where they go is described in
[scripts/createpdf/README.md](scripts/createpdf/README.md).

## GUI

```bash
wish scripts/pdfgui.tcl
```

`pdfgui.tcl` does what `build-pdfs.sh` does, with a GUI: pick manuals and
languages, set title, subtitle, note and the parts of the PDF, build,
cancel. "Copy pages" copies the selected manuals from the `de-markdown`
and `en-markdown` folders of the translation (tcltk-manual-de) into the
collection; license files stay. Selected books come from the "Books" field
(the book tree, e.g. `bibliothek/books`): the folder from column `quelle`
of the catalog is mirrored to `Books/LANG-markdown/FOLDER`, without
`*.pdf`, `*.html`, `.gitignore`, `nogit/`, `CONTRIBUTING.md` and
`BUCHSTRUKTUR.md` (notes for writing the book); files missing in the source
are removed, unchanged files stay untouched. "Add book…" adds a book from
the book tree to the catalog (see above). The field "Own folder" takes a further folder of
Markdown or HTML pages. The field "Derive index terms"
passes `-index-terms` (automatic, keywords only, all pages). Settings can be saved under a name
(`~/.config/tcltk-manuals/pdfgui/`). The interface speaks German or
English.

Besides the packages for createpdf, the GUI needs Tk and the packages
**tkutils** (tkuform, tkuballoon, tkustatus, tkufiledialog, tkudialog)
and **tclutils** (tutask). These, the translation and bookkit are looked
up in root folders: first the folder that holds the collection, then the
folders in `PDFGUI_ROOTS` (separated like `PATH`: `:` on Unix, `;` on
Windows). In each root folder:

| Folder | for |
|---|---|
| `tkutils/lib/tm`, `tclutils/lib/tm` | the packages of the GUI |
| `translation/tcltk-manual-de` or `tcltk-manual-de` | `de-markdown`, `en-markdown` |
| `bibliothek/books/bookkit` or `bookkit` | bookkit |
| `bibliothek/books` or `books` | the book tree ("Books" field) |

Each item is looked up on its own, so they may sit in different root
folders. `TCLTK_MANUAL_DE`, `BOOKKIT` and `PDFGUI_BOOKS` take precedence; packages Tcl
already finds (`TCL8_6_TM_PATH`, `TCL9_0_TM_PATH`, installed) need no
entry. The paths can also be chosen by hand in the GUI.

```bash
cd /path/to/tcltk-manuals
PDFGUI_ROOTS=$HOME/src wish scripts/pdfgui.tcl
```
