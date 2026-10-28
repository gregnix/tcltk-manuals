# mdserver — Handbuch

*Stand: 2026-10-27*

Handbuch für den HTTP-Dienst [mdserver]{.index} **0.4**: Markdown zur
Laufzeit als HTML, ohne Tk. Mit Seitenlayout `site`, Volltextsuche über
Markdown und (mit tclutils) PDFs und erzeugten Buch-Startseiten.
Modul `tools/mdserver/lib/mdserver-0.4.tm` im mdstack-Baum. Die
Paketdoku bleibt unter `mdstack/tools/mdserver/doc/`.

Geprüft mit mdstack (parser 0.9.2, html 0.2), docir 0.1.1 (mdSource
0.2, html 0.2), tclutils 0.68.0, Tcl 8.6.14 und 9.0.4.

LXC, Samba, nginx und Firewall: Lehrbuch *Nginx* und die beiden
LAN-Bücher. Dieses Buch ist das Programm, als Handbuch
(`booktype manual`, Regeln in `bookkit/doc/de/STYLE.md`).

## Zielgruppe

- Wer den Dienst startet, prüft und beendet
- Wer Optionen, HTTP-Verhalten und den Control-Port braucht
- Wer eine Site mit Büchern und Handbüchern im LAN aufbaut

## Umfang

`book.tcl`: **14** Kapiteldateien (10 Kapitel + 4 Anhänge).

## PDF und HTML bauen

```bash
cd ../..
tclsh bookkit/tools/book-build.tcl book-mdserver/Mdserver-de/ -number
```

Entstanden mit Unterstützung von KI-Werkzeugen; Text und Beispiele sind vom Autor geprüft.

## Lizenz

Doku: [CC BY-SA 4.0](LICENSE). Code-Beispiele: [MIT](LICENSE).
