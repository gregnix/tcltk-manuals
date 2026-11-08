# Designer und load

## tkurender / tkuload

[tkurender]{.index} ist der Render-Kern von tkudesigner und tkuload; er
kennt den Widget-Typ [placeholder]{.index} (Optionen `text`, `role`,
`width`, `height`). [tkuload]{.index} baut aus einem `.tkd`-Entwurf eine
lebende Oberfläche und bietet [slot]{.index}: Platzhalter-Rahmen leeren, der
Host packt das echte Widget hinein.

Beide Module haben eigene Namensräume (`::tkurender`, `::tkuload`) und sind
nicht im Umbrella. Die Pakete heißen `tkutils::tkurender` (0.2) und
`tkutils::tkuload` (0.3).

```tcl
package require tkutils::tkuload
package require tkutils::tkurender
package require tkutils::tkufilelist

# Entwurf mit einem benannten Platzhalter (sonst aus tkudesigner, .tkd)
::tkurender::newModel
set p [::tkurender::addNode placeholder $::tkurender::D(root)]
::tkurender::setName $p filelist
::tkurender::setOpt  $p role filelist
set spec [::tkurender::serialize]

ttk::frame .host
pack .host -fill both -expand 1
set ui [::tkuload::build .host $spec]

set box [::tkuload::slot $ui filelist]
::tkutils::tkufilelist::widget $box.l -dir [pwd]
pack $box.l -fill both -expand 1
pack propagate $box 1
```

Aus einer Datei: `::tkuload::buildFromFile $parent $pfad`.

`build` liefert ein Dict mit `root`, `byId`, `byType` und `byName`. Als
`$parent` ist auch `.` erlaubt; `build` legt dann einen eigenen Rahmen
`.tkuloadHost<n>` an. Jeden Entwurf in einen eigenen, leeren Parent bauen:
Die Widget-Namen kommen aus den Knoten-Ids, ein zweiter Bau in denselben
Parent kollidiert. Beim ersten `build` trägt `tkuload` die Pfade aus
`TCLUTILS_TM` und `TKUTILS_TM` in den Modulpfad ein, falls gesetzt.

Weitere Befehle für benannte Widgets: `widgetByName`, `setValue`,
`getValue`, `fill` (Dict Name → Wert, unbekannte Namen werden übersprungen)
und `collect` (Werte zurück als Dict). Seit 0.3 nennt `namespace export`
alle acht Befehle, `namespace import ::tkuload::*` holt sie also
vollständig; bis 0.2 waren nur `build`, `buildFromFile` und `slot`
exportiert.

---

## Feste Größe des Platzhalters

Der Platzhalter ist ein `ttk::frame` mit fester Größe — Standard
**200×120** Pixel — und `pack propagate 0`. `slot` entfernt nur die
Kinder; Größe und Propagation bleiben. Ein hineingepacktes Widget wird
also auf 200×120 beschnitten. Der Rahmen aus dem Beispiel ist vor
`pack propagate $box 1` genau 200×120 groß bei Propagation 0, danach
199×251 (Tcl/Tk 9.0.4: 199×231). Abhilfe:

- `pack propagate $box 1` — der Rahmen wächst mit dem Inhalt, oder
- im Designer `width`/`height` passend setzen, oder
- den Platzhalter im Layout mit `-fill both -expand 1` (bzw. Grid-Gewicht)
  strecken.

---

## Einsatz

Die App **Dateiblick** bleibt laut Buch *Utils-Stack*
handverdrahtet (kein `.tkd`); ihr Code liegt nicht in tclutils, tkutils
oder ctrlutils und ist hier nicht geprüft.
tkudesigner zeigt Placeholder in der Palette (Gruppe *Widget*; im Code
`defType placeholder Widget`).

Fehler von tkuload:

| Code | Meldung |
|---|---|
| `{TKULOAD PARENT}` | `no such parent widget: .nix` |
| `{TKULOAD NONAME}` | `no widget named 'foo'` (aus `slot` und `widgetByName`) |

Details: `docs/tkuload.md` im tkutils-Baum.

---

## Seitenlayout: tkulayoutcanvas

[tkulayoutcanvas]{.index} 0.2 setzt benannte Blöcke auf eine Seite in
Millimetern. Die Engine ist `tclutils::tulayout`. Feine Schrift und
Spalten bleiben in der Anwendung oder in `tkutemplate` (nächster
Abschnitt).

