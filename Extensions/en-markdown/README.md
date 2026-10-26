# Weitere Pakete von core.tcl-lang.org (englisch)

Umgewandelt mit `KONVERTIERE-ERWEITERUNGEN.sh`; Quellen unter `src/NAME/`
(Herkunft je Paket in `src/NAME/HERKUNFT.txt`).

| Ordner | Paket | Quelle | Format |
|---|---|---|---|
| `tdbc/` | TDBC (Kern) | `doc/*.n` | TIP 700 (n2md) |
| `tdbcsqlite3/`, `tdbcodbc/`, `tdbcmysql/`, `tdbcpostgres/` | TDBC-Treiber | `doc/*.n` | TIP 700 |
| `thread/` | Thread | `doc/man/*.n` | TIP 700 |
| `itcl/` | [incr Tcl] | `doc/*.n` | TIP 700 |
| `itk/` | [incr Tk] | `doc/*.n` | TIP 700 |
| `bwidget/` | BWidget | `BWman/*.html` | Markdown (h2md) |
| `tclws/` | Tcl Web Services | `docs/*.html` | Markdown (h2md) |
| `tdom/` | tDOM | `doc/*.n` | TIP 700 |
| `tcltls/` | TclTLS | `doc/*.n` | TIP 700 |
| `tclvfs/` | TclVFS | `doc/*.n`, `doc/vfs-*.man` (doctools) | TIP 700 |
| `tcludp/` | TclUDP | `doc/*.n` | TIP 700 |
| `tclhttpd/` | Tclhttpd | `doc/httpd.1` | TIP 700 |
| `expect/` | Expect | `expect.man`, `libexpect.man` (nroff) | TIP 700 |
| `mpexpr/` | mpexpr | `doc/*.html` | Markdown (h2md) |
| `mclistbox/` | MCListbox | `mclistbox.html` | Markdown (h2md) |
| `itcl-c/` | [incr Tcl], C-Schnittstelle | `doc/*.3` | TIP 700 |
| `tdbc-c/` | TDBC, C-Schnittstelle | `doc/*.3` | TIP 700 |

Stand 2026-10-22: 37 Handbuchseiten (nroff) und 49 HTML-Seiten, alle
umgewandelt. BWidget hat keine Überschriften, nur Begriffslisten; Sprünge
innerhalb einer Seite führen deshalb an den Seitenanfang.

Stand 2026-10-24: auch die acht 2026-10-23 geholten Pakete und die
`.3`-Seiten von itcl und tdbc (eigene Ordner `-c`, weil `Class.3` und
`class.n` unter Windows und macOS dieselbe Datei wären). Braucht n2md ab
2026-10-24 (Schriftmakros für Expect, `\&\fR` bei tDOM, `.AP`). Wo es
neben `.n` noch `.html`, `.xml` oder `.man` gibt (tDOM, TclTLS, TclUDP),
gilt das `.n`. iwidgets und TclApps bleiben außen vor.

BWidget und TclWS: ein neuer Lauf mit dem aktuellen h2md ändert ein paar
Leerzeilen (bwidget 3, tclws 8 Seiten). Am 2026-10-24 sind diese beiden
Ordner deshalb auf dem alten Stand geblieben, auf dem die Übersetzung
beruht.
