# Utils-Stack

*Stand: 2026-10-28*

Handbuch zum **Pairing** von [tclutils]{.index} **0.69.0**,
[tkutils]{.index} **0.49.0** und [ctrlutils]{.index} **0.4**: Model / View /
Controller, Setup aller drei Bibliotheken, Tests, die fünf Controller,
Explorer und Dateiblick. Dazu die Kalender-Engine [tical]{.index} **1.1**,
auf der zwei optionale Kalender-Widgets von tkutils aufbauen. Im
Sammelpaket ctrlutils 0.5 stecken `cufileops` 0.6, `cuundo` 0.5,
`cusync` 0.3 und `cufilter` 0.2.

Beispiele und Testsuiten geprüft mit Tcl/Tk 8.6.14 und 9.0.4 unter
Linux (Xvfb); unter macOS und Windows nur die Testsuiten.

API-Bücher daneben: *tclutils* und *tkutils*. Dieses Buch ändert keinen
Lib-Code und nicht den Explorer unter `ctrlutils/apps/explorer/`.

## Zielgruppe

- Wer eine Datei- oder Provider-App verdrahten will
- Wer ctrlutils (5 Module) im Kontext braucht, nicht als eigenes Dickbuch
- Wer einen Kalender mit tical in eine Stack-Anwendung einbaut

## Umfang

`book.tcl`: **14** Kapiteldateien (10 Kapitel + 4 Anhänge). Buchtyp: Handbuch
(`booktype manual`, Regeln in `bookkit/doc/de/STYLE.md`).

Englische Ausgabe: `Utils-Stack-en/` neben diesem Ordner, mit denselben
Dateinamen.

## PDF und HTML bauen

Aus dem Ordner, in dem `bookkit/` liegt:

```bash
tclsh bookkit/tools/book-build.tcl <buchordner>/Utils-Stack-de/ -number
```

Entstanden mit Unterstützung von KI-Werkzeugen; Text und Beispiele sind vom Autor geprüft.

## Lizenz

Doku: [CC BY-SA 4.0](LICENSE). Beispiele: [MIT](LICENSE).
Libs: MIT (Upstream).
