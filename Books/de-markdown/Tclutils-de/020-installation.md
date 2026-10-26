# Installation

tclutils ist ein Baum von Tcl-Modulen unter `lib/tm/`. Tcl lädt eine
`.tm`-Datei nur, wenn ihr Verzeichnis auf dem [Modulpfad]{.index} steht.
`lappend auto_path` reicht dafür nicht.

---

## Ein Verzeichnis eintragen

```tcl
::tcl::tm::path add /pfad/zu/tclutils-0.68.0/lib/tm
package require tclutils                 ;# -> 0.68.0
package require tclutils::tucsv          ;# ein Modul, der Umbrella ist nicht nötig
```

`package require` liefert die Paketversion. Fehlt das Paket, bricht es
mit `can't find package tclutils::gibt-es-nicht` ab. Ein Verzeichnis,
das es nicht gibt, trägt `setup.tcl` nicht ein. Der Fehler kommt erst
beim `package require`.

---

## setup.tcl

`tools/setup.tcl` liegt wortgleich in tclutils und in tkutils. Einmal
sourcen trägt die vorhandenen `lib/tm` beider Bibliotheken ein:

```tcl
source /pfad/zu/tclutils/tools/setup.tcl
package require tclutils::tubin
```

Die Kandidaten stehen in `tools/setup.tcl` in dieser Reihenfolge. Nur
Verzeichnisse, die es gibt und die noch nicht auf dem Modulpfad stehen,
werden eingetragen. Eingetragen wird von hinten nach vorn, damit der
erste vorhandene Kandidat vorn liegt und gewinnt:

| # | Kandidat |
|---|---|
| 1 | `TCLUTILS_TM` bzw. `TKUTILS_TM`, wenn die Variable gesetzt und nicht leer ist |
| 2 | `lib/tm` des Baums, aus dem `setup.tcl` kommt |
| 3 | neben der Tcl-Bibliothek: `[file dirname [info library]]/<paket>/lib/tm` |
| 4 | `/usr/local/share/tcltk/<paket>/lib/tm` |
| 5 | `$XDG_DATA_HOME/tcltk/<paket>/lib/tm`, sonst `~/.local/share/tcltk/<paket>/lib/tm` |
| 6 | Geschwisterordner `<paket>/lib/tm` neben dem Baum |
| 7 | `<paket>-*/lib/tm`, die höchste Version, die ein `lib/tm` hat |

Ist `TCLUTILS_TM` gesetzt, kommt `package ifneeded tclutils 0.68.0` aus
diesem Verzeichnis, auch wenn der Quellbaum daneben liegt. Sobald
Installation und Baum auseinanderlaufen, entscheidet die Variable, nicht
die Nähe zum Skript.

Details der Suche: `tools/setup.md`. Was `.tm` allgemein ist: Buch
*Pakete und Module*.

---

## Welche Datei geladen wird

```bash
export TCLUTILS_TM=/pfad/zu/tclutils/lib/tm
tclsh8.6 tests/all.tcl
```

Der Runner schreibt ins Banner, welche Umbrella-Datei `tclutils`
auflöst. Er sucht den Pfad, er lädt ihn an dieser Stelle nicht.

```text
Modules resolve to:
  tclutils   0.68.0   …/tclutils/lib/tm/tclutils-0.68.0.tm
```

Liegt dieselbe Version
noch einmal weiter hinten auf dem Modulpfad, gewinnt die vordere.
Welche Kopien es gibt, zeigt `tupkgfinder` im Kapitel
[Tests und tutestrun](090-tests-und-tutestrun.md).

---

## Merkliste

- Modulpfad: `tcl::tm::path add …/lib/tm`, oder einmal `setup.tcl`.
- `TCLUTILS_TM` steht vor dem Baum, aus dem `setup.tcl` kommt.
- `package require tclutils` lädt den Umbrella. Ein einzelnes Modul geht ohne ihn.
- Fehlt das Paket, sagt das erst `package require`.

---

*Nächstes Kapitel: [Umbrella und Module](030-umbrella-und-module.md)*
