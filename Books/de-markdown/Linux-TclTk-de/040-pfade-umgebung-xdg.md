# Pfade, Umgebung, XDG

## Einführung

Unter Linux hat jeder Prozess ein `HOME`, Pfade trennt der
Schrägstrich, es gibt nur ein Wurzelverzeichnis. Wo ein Programm seine
Einstellungen ablegt, regelt die [XDG Base Directory]{.index}
Specification: nicht als Punktdatei direkt in `$HOME`, sondern in
`~/.config/<Programm>/`. Dieses Kapitel zeigt die Variablen, die
Vorgaben, wenn sie fehlen, und den Bruch bei der Tilde zwischen Tcl
8.6 und 9.

---

## HOME und die Tilde

`$env(HOME)` ist unter Linux gesetzt, anders als oft unter Windows
(`serie-linux`, Howto 02 und 03). Pfade baut man mit `file join`:

```tcl
set konfig [file join $env(HOME) .config meineapp]
```

Bei der Tilde trennen sich 8.6 und 9. Tcl 8.6 ersetzt ein führendes
`~` in jedem Pfad durch `HOME`. Tcl 9 tut das nicht mehr (TIP 602):
`~` ist dort ein gewöhnlicher Dateiname. Dafür gibt es zwei neue
Befehle. Container-Prüfung, Arbeitsordner `/tmp`, `HOME=/root`:

| Ausdruck | Tcl 8.6.14 | Tcl 9.0.4 und 9.1.0 |
|----------|------------|---------------------|
| `file normalize ~` (gestartet in `/tmp`) | `/root` | `/tmp/~` |
| `file exists ~` | 1 | 0 |
| `file home` | Fehler, unbekannt | `/root` |
| `file tildeexpand ~/x` | Fehler, unbekannt | `/root/x` |

Auf lxpro mit den Debian-Paketen, im Heimatordner gestartet, dasselbe
Bild: `tclsh` 8.6.18 liefert für `file normalize ~` den Heimatordner
und für `file exists ~` 1, `tclsh9.0` 9.0.4 und `tclsh9.1` 9.1.0
liefern `<Heimatordner>/~` und 0.

`file normalize ~` taugt also nur unter 8.6 als Weg zum
Heimatordner. Unter Tcl 9 liefert derselbe Ausdruck einen Pfad im
aktuellen Ordner. `serie-linux` zeigt in Howto 02 beide Fassungen; die
Demo `02-pfade.tcl` prüft unter 8.6 „Tilde = HOME“ und unter 9
`file home` und `file tildeexpand`.

Code für beide Fassungen nimmt `$env(HOME)` und keine Tilde:

```tcl
proc heim {} {
    if {[info exists ::env(HOME)] && $::env(HOME) ne ""} {
        return $::env(HOME)
    }
    return [file home]          ;# nur Tcl 9
}
```

Eine Tilde, die von außen kommt, etwa aus einer Konfigurationsdatei,
löst unter Tcl 9 erst `file tildeexpand` auf. Unter 8.6 erledigt das
jeder Dateibefehl von selbst.

---

## Umgebungsvariablen

`serie-linux` (Howto 03) liest die üblichen Variablen:

```tcl
$env(HOME) $env(USER) $env(SHELL) $env(PATH)
$env(LANG) $env(DISPLAY)
```

Was davon gesetzt ist, hängt an der Sitzung. In einer grafischen
Sitzung stehen `DISPLAY`, `XDG_CURRENT_DESKTOP`, `XDG_SESSION_TYPE` und
`XDG_RUNTIME_DIR` bereit. In einem Cron-Lauf, unter `sudo` oder mit
`env -i` fehlen sie. `HOSTNAME` und `TMPDIR` fehlen oft auch in der
Sitzung. Für den Rechnernamen gibt es `info hostname`. Das temporäre
Verzeichnis ist dann `/tmp`.

Robust ist ein Zugriff mit Vorgabe:

```tcl
proc envOder {name vorgabe} {
    if {[info exists ::env($name)] && $::env($name) ne ""} {
        return $::env($name)
    }
    return $vorgabe
}
set tmp [envOder TMPDIR /tmp]
```

Tcl 9 hat dafür auch `file tempdir`. Es legt ein neues, leeres
Verzeichnis an und liefert seinen Pfad, im Container
`/tmp/tcl_KZSgAw`. Das Verzeichnis räumt das Programm selbst wieder
weg.

---

## XDG Base Directory

Die Spezifikation legt vier Orte für Benutzerdaten fest. Jede Variable
darf fehlen, dann gilt die Vorgabe. `serie-linux` (Howto 04):

