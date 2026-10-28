# Navigation und Theme

## Einführung

Jede Seite trägt eine Navigation. Wie sie aussieht, entscheidet der
Stil. Stil und Theme gelten serverseitig und zusätzlich per URL, ohne
Neustart.

---

## Seitenstil

| Stil | Wirkung |
|---|---|
| `site` | ganzes Seitenlayout: Kopfleiste mit Suchfeld, Kapitel- oder Ordnerleiste, Brotkrumen, „Auf dieser Seite“, Kacheln (Vorgabe) |
| `plain` | TOC als Block oben (bis 0.4 Vorgabe) |
| `sidebar` | TOC als feste Leiste links |
| `sticky` | TOC klebt am oberen Rand |
| `collapsible` | TOC einklappbar |

```
http://127.0.0.1:8080/doc.md?style=plain
http://127.0.0.1:8080/doc.md?style=sidebar
```

Der [Stil site]{.index} legt kein Stylesheet über eine fertige Seite.
Er nimmt den gerenderten Inhalt und baut die Seite darum. Die Einzelheiten
stehen im nächsten Kapitel. Die vier älteren Stile hängen dagegen eine
CSS-Datei hinter das Standard-CSS.

CSS in `tools/mdserver/styles/`: `site.css`, `sidebar.css`,
`sticky-top.css`, `collapsible.css`. Fehlt die Datei, kommt die Seite
ohne Stil — kein Fehler. Anderer Ort: `--stylesdir`.

---

## Theme per URL

Im Stil `site` zählt nur der Dunkelmodus:

```
http://127.0.0.1:8080/doc.md?theme=dunkel
```

Ohne `theme=dunkel` folgt die Seite der Systemeinstellung des Browsers.
Hell erzwingen lässt sich nicht.

In den älteren Stilen gelten die Namen aus `mdstack::theme` und der
Schalter `toc`:

```
http://127.0.0.1:8080/doc.md?style=plain&theme=solarized&toc=0
```

Namen: `hell`, `dunkel`, `solarized`. `toc=0` nimmt das
Inhaltsverzeichnis oben weg.

---

## Kopfleiste in `site`

- Links der Site-Titel (`--title`), er führt auf `/`.
- **Start** und **Alle Dokumente** (`/?nav=index`).
- Die Top-Level-Ordner als Bereiche, wenn darunter irgendeine `.md`
  oder `.pdf` liegt. Beschriftung aus der H1 der `index.md`, sonst
  Ordnername.
- Rechts das Suchfeld (Kapitel *Seitenlayout und Suche*).

---

## Leiste der älteren Stile

- **Start** führt auf `/` (`index.md` in der Wurzel).
- **Alle Dokumente**: `/?nav=index` — Baum aller `.md`, Titel aus dem
  ersten H1, dazu jede `.pdf` mit Dateinamen und „(PDF)“.
- Top-Level-Ordner als Sektionen, wenn darunter irgendeine `.md` oder
  `.pdf` liegt.
  Ab `navmax` (6) klappen sie in ein Dropdown. `--navmax 0` klappt nie.

Farben: `--navbg`, `--navfg`. Abschalten im Konstruktor: `nav 0`. Diese
Optionen wirken nur hier, nicht in `site`.

---

## Bücher

Ein Ordner mit `book.tcl` oder einem `<!-- bookkit:toc:begin -->` gilt
als Buch. Reihenfolge aus `book.tcl`, sonst TOC-Block, sonst
`NNN-`-Präfix.

| | `site` | ältere Stile |
|---|---|---|
| Kapitelliste | Seitenleiste links, aktuelles Kapitel markiert | nur `sidebar`: Leiste links |
| Übersicht | erster Eintrag der Seitenleiste | Mitte der Kapitelleiste |
| voriges / nächstes | zwei Karten „Zurück“ und „Weiter“ am Fuß | Kapitelleiste (zurück, Übersicht, weiter) am Fuß |
| PDF/HTML | Knöpfe über der Kapitelliste | Links auf der Startseite |

---

## Startseite eines Buchs

Fehlt im Buchordner die `index.md`, erzeugt mdserver die
[Buch-Startseite]{.index} aus `book.tcl`. Das gilt in jedem Stil.

1. Titel (`title`), darunter der Untertitel (`subtitle`) kursiv.
2. Der erste Absatz der `README.md` — im Buchordner, sonst im Ordner
   darüber.
3. **Download:** `PDF` und `HTML`, wenn `<name>.pdf` und `<name>.html`
   neben dem Buchordner liegen. So legt bookkit sie ab.
4. **Kapitel:** nummerierte Liste mit den H1-Titeln.

Für einen Buchordner `Beispiel-de/` heißen die Downloads
`Beispiel-de.pdf` und `Beispiel-de.html` im Ordner darüber.

Eine eigene `index.md` hat Vorrang. `book-webindex.tcl` (bookkit)
schreibt eine, wenn gewünscht — nötig ist es nicht mehr.

---

## Zusammenfassung

- Vorgabe ist `site`; die älteren Stile per `--style` oder `?style=`.
- In `site` zählt `theme=dunkel`, sonst die Systemeinstellung.
- `--navbg`, `--navfg`, `--navmax`, `toc` gelten nur für die älteren
  Stile.
- Ein Buch ohne `index.md` bekommt eine erzeugte Startseite.
- CSS fehlt = ungestylt, nicht 500.

---

*Nächstes Kapitel: [Seitenlayout und Suche](045-seitenlayout-und-suche.md)*
