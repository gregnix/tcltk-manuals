# Mitwirkung an diesem Buch

Dieses Werk ist ein deutschsprachiges Lehrbuch für pdf4tcl 0.9.4.69.
Korrekturen, Ergänzungen und neue Kapitel sind willkommen.

## Was beigetragen werden kann

### Korrekturen

- Sachfehler (pdf4tcl-API, Verhalten, Beispiele)
- Veraltete Angaben zur Version 0.9.4.69
- Code-Beispiele, die nicht laufen
- Tippfehler, sprachliche Glätte

### Ergänzungen

- Gemessene Viewer-Hinweise (Acrobat, PDFium, Poppler, MuPDF)
- Weitere Methoden mit konkretem Beispiel
- Fallstricke aus eigener Messung

### Was nicht passt

- Allgemeine Tcl-Einführung ohne PDF-Bezug
- Layout-Bibliotheken als Ersatz für die Zeichen-API
- Werbung für proprietäre PDF-Werkzeuge

## Stil

Das Buch verwendet konsequent:

- **Imperativ und unpersönliche Form**, kein "du" oder "Sie"
- **Deutsche Fachbegriffe** wo etabliert, englische wo geläufig
  (CID, Appearance, NeedAppearances bleiben englisch oder als
  Fachwort stehen)
- **Echte deutsche Umlaute** (ä, ö, ü), auch in Code-Kommentaren
- **Konkrete Code-Beispiele** statt abstrakter Beschreibungen
- **Querverweise** zu anderen Kapiteln/Anhängen

Beispiel für gute Form:

> "fillForms baut den Appearance-Stream für einfaches Textfeld neu.
> Comb ohne MaxLen, Kennwort und Auswahl behalten den alten Stream."

Beispiel für unpassende Form:

> "Wenn du fillForms aufrufst, kannst du deine Felder füllen. Du musst
> dann NeedAppearances nicht selbst setzen."

## Format

- **Markdown** (CommonMark + GitHub-Tabellen)
- **Code-Blöcke mit Sprach-Hint** (`` ```tcl ``, `` ```bash ``)
- **Querverweise** als relative Markdown-Links auf die flachen Dateinamen:
  `[fillForms](090-fillforms.md)`
- **Datums-Stempel** in jedem Kapitel: `*Stand: YYYY-MM-DD*` direkt
  unter der H1-Überschrift

## Workflow für Beiträge

1. **Issue eröffnen** für größere Änderungen
2. **Pull Request** mit klarer Beschreibung
3. **Eine Sache pro PR**

### Commit-Stil

- Kurze, beschreibende erste Zeile (≤72 Zeichen)

Beispiele:

```
090-fillforms: NeedAppearances nur bei altem Stream
170-cid-subset-cmap: Identity-CMap, nicht FFFE
```

## Code-Lizenz für Beiträge

- **Doku-Text:** CC BY-SA 4.0
- **Code-Beispiele:** MIT

## Themen, die im Buch stehen

Diese Kapitel existieren bereits (nicht als „fehlend“ behandeln):

- **CID-cmap:** [CID-Subset und CMap](170-cid-subset-cmap.md)
- **gsave und BT:** [gsave und Text](160-gsave-und-text.md)
- **fillForms:** [fillForms](090-fillforms.md)

Neue Kapitel nur nach Abstimmung mit der Liste in `book.tcl`.
