# tcltk-manuals

*[English](README.md) · Deutsch*

Handbuchseiten zu Tcl/Tk, Tcllib, Tklib und weiteren Erweiterungen als
Markdown und PDF, englisch (Original) und deutsch (Übersetzung), dazu
Bücher zu Tcl-Bibliotheken.

> **Inoffiziell.** Eine unabhängige Sammlung, keine Veröffentlichung der
> jeweiligen Projekte. Die Originaltexte stammen von deren Autoren und
> stehen unter deren Lizenzen; die englischen Seiten sind nur ins
> Markdown-Format umgewandelt. Fehler der Umwandlung oder der Übersetzung
> bitte hier melden, nicht bei den Projekten.

## Inhalt

Drei Gruppen, jede mit `en-markdown/`, `de-markdown/`, `en-pdf/` und
`de-pdf/`.

| Gruppe | Ordner | PDFs |
|---|---|---|
| `Tcl-family/` (Tcl-Familie) | `9.0/`, `8.6/` (Tcl und Tk; englisch auch die C-API in `tcl-c/`, `tk-c/`), `tcllib/`, `tklib/`, `pakete/` (Csaba Nemethi: tablelist, mentry, scrollutil, wcb, tsw) | `tcltk-9.0`, `tcltk-8.6`, `tcltk-*-capi` (en), `tcllib`, `tklib`, `tablelist`, `mentry`, `scrollutil`, `wcb`, `tsw`; **`tcl-family-index`** |
| `Extensions/` (Erweiterungen) | TDBC, Thread, [incr Tcl], BWidget, tDOM, tcltls, tclvfs, tcludp, tclhttpd, expect, mpexpr, mclistbox, tclws | `erweiterungen` |
| `Books/` (Bücher) | `Tclutils-de`, `Tclutils-en`, `pdf4tcl-de`, `pdf4tcl-en`, `pdf4tcllib-de`, `pdf4tcllib-en` | gleichnamig |

**Gesamtindex:** `Tcl-family/de-pdf/tcl-family-index-de.pdf` und
`Tcl-family/en-pdf/tcl-family-index-en.pdf` führen die Stichwörter aller
PDFs der Tcl-Familie in einem Verzeichnis zusammen; jede Seitenzahl
springt in das jeweilige PDF. Dafür müssen die PDFs im selben Ordner
liegen (wie im Repository); Acrobat, Okular und Evince folgen den
Sprüngen, manche Betrachter im Browser nicht.

`scripts/` enthält die Werkzeuge: `createpdf/` (mit `index-gesamt.tcl`),
`build-pdfs.sh`, `hole-lizenzen.sh` und die Oberfläche `pdfgui.tcl`.

Die Seiten im Format TIP 700 tragen im YAML-Kopf Befehlsname, Abschnitt,
Stichwörter und die Copyright-Angaben des Originals.

## Lizenzen

Jeder Teil steht unter der Lizenz seines Originals; die deutschen
Übersetzungen unter denselben Bedingungen wie ihr Original. Übersicht:
[LICENSES.md](LICENSES.md).

## PDFs bauen

```bash
# Lizenztexte aus den Fossil-Klonen holen (einmal, und nach neuen Quellen)
bash scripts/hole-lizenzen.sh /pfad/zu/fossil /pfad/zu/nemethi

# alle PDFs, oder nur eine Sprache / einzelne PDFs
bash scripts/build-pdfs.sh
bash scripts/build-pdfs.sh -de tcltk-9.0 erweiterungen

# nach einzelnen PDFs der Tcl-Familie den Gesamtindex neu bauen
bash scripts/build-pdfs.sh -de tcllib tcl-family-index

# die Bücher brauchen bookkit
BOOKKIT=/pfad/zu/bookkit bash scripts/build-pdfs.sh Tclutils-de pdf4tcllib-de
```

Gebraucht werden Tcl 8.6 oder 9.x und die Pakete docir, mdstack, pdf4tcl
und pdf4tcllib; wo sie liegen, steht in
[scripts/createpdf/README.md](scripts/createpdf/README.md) (englisch).

## Oberfläche

```bash
wish scripts/pdfgui.tcl
```

`pdfgui.tcl` macht dasselbe wie `build-pdfs.sh` mit einer Oberfläche:
Handbücher und Sprachen wählen, Titel, Untertitel, Vermerk und die Teile
des PDFs einstellen, bauen, abbrechen. „Seiten übernehmen“ kopiert die
gewählten Handbücher aus den Ordnern `de-markdown` und `en-markdown` der
Übersetzung (tcltk-manual-de) in die Sammlung; Lizenzdateien bleiben.
Einstellungen lassen sich unter einem Namen speichern
(`~/.config/tcltk-manuals/pdfgui/`). Die Oberfläche spricht Deutsch oder
Englisch.

Zusätzlich zu den Paketen für createpdf braucht die Oberfläche Tk und
die Pakete **tkutils** (tkuform, tkuballoon, tkustatus, tkufiledialog,
tkudialog) und **tclutils** (tutask). Gesucht werden sie, ebenso die
Übersetzung und bookkit, in Wurzelordnern: zuerst im Ordner, in dem die
Sammlung liegt, dann in den Ordnern aus `PDFGUI_ROOTS` (getrennt wie
`PATH`: unter Unix mit `:`, unter Windows mit `;`). In jedem
Wurzelordner:

| Ordner | für |
|---|---|
| `tkutils/lib/tm`, `tclutils/lib/tm` | die Pakete der Oberfläche |
| `translation/tcltk-manual-de` oder `tcltk-manual-de` | `de-markdown`, `en-markdown` |
| `bibliothek/books/bookkit` oder `bookkit` | die Bücher |

Jedes Teil wird für sich gesucht, es darf also in verschiedenen
Wurzelordnern liegen. `TCLTK_MANUAL_DE` und `BOOKKIT` gehen vor; Pakete,
die Tcl schon findet (`TCL8_6_TM_PATH`, `TCL9_0_TM_PATH`, installiert),
brauchen keinen Eintrag. Die Pfade lassen sich in der Oberfläche auch
von Hand wählen.

```bash
cd /pfad/zu/tcltk-manuals
PDFGUI_ROOTS=$HOME/src wish scripts/pdfgui.tcl
```
