# Belege aus Vorlagen

## Einführung

Ein Lieferschein, ein Angebot, ein Brief: Oben stehen ein paar Blöcke an
festen Stellen, Absender, Anschrift, Nummer und Datum. Dann kommt eine
Tabelle, die über so viele Seiten läuft, wie sie braucht. Dahinter stehen
Blöcke, die der Tabelle folgen, wo immer sie endet: Summe, Hinweis,
Gruß. Die Schleife aus dem Kapitel [Messen und stapeln](200-messen-und-stapeln.md)
kann das, aber jede Belegart schreibt sie neu.

Das Paket [pdf4tcltemplate]{.index} trennt den Beleg in zwei Dicts: die
**Vorlage**, wo jeder Block steht und wie er aussieht, und die **Daten**,
was er zeigt. Die Vorlage bleibt für jeden Lieferschein dieselbe und
kann in einer Datei oder einer Tabelle liegen; die Daten entstehen je
Beleg.

---

## Vorlage und Daten

```tcl
package require pdf4tcltemplate
set r [pdf4tcllib::template::render pdf vorlage daten ?option wert ...?]
```

```tcl
# 205-vorlagen.tcl -- Lieferschein aus Vorlage und Daten, Seite n von m
package require pdf4tcl
package require pdf4tcllib
package require pdf4tcltemplate

pdf4tcllib::fonts::init -cid 1

# Die Vorlage: wo die Bloecke stehen und wie sie aussehen, in mm
set vorlage {
    paper a4  margin 20  size 10
    theme {accent {0.15 0.30 0.20} muted {0.40 0.40 0.40}}
    blocks {
        firma     {x 20 y 18 w 110 size 18 bold 1 color accent}
        absender  {x 20 y 45 w 85 size 7 color muted}
        anschrift {x 20 y 50 w 85 size 11 list 1}
        angaben   {type pairs x 125 y 50 w 65 labelw 30 size 9}
        titel     {x 20 y 95 w 170 size 15 bold 1 color accent
                   text "Lieferschein {nummer}"}
        positionen {type table x 20 y 108 w 170 size 9 zebra 1
                    cols {{key pos title Pos w 12 align right}
                          {key text title Bezeichnung}
                          {key menge title Menge w 22 align right}
                          {key einheit title Einheit w 16}}}
        hinweis   {x 20 y 0 w 170 gap 8 color muted}
        fuss      {x 20 y 285 w 170 size 8 color muted page all
                   align center text "Seite {page} von {pages}"}
    }
}

# Die Daten: ein Lieferschein, alles schon als Text
set zeilen {}
for {set i 1} {$i <= 40} {incr i} {
    lappend zeilen [dict create pos $i text "Tontopf, natur, Nr. $i" \
        menge [expr {$i * 12}] einheit Stk]
}
set daten [dict create \
    firma     "Gärtnerei Beispiel" \
    absender  "Gärtnerei Beispiel · Gartenweg 1 · 12345 Grünfeld" \
    anschrift {"Blumenhaus Müller" "" "Hauptstraße 5" "54321 Stadt"} \
    angaben   {Nummer LS-2026-0007 Datum 08.11.2026 Kunde K12 Bestellung {}} \
    nummer    LS-2026-0007 \
    positionen $zeilen \
    hinweis   "Bitte prüfen Sie die Ware.\nVielen Dank für Ihren Auftrag."]

set pdf [pdf4tcl::new %AUTO% -paper a4 -orient true]
set r [pdf4tcllib::template::render $pdf $vorlage $daten]
$pdf write -file 205-vorlagen.pdf
$pdf destroy
puts "Ergebnis: $r"

# Dieselbe Vorlage fuer einen anderen Kunden: einen Block ausblenden
dict set vorlage blocks absender show 0
set pdf [pdf4tcl::new %AUTO% -paper a4 -orient true]
set r2 [pdf4tcllib::template::render $pdf $vorlage \
    [dict replace $daten positionen [lrange $zeilen 0 4]]]
$pdf destroy
puts "fünf Zeilen: $r2"

# Fehler in der Vorlage melden sich vor dem Zeichnen
catch {pdf4tcllib::template::check {blocks {a {type kreis}}}} m o
puts "[dict get $o -errorcode]: $m"
```

```text
Ergebnis: pages 2 y 88.4472222222222
fünf Zeilen: pages 1 y 155.9372222222222
PDF4TCLLIB TEMPLATE TYPE: template: block "a": unknown type "kreis", known: text, pairs, table, image, rule
```

`render` öffnet die erste Seite selbst und schließt die letzte. Das
Ergebnis ist ein Dict: `pages`, die Zahl der Seiten, und `y`, der Platz
unter dem letzten Block in Millimetern. Die 40 Zeilen brauchen zwei
Seiten; der Hinweis steht auf der zweiten unter der letzten Zeile.

**Das Paket rechnet nichts.** Mengen, Preise und Summen kommen als
fertiger Text. Wer Beträge druckt, rechnet sie an einer Stelle aus, und
das PDF kann nicht anders runden.

---

## Die Vorlage

| Schlüssel | Vorgabe | Bedeutung |
|---|---|---|
| `paper` | `a4` | `a4`, `a5`, `letter` oder `{breite höhe}` in mm |
| `margin` | `20` | mm; `x` und `w` eines Blocks ohne eigene Angabe |
| `top` | `margin` | mm; wo der Fluss auf einer neuen Seite beginnt |
| `bottom` | Seitenhöhe − `margin` | mm; wo der Fluss endet |
| `size` | `10` | Schriftgröße in Punkt |
| `theme` | – | Farbnamen → `{r g b}` |
| `blocks` | – | Block-ID → Block, gezeichnet in dieser Reihenfolge |

