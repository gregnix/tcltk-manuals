# exec, xdg-open, Prozesse

## Einführung

Unter Linux ist `exec` das Werkzeug für alles, was Tcl nicht selbst
kann: Dateien mit dem passenden Programm öffnen, den Browser starten,
Systemwerte abfragen. Es gibt keine Shell dazwischen. Tcl startet das
Programm direkt, mit den Argumenten als Liste. Das macht `exec` sicher
gegen Leerzeichen und Sonderzeichen, aber Shell-Syntax wie `*`, `~`
oder `$VAR` wirkt nicht.

---

## Programm finden: auto_execok

[`auto_execok`]{.index} sucht ein Programm im `PATH` und liefert den
vollen Pfad als Liste, oder einen leeren String:

```tcl
set p [auto_execok xdg-open]
if {$p eq ""} {
    error "xdg-open fehlt"
}
exec {*}$p $datei &
```

Im Container: `auto_execok sh` liefert `/usr/bin/sh`, `auto_execok
xdg-open` liefert `/usr/bin/xdg-open`, `auto_execok lpstat` einen
leeren String (kein CUPS). Das Ergebnis ist eine Liste, daher das `{*}`.
Unter Windows kann sie mehrere Elemente haben, unter Linux ist es ein
Pfad.

`auto_execok` merkt sich jede Antwort im globalen Array `auto_execs`,
auch die leere. Wer nach dem Programmstart ein Werkzeug installiert,
löscht den Eintrag, sonst bleibt die alte Antwort:

```tcl
unset -nocomplain ::auto_execs(xdg-open)
```

`auto_reset` leert das Array ebenfalls, entfernt aber zugleich alle
über `auto_index` nachgeladenen Befehle (Quelltext `auto.tcl` in
Tcl 9.0.4). Für diesen Zweck ist es zu grob.

---

## Fehler von exec auseinanderhalten

`exec` wirft einen Fehler in drei verschiedenen Fällen. Welcher
vorliegt, steht in `errorCode`. Container-Prüfung, 8.6.14 und 9.0.4
gleich:

| Fall | Meldung | `errorCode` |
|------|---------|-------------|
| Programm fehlt | `couldn't execute "gibtsnicht": no such file or directory` | `POSIX ENOENT {no such file or directory}` |
| Rückgabewert ungleich 0 (`false`) | `child process exited abnormally` | `CHILDSTATUS <pid> 1` |
| Ausgabe auf stderr | der stderr-Text, hier `meldung` | `NONE` |
| Kind durch Signal beendet | `child killed: software termination signal` | `CHILDKILLED <pid> SIGTERM {software termination signal}` |

Der dritte Fall ist die bekannte Falle: Ein Programm, das erfolgreich
läuft, aber eine Warnung auf stderr schreibt, gilt für `exec` als
Fehler. Abhilfe:

```tcl
exec -ignorestderr programm arg      ;# stderr geht an Tcls stderr
exec programm arg 2>@1               ;# stderr in das Ergebnis
exec programm arg 2>/dev/null        ;# stderr verwerfen
```

Ein Muster für alle Fälle:

```tcl
try {
    set aus [exec -ignorestderr {*}$befehl]
} trap {CHILDSTATUS} {msg opts} {
    set rc [lindex [dict get $opts -errorcode] 2]
    puts "Rückgabewert $rc"
} trap {POSIX ENOENT} {} {
    puts "Programm fehlt"
}
```

---

## Im Hintergrund und über Kanäle

Ein `&` am Ende startet das Programm im Hintergrund. `exec` wartet nicht
und liefert die Prozessnummern:

```tcl
set pids [exec xdg-open $datei &]
```

Für lang laufende Programme, deren Ausgabe man lesen will, ohne die
Oberfläche anzuhalten, ist ein Kanal das richtige Werkzeug:

```tcl
set ch [open |[list ping -c 3 localhost] r]
fconfigure $ch -blocking 0 -encoding utf-8
fileevent $ch readable [list lesen $ch]
proc lesen {ch} {
    if {[gets $ch zeile] >= 0} { .t insert end $zeile\n }
    if {[eof $ch]} {
        fconfigure $ch -blocking 1
        catch {close $ch} fehler
    }
}
```

Das `fconfigure -blocking 1` vor dem `close` sorgt dafür, dass `close`
den Rückgabewert des Kindes meldet. Die Kodierung des Kanals folgt sonst
`encoding system`, siehe [Kodierung und Locale](060-kodierung-und-locale.md).

### Die Falle mit der eigenen Auswahl

