# Lizenzen / Licenses

Dieses Repository enthält Dokumentation verschiedener Projekte. Jeder Teil
steht unter der Lizenz seines Originals; der Lizenztext liegt jeweils als
`license.terms`, `LICENSE`, `LICENSE.txt` oder `COPYRIGHT.txt` im Ordner neben den Seiten
und steht auch im Lizenzkapitel jedes PDFs.

This repository holds documentation from several projects. Each part is
under the license of its original; the license text sits next to the pages
as `license.terms`, `LICENSE`, `LICENSE.txt` or `COPYRIGHT.txt` and is printed in the
license chapter of every PDF.

## Englische Originale / English originals (`*/en-markdown/`, `*/en-pdf/`)

Die Ordner stehen unter `GRUPPE/en-markdown/` bzw. `GRUPPE/de-markdown/`.
Folders are below `GROUP/en-markdown/` and `GROUP/de-markdown/`.

| Ordner / folder | Projekt / project | Lizenz / license |
|---|---|---|
| | **Tcl-Familie / Tcl family** (`Tcl-family/`) | |
| `9.0/tcl`, `8.6/tcl`, `9.0/tcl-c`, `8.6/tcl-c` | Tcl (Befehle / C API) | `license.terms` (Tcl license, BSD style) |
| `9.0/tk`, `8.6/tk`, `9.0/tk-c`, `8.6/tk-c` | Tk (Befehle / C API) | `license.terms` (Tcl license, BSD style) |
| `tcllib` | Tcllib | `license.terms` (Tcl license, BSD style) |
| `tklib` | Tklib | `license.terms` (Tcl license, BSD style) |
| `pakete/tablelist`, `mentry`, `scrollutil`, `wcb`, `tsw` | Csaba Nemethi | `COPYRIGHT.txt` of the distribution |
| | **Erweiterungen / Extensions** (`Extensions/`) | |
| `thread` | Thread | `license.terms` |
| `tdbc`, `tdbc-c`, `tdbcsqlite3`, `tdbcmysql`, `tdbcodbc`, `tdbcpostgres` | TDBC | `license.terms` |
| `itcl`, `itcl-c`, `itk` | [incr Tcl], [incr Tk] | `license.terms` |
| `bwidget` | BWidget | `LICENSE.txt` |
| `tclws` | Tcl Web Services | `license.terms` |
| `tdom` | tDOM | `LICENSE`: Mozilla Public License 1.1 (full text included) |
| `tcltls`, `tclvfs`, `tcludp`, `tclhttpd`, `expect`, `mpexpr`, `mclistbox` | | `license.terms` from the project's Fossil repository (`scripts/hole-lizenzen.sh`) |

## Bearbeitungen / Modifications

Englische Seiten: nur ins Markdown-Format (TIP 700) umgewandelt, Text
unverändert; Auszeichnung ohne Platz im Format (Verweise ohne Ziel,
Layoutbilder) kann wegfallen. Deutsche Seiten: zusätzlich übersetzt. Für tDOM (Mozilla
Public License 1.1) ist das die Beschreibung der Änderungen nach
Abschnitt 3.3; sie steht auch vor dem Lizenzkapitel jedes PDFs.

English pages: only converted to Markdown (TIP 700), text unchanged;
markup without a place in the format (links without a target, layout
images) may be lost.
German pages: also translated. For tDOM (Mozilla Public License 1.1) this
is the description of modifications under section 3.3; it is also printed
before the license chapter of every PDF.

Berichtigt / corrected: Tcllib `tool` – die Stichwörter im Original sind
versehentlich Sätze aus der Beschreibung; im YAML-Kopf stehen statt
dessen `TOOL`, `TclOO`, `framework`. / The keywords in the original are
sentences from the description by mistake; the YAML head lists `TOOL`,
`TclOO`, `framework` instead.

**mclistbox:** die Lizenz von Bryan Oakley erlaubt die Nutzung („may be
used free of charge“), sagt aber nichts ausdrücklich über Änderung und
Weitergabe. / Bryan Oakley's license permits use ("may be used free of
charge") but says nothing explicit about modification and redistribution.

## Deutsche Übersetzungen / German translations (`*/de-markdown/`, `*/de-pdf/`)

Deutsche Übersetzung © 2026 Gregor Ebbing. Jede Übersetzung steht unter
denselben Bedingungen wie ihr englisches Original (Tabelle oben). Die
Copyright-Angaben der Originalseiten bleiben bei jeder Seite.

German translation © 2026 Gregor Ebbing. Each translation is under the same
terms as its English original (table above). The copyright notices of the
original pages stay with each page.

## Bücher / Books (`Books/`)

| Ordner / folder | Lizenz / license |
|---|---|
| `de-markdown/Tclutils-de`, `en-markdown/Tclutils-en` | Text CC BY-SA 4.0, Code-Beispiele MIT (`LICENSE`) |
| `de-markdown/pdf4tcl-de`, `en-markdown/pdf4tcl-en` | Text CC BY-SA 4.0, Code-Beispiele MIT (`LICENSE`) |
| `de-markdown/pdf4tcllib-de`, `en-markdown/pdf4tcllib-en` | Text CC BY-SA 4.0, Code-Beispiele MIT (`LICENSE`) |
| `de-markdown/Tkutils-de`, `en-markdown/Tkutils-en` | Text CC BY-SA 4.0, Code-Beispiele MIT (`LICENSE`) |
| `de-markdown/Mdserver-de`, `en-markdown/Mdserver-en` | Text CC BY-SA 4.0, Code-Beispiele MIT (`LICENSE`) |

Der Lizenztext steht als letztes Kapitel in jedem Buch-PDF (bookkit,
`book-build.tcl`). / The license text is the last chapter of every book PDF.

## Skripte / Scripts (`scripts/`)

`createpdf`, `build-pdfs.sh`, `hole-lizenzen.sh`, `katalog.tsv`,
`katalog.tcl`, `tests/`: MIT, © 2026 Gregor Ebbing.
