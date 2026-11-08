# pdf4tcllib

*Stand: 2026-11-08*

Ein deutschsprachiges Werkstattbuch für [pdf4tcllib]{.index} 0.6.8:
Schriften und Unicode, Seitenkontext, Text, Tabellen mit Seitenumbruch,
Diagramme, Inhaltsverzeichnis, Etiketten, Formulare, Zeichenhilfen,
Tk-Widgets (tablelist, Text, Canvas, Treeview) im PDF, barrierefreie
PDFs und Belege aus Vorlagen, auf pdf4tcl 0.9.4.74.

pdf4tcl zeichnet; wie das geht, erklärt das Buch *pdf4tcl*. Dieses Buch
baut darauf auf und löst die Aufgaben, die in Berichten und Listen immer
wiederkehren.

## Zielgruppe

- Tcl-Entwickler, die Berichte, Rechnungen, Listen oder Etiketten als
  PDF erzeugen
- Leser des Buchs *pdf4tcl*, die nicht jede Tabelle selbst umbrechen
  wollen

## Beispiele

Jedes Beispiel liegt als Skript in `../beispiele/`. Die Serie
`serie-pdf4tcllib` misst Einheiten, Satzspiegel, Umbruch, Tabelle
und Balken. Ob Buch und Skripte übereinstimmen und die Skripte laufen,
prüft:

```bash
tclsh beispiele/pruefe-beispiele.tcl -run
```

Die Beispiele aus Teil 5 (Tk-Widgets) brauchen Tk und damit eine
Anzeige, das tablelist-Beispiel außerdem tklib; ohne `DISPLAY` werden
sie übersprungen. Auf einem Server ohne Bildschirm:

```bash
xvfb-run tclsh beispiele/pruefe-beispiele.tcl -run
```

Die Bilder für Kapitel 15 liegen in `../beispiele/bilder/`.

## Lizenz

Doku-Text: [CC BY-SA 4.0](LICENSE)
Code-Beispiele: [MIT](LICENSE)
