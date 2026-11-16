# mdserver — Handbuch

*Stand: 2026-11-16*

Handbuch für den HTTP-Dienst [mdserver]{.index} **0.5**: Markdown zur
Laufzeit als HTML, ohne Tk. Mit Seitenlayout `site`, Volltextsuche über
Markdown und (mit tclutils) PDFs, Office- und CSV-Dateien, Office- und
CSV-Dateien als Seite, erzeugten Buch-Startseiten, Anmeldung mit
Rechten je Ordner, Einstellungsdatei und GUI. mdserver ist seit 0.5 ein
eigenes Repository (bis 0.4 `mdstack/tools/mdserver/`); Module
`lib/mdserver-0.5.tm` und `lib/mdserver/*-0.5.tm`. Die Paketdoku steht
dort unter `doc/`.

Geprüft mit mdstack (parser 0.9.2, html 0.2), docir 0.1.1 (mdSource
0.2, html 0.2), tclutils 0.69.0, Tcl 8.6.14 und 9.0.4; Tests
`test-mdserver-oo.tcl` (186) und `test-mdserver-gui.tcl` (18).

LXC, Samba, nginx und Firewall: Lehrbuch *Nginx* und die beiden
LAN-Bücher. Dieses Buch ist das Programm, als Handbuch
(`booktype manual`, Regeln in `bookkit/doc/de/STYLE.md`).

## Zielgruppe

- Wer den Dienst startet, prüft und beendet
- Wer Optionen, HTTP-Verhalten und den Control-Port braucht
- Wer festlegt, wer was sehen darf
- Wer eine Site mit Büchern und Handbüchern im LAN aufbaut

## Umfang

`book.tcl`: **16** Kapiteldateien (12 Kapitel + 4 Anhänge).

## PDF und HTML bauen

```bash
cd ../..
tclsh bookkit/tools/book-build.tcl book-mdserver/Mdserver-de/ -number
```

Entstanden mit Unterstützung von KI-Werkzeugen; Text und Beispiele sind vom Autor geprüft.

## Lizenz

Doku: [CC BY-SA 4.0](LICENSE). Code-Beispiele: [MIT](LICENSE).
