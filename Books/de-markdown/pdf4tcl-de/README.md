# pdf4tcl

*Stand: 2026-09-29*

Ein deutschsprachiges Lehrbuch für [pdf4tcl]{.index} 0.9.4.69:
Seiten, Text, CID-Schriften, Grafik, Canvas-Export, AcroForm,
Verschlüsselung, Zusammenfügen und PDF/A.

pdf4tcl zeichnet. Zeilenumbruch über Seiten, Tabellen mit Umbruch
und Inhaltsverzeichnisse mit echten Seitennummern liegen in
`pdf4tcllib`. Dieses Buch bleibt bei der Zeichen-API.

## Zielgruppe

- Tcl-Entwickler, die Berichte, Formulare oder Archiv-PDFs erzeugen
- GUI-Entwickler, die ein Tk-Canvas nach PDF exportieren
- Leser, die Appearance-Streams, CID-Subsets und AES brauchen,
  ohne die Manpage zeilenweise zu durchsuchen

## Umfang

`book.tcl` ist die Build-Wahrheit: **22** Kapiteldateien
(18 Kapitel + 4 Anhänge).

| Kennzahl | Wert |
|---|---|
| Hauptkapitel (Teil 1–4) | 15 |
| Vertiefung (Teil 5) | 3 |
| Anhänge | 4 |
| **Gesamt** | 22 Markdown-Dateien |
| Sprache | Deutsch |
| Paket | pdf4tcl 0.9.4.69 |

## Struktur

Kapitel liegen flach als `NNN-*.md` (bookkit). Inhaltsübersicht:
[`BUCHSTRUKTUR.md`](BUCHSTRUKTUR.md), Build: [`BOOKKIT.md`](../BOOKKIT.md).

## PDF und HTML bauen (bookkit)

```bash
cd ..
tclsh bookkit/tools/book-build.tcl book-pdf4tcl/pdf4tcl-de/ -number
```

Ausgabe: `pdf4tcl-de.pdf` / `.html` in `bibliothek/books/book-pdf4tcl/`.

## Empfohlene Lesereihenfolge

### Einstieg

1. **Teil 1** vollständig — Objekt, Seite, Text, CID
2. **Teil 2** — Grafik, Bilder, Canvas

### Formulare und Ausgabe

1. **Teil 3** — Felder anlegen, füllen, Annotationen
2. **Teil 4** — AES, catPdf, PDF/A, Ebenen, Metadaten
3. **Anhang A (Fallen)** nebenbei offen halten

### Vertiefung

1. **Teil 5** — `gsave` und Textobjekt, CID-cmap, Fallstudie

## Lizenz

Doku-Text: [CC BY-SA 4.0](LICENSE)
Code-Beispiele: [MIT](LICENSE)

## Mitwirkung

Korrekturen und Ergänzungen sind willkommen — siehe [CONTRIBUTING.md](CONTRIBUTING.md).

## Stil

- **Imperativ und unpersönliche Form** — keine "du"-Anrede
- Deutsche Fachbegriffe wo etabliert, englische wo geläufig
- Konkrete Code-Beispiele statt abstrakter Beschreibungen
- Querverweise zu anderen Kapiteln und Anhängen