Ein Block hat einen Typ:

| `type` | Wert in den Daten |
|---|---|
| `text` (Vorgabe) | Text; ein Zeilenumbruch beginnt eine neue Zeile. Mit `list 1` eine Liste von Zeilen, leere fallen weg |
| `pairs` | `bezeichnung wert bezeichnung wert …`; Bezeichnungen in den ersten `labelw` mm, Paare ohne Wert fallen weg |
| `table` | Liste von Zeilen, je ein Dict mit den Spaltenschlüsseln oder eine Liste in Spaltenfolge |
| `image` | Bilddatei; passt in `w` × `h`, Seitenverhältnis bleibt |
| `rule` | keiner; eine Linie über `w` |

Weitere Schlüssel: `x y w h` in mm, `show`, `page` (`first`, `all`,
`rest`, `last`), `gap`, `size`, `bold`, `color`, `align`, `leading`,
`field` (Datenschlüssel, sonst die Block-ID) und `text` (gilt, wenn die
Daten keinen Wert haben). In einem Text der Vorlage wird `{schlüssel}`
aus den Daten ersetzt, `{page}` und `{pages}` durch die Seitenzahlen.

Für Tabellen nennt `cols` die Spalten, je ein Schlüssel oder
`{key k title t w mm align a}`. Spalten ohne `w` teilen sich den Rest
der Blockbreite. Eine Zelle bricht in ihrer Spalte um, eine Zeile wird
nie geteilt, der Kopf steht auf jeder Seite. `zebra 1` hinterlegt jede
zweite Zeile.

Ein Bild über die ganze Seite mit `x 0 y 0` und `page all`, als erster
Block, ist ein Briefpapier.

---

## Der Fluss

Ein Block mit festem `y` steht, wo er soll. Ein Block mit `y 0` steht
`gap` mm unter dem Block davor in der Reihenfolge, meist der Tabelle.
Passt ein kurzer Block nicht mehr über `bottom`, kommt er ganz auf die
nächste Seite; ein langer Textblock bricht zwischen den Zeilen um.

Ein Block mit `page all` steht auf jeder Seite, `rest` ab der zweiten,
`last` auf der letzten. Solche Blöcke brauchen ein festes `y`.

---

## Seite n von m

`{pages}` kennt man erst nach der letzten Seite. Steht es in der Vorlage,
zeichnet `render` den Beleg zuerst in ein Wegwerf-Dokument mit gleichem
Papier, gleicher Einheit und gleichen Schriften und zählt die Seiten. Das
Prinzip ist dasselbe wie im Kapitel
[Kopf- und Fußzeilen, Seitenzahlen](060-kopf-fuss-seitenzahlen.md).

---

## Optionen, Einheit und Schriften

| Option | Vorgabe | Bedeutung |
|---|---|---|
| `-font` | aus `fonts::init` | Schrift für normalen Text |
| `-fontbold` | deren fette Form, sonst `-font` | Schrift für `bold 1` |
| `-startpage` | `1` | `0`: der Aufrufer hat eine Seite offen und schließt sie selbst |
| `-newpage` | – | Skript nach jedem Seitenwechsel, im Bereich des Aufrufers |

Das Dokument darf jede `-unit` haben; die Blöcke stehen gleich. Es muss
`-orient true` haben (y von oben), sonst meldet `render`
`{PDF4TCLLIB TEMPLATE ORIENT}`.

Für PDF/A übergibt man eingebettete Schriften. Baut eine andere
Bibliothek das Dokument und lädt die Schriften, gibt man deren Namen mit
`-font` und `-fontbold` weiter.

`template::check vorlage` prüft eine Vorlage und gibt sie mit eingesetzten
Vorgaben zurück, ohne zu zeichnen; Fehler tragen
`{PDF4TCLLIB TEMPLATE <art>}`.

---

## Was nicht geht

- Zellen über mehrere Spalten und Summenzeilen in der Tabelle; Summen
  stehen in einem `pairs`-Block im Fluss.
- Blöcke, die höher sind als eine Seite, außer Textblöcken.
- Ein PDF als Briefpapier; vorher in ein Bild umwandeln.
- `render` gibt den Text unverändert an pdf4tcl weiter. Zeichen, die
  die Schrift nicht hat, ersetzt es nicht wie `safeText` (Kapitel
  [Unicode sicher ausgeben](030-unicode-sicher-ausgeben.md)).

Eine Vorlage am Bildschirm bearbeiten: `tkutils::tkutemplate`, Buch
*tkutils*.

---

## Zusammenfassung

- `template::render` zeichnet einen Beleg aus Vorlage und Daten; das
  Paket rechnet nichts.
- Feste Blöcke stehen an ihrem `y`, Blöcke mit `y 0` folgen dem Block
  davor.
- `{page}`, `{pages}` und `{schlüssel}` in Texten der Vorlage;
  `{pages}` kostet einen Probedurchlauf.
- Jede Einheit, aber `-orient true`; für PDF/A eingebettete Schriften.

---

*Nächstes Kapitel: [Fallstudie: Lagerbericht](210-fallstudie-bericht.md)*
