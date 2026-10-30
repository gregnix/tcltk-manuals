# tkutils verstehen

## Einführung

[tkutils]{.index} liefert Tk-Widgets und Dialoge: Dialoge, Dateiliste und
-baum, Filedialog, tablelist, Geometrie, Units, Actions, Launcher,
Designer-Slots und die App tkdevtools. Die Engines bleiben in
[tclutils]{.index}, so brauchen Server und CI kein Tk. Der Code nennt
Tcl/Tk **8.6** und **9.x**.

Dieses Handbuch beschreibt tkutils **0.49.0** für Desktop-Anwendungen auf
Provider und ttk. Die Beispiele und die Testsuite laufen mit Tcl/Tk 8.6.14
und 9.0.4 unter Linux (Xvfb). Unter Windows und macOS ist das Buch nicht
geprüft.

Empfohlene Paarung: tclutils **0.69.0** + tkutils **0.49.0** + ctrlutils
**0.4**. Den CSV-Export von `tkutablelist` 0.5 (`toCsv`, `saveCsv`)
braucht `tclutils::tucsv` 0.2 aus tclutils 0.69.0.
Sonst braucht tkutils 0.49.0 mindestens tclutils **0.64.0**: Erst diese Version
bringt `tusettings` (für `tkugeometry`), `tutestrun` (Testrunner) und die
Funktionen, die tkdevtools braucht.

---

## Rolle

| Stück | Rolle |
|---|---|
| Präfix | Paket `tkutils::tku<name>`, Namensraum `::tkutils::tku<name>` |
| Schicht | View |
| Regel | Engine in tclutils, GUI hier |
| Laden | `package require tkutils` oder Einzelmodul |

Jedes Modul ist ein Paket `tkutils::tku<name>` in
`lib/tm/tkutils/tku<name>-<version>.tm`. Seine Befehle liegen im Namensraum
`::tkutils::tku<name>`. Die meisten Module markieren sie mit
`namespace export`, aber kein Modul importiert sie in den globalen
Namensraum. Rufen Sie sie deshalb immer voll qualifiziert auf:
`::tkutils::tkudialog::confirm`, nicht `tkudialog::confirm` — die Kurzform
bricht mit `invalid command name "tkudialog::confirm"` ab.

Zwei Ausnahmen haben einen eigenen Namensraum: [tkuload]{.index} lebt in
`::tkuload`, [tkurender]{.index} in `::tkurender` (Kapitel
[Designer und load](080-designer-und-load.md)). Die Pakete heißen trotzdem
`tkutils::tkuload` und `tkutils::tkurender`.

---

## Der Umbrella

`package require tkutils` lädt **53** Module direkt, darunter Dialoge,
Dateiliste und -baum, Filedialog, Pfadzeile, Vorschau, Tabs, Toolbar,
Statusleiste, Actions, Launcher, Geometrie und Units. Zwei weitere kommen
indirekt mit:

- [tkutablelist]{.index} — über `tkufilelist` (und damit `tkufiledialog`).
  Der [Umbrella]{.index} braucht deshalb **Tablelist** aus tklib auf dem
  `auto_path`; ohne Tablelist scheitert `package require tkutils` mit
  `can't find package Tablelist`.
- `tkuopts` — die gemeinsame Optionsprüfung (Kapitel
  [Fehlermeldungen](830-anhang-fehlermeldungen.md)).

Nach `package require tkutils` sind **55** Pakete `tkutils::*` geladen —
53 direkt, dazu `tkutablelist` 0.5 und `tkuopts` 0.1. Der Umbrella fordert
`tkupath 0.2` und `tkupreview 0.1` an; geladen werden die vorhandenen
Versionen 0.3 und 0.2.

Nicht im Umbrella — einzeln requiren:

| Modul | Braucht |
|---|---|
| `tkuxml` | tDOM |
| `tkusqlite` | sqlite3 |
| `tkuicon` | für SVG: tksvg (Tk 8.6) oder Tk 9; PNG/GIF ohne |
| `tkuscrolledframe` | scrollutil (tklib) |
| `tkutical`, `tkumonthcanvas` | tical 1.0 |
| `tkucanvaspng` | `tclutils::tupngdraw` |
| `tkutltools` und `tkutlclip`, `tkutldrag`, `tkutlfilter`, `tkutlfind`, `tkutlfmt`, `tkutlfooter`, `tkutlgroup`, `tkutlsort`, `tkutlstate`, `tkutltree` | Tablelist (`tablelist_tile`) |
| `tkuload`, `tkurender` | — (Designer-Kern) |
| `tkumdview`, `tkupdfinspect`, `tkulayoutcanvas` | tclutils-Engines |
| `tkusysinfo` | `tclutils::tusysinfo` (tclutils 0.69.0) |