```tcl
::tkutils::tkulayoutcanvas::widget     $pfad ?option wert ...?
::tkutils::tkulayoutcanvas::getBlocks  $pfad
::tkutils::tkulayoutcanvas::setBlocks  $pfad $blöcke
::tkutils::tkulayoutcanvas::select     $pfad $id
::tkutils::tkulayoutcanvas::getCanvas  $pfad
::tkutils::tkulayoutcanvas::redraw     $pfad
```

| Option | Vorgabe | Wirkung |
|---|---|---|
| `-paper` | `a4` | `a4`, `a5`, `letter` |
| `-orientation` | `portrait` | `portrait` oder `landscape` |
| `-margin` | `20.0` | Rand in mm |
| `-gridmm` | `5.0` | Raster in mm |
| `-scale` | `3.0` | Pixel je mm |
| `-blocks` | `{}` | Dict der Blöcke |
| `-definitions` | `{}` | Katalog: Beschriftung und Größe je Id |
| `-blockorder` | `{}` | Reihenfolge der Blöcke; sonst aus den Definitionen, sonst sortiert |
| `-onchange` | `{}` | `befehl $pfad $blöcke` nach Ziehen oder Eingabe |
| `-onselect` | `{}` | `befehl $pfad $id`, wenn ein Block gewählt wird (Seite, Liste, `select`); neu in 0.2 |

`mergePreset` übernimmt aus einer Vorlage nur die genannten Schlüssel,
Vorgabe `x`, `y`, `w` und `show`.

Ein Block mit `y 0` oder `lockedY 1` steht im Fluss: Seine Lage ergibt
erst der Renderer. Die Seite zeigt ihn seit 0.2 zwei Millimeter unter dem
sichtbaren Block davor, wo ihn ein Renderer hinsetzt, der so fließt. Bis
0.1 stapelte sie solche Blöcke ab dem oberen Rand in Schritten von 12 mm.

```tcl
package require tkutils::tkulayoutcanvas
tkutils::tkulayoutcanvas::widget .lc -blockorder {kopf tabelle fuss} -blocks {
    kopf    {x 20 y 25 w 170 h 15}
    tabelle {x 20 y 55 w 170 h 40}
    fuss    {x 20 y 0  w 170 h 10}
} -onselect {apply {{p id} { puts "gewählt: $id" }}}
pack .lc -fill both -expand 1
tkutils::tkulayoutcanvas::select .lc kopf   ;# gibt "gewählt: kopf" aus
dict get [tkutils::tkulayoutcanvas::getBlocks .lc] fuss y   ;# -> 0.0
```

Die Seite zeigt `fuss` bei 97 mm: `tabelle` endet bei 55 + 40 = 95 mm.

`getBlocks` liefert nur die Schlüssel, die `tulayout` kennt (`label x y w
h show lockedY`). Wer Blöcke mit weiteren Schlüsseln durch die Seite
schickt, mischt das Ergebnis mit `tulayout::mergeLayout` zurück, sonst
fehlen sie danach.

---

## Vorlagen: tkutemplate

[tkutemplate]{.index} 0.1 bearbeitet eine ganze Dokumentvorlage im Format
von `pdf4tcltemplate` (pdf4tcllib): Papier, Ränder, Farben und Blöcke mit
Typ (`text`, `pairs`, `table`, `image`, `rule`), Schrift, Ausrichtung,
Text mit Platzhaltern und Tabellenspalten. Die Lage der Blöcke setzt
`tkulayoutcanvas`; alles andere steht in drei Reitern daneben: *Block*,
*Columns*, *Page*. Was von der Seite zurückkommt, mischt `tkutemplate` mit
`mergeLayout` (Schlüssel `x y w show`) in die Vorlage; kein anderes
Attribut geht verloren.

```tcl
::tkutils::tkutemplate::widget      $pfad ?option wert ...?
::tkutils::tkutemplate::getTemplate $pfad
::tkutils::tkutemplate::setTemplate $pfad $vorlage
::tkutils::tkutemplate::setSample   $pfad $daten
::tkutils::tkutemplate::select      $pfad $id
::tkutils::tkutemplate::addBlock    $pfad $id ?typ?
::tkutils::tkutemplate::deleteBlock $pfad $id
::tkutils::tkutemplate::moveBlock   $pfad $id up|down
::tkutils::tkutemplate::setBlock    $pfad $id schlüssel wert ?schlüssel wert ...?
::tkutils::tkutemplate::loadFile    $pfad $datei
::tkutils::tkutemplate::saveFile    $pfad $datei
::tkutils::tkutemplate::preview     $pfad ?datei?
```

