# Installation

## Pfade

tkutils braucht tclutils auf dem Modulpfad, dazu Tablelist aus tklib (für
den Umbrella und alle Tabellen-Widgets). Der übliche Weg ist der Bootstrap
`tools/setup.tcl`:

```tcl
source /pfad/zu/tkutils/tools/setup.tcl
package require tkutils
package require tkutils::tkudialog 0.3
```

`setup.tcl` ist in tclutils und tkutils identisch (`diff` ohne
Unterschied); welche Kopie Sie sourcen, ist egal — beide Bäume
werden registriert. Gesucht wird in dieser Reihenfolge, nur vorhandene
Pfade werden eingetragen:

1. `TCLUTILS_TM` / `TKUTILS_TM` (Override, gewinnt)
2. `lib/tm` des eigenen Baums
3. neben der Tcl-Installation (`<tcl-lib>/<paket>/lib/tm`)
4. `/usr/local/share/tcltk/<paket>/lib/tm`
5. `$XDG_DATA_HOME/tcltk/<paket>/lib/tm`, sonst
   `$HOME/.local/share/tcltk/<paket>/lib/tm`
6. Geschwisterordner `<paket>/lib/tm`, dann `<paket>-*/lib/tm` (höchste
   Version)

Ohne `setup.tcl` tragen Sie die Bäume selbst ein:

```tcl
tcl::tm::path add /pfad/zu/tclutils/lib/tm /pfad/zu/tkutils/lib/tm
package require tkutils::tkudialog 0.3
```

Fehlt nur der tclutils-Baum, scheitern Module mit Engine-Bedarf, etwa
`tkugeometry` mit `can't find package tclutils::common 0.1`.

### Über einen älteren Baum kopieren

Der Umbrella von 0.48.0 ist `lib/tm/tkutils-0.48.0.tm`. Neue
Modulversionen in 0.48.0: `tkulauncher` und `tkuload` 0.3; in 0.47.0:
`tkufiledialog` 0.2; `tkutlsort`, `tkutlclip`, `tkutlfind`, `tkutltree`,
`tkutltools` 0.2; `tkutlfooter`, `tkutlfmt`, `tkutlstate` 0.3. Wer 0.48.0
über einen älteren Baum kopiert, löscht vorher die alten Dateien, sonst
liegen zwei Versionen nebeneinander.

Über einen Baum von 0.47.0:

- `lib/tm/tkutils-0.47.0.tm`
- `lib/tm/tkutils/tkulauncher-0.2.tm`, `tkuload-0.2.tm`

Über einen Baum von 0.46.0 statt `tkutils-0.47.0.tm` die Datei
`lib/tm/tkutils-0.46.0.tm`, dazu in `lib/tm/tkutils/`:

- `tkufiledialog-0.1.tm`
- `tkutlclip-0.1.tm`, `tkutlfind-0.1.tm`, `tkutlsort-0.1.tm`,
  `tkutltools-0.1.tm`, `tkutltree-0.1.tm`
- `tkutlfmt-0.2.tm`, `tkutlfooter-0.2.tm`, `tkutlstate-0.2.tm`
- `tkulauncher-0.2.tm`, `tkuload-0.2.tm`

Die Listen stammen aus dem Vergleich der Bäume von 0.46.0, 0.47.0 und
0.48.0.

---

## Die Umgebungsvariablen

[TCLUTILS_TM]{.index} und `TKUTILS_TM` liest Tcl **nicht** selbst. Sie
wirken nur dort, wo Code sie ausdrücklich auswertet:

- `tools/setup.tcl` und damit die mitgelieferten Apps (über
  `apps/_lib/paths.tcl`),
- `tkuload` beim ersten `build` (trägt beide Pfade per
  `tcl::tm::path add` ein),
- `tests/all.tcl`: `TCLUTILS_TM` hilft beim Finden des Runners; der Runner
  selbst stellt die Bäume aus `TKUTILS_TM` und `TCLUTILS_TM` nach vorn,
- die einzelnen Testdateien (`TKUTILS_TM`).

