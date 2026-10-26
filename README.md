# tcltk-manuals

Handbuchseiten zu Tcl/Tk, Tcllib, Tklib und weiteren Erweiterungen als
Markdown und PDF, englisch (Original) und deutsch (Übersetzung), dazu
Bücher zu Tcl-Bibliotheken.

Manual pages for Tcl/Tk, Tcllib, Tklib and further extensions as Markdown
and PDF, in English (original) and German (translation), plus books on Tcl
libraries.

> **Inoffiziell / Unofficial.** Eine unabhängige Sammlung, keine
> Veröffentlichung der jeweiligen Projekte. Die Originaltexte stammen von
> deren Autoren und stehen unter deren Lizenzen; die englischen Seiten sind
> nur ins Markdown-Format umgewandelt. Fehler der Umwandlung oder der
> Übersetzung bitte hier melden, nicht bei den Projekten.
>
> An independent collection, not a publication of the projects. The
> original texts are by their authors and under their licenses; the English
> pages are only converted to Markdown. Please report conversion or
> translation errors here, not to the projects.

## Inhalt / Contents

Drei Gruppen, jede mit `en-markdown/`, `de-markdown/`, `en-pdf/` und
`de-pdf/`. Three groups, each with `en-markdown/`, `de-markdown/`,
`en-pdf/` and `de-pdf/`.

| Gruppe / group | Ordner / folders | PDFs |
|---|---|---|
| `Tcl-family/` — **Tcl-Familie** / *Tcl family* | `9.0/`, `8.6/` (Tcl und Tk; englisch auch die C-API in `tcl-c/`, `tk-c/`), `tcllib/`, `tklib/`, `pakete/` (Csaba Nemethi: tablelist, mentry, scrollutil, wcb, tsw) | `tcltk-9.0`, `tcltk-8.6`, `tcltk-*-capi` (en), `tcllib`, `tklib`, `tablelist`, `mentry`, `scrollutil`, `wcb`, `tsw` |
| `Extensions/` — **Erweiterungen** / *Extensions* | TDBC, Thread, [incr Tcl], BWidget, tDOM, tcltls, tclvfs, tcludp, tclhttpd, expect, mpexpr, mclistbox, tclws | `erweiterungen` |
| `Books/` — **Bücher** / *Books* | `Tclutils-de`, `Tclutils-en`, `pdf4tcl-de`, `pdf4tcllib-de` | gleichnamig / same names |

`scripts/` enthält die Werkzeuge / holds the tools: `createpdf/`,
`build-pdfs.sh`, `hole-lizenzen.sh`.

Die Seiten im Format TIP 700 tragen im YAML-Kopf Befehlsname, Abschnitt,
Stichwörter und die Copyright-Angaben des Originals.

## Lizenzen / Licenses

Jeder Teil steht unter der Lizenz seines Originals; die deutschen
Übersetzungen unter denselben Bedingungen wie ihr Original. Übersicht:
[LICENSES.md](LICENSES.md).

Each part is under the license of its original; the German translations
under the same terms as their original. Overview: [LICENSES.md](LICENSES.md).

## PDFs bauen / Building the PDFs

```bash
# Lizenztexte aus den Fossil-Klonen holen (einmal, und nach neuen Quellen)
bash scripts/hole-lizenzen.sh /pfad/zu/fossil /pfad/zu/nemethi

# alle PDFs, oder nur eine Sprache / einzelne PDFs
bash scripts/build-pdfs.sh
bash scripts/build-pdfs.sh -de tcltk-9.0 erweiterungen

# die Bücher brauchen bookkit / the books need bookkit
BOOKKIT=/pfad/zu/bookkit bash scripts/build-pdfs.sh Tclutils-de pdf4tcllib-de
```

Gebraucht werden Tcl 8.6 oder 9.x und die Pakete docir, mdstack, pdf4tcl
und pdf4tcllib; wo sie liegen, steht in
[scripts/createpdf/README.md](scripts/createpdf/README.md).

Requires Tcl 8.6 or 9.x and the packages docir, mdstack, pdf4tcl and
pdf4tcllib; see [scripts/createpdf/README.md](scripts/createpdf/README.md).