| Option | Vorgabe | Wirkung |
|---|---|---|
| `-template` | `{blocks {}}` | die Vorlage |
| `-sample` | `{}` | Musterdaten für die Vorschau |
| `-onchange` | `{}` | `befehl $pfad $vorlage` nach jeder Änderung |
| `-scale`, `-gridmm` | `2.5`, `5` | Pixel je mm, Raster in mm |
| `-font`, `-fontbold` | `{}` | Schriften der Vorschau; sonst die TrueType-Schriften von pdf4tcllib |

`setBlock` prüft, was es setzt: Zahlen, Wahrheitswerte, `type`, `page`,
`align`, Farbe als Name aus dem Thema oder `r g b`. Ein leerer Wert
entfernt den Schlüssel, außer bei `type` und `cols`. Ein Block, der zur
Tabelle wird, bekommt zwei Spalten, ein Bild eine Höhe. `moveBlock`
ändert die Reihenfolge, und die zählt: Ein Block mit `y 0` folgt dem
davor.

```tcl
package require tkutils::tkutemplate
tkutils::tkutemplate::widget .te -template {
    paper a4 margin 20 size 10
    blocks {
        kopf    {x 20 y 18 w 110 size 18 bold 1}
        tabelle {type table x 20 y 100 w 170 cols {pos text}}
        schluss {x 20 y 0 w 170 gap 8 text "Danke, {name}."}
    }
} -sample {kopf Gärtnerei name Kunde tabelle {{pos 1 text Rose}}}
pack .te -fill both -expand 1
tkutils::tkutemplate::setBlock .te kopf size 20 align center
dict get [tkutils::tkutemplate::getTemplate .te] blocks kopf
    ;# -> x 20 y 18 w 110 size 20 bold 1 align center
catch {tkutils::tkutemplate::setBlock .te kopf align mitte} m o
dict get $o -errorcode            ;# -> TKUTILS TKUTEMPLATE VALUE
```

**Vorschau.** `preview` zeichnet die Vorlage mit `-sample` in ein PDF
und gibt die Datei zurück (ohne Angabe eine temporäre); der Knopf
*Preview* öffnet sie mit `tclutils::tuopen`. Blöcke ohne Musterdaten
bekommen einen Platzhalter, damit jeder Block im PDF steht.
`pdf4tcltemplate` und `pdf4tcl` lädt erst die Vorschau; der Editor selbst
braucht nur Tk, tclutils und `tkulayoutcanvas`. Fehlt eins von beiden,
meldet `preview` `{TKUTILS TKUTEMPLATE PREVIEW}`. pdf4tcllib lädt auch
ohne pdf4tcl; `preview` prüft deshalb beide.

**Dateien.** `saveFile` schreibt die Vorlage als Tcl, einen Block je
Zeile; `loadFile` liest sie zurück, das Ergebnis gleicht der
gespeicherten Vorlage. Die Höhe, die die Seite zeigt, ist eine Schätzung
aus Typ und Musterdaten und wird nicht gespeichert.

Launcher `bin/tkutemplate.tcl ?vorlage.tcl?`, Demo
`examples/demo-tkutemplate.tcl`.

---

## Zusammenfassung

- placeholder/slot für Host-Apps und Designer.
- Platzhalter 200×120, `pack propagate 0` — beim Füllen bedenken.
- `build` liefert `root`, `byId`, `byType`, `byName`; Werte über
  `setValue`/`getValue`/`fill`/`collect`.
- Pflicht für Dateiblick: nein.
- `tkulayoutcanvas` setzt Blöcke in Millimetern. Die Engine ist `tulayout`.
  Blöcke im Fluss stehen in der Vorschau unter dem Block davor.
- `tkutemplate` bearbeitet eine ganze Vorlage für `pdf4tcltemplate`; die
  Vorschau braucht pdf4tcllib und pdf4tcl.

::: {.info}
**Getestet mit** Tcl/Tk 8.6.14 und 9.0.4 unter Linux und Xvfb: das
Beispiel mit `slot`, die Größen des Platzhalters, die Fehler von
`tkuload`.

Die Beispiele zu `tkulayoutcanvas` 0.2 und `tkutemplate` 0.1 unter
Tcl/Tk 8.6.14 und 9.0.4; die Vorschau mit pdf4tcl 0.9.4.74.

**Nicht getestet:** die App Dateiblick.
:::

---

*Nächstes Kapitel: [Bilder](082-bilder.md)*
