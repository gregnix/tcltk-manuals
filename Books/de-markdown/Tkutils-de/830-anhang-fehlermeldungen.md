# Fehlermeldungen

| Code / Symptom | Bedeutung |
|---|---|
| `invalid command name "tkudialog::…"` | Namensraum fehlt; `::tkutils::tkudialog::…` |
| `can't find package tclutils::…` | tclutils nicht auf Modulpfad |
| `can't find package tkutils::…` | setup.tcl / `tcl::tm::path add` fehlt |
| `can't find package Tablelist` | Umbrella oder Tabellen-Widget ohne tklib |
| `can't set "usingTile": …` | bis 0.46.0: `tkutl*` nach `tkutablelist` geladen, `tablelist` zuerst laden; behoben in 0.47.0. Heute nur noch, wenn eine Anwendung selbst beide Varianten anfordert |
| `{TKUTILS <MODUL> OPTION <opt>}` | unbekannte Option (Module mit `tkuopts`, `tkudialog`, `tkufiledialog`, ab 0.47.0 zehn weitere, siehe unten) |
| `{TKUTILS <MODUL> OPTION}` | Wert zur Option fehlt; bis 0.46.0 in zehn Modulen auch unbekannte Option |
| `{TCLUTILS COMMON OPTION <opt>}` | unbekannte Option in tkugeometry, tkucanvaspng, `tkudavbrowser::refresh` |
| `{TKUTILS TKUDIALOG PARENT <w>}` | `-parent` existiert nicht |
| `{TKUTILS TKUFILEDIALOG PARENT <w>}` | dito im Filedialog |
| `{TKUTILS TKUGEOMETRY WINDOW}` | kein Toplevel für save/track/restore |
| `{TCLUTILS TUSETTINGS …}` | Geometrie-Persistenz (tusettings), z. B. `APP` |
| `{TKUTILS TKUUNITS UNIT}` | unbekannte Einheit |
| `{TKUTILS TKUUNITS VALUE}` | keine Zahl (`2c`) |
| `{TKUTILS TKUUNITS WINDOW}` | kein solches Fenster |
| `{TKUTILS TKUACTION WINDOW}` | unbekanntes Fenster bei Enable |
| `{TKUTILS TKUACTION NOACTION}` / `NOGROUP` | unbekannte Aktion / Gruppe |
| `{TKULOAD PARENT}` / `{TKULOAD NONAME}` | tkuload: Parent / Name fehlt |
| `unknown interpreter: <key>` | tkulauncher: kein solcher Interpreter-Schlüssel |
| `ITEM_EXISTS` in tkufiletree | vor 0.46.0: Punkt-Dateien doppelt unter Windows |
| `{TKUTILS TKCANVASPNG WINDOW}` / `EMPTY` | tkucanvaspng: Fenster fehlt / Fläche leer |
| `{TKUTILS TKUICON NOSVG}` | tkuicon: SVG ohne tksvg unter Tk 8.6 |

Die Optionsprüfung von [tkuopts]{.index} benutzen 20 Module, darunter
`tkufilelist`, `tkufiletree`, `tkupath` und `tkulauncher`.
Sie melden eine unbekannte Option als `{TKUTILS <MODUL> OPTION <opt>}` mit
`unknown option "<opt>"` und in der zweiten Zeile `Known:` mit den
sortierten bekannten Optionen. Ein fehlender Wert meldet
`{TKUTILS <MODUL> OPTION}` mit `missing value for option "<opt>"`.
`tkudialog` und `tkufiledialog` prüfen selbst, mit demselben Aufbau;
die `Known:`-Liste steht dort in der Reihenfolge des Codes.

Zehn Module prüfen ihre Optionen selbst: `tkuaction` (bei `define`),
`tkuballoon`, `tkuform`, `tkukeynav`, `tkulayoutcanvas`, `tkumarquee`,
`tkuscrolledframe`, `tkutoolbar`, `tkuvalidate` und `tkutablelist` (das
prüft vor `tkuopts`). Ab 0.47.0 folgen sie dem Aufbau von `tkuopts`: Code
`{TKUTILS <MODUL> OPTION <opt>}`, Meldung `unknown option "<opt>"` und
in der zweiten Zeile `Known:` mit den sortierten bekannten Optionen. Bis
0.46.0 fehlte dort der Optionsname im Code, die `Known:`-Liste fehlte, und
die Meldung lautete `unknown option '<opt>'`. Wer den Fehlercode
vergleicht, muss ab 0.47.0 die Option als viertes Element erwarten
(Anhang [Fallen](800-anhang-fallen.md)).

Nur wenige Module nutzen die tclutils-Prüfung und melden
`{TCLUTILS COMMON OPTION <opt>}`.

Nicht jedes Modul folgt dem Schema: `tkutlclip` und `tkutlfind` melden
`{TKUTILS <MODUL> OPTION}` ohne Optionsnamen und ohne `Known:`-Zeile,
`tkutlstate::autosave` den Grund `badoption` in Kleinbuchstaben, und
`tkutlfooter` prüft Optionen nicht.

Modul-spezifische Codes: jeweiliges `docs/<modul>.md`.

---

## Zusammenfassung

- Fehlercodes folgen `{TKUTILS <MODUL> <GRUND>}`; Ausnahmen sind tkuload
  (`TKULOAD`) und Module mit tclutils-Prüfung (`TCLUTILS COMMON`).
- Ab 0.47.0 nennen die zehn Module mit eigener Optionsprüfung den
  Optionsnamen im Code und die bekannten Optionen in der Meldung; bis
  0.46.0 fehlte beides. Module mit tclutils-Prüfung melden dasselbe unter
  `{TCLUTILS COMMON OPTION <opt>}`. Abweichend: `tkutlclip`, `tkutlfind`,
  `tkutlstate`, `tkutlfooter`.

::: {.info}
**Getestet mit** Tcl/Tk 8.6.14 und 9.0.4 unter Linux und Xvfb: Codes und
Meldungen von `tkudialog`, `tkutablelist`, `tkutl*`, `tkugeometry`,
`tkuunits`, `tkuaction`, `tkuform`, `tkulauncher`, `tkucanvaspng` und
`tkuload` wie hier und in den Kapiteln angegeben. Die übrigen Zeilen sind
aus dem Code gelesen.
:::
