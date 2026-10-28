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

[tkulayoutcanvas]{.index} 0.1 setzt benannte Blöcke auf eine Seite in
Millimetern. Die Engine ist `tclutils::tulayout`. Feine Schrift und
Spalten bleiben in der Anwendung.

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

`mergePreset` übernimmt aus einer Vorlage nur die genannten Schlüssel,
Vorgabe `x`, `y`, `w` und `show`.

---

## Zusammenfassung

- placeholder/slot für Host-Apps und Designer.
- Platzhalter 200×120, `pack propagate 0` — beim Füllen bedenken.
- `build` liefert `root`, `byId`, `byType`, `byName`; Werte über
  `setValue`/`getValue`/`fill`/`collect`.
- Pflicht für Dateiblick: nein.
- `tkulayoutcanvas` setzt Blöcke in Millimetern. Die Engine ist `tulayout`.

::: {.info}
**Getestet mit** Tcl/Tk 8.6.14 und 9.0.4 unter Linux und Xvfb: das
Beispiel mit `slot`, die Größen des Platzhalters, die Fehler von
`tkuload`.

**Nicht getestet:** die App Dateiblick.
:::

---

*Nächstes Kapitel: [Bilder](082-bilder.md)*
