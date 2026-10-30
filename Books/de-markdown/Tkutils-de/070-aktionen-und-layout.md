# Aktionen und Layout

## tkuaction 0.2

[tkuaction]{.index} beschreibt eine Aktion einmal — Label, Befehl, Icon,
Tastenkürzel, Enable/Check-Zustand — und hält alle registrierten Widgets
und Menüeinträge synchron. Das Modul ist das Model; gezeichnet wird in den
Widgets.

```tcl
package require tkutils::tkuaction

proc speichern {} { puts gespeichert }
::tkutils::tkuaction::define save -label "Speichern" -command speichern \
    -accelerator "Ctrl+S"

foreach top {.a .b} {
    toplevel $top
    ttk::button $top.save -text Speichern \
        -command {::tkutils::tkuaction::invoke save}
    pack $top.save
    ::tkutils::tkuaction::register save $top.save
    menu $top.m -tearoff 0
    ::tkutils::tkuaction::addMenuItem $top.m save
}

::tkutils::tkuaction::setEnabled save 0 .b      ;# nur Fenster .b
puts [::tkutils::tkuaction::getEnabled save .a] ;# -> 1
puts [::tkutils::tkuaction::getEnabled save .b] ;# -> 0
::tkutils::tkuaction::setEnabled save 1         ;# global, hebt .b auf
```

---

## Enable pro Fenster

- `setEnabled id 0|1` ohne Fenster wirkt auf alle gebundenen Widgets, wie
  in 0.1. Dieser Aufruf löscht zugleich alle Fenster-Overrides.
- `setEnabled id 0|1 $w` graut nur Widgets und Menüeinträge im Toplevel von
  `$w`. Ein Kind-Widget wird mit `winfo toplevel` aufgelöst; bei Menüs, die
  selbst Toplevels sind, gilt der erste Vorfahr, der kein Menü ist.
- `getEnabled` und `groupSet` nehmen dasselbe optionale Fenster.
- `invoke` prüft immer das **globale** Flag.
- Unbekanntes Fenster: `{TKUTILS TKUACTION WINDOW}`.

Menüzeilen sind keine Widgets; `addMenuItem $menu id` legt die Zeile an und
registriert ihren Index, `registerMenu`/`unregisterMenu` binden eine
bestehende Zeile. Gruppen schalten mehrere Aktionen auf einmal:

```tcl
package require tkutils::tkuaction
::tkutils::tkuaction::define zoom_in  -label "Vergrößern" -command {puts +}
::tkutils::tkuaction::define zoom_out -label "Verkleinern" -command {puts -}
::tkutils::tkuaction::groupDefine bild {zoom_in zoom_out}
::tkutils::tkuaction::groupSet bild 0
```

Fehlercodes: `{TKUTILS TKUACTION <GRUND>}` mit `OPTION`, `NOACTION`,
`NOGROUP`, `WINDOW`. Eine unbekannte Option bei `define` meldet den Code
`{TKUTILS TKUACTION OPTION -lable}` mit dem Optionsnamen und zwei Zeilen
wie bei `tkuopts`:

```text
unknown option "-lable"
Known: -accelerator -checkable -checked -command -compound -enabled -icon -iconChecked -label -tooltip
```

Die übrigen Meldungen: `unknown action 'zz'`, `unknown group 'zz'`,
`unknown window '.nix'`. `getEnabled` für eine unbekannte Aktion liefert
`0` statt eines Fehlers. Zum Stand bis 0.46.0: Anhang
[Fallen](800-anhang-fallen.md).

---

## Gerüst

Leiste, Status, Reiter, Hinweis, Kontextmenü, Tasten, Fokus, Suche,
Filter, Scrollen und der Auswahlrahmen stehen im Kapitel
[Gerüst](072-geruest.md). Formulare stehen im Kapitel
[Eingabe](074-eingabe.md). Viewer für CSV, JSON und Diff stehen im
Kapitel [Daten ansehen](078-daten-ansehen.md).

---

## tkulauncher 0.4

[tkulauncher]{.index} ist ein Programmstarter als Menü (`-mode menu`) oder
Knopfliste (`-mode list`). Einträge: `app` (auch `command`), `url`, `open` (auch `file`), `tcl`,
`system`, `menu`, `separator`, `calendar`, `calc`. URLs und Dateien öffnet
`tclutils::tuopen` mit dem Standardprogramm des Systems. `app`- und
`tcl`-Einträge kennen zusätzlich `dir` (Arbeitsverzeichnis) und `terminal 1`
(im Terminalfenster starten).

