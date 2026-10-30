# tusettings

## Zweck

[tusettings]{.index} **0.1** legt pro App Einstellungen als INI in das
Plattform-Config-Verzeichnis, plus Verzeichnisse für cache/data/temp und
eine Recent-Liste. Pure Tcl, kein Tk. Neu in 0.64.0, seither im
Umbrella. Die INI schreibt `tuini`; sie lässt sich von Hand lesen und
ändern. Dateien schreibt und liest das Modul als UTF-8.

```tcl
package require tclutils::tusettings
set s [::tclutils::tusettings::load meineapp -defaults {
    window {width 800 height 600}
}]
dict set s window width 1024
::tclutils::tusettings::save meineapp $s     ;# -> Pfad der settings.ini
::tclutils::tusettings::recentAdd meineapp /pfad/zur/datei
::tclutils::tusettings::value $s window width ;# -> 1024
```

`save` liefert den Pfad, unter Linux `$HOME/.config/meineapp/settings.ini`.

Die Befehle liegen im Namensraum `::tclutils::tusettings`. Die Kurzform
`tusettings::load` löst Tcl nur innerhalb von `namespace eval ::tclutils`
auf; auf globaler Ebene bricht sie mit `invalid command name` ab.

---

## API (Kurz)

| Befehl | Rolle |
|---|---|
| `dir kind app ?-create bool?` | config / cache / data / temp |
| `file app ?name?` | `<config>/<name>.ini`, Default-Name `settings` |
| `load app ?-defaults d? ?-name n?` | INI zu Dict, über die Defaults gelegt |
| `save app settings ?-name n?` | Dict zu INI (Temp-Datei, dann Rename); liefert den Pfad |
| `value settings section key ?default?` | Section/Key lesen |
| `recentAdd app path ?-list l? ?-max n?` | Pfad nach oben, liefert die neue Liste |
| `recentList app ?-list l? ?-existing bool?` | Liste, neuester zuerst |
| `recentRemove app path ?-list l?` / `recentClear app ?-list l?` | Eintrag bzw. Liste löschen |

`load` legt die Datei über `-defaults`; neue Schlüssel einer späteren
App-Version bekommen so ihren Default. Fehlt die Datei, liefert `load`
die Defaults. `dir` legt nur mit `-create 1` etwas an; `save` und
`recentAdd` erzeugen das Config-Verzeichnis selbst. `-list` (Default
`recent`) wählt die Recent-Datei.

---

## Verzeichnisse pro Plattform

| kind | Linux / BSD | Windows | macOS |
|---|---|---|---|
| config | `$XDG_CONFIG_HOME` oder `~/.config` | `%APPDATA%` | `~/Library/Application Support` |
| cache | `$XDG_CACHE_HOME` oder `~/.cache` | `%LOCALAPPDATA%` | `~/Library/Caches` |
| data | `$XDG_DATA_HOME` oder `~/.local/share` | `%APPDATA%` | `~/Library/Application Support` |
| temp | `$TMPDIR` oder `/tmp` | `%TEMP%` oder `%TMP%` | `$TMPDIR` oder `/tmp` |

An jedes Verzeichnis wird der App-Name angehängt. Unter Windows greifen
ohne die Umgebungsvariablen `<home>/AppData/Roaming` bzw.
`<home>/AppData/Local` (temp: `…/Local/Temp`). macOS wird an
`tcl_platform(os)` = `Darwin` erkannt.

Ohne `XDG_*` und `TMPDIR` sind das unter Linux `~/.config/meineapp`,
`~/.cache/meineapp`, `~/.local/share/meineapp` und `/tmp/meineapp`.
Die Spalten für Windows und macOS stehen so im Code.

---

## Recent-Liste

Eine Textdatei pro Liste (`<config>/<list>.txt`, ein Pfad pro Zeile,
UTF-8). `recentAdd` normalisiert den Pfad, setzt ihn nach oben, wirft
einen älteren Eintrag derselben Datei hinaus (unter Windows ohne
Groß/Klein-Unterschied) und behält `-max` Einträge (Default 10).
`recentList -existing 1` lässt verschwundene Dateien weg.

---

## Grenzen und Fehler

INI kann nicht alles. `save` lehnt ab: Werte mit Zeilenumbruch oder
Leerzeichen am Rand; leere Schlüssel, Schlüssel mit `=`, Zeilenumbruch,
Leerzeichen am Rand oder mit `;`, `#`, `[` am Anfang; Sektionsnamen mit
`]` oder Zeilenumbruch. Geprüft wird vor dem Schreiben, die Datei bleibt
dann unverändert. Scheitert das Schreiben selbst, bleibt die alte Datei
ebenfalls, die Temp-Datei wird gelöscht, und kein Kanal bleibt offen
(0.2). Kommentare in der Datei überleben `save` nicht.

```tcl
try {
    ::tclutils::tusettings::save meineapp {window {title " x"}}
} trap {TCLUTILS TUSETTINGS VALUE} msg {
    puts "abgelehnt: $msg"
}
```

Die Meldung lautet
`value of window.title: no line breaks or outer blanks in INI`.

| Code | Fall |
|---|---|
| `{TCLUTILS TUSETTINGS APP}` | App-Name leer oder mit Pfadzeichen |
| `{TCLUTILS TUSETTINGS KIND}` | `dir` mit unbekanntem kind |
| `{TCLUTILS TUSETTINGS SYNTAX}` | INI-Datei nicht parsebar |
| `{TCLUTILS TUSETTINGS VALUE}` | Wert, Schlüssel oder Sektion nicht INI-tauglich; `-max` keine positive Ganzzahl; Pfad mit Zeilenumbruch |

Unbekannte Optionen: `{TCLUTILS COMMON OPTION <opt>}`. Bei `SYNTAX`
entscheidet der Aufrufer, ob er auf die Defaults zurückfällt; die
Meldung nennt die Datei und die fehlerhafte Zeile, etwa
`…/settings.ini: line without '=' : garbage line`.

`tkutils::tkugeometry` speichert Fenstergeometrie darüber; Details im
Buch *tkutils*.

---

## Zusammenfassung

- INI-Settings + Recent, plattformübliche Pfade.
- Voller Namensraum `::tclutils::tusettings::…`.
- GUI-Geometrie: Buch *tkutils*.

---

*Nächstes Kapitel: [Tasks mit tutask](085-tutask.md)*
