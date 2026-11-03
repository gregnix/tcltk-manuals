# Tcl/Tk unter Linux

*Stand: 2026-11-03*

Ein deutschsprachiges Werkstattbuch für [Tcl/Tk]{.index} unter Linux:
Plattformwert, mehrere Interpreter, XDG, Suchpfade der Distribution,
Kodierung aus der Locale, `exec`, X11 und Fenstermanager, Schriften und
Skalierung, Mausrad und Zwischenablage, Desktop-Integration, Xfce,
GUI-Tests unter Xvfb, Bauabhängigkeiten und Weitergabe.

Die Beispiele verwenden Tcl 8.6 aus der Distribution und Tcl/Tk 9.0.4
unter `/opt/tcl9`, auf Debian und Ubuntu mit X11 und Xfce 4.20.
Grundlage sind fünf Howto-Serien des Autors (`serie-linux`,
`serie-xvfb`, `serie-xfce`, `serie-tcltk-bauen`, `serie-tcl9-app`).
Die Serien sind nicht veröffentlicht; Angaben wie „(`serie-linux`,
Howto 08)“ nennen das Skript, mit dem ein Wert geprüft wurde. Zum
Nachprüfen liegen die Skripte in `beispiele/` beim Buch.
Rechner, Versionen und offene Prüfungen: Anhang F.

Wichtig für Leser, die von Tk 8.6 kommen: Tk 9 meldet das Mausrad unter
X11 als `<MouseWheel>` und vergibt `<Button-4>`/`<Button-5>` an die
Seitentasten 8 und 9; `<Command-c>` greift unter Tk 9 auf X11 bei
keiner Taste; `file normalize ~` löst unter Tcl 9 die Tilde nicht mehr
auf; `wish` ohne Anzeige endet mit Rückgabewert 0.

Autor: Gregor Ebbing. Text und Skripte entstanden mit Unterstützung
von Claude (Anthropic); die Programmausgaben stammen aus den
Howto-Serien des Autors und aus Prüfungen in einem Ubuntu-Container.
Quellen: Anhang E.

## Zielgruppe

- Leser, die Tcl/Tk-Code auf Linux von macOS und Windows trennen
- Wer ein Tcl 9 unter `/opt` neben dem Distributions-Tcl betreibt
- Wer Tk-Oberflächen unter Xvfb in einer Pipeline testet

## Umfang

`book.tcl` ist die Build-Wahrheit: **23** Kapiteldateien (17 Kapitel + 6 Anhänge).

| Kennzahl | Wert |
|---|---|
| Hauptkapitel | 17 |
| Anhänge | 6 |
| **Gesamt** | 23 Markdown-Dateien |
| Sprache | Deutsch |

## Struktur

Kapitel liegen flach als `NNN-*.md` (bookkit). Inhaltsübersicht:
[`BUCHSTRUKTUR.md`](BUCHSTRUKTUR.md), Build: [`BOOKKIT.md`](../BOOKKIT.md).

## PDF und HTML bauen (bookkit)

```bash
cd ..
tclsh bookkit/tools/book-build.tcl book-linux-tcltk/Linux-TclTk-de/ -number
```

Ausgabe: `Linux-TclTk-de.pdf` / `.html` in `bibliothek/books/book-linux-tcltk/`.

## Empfohlene Lesereihenfolge

### Einstieg

1. **Teil 1** — Plattform, welches Tcl, Pfade und XDG, Suchpfade,
   Kodierung, `exec`
2. **Teil 2** — X11 und Fenstermanager, Schriften, Maus und Tastatur,
   Desktop, Xfce
3. **Teil 3** — Tests unter Xvfb, Bauabhängigkeiten, Weitergeben, FAQ

### Anhang

1. **Anhang A (Fallen)** nebenbei offen halten
2. **Anhang B (CLI)**: Prüfskript und Ergebnisse der Serien im Container
3. **Anhang F (Testumgebung)**: womit die Beispiele ausprobiert sind und
   was noch offen ist

## Lizenz

Linux ist eine Marke von Linus Torvalds. Debian, Ubuntu und Xfce sind
Marken bzw. Namen ihrer Inhaber. Das Buch steht in keiner Verbindung
zu ihnen.

Doku-Text: [CC BY-SA 4.0](LICENSE)
Code-Beispiele: [MIT](LICENSE)

## Mitwirkung

Korrekturen und Ergänzungen sind willkommen — siehe [CONTRIBUTING.md](CONTRIBUTING.md).

## Stil

- **Werkstattbuch** (`booktype workshop`, Regeln: `bookkit/doc/de/STYLE.md`)
- **Imperativ und unpersönliche Form** — keine "du"-Anrede
- Deutsche Fachbegriffe wo etabliert, englische wo geläufig
- Querverweise zu anderen Kapiteln und Anhängen

## Verwandte Werke

- *Debian unter Linux* — `book-linux-debian`, Kapitel Tcl unter Linux
- *Tcl/Tk unter macOS* — `book-macos-tcltk` (Schwesterbuch)
- *Windows 11* — `book-mswindows11`, Kapitel Tcl unter Windows
- *Tcl/Tk 9.0 bauen*, *Tcl/Tk 9.1 bauen* — `book-tcltk9.0-bauen`,
  `book-tcltk9.1-bauen`, Kapitel Unix
- *Tcl-Anwendungen ausliefern* (im Text kurz *Ausliefern*) —
  `book-tcl-ausliefern`, Kapitel zipfs, Zipkits, Linux: deb und rpm
- *C-Erweiterungen* — `book-tcl-erweiterungen`