Ein blockierendes `exec` hält die Ereignisschleife an. Meist ist das
nur unschön. Es wird zur Verklemmung, wenn das Kind auf das eigene
Programm wartet. Container-Prüfung: Ein `wish` markiert Text in einem
Entry und ruft dann `exec xclip -o -selection primary`. `xclip` fragt
beim Besitzer der Auswahl nach, also bei diesem `wish`. Der steht in
`exec` und antwortet nicht. Beide warten, bis `timeout` den Lauf nach
20 Sekunden beendet. Mit einem Kanal und `fileevent` wie oben läuft
derselbe Aufruf durch (`beispiele/auswahl-probe.tcl`). Mehr zur
Auswahl in [Maus, Tastatur, Zwischenablage](100-maus-tastatur-zwischenablage.md).

---

## xdg-open: Datei oder Adresse öffnen

[`xdg-open`]{.index} ist das Linux-Gegenstück zu `start` unter Windows
und `open` unter macOS. Es öffnet eine Datei mit dem eingestellten
Programm oder eine Adresse im Browser (`serie-linux`, Howto 07):

```tcl
proc oeffnen {ziel} {
    set p [auto_execok xdg-open]
    if {$p eq ""} { error "xdg-open fehlt (Paket xdg-utils)" }
    exec {*}$p $ziel &
}
oeffnen https://www.tcl-lang.org
oeffnen [file join $env(HOME) bericht.pdf]
```

`xdg-open` gehört zum Paket `xdg-utils`. Es fragt die Desktop-Umgebung,
welches Programm zuständig ist. Unter Xfce reicht es an `exo-open`
weiter (siehe [Xfce aus Tcl](120-xfce.md)). Die Zuordnung für einen
Dateityp zeigt `xdg-mime query default <MIME-Typ>`.

Das `&` ist wichtig. Ob `xdg-open` sofort zurückkehrt oder wartet, bis
das geöffnete Programm endet, hängt von der Desktop-Umgebung und vom
Programm ab; ohne `&` kann die Oberfläche stehen bleiben. Gemessen mit
Tcl 8.6:

| Aufruf | Arbeitsplatz, Xfce | Container ohne Desktop |
|---|---|---|
| `exec xdg-open /etc/hostname &` | Prozessnummer sofort, Mousepad öffnet | ruft LibreOffice auf und wartet |
| `exec xdg-open https://example.org &` | Prozessnummer sofort, Browser öffnet | kein Browser, Exit 3 |
| `exec xdg-open /gibtsnicht` | `CHILDSTATUS … 4` | `CHILDSTATUS … 2` |

Die Exitcodes stehen in `xdg-open(1)`: 2 Datei fehlt, 3 kein Programm,
4 Aktion gescheitert. Unter Xfce prüft `xdg-open` die Datei nicht
selbst, sondern reicht sie an `exo-open` weiter; dessen Fehler wird 4.
Ohne Desktop-Sitzung (`xdg-utils` 1.1.3, Container) prüft es selbst
und meldet 2. Code prüft also nur „nicht 0“, nicht eine bestimmte Zahl. Die Fenster
erscheinen nicht in der Reihenfolge der Aufrufe: Auf dem Arbeitsplatz
kam der Browser vor Mousepad, obwohl `/etc/hostname` zuerst geöffnet
wurde. Wer danach ein Fenster erwartet, wartet nicht auf eine Reihenfolge.
Die Serien starten `xdg-open` unter `SERIES_AUTO` nicht.

---

## Prozessnummer und Signale

```tcl
pid                       ;# eigene Prozessnummer
pid $ch                   ;# Prozessnummern hinter einem Kanal
```

Ein Signal schickt Tcl nicht selbst. `exec kill -TERM $p` tut es. Ein
Tcl-Programm, das auf `SIGTERM` reagieren soll, braucht eine Erweiterung
(etwa `TclX` mit `signal`); ohne sie endet es sofort. Das ist nicht
geprüft.

Unter Linux hat jedes Programm `/proc/<pid>/` mit `cmdline`, `environ`
und `status`. Ob ein Prozess noch lebt:

```tcl
file isdirectory /proc/$p
```

---

## Zusammenfassung

- `auto_execok` vor jedem `exec` eines Fremdprogramms, Ergebnis mit
  `{*}` einsetzen.
- `errorCode` trennt: `POSIX ENOENT`, `CHILDSTATUS`, `NONE` (stderr),
  `CHILDKILLED`.
- `-ignorestderr` für Programme, die auf stderr plaudern.
- Lange Läufe über `open |…` mit `fileevent`. Nie blockierend ein
  Programm rufen, das das eigene Programm fragt.
- `xdg-open` mit `&`, Paket `xdg-utils`.

---

*Nächstes Kapitel: [X11, Fenstermanager und Wayland](080-x11-fenstermanager-wayland.md)*
