# Was mdserver ist

## Einführung

[mdserver]{.index} **0.4** ist ein HTTP-Dienst in reinem Tcl (kein Tk).
Er liefert Markdown-Dateien zur Laufzeit als HTML aus. Eine Coroutine
pro Verbindung, non-blocking I/O: ein langsamer Client blockiert die
anderen nicht. Alles läuft in einem Thread; eine teure Anfrage hält die
anderen auf, bis sie fertig ist (Kapitel *HTTP-Verhalten*, Abschnitt
*Antwortzeiten*).

Module: `mdstack/tools/mdserver/lib/mdserver-0.4.tm`, die Suche in
`lib/mdserver/search-0.4.tm` und die Office- und CSV-Ansicht in
`lib/mdserver/view-0.4.tm`. Startskript:
`mdstack/tools/mdserver/mdserver.tcl`.

Dieses Handbuch beschreibt Start und Optionen, Navigation und Themes,
Seitenlayout und Suche, das HTTP-Verhalten, den Control-Port, TLS, den
Betrieb hinter einem Proxy und den Aufbau einer Site. Die Anhänge
sammeln Fallen, Aufrufe, ein Glossar und Fehlermeldungen. Änderungen
von Version zu Version stehen in der Paketdoku unter
`mdstack/tools/mdserver/`; dieses Buch beschreibt den aktuellen Stand.

---

## Was es tut

- HTTP immer, HTTPS optional (`tls`)
- Seitenlayout `site` als Vorgabe: Kopfleiste, Seitenleiste,
  Brotkrumen, „Auf dieser Seite“, Ordner als Kacheln, Dunkelmodus
- Volltextsuche über alle `.md` der Wurzel: `/?q=Wörter`, mit tclutils
  auch über PDFs (ein Treffer je Seite), Office- und CSV-Dateien; mit
  Suchtipps und Hilfe, wenn nichts gefunden wird
- Office- und CSV-Dateien als Seite statt als Download (mit tclutils)
- Ältere Stile `plain`, `sidebar`, `sticky`, `collapsible` mit Theme
  und TOC per Option und per URL
- Navigation: Startseite, Gesamt-Index, Bereiche aus den Top-Level-Ordnern
- Range (206), Conditional GET (304), Control-Port
- Statische Dateien (PDF, Bilder, CSS)
- Verzeichnisseite, wenn keine `index.md` liegt
- Buchordner mit `book.tcl`: Kapitel-Navigation, erzeugte Startseite

Dual: Tcl **8.6** und **9.0**.

## Was es nicht tut

Kein Parser eigener Syntax — rendert über mdstack und docir. Kein
Reverse-Proxy, keine Anmeldung, keine Firewall. Ohne `--bind` horcht
mdserver nur auf `127.0.0.1`; das passt hinter einem Proxy mit Anmeldung.
Die LAN-Installation steht in den Büchern *Proxmox LXC nginx* und
*Dokumentenserver LAN*.

---

## Abhängigkeiten

| Paket | verlangt | geprüft mit | Pflicht |
|---|---|---|---|
| Tcl | 8.6 oder 9 | 8.6.14, 9.0.4 | ja |
| `mdstack::parser` | 0.2 oder neuer | 0.9.2 | ja |
| `mdstack::html` | 0.1 oder neuer | 0.2 | ja |
| `docir` | 0.1 | 0.1.1 | ja (für `docir::html`) |
| `docir::mdSource` | — | 0.2 | ja (für `mdstack::html`) |
| `docir::html` | — | 0.2 | ja (für `mdstack::html`) |
| `docir::diag` | — | 0.1 | ja (für `docir::html`) |
| `docir::diagram` | — | 0.1 | ja (für `docir::html`) |
| `mdstack::theme` | 0.1 | 0.1 | empfohlen |
| `tclutils::tupdftext` | 0.1 | 0.1 (tclutils 0.68.0) | nur PDF-Suche |
| `tclutils::tutask` | 0.2 | 0.2 (tclutils 0.68.0) | nur PDF-Worker |
| `tclutils::tuodf`, `tudocx`, `tuxlsx` | 0.1 | 0.2, 0.1, 0.1 (tclutils 0.69.0) | nur Office-Dateien in Suche und Ansicht |
| `tclutils::tucsv` | 0.2 | 0.2 (tclutils 0.69.0) | nur CSV als Tabelle |
| `tclutils::tujson` | 0.1 | 0.1 (tclutils 0.69.0) | nur Suche als JSON |
| `tclutils::common` | 0.3 | 0.3 (tclutils 0.69.0) | nein; PDF-Cache über `replaceFile`, sonst dasselbe von Hand |
| `tls` | — | — | nur HTTPS |

Die [docir-Module]{.index} sind keine Kür. `mdstack::html` 0.2 lädt
`docir::mdSource` und `docir::html`, und `docir::html` lädt
`docir::diag` und `docir::diagram`. Fehlt eines, endet der Start mit
`can't find package docir::…` (Kapitel *Fehlermeldungen*).

Ohne `mdstack::theme` läuft der Server, aber `--theme` wirkt nicht. Am
Start steht dann eine Warnung.

Alle tclutils-Module sind freiwillig; fehlt eines, fällt nur seine
Funktion weg (Kapitel *Seitenlayout und Suche*). `tupdftext` (ab
tclutils 0.67.0) liest den Text von PDFs für die Suche, `tutask` startet
dafür einen zweiten `tclsh`. `tuodf`, `tudocx` und `tuxlsx` lesen
Office-Dateien, `tucsv` zeigt CSV als Tabelle, `tujson` gibt die Suche
als JSON aus (alle drei ab tclutils 0.69.0). Ohne tclutils durchsucht
mdserver nur Markdown.

HTTPS braucht das Paket `tls`, unter Debian:

```bash
apt install tcl-tls
```

Wo die Module liegen müssen, zeigt das Kapitel *Starten*.

---

## Zusammenfassung

- Ein Dienst, ein Prozess, Markdown wird HTML.
- 0.4 ist die Paketfassung aus `package provide mdserver`.
- mdstack allein reicht nicht: fünf docir-Module gehören dazu.
- tclutils ist freiwillig und schaltet PDF-, Office- und CSV-Dateien in
  Suche und Ansicht ein.
- Suche und Office-/CSV-Ansicht sind eigene Module neben dem Server-Modul.
- Bind Loopback, wenn nginx davor sitzt.

---

*Nächstes Kapitel: [Starten](020-starten.md)*