Optionen von `widget`: `-mode` (Standard `list`), `-text` (Knopftext im
Menümodus, Standard `Start`), `-items`, `-file` (Einträge aus `.json` oder
`.ini`), `-onlaunch`, `-settings`, `-system`, `-scroll`, `-height`
(Standard 400), `-tooltips`, `-columns` (Standard 1), `-editable`.

```tcl
package require tkutils::tkulauncher
set spec {
    {type menu label Werkzeuge items {
        {type app label Editor cmd {xterm}}
        {type url label "Tcl-Handbuch" target https://www.tcl.tk/man/tcl9.0/}
    }}
    {type separator}
    {type tcl label "Meine App" target app.tcl interp wish8}
}
::tkutils::tkulauncher::widget .l -mode list -items $spec \
    -onlaunch {apply {{kind argv} {puts "$kind: $argv"; return 0}}}
pack .l -fill both -expand 1
```

`-onlaunch` bekommt `kind argv`; ein falscher Rückgabewert unterdrückt den
Start — gut für Protokoll, Rückfrage oder Tests. `calendar`- und
`calc`-Einträge öffnen eingebaute Fenster und laufen nicht über
`-onlaunch`.

Mit `-scroll 1` liegt die Knopfliste in einem `tkuscrolledframe` und braucht
damit scrollutil. Das Mausrad über den Knöpfen rollt die Liste, auch
über Knöpfen, die `reload` neu anlegt; bis 0.2 fehlte ihnen diese
Bindung. Eine unbekannte Option an `widget` meldet
`unknown option "-foo"` mit der `Known:`-Liste aus `tkuopts`.

### Start unter Windows

`app`-Einträge laufen unter Windows über `cmd /c start`, damit unter
*App Paths* registrierte Programme ohne vollen Pfad starten; das
Arbeitsverzeichnis geht über `start /D`. `start` liest ein `/` als Beginn
eines Schalters. Seit 0.46.0 bekommen deshalb das Programm (erstes Wort)
und das `/D`-Verzeichnis **Backslashes**; die Argumente bleiben, wie sie
sind (sie können URLs oder Optionen sein). Ein Programm mit `://` behält
seine Schreibweise. Unter Linux/macOS wird das Programm direkt ausgeführt;
ein `dir` wird dort per `cd` vor dem Start gesetzt.

### Interpreter für `tcl`-Einträge

Ein `tcl`-Eintrag startet ein Skript mit `interp` (Standard `wish9`).
Optional setzt `tcllibpath` die Variable `TCLLIBPATH` für den Kindprozess.

| Schlüssel | Linux | Windows |
|---|---|---|
| `wish9` | `wish9.0` | `wish90.exe` |
| `wish8` | `wish8.6` | `wish86t.exe` |
| `tclsh9` | `tclsh9.0` | `tclsh90.exe` |
| `tclsh8` | `tclsh8.6` | `tclsh86t.exe` |

Jede Plattform außer Windows benutzt die Spalte *Linux*, auch macOS.

```tcl
package require tkutils::tkulauncher
puts [::tkutils::tkulauncher::tclInterpreters]                ;# -> wish9 wish8 tclsh9 tclsh8
puts [::tkutils::tkulauncher::resolveTclInterp wish8 windows] ;# -> wish86t.exe
::tkutils::tkulauncher::setTclInterp wish9 -linux /usr/local/tcl9/bin/wish9.0
puts [::tkutils::tkulauncher::resolve \
    {type tcl label Demo target app.tcl interp wish9 tcllibpath {lib}}]
```

`resolve` zeigt ohne Nebenwirkung, was gestartet würde (`kind`, `argv`,
optional `env`, `dir`, `terminal`). Die letzte Zeile des Beispiels gibt
`kind exec argv {/usr/local/tcl9/bin/wish9.0 app.tcl} env {TCLLIBPATH
lib}` aus. Ein führendes `~` in Pfaden erweitert der Launcher selbst, weil
Tcl 9 das nicht mehr tut. Ein unbekannter Interpreter-Schlüssel meldet
`unknown interpreter: <key>` (ohne Fehlercode).

---

## Zusammenfassung

- Actions zentral; Enable global oder pro Fenster (`setEnabled id 0 $w`).
- `invoke` folgt dem globalen Flag.
- Launcher: Windows-Start mit Backslashes, Interpreter-Mapping per
  `setTclInterp`.

::: {.info}
**Getestet mit** Tcl/Tk 8.6.14 und 9.0.4 unter Linux und Xvfb: alle
Beispiele und Meldungen dieses Kapitels, `tkulauncher.test` (100 Tests).

**Nicht getestet:** Start von `app`-Einträgen unter Windows (nur im Code
nachgelesen), Interpreter unter macOS.
:::

---

*Nächstes Kapitel: [Gerüst](072-geruest.md)*