| Variable | Vorgabe | Inhalt |
|----------|---------|--------|
| `XDG_CONFIG_HOME` | `~/.config` | Einstellungen |
| `XDG_DATA_HOME` | `~/.local/share` | Daten, die bleiben sollen |
| `XDG_CACHE_HOME` | `~/.cache` | Wegwerfbares |
| `XDG_STATE_HOME` | `~/.local/state` | Verlauf, letzte Fenstergröße |
| `XDG_RUNTIME_DIR` | keine | Sockets, Sperrdateien; `/run/user/UID` |

Auf dem Arbeitsplatz des Autors ist `XDG_DATA_HOME` oft nicht gesetzt,
`XDG_RUNTIME_DIR` ist `/run/user/UID`. Im Container mit `env -i` ist
keine dieser Variablen gesetzt. `XDG_STATE_HOME` prüfen die Serien
nicht; die Vorgabe stammt aus der Spezifikation.

Ein Programm legt seine Dateien in einen eigenen Unterordner:

```tcl
proc xdgOrdner {var vorgabe app} {
    set basis ""
    if {[info exists ::env($var)]} { set basis $::env($var) }
    if {$basis eq "" || [file pathtype $basis] ne "absolute"} {
        set basis [file join [heim] {*}$vorgabe]
    }
    return [file join $basis $app]
}
set konfig [xdgOrdner XDG_CONFIG_HOME .config meineapp]
file mkdir $konfig
```

Ein relativer Wert ist laut Spezifikation ungültig und wird übergangen.
`beispiele/xdg-ordner.tcl` enthält die vier Varianten und lief im
Container unter 8.6.14 und 9.0.4 mit demselben Ergebnis, auch mit
`XDG_CONFIG_HOME=relativ`: `/root/.config/meineapp`.

Die Windows-Entsprechung ist `APPDATA`, die macOS-Entsprechung
`~/Library/Application Support`. Ein Programm für alle drei fragt
zuerst `tcl_platform(os)` und dann die jeweilige Quelle.

---

## Benutzerordner: Dokumente und Desktop

Die Namen der sichtbaren Ordner im Heimatverzeichnis sind
**lokalisiert**. Auf einem deutschen Desktop heißt der Ordner
`Dokumente`, nicht `Documents`, der Desktop `Schreibtisch`. Die
Zuordnung steht in [`~/.config/user-dirs.dirs`]{.index}; das Werkzeug
`xdg-user-dir` liest sie (`serie-linux`, Howto 05):

```tcl
exec {*}[auto_execok xdg-user-dir] DOCUMENTS
exec {*}[auto_execok xdg-user-dir] DESKTOP
exec {*}[auto_execok xdg-user-dir] DOWNLOAD
```

`xdg-user-dir` gehört zum Debian-Paket `xdg-user-dirs`. Im Container
fehlt es; Howto 05 schlägt dort fehl. `beispiele/xdg-ordner.tcl` fällt
in diesem Fall auf `HOME` zurück. Einen Ordner wie `~/Documents` fest
einzutragen ist der häufigste Fehler dieses Abschnitts.

---

## Dateisystem

Unix-Attribute, keine Laufwerksbuchstaben (`serie-linux`, Howto 09):

```tcl
file volumes                          ;# /
file attributes $f                    ;# -group -owner -permissions
file attributes $f -permissions 00644
```

Unter Tcl 9 liefert `file volumes` zusätzlich `//zipfs:/`
(Container-Prüfung: `//zipfs:/ /`). Code, der `[lindex [file volumes] 0]`
für die Wurzel hält, bekommt unter 9 das Zipfs. `/tmp` hat das
Sticky-Bit, Rechte `1777`. Das Format des Rechtewerts unterscheidet
sich zwischen 8.6 und 9, siehe [Welches Tcl?](030-welches-tcl.md).

`file nativename` liefert unter Linux denselben Pfad zurück. Groß- und
Kleinschreibung zählt: `Daten.txt` und `daten.txt` sind zwei Dateien.
Das unterscheidet Linux von macOS (APFS in der Grundeinstellung) und
von Windows.

---

## Zusammenfassung

- `HOME` ist gesetzt. Pfade mit `file join`.
- Tilde: unter 8.6 überall aufgelöst, unter 9 nicht mehr.
  `file normalize ~` liefert unter 9 einen Pfad im aktuellen Ordner.
  Für beide Fassungen `$env(HOME)`.
- XDG: Variable oder Vorgabe, eigener Unterordner, relative Werte
  übergehen.
- Benutzerordner lokalisiert, über `xdg-user-dir`.
- `file volumes` enthält unter 9 auch `//zipfs:/`.

---

*Nächstes Kapitel: [Suchpfade](050-suchpfade.md)*
