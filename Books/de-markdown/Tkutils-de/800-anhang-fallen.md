# Fallen

---

- Kurzform `tkudialog::confirm` statt `::tkutils::tkudialog::confirm` —
  `invalid command name "tkudialog::confirm"`.
- `TCLUTILS_TM`/`TKUTILS_TM` setzen und `setup.tcl` weglassen — Tcl liest
  die Variablen nicht; `can't find package tkutils` bzw.
  `can't find package tclutils::…`.
- Umbrella ohne Tablelist — `can't find package Tablelist`.
- `tkudialog` 0.2 erwarten — Datei entfernt, Verhalten = 0.3.
- `tkudialog::message`/`warning` aufrufen — heißen `showInfo`/`showWarning`.
- `input` liefert `""` — Abbruch oder leeres Feld, beides gleich.
- `tkutablelist` 0.3 requiren und alte PRIMARY-Auswahl erwarten — es kommt
  immer 0.4; `-exportselection 1` setzen.
- `tkufilelist` ohne `-dir` — zeigt `/`, nicht das aktuelle Verzeichnis.
- `tkugeometry::restore` vor `track` aufrufen — doppelt; `track` stellt
  selbst her.
- `-default 800x600` gibt nur eine Größe; die Position wählt der
  Window-Manager (unter Xvfb ohne Fenstermanager `+0+0`; unter einem
  echten Fenstermanager nicht geprüft). Der Test `tkugeometry-3.2` vergleicht
  deshalb nur die Größe.
- `setEnabled id 0` (global) nach `setEnabled id 0 $w` — löscht die
  Fenster-Overrides; `invoke` folgt nur dem globalen Flag.
- Placeholder füllen und wundern, dass der Inhalt abgeschnitten ist —
  200×120 und `pack propagate 0`.
- Tests mit `wish` starten — `tclsh tests/all.tcl`.
- Dateioperationen im Widget suchen — gehören in ctrlutils.
- Unbekannte Optionen an `tkutlfooter` — werden ohne Fehler übergangen.
- `tkutablelist::toCsv` oder `saveCsv` mit versteckten Zeilen oder
  Spalten — seit 0.49.0 exportieren beide nur Sichtbares; alles mit
  `-all 1`.
- Eine `integer`- oder `real`-Spalte mit leeren Zellen sortieren —
  Tablelist bricht mit einem Fehler ab; `tkutlsort::column … -empty last`.
- Von `tkutltree::fromData` den Tabellenpfad zurück erwarten — seit 0.3
  kommen die Schlüssel der obersten Knoten.
- Strg+C mit `tkutlclip::installBindings` bis tkutils 0.48.0 — die eigene
  `<<Copy>>`-Bindung von Tablelist überschrieb die Zwischenablage; seit
  `tkutlclip` 0.3 behoben.
- 0.49.0 über einen älteren Baum kopieren und die alten `.tm`-Dateien
  liegen lassen — dann liegen zwei Versionen nebeneinander (Liste im
  Kapitel [Installation](020-installation.md)).
- Auf den Fehlercode `{TKUTILS <MODUL> OPTION}` ohne viertes Element
  prüfen — ab 0.47.0 trägt er auch in `tkuaction` (`define`),
  `tkuballoon`, `tkuform`, `tkukeynav`, `tkulayoutcanvas`, `tkumarquee`,
  `tkuscrolledframe`, `tkutablelist`, `tkutoolbar` und `tkuvalidate` den
  Optionsnamen als viertes Element: `{TKUTILS <MODUL> OPTION <opt>}`. Bis
  0.46.0 fehlte er dort, und die Meldung lautete `unknown option '<opt>'`
  ohne `Known:`-Zeile. Code, der den ganzen Code oder den Meldungstext
  vergleicht, muss angepasst werden; `lrange $code 0 2` passt für beide
  Stände. Nur ein fehlender Wert meldet weiterhin `OPTION` ohne
  Optionsnamen.

---

## Behoben in 0.47.0

Diese Fallen gelten für 0.46.0. In 0.47.0 sind sie behoben:

- Doppelklick auf eine Datei in `tkufiledialog` 0.1 — Dialog schließt, das
  Ergebnis ist `""`; bis 0.46.0 nötig: *OK* oder Return benutzen. Behoben
  in `tkufiledialog` 0.2.
- Tests ohne Display starten — vier Dateien brechen ab, Exit-Code 1.
- `tkumonthcanvas.test` ohne `TICAL_DIR` — alle Tests übersprungen, wenn
  tical flach neben tkutils liegt; bis 0.46.0 nötig: `TICAL_DIR` setzen.
- `tkutltools` oder ein `tkutl*`-Helfer **nach** dem Umbrella —
  `can't set "usingTile": it is not supported to use both Tablelist and
  Tablelist_tile in the same application`; bis 0.46.0 nötig: `tablelist`
  zuerst laden. Jetzt laden alle `tablelist_tile`.

---

## Zusammenfassung

- Die meisten Fallen sind Pfad- und Ladefragen: setup.tcl, Tablelist,
  Ladereihenfolge.
- Zwei Fallen sind Code-Fehler in 0.46.0: Doppelklick im Filedialog und
  Tests ohne Display. Beide sind in 0.47.0 behoben.
- Code, der Optionsfehler am Fehlercode erkennt, muss ab 0.47.0 in zehn
  weiteren Modulen den Optionsnamen als viertes Element erwarten.

---

*Nächstes Kapitel: [Widgets](810-anhang-widgets.md)*