Das sind **24** Module; zusammen mit den 55 aus dem Umbrella ergibt das die
**79** Module des Baums.

```tcl
package require tkutils
puts [package present tkutils::tkutablelist]   ;# -> 0.5, über tkufilelist
package require tkutils::tkuload               ;# extra
```

Alle 24 Einzelmodule laden, wenn tDOM, sqlite3, tklib (Tablelist,
scrollutil) und tical auf dem Pfad liegen; `tkuicon` lädt auch ohne
tksvg.

### tical einbinden

[tical]{.index} 1.1 ist die Kalender- und iCalendar-Engine, die das Buch
*Utils-Stack* beschreibt. Sie ist kein Teil von tkutils und wird von
`setup.tcl` nicht gefunden. Der tical-Baum bringt eine `pkgIndex.tcl`
mit; tragen Sie ihn in den `auto_path` ein:

```tcl
lappend auto_path /pfad/zu/tical
package require tkutils::tkutical        ;# -> 0.4
package require tkutils::tkumonthcanvas  ;# -> 0.5
```

`tkutical` braucht `tical::view::month`, `tical::view::week` und
`tical::render::canvas` (je 1.0). `tkumonthcanvas` braucht
`tical::config`, `tical::locale`, `tical::holidays`, `tical::holidays::de`
und `tical::view::month` (je 1.0).

### Eine Tablelist-Variante

tklib erlaubt nicht beide Tablelist-Varianten (`tablelist` und
`tablelist_tile`) in einem Programm. tkutils verwendet deshalb überall
**`tablelist_tile`**: `tkutablelist` lädt es zuerst und nur, wenn es
fehlt, `Tablelist`. Die `tkutl*`-Helfer laden `tablelist_tile`, wenn noch
keine Tablelist geladen ist; hat die Anwendung schon eine der beiden
Varianten, nehmen sie diese. Apps (tkdevtools, Wissensbasis), Beispiele,
Tests und Doku laden `tablelist_tile`. `tkutils` und danach `tkutltools`
lädt ohne Fehler, die umgekehrte Reihenfolge ebenso (Tests
`tkutltools-2.1`, `-2.2`). Zum Verhalten bis 0.46.0:
[Anhang G](860-anhang-testumgebung.md).

---

## Abgrenzung

- Kein allgemeines Tk-Lehrbuch — dafür *TclTk-Benutzeroberflächen*
- Keine Controller wie `cufileops` — dafür *Utils-Stack*
- Keine Engines — dafür *tclutils*
- Keine Abschrift aller Widget-Docs — API-Wahrheit: `docs/<modul>.md`

---

## Aufbau

Kapitel 2 behandelt Installation und Tests. Danach folgen Dialoge,
Datei-Widgets, Listen und die Tablelist-Helfer, Geometrie und Units,
Aktionen, das Gerüst, die Eingabe, Kalender und Notizen, die
Datenansicht, Designer und load, Bilder und tkdevtools. Kapitel 16
nennt die Grenzen. Die Anhänge enthalten Fallen (A), die Widget-Liste
(B), das Glossar (C), Fehlermeldungen (D), den API-Katalog (E),
Praxisbeispiele (F) und die Testumgebung (G).

---

## Merkliste

- Widgets auf tclutils-Engines, Version 0.49.0.
- Paarung tclutils 0.69.0 + tkutils 0.49.0 + ctrlutils 0.5; mindestens
  tclutils 0.64.0, für den CSV-Export von `tkutablelist` 0.69.0.
- Befehle immer mit `::tkutils::tku<name>::…` aufrufen.
- Umbrella braucht Tablelist; 24 Module kommen nur einzeln.
- Überall `tablelist_tile`; beide Tablelist-Varianten in einem Programm
  lehnt tklib ab.

::: {.info}
**Getestet mit** Tcl/Tk 8.6.14 (Tablelist 6.20, scrollutil 1.17) und
9.0.4 (Tablelist 7.11, scrollutil 2.10) unter Linux und Xvfb, tclutils
0.69.0, tical 1.1.

**Nicht getestet:** Windows, macOS.
:::

---

*Nächstes Kapitel: [Installation](020-installation.md)*
