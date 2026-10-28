# Weitere Pakete von core.tcl-lang.org (deutsch)

Deutsche Übersetzung der Seiten aus `en-markdown/erweiterungen/`.
Die Dateien liegen unter `de-markdown/erweiterungen/`; die Dateinamen
sind unverändert. Quellen unter `src/NAME/` (Herkunft je Paket in
`src/NAME/HERKUNFT.txt`).

| Ordner | Paket | Quelle | Format |
|---|---|---|---|
| `tdbc/` | TDBC (Kern) | `doc/*.n` | TIP 700 (n2md) |
| `tdbcsqlite3/`, `tdbcodbc/`, `tdbcmysql/`, `tdbcpostgres/` | TDBC-Treiber | `doc/*.n` | TIP 700 |
| `thread/` | Thread | `doc/man/*.n` | TIP 700 |
| `itcl/` | [incr Tcl] | `doc/*.n` | TIP 700 |
| `itk/` | [incr Tk] | `doc/*.n` | TIP 700 |
| `bwidget/` | BWidget | `BWman/*.html` | Markdown (h2md) |
| `tclws/` | Tcl Web Services | `docs/*.html` | Markdown (h2md) |

Stand 2026-10-22: 37 Handbuchseiten (nroff) und 49 HTML-Seiten, alle
umgewandelt. Übersetzt sind TDBC (10 Seiten), Thread (4 Seiten), itk (6 Seiten), itcl (17 Seiten), tclws (11 Seiten) und BWidget (38 Seiten). BWidget hat keine
Überschriften, nur Begriffslisten; Sprünge innerhalb einer Seite führen
deshalb an den Seitenanfang.

Geholt am 2026-10-23, noch nicht umgewandelt und nicht übersetzt: tDOM,
TclTLS, TclVFS, TclUDP, mpexpr, Tclhttpd, Expect und MCListbox. Sie
liegen unter `src/NAME/` mit `HERKUNFT.txt`. `KONVERTIERE-ERWEITERUNGEN.sh`
hat die Einträge schon. iwidgets (das Repository enthält keine Doku) und
TclApps (keine gemeinsame Doku, je Anwendung eigene) bleiben außen vor.
