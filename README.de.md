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
>
> Die deutsche Übersetzung entstand mit Unterstützung von DeepL und
> KI-Werkzeugen und wurde von Hand durchgesehen und überarbeitet. Die Skripte
> entstanden mit Unterstützung von KI-Werkzeugen und werden vom Autor geprüft
> und getestet.

## Inhalt

Drei Gruppen, jede mit `en-markdown/`, `de-markdown/`, `en-pdf/` und
`de-pdf/`.

| Gruppe | Ordner | PDFs |
|---|---|---|
| `Tcl-family/` (Tcl-Familie) | `9.0/`, `8.6/` (Tcl und Tk; englisch auch die C-API in `tcl-c/`, `tk-c/`), `tcllib/`, `tklib/`, `pakete/` (Csaba Nemethi: tablelist, mentry, scrollutil, wcb, tsw) | `tcltk-9.0`, `tcltk-8.6`, `tcltk-*-capi` (en), `tcllib`, `tklib`, `tablelist`, `mentry`, `scrollutil`, `wcb`, `tsw`; **`tcl-family-index`**, **`nemethi-index`** |
| `Extensions/` (Erweiterungen) | TDBC, Thread, [incr Tcl], BWidget, tDOM, tcltls, tclvfs, tcludp, tclhttpd, expect, mpexpr, mclistbox, tclws | `erweiterungen`, `bwidget` (nur BWidget) |
| `Books/` (Bücher) | `Tclutils-de`, `Tclutils-en`, `pdf4tcl-de`, `pdf4tcl-en`, `pdf4tcllib-de`, `pdf4tcllib-en`, `Tkutils-de`, `Tkutils-en`, `Mdserver-de`, `Mdserver-en` | gleichnamig |

**Gesamtindex:** `Tcl-family/de-pdf/tcl-family-index-de.pdf` und
`Tcl-family/en-pdf/tcl-family-index-en.pdf` führen die Stichwörter aller
PDFs der Tcl-Familie in einem Verzeichnis zusammen; jede Seitenzahl
springt in das jeweilige PDF. Dafür müssen die PDFs im selben Ordner
liegen (wie im Repository); Acrobat, Okular und Evince folgen den
Sprüngen, manche Betrachter im Browser nicht.

**Teil-Indizes:** Ein Index kann auch nur einige Handbücher zusammenfassen,
etwa `nemethi-index` (`Tcl-family/LANG-pdf/nemethi-index-LANG.pdf`) die
fünf Pakete von Csaba Nemethi. Dafür eine Zeile mit `art` = `index` in
`scripts/katalog.tsv`, in der Spalte `quelle` die Handbücher mit Komma
(`tablelist,mentry,scrollutil,wcb,tsw`, in dieser Reihenfolge; jedes ein
Handbuch derselben Gruppe). `-` heißt alle Handbücher der Gruppe (wie
`tcl-family-index`). Gebaut wird er wie der Gesamtindex, aus den
vorhandenen `.index.tsv`; eine fehlende Tabelle wird mit Meldung
ausgelassen.

`scripts/` enthält die Werkzeuge: `createpdf/` (mit `index-gesamt.tcl`),
`build-pdfs.sh`, `hole-lizenzen.sh` und die Oberfläche `pdfgui.tcl`. Die
Liste der PDFs steht in `scripts/katalog.tsv`; `build-pdfs.sh` und die
Oberfläche lesen sie beide.

Die Seiten im Format TIP 700 tragen im YAML-Kopf Befehlsname, Abschnitt,
Stichwörter und die Copyright-Angaben des Originals.

