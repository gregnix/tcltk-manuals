# tcltk-manuals

*English · [Deutsch](README.de.md)*

Manual pages for Tcl/Tk, Tcllib, Tklib and further extensions as Markdown
and PDF, in English (original) and German (translation), plus books on Tcl
libraries.

> **Unofficial.** An independent collection, not a publication of the
> projects. The original texts are by their authors and under their
> licenses; the English pages are only converted to Markdown. Please report
> conversion or translation errors here, not to the projects.

## Contents

Three groups, each with `en-markdown/`, `de-markdown/`, `en-pdf/` and
`de-pdf/`.

| Group | Folders | PDFs |
|---|---|---|
| `Tcl-family/` | `9.0/`, `8.6/` (Tcl and Tk; in English also the C API in `tcl-c/`, `tk-c/`), `tcllib/`, `tklib/`, `pakete/` (Csaba Nemethi: tablelist, mentry, scrollutil, wcb, tsw) | `tcltk-9.0`, `tcltk-8.6`, `tcltk-*-capi` (en), `tcllib`, `tklib`, `tablelist`, `mentry`, `scrollutil`, `wcb`, `tsw`; **`tcl-family-index`** |
| `Extensions/` | TDBC, Thread, [incr Tcl], BWidget, tDOM, tcltls, tclvfs, tcludp, tclhttpd, expect, mpexpr, mclistbox, tclws | `erweiterungen` |
| `Books/` | `Tclutils-de`, `Tclutils-en`, `pdf4tcl-de`, `pdf4tcl-en`, `pdf4tcllib-de`, `pdf4tcllib-en` | same names |

**Combined index:** `Tcl-family/en-pdf/tcl-family-index-en.pdf` and
`Tcl-family/de-pdf/tcl-family-index-de.pdf` gather the keywords of all
Tcl family PDFs in one index; every page number jumps into that PDF. Keep
the PDFs in one folder, as in the repository. Acrobat, Okular and Evince
follow the jumps; some viewers in the browser do not.

`scripts/` holds the tools: `createpdf/` (with `index-gesamt.tcl`),
`build-pdfs.sh`, `hole-lizenzen.sh` and the GUI `pdfgui.tcl`.

The pages in TIP 700 format carry the command name, section, keywords and
the copyright lines of the original in their YAML head.

The Markdown pages follow the format of TIP 700, which `man2markdown.tcl`
in the Tcl sources also uses. They were converted with `n2md` from the
[man-viewer](https://github.com/gregnix/man-viewer) project. This
independently developed tool supports Tcl/Tk 8.6, Tcllib, Tklib and further
extensions as well as Tcl/Tk 9. `n2md` is meant as a complementary tool and
does not claim to replace `man2markdown.tcl`.

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
```

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
collection; license files stay. Settings can be saved under a name
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
| `bibliothek/books/bookkit` or `bookkit` | the books |

Each item is looked up on its own, so they may sit in different root
folders. `TCLTK_MANUAL_DE` and `BOOKKIT` take precedence; packages Tcl
already finds (`TCL8_6_TM_PATH`, `TCL9_0_TM_PATH`, installed) need no
entry. The paths can also be chosen by hand in the GUI.

```bash
cd /path/to/tcltk-manuals
PDFGUI_ROOTS=$HOME/src wish scripts/pdfgui.tcl
```
