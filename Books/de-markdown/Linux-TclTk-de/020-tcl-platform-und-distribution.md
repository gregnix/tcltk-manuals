# tcl_platform und Distribution

## Einführung

[`tcl_platform`]{.index} sagt, welches Betriebssystem Tcl sieht. Unter
Linux und unter macOS lautet `platform` gleich: `unix`. Die Trennung
macht `os`. Welche Distribution läuft, sagt `tcl_platform` nicht. Dafür
gibt es [`/etc/os-release`]{.index}.

---

## Die Schlüssel

```tcl
set ::tcl_platform(platform)   ;# unix
set ::tcl_platform(os)         ;# Linux
set ::tcl_platform(osVersion)  ;# Kernel, nicht Distribution
set ::tcl_platform(machine)    ;# x86_64
set ::tcl_platform(user)       ;# Benutzer des Prozesses
```

Werte aus `serie-linux` (Debian forky, Tcl 8.6.18, Howto 10) und aus
der Container-Prüfung (– = dort nicht erhoben):

| Schlüssel | Debian forky, 8.6.18 | Container, 8.6.14 | Container, 9.0.4 |
|-----------|----------------------|-------------------|------------------|
| `platform` | unix | unix | unix |
| `os` | Linux | Linux | Linux |
| `osVersion` | `7.2.14+deb14-amd64` | `6.18.44-fc-v139` | `6.18.44-fc-v139` |
| `machine` | x86_64 | x86_64 | x86_64 |
| `wordSize` | 8 | 8 | 8 |
| `pointerSize` | – | 8 | 8 |
| `byteOrder` | – | littleEndian | littleEndian |
| `threaded` | 1 (8.6) | 1 | Schlüssel fehlt |

Linux-Code prüft also:

```tcl
if {$::tcl_platform(os) eq "Linux"} { ... }
```

`platform eq "unix"` trifft auch macOS (`os` ist dort `Darwin`) und die
BSDs. Für „X11 oder nicht“ ist `tcl_platform` ohnehin der falsche
Zeuge, das sagt `tk windowingsystem`, siehe
[X11, Fenstermanager und Wayland](080-x11-fenstermanager-wayland.md).

### threaded unter Tcl 9

Tcl 9 ist immer mit Threads gebaut. Der Schlüssel
[`threaded`]{.index} fehlt deshalb. Code, der ihn liest, braucht
`info exists`:

```tcl
set threads [expr {![info exists ::tcl_platform(threaded)]
                   || $::tcl_platform(threaded)}]
```

`serie-tcltk-bauen` (Howto 05) bestätigt das für 9.0.4 auf
Debian: `TCL_THREADS=1` in der `tclConfig.sh` von 8.6, unter 9.0 kein
Schlüssel, `--enable-threads` ist dort ein unbekannter Schalter.

### osVersion ist der Kernel

`osVersion` ist die Ausgabe von `uname -r` und wechselt mit jedem
Kernel-Update. Auf dem Debian-Arbeitsplatz war es bei der letzten
Prüfung `7.2.14+deb14-amd64` (`serie-linux`, Howto 10, nennt noch
`7.1.9+deb14-amd64`), im Container `6.18.44-fc-v139`. Der zweite
Wert ist der Kernel des Wirts, nicht der von Ubuntu: Ein Container
bringt keinen eigenen Kernel mit. Eine Versionsprüfung auf
„Debian 13“ oder „Ubuntu 24.04“ über `osVersion` geht daher immer
schief.

### user ist nicht USER

`tcl_platform(user)` ist der Name zur effektiven Benutzerkennung des
Prozesses. `$env(USER)` ist geerbt und kann fehlen oder etwas anderes
sagen, etwa nach `sudo` oder in einer Sandbox. Im Container mit
`env -i` gestartet: `tcl_platform(user)` ist `root`, `env(USER)` gibt
es nicht. `serie-linux` (Howto 03) schlägt deshalb im Container mit
„env USER gesetzt“ fehl, auf dem Arbeitsplatz nicht.