Die Markdown-Seiten orientieren sich am Format von TIP 700, das auch
`man2markdown.tcl` aus den Tcl-Quellen verwendet. Die Umwandlung erfolgte
mit `n2md` aus dem Projekt [man-viewer](https://github.com/gregnix/man-viewer).
Dieses unabhängig entwickelte Werkzeug unterstützt neben Tcl/Tk 9 auch
Tcl/Tk 8.6, Tcllib, Tklib und weitere Erweiterungen. `n2md` ist als
ergänzendes Werkzeug gedacht und erhebt nicht den Anspruch,
`man2markdown.tcl` zu ersetzen.

## Ein Buch aufnehmen

In der Oberfläche: „Bücher“ auf den Bücherbaum setzen, „Buch aufnehmen…“,
den Ausgabeordner (mit `book.tcl`, etwa `book-tkutils/Tkutils-de`) oder
den Buchordner darüber (`book-tkutils`, dann alle Ausgaben darin) wählen.
Die Sprache kommt aus `set lang` in `book.tcl`, sonst aus der Endung
`-de`/`-en`, sonst fragt die Oberfläche. Sie zeigt die neuen Zeilen für
`scripts/katalog.tsv` (schon vorhandene Namen werden nicht doppelt
eingetragen), hängt sie an und übernimmt die Seiten auf Wunsch gleich.
Die Schritte 3 und 4 bleiben. Der Ordner muss unter dem Bücherbaum
liegen, im Katalog stehen nur relative Pfade.

Von Hand:

1. Je Sprache eine Zeile in `scripts/katalog.tsv` (Tabulatoren, Spalten
   im Kopf der Datei), etwa
   `Tkutils-de  buch  Books  Tkutils-de  *  de  book-tkutils/Tkutils-de  -  -`.
2. Seiten holen: in der Oberfläche das Buch wählen, „Bücher“ auf den
   Bücherbaum setzen, „Seiten übernehmen“. Oder von Hand den Buchordner
   nach `Books/de-markdown/Tkutils-de` kopieren, ohne `*.pdf`, `*.html`,
   `.gitignore`, `nogit/`, `CONTRIBUTING.md`, `BUCHSTRUKTUR.md`. Nötig sind `book.tcl` und `LICENSE`.
3. Das Buch in die Tabelle oben und in [LICENSES.md](LICENSES.md)
   eintragen.
4. Bauen: `BOOKKIT=/pfad/zu/bookkit bash scripts/build-pdfs.sh Tkutils-de`.

Prüfen: `tclsh scripts/tests/katalog-test.tcl /pfad/zu/books` liest den
Katalog, prüft das Aufnehmen an einer Kopie und spiegelt die Bücher
probeweise in einen Arbeitsordner.

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

# Stichwörter der Handbücher (Vorgabe auto)
bash scripts/build-pdfs.sh -index-terms keywords tablelist
```

**Stichwörter:** Das Stichwortverzeichnis eines Handbuchs nimmt den
Befehlsnamen und die `Keywords:` aus dem YAML-Kopf. Seiten ohne YAML-Kopf
(aus HTML umgewandelt: Nemethi-Pakete, BWidget, TclWS, mpexpr, mclistbox)
bekommen dazu Begriffe aus dem Text: Optionen und Befehle der
Definitionslisten (`-arrowstyle`, `cellconfigure`, `header bbox`),
Überschriften ab Ebene 2 (ohne Allerweltsüberschriften wie Inhalt oder
Beispiele) und mit `[Wort]{.index}` markierte Wörter; jeder springt an
seine Stelle. `-index-terms` wählt: `auto` (Vorgabe) wie beschrieben,
`keywords` nur Befehlsname und Keywords (wie früher), `all` Begriffe aus
dem Text jeder Seite. Einzelheiten:
[scripts/createpdf/README.md](scripts/createpdf/README.md) (englisch).

**HTML-Doku direkt als PDF:** `createpdf.tcl` liest auch einen Ordner
mit HTML-Seiten (Paketdoku wie `tablelist7.12/doc`), wandelt sie mit dem
HTML-Leser von docir in einen temporären Ordner um und baut das PDF wie
aus Markdown, mit abgeleiteten Stichwörtern:
`tclsh scripts/createpdf/createpdf.tcl /pfad/zu/tablelist7.12/doc -o tablelist.pdf`
(braucht tdom; siehe
[scripts/createpdf/README.md](scripts/createpdf/README.md), „HTML pages“).

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
Gewählte Bücher kommen aus dem Feld „Bücher“ (dem Bücherbaum, etwa
`bibliothek/books`): der Ordner aus der Spalte `quelle` des Katalogs wird
nach `Books/LANG-markdown/ORDNER` gespiegelt, ohne `*.pdf`, `*.html`,
`.gitignore`, `nogit/`, `CONTRIBUTING.md` und `BUCHSTRUKTUR.md`
(Hinweise zum Schreiben am Buch); was in der Quelle fehlt, wird entfernt,
unveränderte Dateien bleiben unberührt. „Buch aufnehmen…“ trägt ein
Buch aus dem Bücherbaum in den Katalog ein (siehe oben). Das Feld „Eigener
Ordner“ nimmt einen weiteren Ordner mit Markdown- oder HTML-Seiten. Das Feld
„Stichwörter ableiten“ reicht `-index-terms` durch (automatisch, nur
Keywords, alle Seiten). Einstellungen lassen sich unter einem Namen speichern
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
| `bibliothek/books/bookkit` oder `bookkit` | bookkit |
| `bibliothek/books` oder `books` | der Bücherbaum (Feld „Bücher“) |

Jedes Teil wird für sich gesucht, es darf also in verschiedenen
Wurzelordnern liegen. `TCLTK_MANUAL_DE`, `BOOKKIT` und `PDFGUI_BOOKS`
gehen vor; Pakete, die Tcl schon findet (`TCL8_6_TM_PATH`,
`TCL9_0_TM_PATH`, installiert), brauchen keinen Eintrag. Die Pfade lassen sich in der Oberfläche auch
von Hand wählen.

```bash
cd /pfad/zu/tcltk-manuals
PDFGUI_ROOTS=$HOME/src wish scripts/pdfgui.tcl
```
