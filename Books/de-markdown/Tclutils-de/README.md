# tclutils

*Stand: 2026-10-24*

Handbuch für [tclutils]{.index} **0.68.0**: Pure-Tcl-Module ohne Tk —
Textfilter, Zeichen und Pfade, Datenformate, TDBC, PDF-Text, ODF, Provider,
HTTPS-Politik, Settings, Tasks (`tutask`), Test-Runner.

Pairing: tclutils **0.68.0** + tkutils **0.47.0** + ctrlutils **0.4**.
Widgets: Buch *tkutils* (`book-tkutils`). Stack und Controller: Buch
*Utils-Stack* (`book-utils-stack`).

Dieses Buch ändert den Modulcode nicht. API-Details: `docs/<modul>.md` im
tclutils-Baum.

## Zielgruppe

- Server, CLI und CI ohne Tk
- Apps, die Engines unter tkutils/ctrlutils nutzen

## Umfang

`book.tcl`: **29** Kapiteldateien (23 Kapitel + 6 Anhänge). Buchtyp: Handbuch
(`booktype manual`, Regeln in `bookkit/doc/de/STYLE.md`).

## PDF und HTML bauen

```bash
cd ../..
tclsh bookkit/tools/book-build.tcl book-tclutils/Tclutils-de/ -number
```

## Lizenz

Doku: [CC BY-SA 4.0](LICENSE). Beispiele: [MIT](LICENSE).
tclutils selbst: MIT (Upstream).