Ein eigenes Skript, das nur `package require tkutils` aufruft, findet trotz
gesetzter Variablen nichts und meldet `can't find package tkutils`.

```bash
export TCLUTILS_TM=/pfad/zu/tclutils/lib/tm
export TKUTILS_TM=/pfad/zu/tkutils/lib/tm
```

Setzen Sie sie, wenn ein bestimmter Arbeitsbaum Vorrang vor einer
Installation haben soll — etwa in CI.

---

## Tests

```bash
xvfb-run -a tclsh tests/all.tcl
xvfb-run -a tclsh tests/all.tcl -match 'tkuunits-*'
```

Der Runner ist [tutestrun]{.index} aus tclutils (`::tclutils::tutestrun`,
ab tclutils 0.64.0). `all.tcl` sucht ihn im eigenen Baum, in `TCLUTILS_TM`
und im Geschwister-Checkout `tclutils*`, nie in einer Installation. Fehlt er,
endet `all.tcl` mit Exit-Code 2 und der Meldung
`all.tcl: tclutils::tutestrun not found (set TCLUTILS_TM)`.

- Jede `tests/*.test` läuft in einem eigenen Prozess.
- Das Banner `Modules resolve to:` zeigt, aus welchen Dateien tkutils und
  tclutils geladen wurden, und nennt gesetzte Pfadvariablen.
- Grenze pro Datei: `TKUTILS_TESTGRENZE` in Sekunden, Standard 120.
- Weitere Argumente gehen an tcltest (`-match`, `-skip`, …).
- Exit-Code 1, wenn eine Datei Fehler meldet, keine Zusammenfassung
  schreibt, abstürzt oder hängt. Die Dateien stehen am Ende unter
  `Files with problems:`.

Aufruf mit `tclsh`, nicht mit `wish`. GUI-Tests tragen die Bedingung
`haveTk`; ohne Display werden sie übersprungen. Auch `stack.test`,
`tkumdview.test`, `tkupdfinspect.test` und `tkuwinico.test` melden ohne
Display `<datei>.test: no display, all tests skipped` und eine
Zusammenfassung mit 0 Fehlern.

Tests für Module mit fehlendem Fremdpaket (tDOM, sqlite3, Tablelist, tical)
werden übersprungen. tical suchen die Tests über `TICAL_DIR` oder einen
Geschwisterordner. `tkutical.test` findet einen Ordner `tical` neben
`tkutils`. `tkumonthcanvas.test` sucht wie `tkutical.test` auch den flachen
Checkout; ohne `TICAL_DIR` bestehen dort 13 von 13 Tests.

### Testlauf

tkutils 0.48.0 unter Linux (Xvfb) mit tclutils 0.68.0, tical 1.1 und
gesetztem `TICAL_DIR`; Tablelist 6.20 unter Tcl/Tk 8.6.14, 7.11 unter
9.0.4:

| Tcl/Tk | Dateien | Tests | bestanden | übersprungen | Fehler |
|---|---|---|---|---|---|
| 8.6.14 | 78 | 843 | 831 | 12 | 0 |
| 9.0.4 | 78 | 843 | 840 | 3 | 0 |

Unter 8.6.14 überspringt die Suite die SVG-Tests von `tkuicon` und
`tkuwinico` (kein tksvg), dazu je einen Test von `tkuscrolledframe` und
`tkuwheel`. Unter Windows und macOS ist die Suite nicht geprüft. Umgebung
und Ergebnisse von 0.46.0: [Anhang G](860-anhang-testumgebung.md).

---

## Zusammenfassung

- `setup.tcl` sourcen oder `tcl::tm::path add` für beide Bäume.
- `TCLUTILS_TM`/`TKUTILS_TM` wirken nur über setup.tcl, Apps, tkuload und
  Testlauf.
- Tests: `xvfb-run -a tclsh tests/all.tcl`; ohne Display werden
  GUI-Tests übersprungen.
- Beim Kopieren über einen älteren Baum die alten `.tm`-Dateien löschen.

---

*Nächstes Kapitel: [Dialoge](030-dialoge.md)*
