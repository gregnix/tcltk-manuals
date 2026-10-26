# Zusätzliche Pakete (englisch)

HTML-Dokumentation von Csaba Nemethis Paketen, umgewandelt mit
`docir/bin/h2md` (`KONVERTIERE-PAKETE.sh`). Normales Markdown für
mdstack/mdserver, kein TIP-700-Format (keine Handbuchseiten, sondern
Programmierhandbücher mit Kapiteln).

| Ordner | Paket | Quelle |
|---|---|---|
| `tablelist/` | Tablelist 7.12 | `src/tablelist7.12/doc` |
| `mentry/` | Mentry 4.5.1 | `src/mentry4.5.1/doc` |
| `scrollutil/` | Scrollutil 2.11 | `src/scrollutil2.11/doc` |
| `wcb/` | Wcb 4.2 | `src/wcb4.2/doc` |
| `tsw/` | tsw 1.5 | `src/tsw1.5/doc` |

Einstieg je Paket: `index.md`. Links zwischen den Seiten zeigen auf `.md`;
Sprungmarken auf Begriffe oder Absätze (im HTML `<dt id>`, `<p id>`) führen
zur Überschrift davor, weil Markdown dort kein Sprungziel hat.

Stand 2026-10-22: 38 Seiten, 109 Bilder; 552 von 579 Sprungmarken
innerhalb einer Seite führen zu einer Überschrift.