```tcl
set wer $::tcl_platform(user)             ;# immer da
set wer2 [expr {[info exists ::env(USER)] ? $::env(USER) : $wer}]
```

---

## Distribution: /etc/os-release

Die Distribution steht in `/etc/os-release`. Die Datei
besteht aus Zeilen `SCHLÜSSEL=Wert`, Werte oft in Anführungszeichen.
Sie ist Shell-Syntax, aber für die üblichen Schlüssel reicht ein
einfacher Leser:

```tcl
proc osRelease {} {
    set d [dict create]
    foreach datei {/etc/os-release /usr/lib/os-release} {
        if {![file readable $datei]} continue
        set ch [open $datei]
        fconfigure $ch -encoding utf-8
        foreach zeile [split [read $ch] \n] {
            if {[regexp {^([A-Z_]+)=(.*)$} $zeile -> k v]} {
                dict set d $k [string trim $v {"'}]
            }
        }
        close $ch
        break
    }
    return $d
}
set r [osRelease]
puts "[dict get $r ID] [dict getdef $r VERSION_CODENAME -]"
```

`dict getdef` gibt es ab Tcl 8.7; unter 8.6 `dict exists` vorher
prüfen. Ergebnis (– = nicht erhoben):

| Schlüssel | Debian-Arbeitsplatz | Container |
|-----------|---------------------|-----------|
| `ID` | debian | ubuntu |
| `ID_LIKE` | – | debian |
| `VERSION_ID` | fehlt | 24.04 |
| `VERSION_CODENAME` | forky | noble |
| `PRETTY_NAME` | Debian GNU/Linux forky/sid | Ubuntu 24.04.5 LTS |

Die Debian-Spalte stammt aus `serie-linux` (Howto 06: `ID=debian`,
`VERSION_CODENAME=forky`). Ubuntu trägt `ID_LIKE=debian`, wie das
Debian-Buch im Kapitel *Debian erkennen* schreibt. Debian Testing setzt
`VERSION_ID` nicht (Arbeitsplatz, forky/sid). Code verlässt sich
deshalb nicht darauf und nimmt `VERSION_CODENAME`. Wer „Debian oder abgeleitet“
prüft, liest `ID` **und** `ID_LIKE`.

```tcl
set familie [concat [dict getdef $r ID ""] [dict getdef $r ID_LIKE ""]]
if {"debian" in $familie} { ... }
```

Im Container liefert `/etc/debian_version` übrigens `trixie/sid`, obwohl
das System Ubuntu ist. Ubuntu übernimmt die Datei aus Debian. Sie taugt
nicht, um Debian von Ubuntu zu trennen.

---

## Der laufende Prozess: /proc/self

Was Windows aus der Registry und macOS aus `sysctl` liest, liegt unter
Linux im Dateisystem [`/proc`]{.index}. `serie-linux` (Howto 06):

```tcl
file readlink /proc/self/exe      ;# z. B. /usr/bin/tclsh8.6
set ch [open /proc/self/comm]
set name [string trim [read $ch]]
close $ch
```

`/proc/self/exe` ist der aufgelöste Pfad des Interpreters, auch wenn er
über einen Symlink gestartet wurde. `info nameofexecutable` liefert
dagegen den Pfad, unter dem der Interpreter aufgerufen wurde. Für die
Frage „welches Tcl läuft hier“ ist das nächste Kapitel zuständig.

---

## Zusammenfassung

- `platform` ist `unix` auf Linux und macOS. `os` trennt: `Linux`.
- `osVersion` ist der Kernel, im Container der des Wirts.
- `threaded` fehlt unter Tcl 9. Vor dem Lesen `info exists`.
- `tcl_platform(user)` ist verlässlich, `$env(USER)` nicht.
- Distribution aus `/etc/os-release`, Familie über `ID` und `ID_LIKE`.
  `/etc/debian_version` steht auch auf Ubuntu.

---

*Nächstes Kapitel: [Welches Tcl?](030-welches-tcl.md)*
