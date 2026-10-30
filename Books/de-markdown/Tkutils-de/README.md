# tkutils

*Stand: 2026-10-27*

Handbuch für [tkutils]{.index} **0.49.0**: Tk-Widgets über den Engines
aus tclutils. Dialoge, Dateiliste, tablelist und ihre Helfer, Geometrie,
Aktionen, Gerüst, Eingabe, Kalender und Notizen, Datenansicht, Designer,
Bilder und die App tkdevtools.

Paarung: tclutils **0.69.0** + tkutils **0.49.0** + ctrlutils **0.5**
(mindestens tclutils 0.64.0; den CSV-Export von `tkutablelist` erst mit
0.69.0).

Verwandte Bücher: Die Engines beschreibt das Buch *tclutils*, Stack,
Controller und tical das Buch *Utils-Stack*, Tk-Grundlagen ohne tkutils
das Buch *TclTk-Benutzeroberflächen*. Dieses Buch ändert den Modulcode
nicht.

Geprüft gegen tkutils 0.49.0 mit Tcl/Tk 8.6.14 und 9.0.4 unter Linux
und Xvfb. Windows und macOS sind nicht geprüft; Umgebung und offene
Punkte: Anhang G.

Die englische Ausgabe liegt im Nachbarordner `Tkutils-en/`, mit
denselben Dateinamen.

## Zielgruppe

- Desktop-Apps auf Provider und ttk
- Wer Dialoge und File-Widgets wiederverwenden will

## Umfang

`book.tcl`: **23** Kapiteldateien (16 Kapitel + 7 Anhänge). Buchtyp: Handbuch
(`booktype manual`, Regeln in `bookkit/doc/de/STYLE.md`).

## PDF und HTML bauen

```bash
cd ../..
tclsh bookkit/tools/book-build.tcl book-tkutils/Tkutils-de/ -number
```

Entstanden mit Unterstützung von KI-Werkzeugen; Text und Beispiele sind vom Autor geprüft.

## Lizenz

Doku: [CC BY-SA 4.0](LICENSE). Beispiele: [MIT](LICENSE).
tkutils selbst: MIT (Upstream).
