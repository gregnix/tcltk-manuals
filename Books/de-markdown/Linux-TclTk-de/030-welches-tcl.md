# Welches Tcl?

## Einführung

Auf einem Linux-Arbeitsplatz liegen oft mehrere Tcl nebeneinander:
das der Distribution unter `/usr` und ein selbst gebautes unter `/opt`.
Beide heißen `tclsh` mit Versionsnummer. Welches antwortet, entscheidet
der `PATH` oder der volle Pfad. Dieses Kapitel zeigt, woran man das
laufende Tcl erkennt und wie sich die beiden Sorten unterscheiden.

---

## Die drei Herkünfte

| Herkunft | Ort | Aufruf | geprüft mit |
|----------|-----|--------|----------|
| Distributionspaket Tcl 8.6 | `/usr/bin` | `tclsh8.6`, `wish8.6`, oft `tclsh` | Debian forky 8.6.18, Ubuntu 24.04 8.6.14 |
| Distributionspaket Tcl 9.0 | `/usr/bin` | `tclsh9.0`, `wish9.0` | Debian forky 9.0.4 (`serie-tcltk-bauen`) |
| Distributionspaket Tcl 9.1 | `/usr/bin` | `tclsh9.1`, `wish9.1` | Debian forky und unstable 9.1.0 |
| Quellbau | `/opt/tcl9` | `/opt/tcl9/bin/tclsh9.0`, `wish9.0` | Container 9.0.4 |

Welche Pakete die Debian-Zweige führen, darunter [`tcl9.0`]{.index}
(Quellpakete, Stand
2026-11-02, `qa.debian.org/madison.php`):

| Paket | Stable (trixie) | Testing (forky) | unstable (sid) |
|---|---|---|---|
| `tcl8.6` | 8.6.16 | 8.6.18 | 8.6.18 |
| `tcl9.0` | 9.0.1 | 9.0.4 | 9.0.4 |
| `tcl9.1` | – | 9.1.0 | 9.1.0 |

Zu jedem `tcl…` gibt es das passende `tk…` in derselben Fassung. Der Betreuer der Tcl-Pakete hat im
November 2026 angekündigt, Tcl/Tk 9.0 für forky zu streichen; dann
bliebe 9.1 neben 8.6. Standard bleibt 8.6: Pakete mit C-Teil
baut Debian nur gegen 8.6, solange die Pakete `tcltk-defaults` nichts
anderes sagen. Das Debian-Buch, Kapitel *Tcl
unter Linux*, nennt die Lage auf den Rechnern des Autors: auf dem
Debian-Arbeitsplatz die Pakete für 8.6.18, 9.0.4 und 9.1.0 unter
`/usr` und ein selbst gebautes 9.1.0 unter `/opt/tcl91`, auf einem
zweiten Rechner ein selbst gebautes 9.0.4 unter `/opt/tcl9`. Ubuntu 24.04 im Container hat nur 8.6.14 als Paket.

Die Regeln aus dem Debian-Buch gelten hier unverändert: Ein eigenes Tcl
nie nach `/usr` installieren, sondern nach `/opt`. Das Bauen selbst
beschreiben *Tcl/Tk 9.0 bauen* und *Tcl/Tk 9.1 bauen*, Kapitel
*Mehrere Installationen*.

---

## Wer antwortet?

In der Shell:

```bash
type -a tclsh tclsh8.6 tclsh9.0 wish9.0
ls -l /usr/bin/tclsh /usr/bin/wish
dpkg -S /usr/bin/tclsh8.6          # nur Debian und Ubuntu
```

Im Container ist `/usr/bin/tclsh` ein Symlink auf `tclsh8.6`, `/usr/bin/wish`
einer auf `wish8.6`. `update-alternatives --display tclsh` meldet dort
„no alternatives for tclsh“: Der Link gehört dem Paket `tcl`, nicht dem
Alternativen-System.

Im Interpreter:

```tcl
puts [info nameofexecutable]    ;# Pfad des Aufrufs
puts [info patchlevel]
puts $tcl_library
puts [tcl::pkgconfig get libdir,runtime]
```

Container-Prüfung:

| Wert | `tclsh8.6` (Ubuntu) | `tclsh9.0` (`/opt/tcl9`) |
|------|---------------------|--------------------------|
| `info patchlevel` | 8.6.14 | 9.0.4 |
| `$tcl_library` | `/usr/share/tcltk/tcl8.6` | `//zipfs:/lib/tcl/tcl_library` |
| `libdir,runtime` | `/usr/lib/x86_64-linux-gnu` | `/opt/tcl9/lib` |
| `scriptdir,runtime` | `/usr/share/tcltk/tcl8.6` | `/opt/tcl9/lib/tcl9.0` |
| `zipfs mount` | Befehl fehlt | `//zipfs:/lib/tcl` an `libtcl9.0.so` |

Zwei Dinge fallen auf. Debian und Ubuntu legen die Tcl-Bibliothek nach
`/usr/share/tcltk`, nicht nach `/usr/lib/tcl8.6` wie ein Quellbau von
8.6. Und ein Quellbau von Tcl 9 hängt die Skriptbibliothek als ZIP an
`libtcl9.0.so`. `$tcl_library` zeigt dann ins [Zipfs]{.index}. Den
Ordner `/opt/tcl9/lib/tcl9.0` aus `scriptdir,runtime` gibt es im
Container nicht; er ist ein Rest der Bauvorgabe.

Die Debian-Pakete für Tcl 9 legen die Bibliothek ohne Zipfs ab. Auf
dem Debian-Arbeitsplatz meldet `tclsh9.0` den Ordner `/usr/lib/tcl9.0`, `tclsh9.1` den
Ordner `/usr/lib/tcl9.1`.

---

## Tk zu Tcl 9.1

Debian trennt Tcl und Tk in eigene Pakete. Wer nur `tcl9.1` installiert,
hat kein `wish9.1`, und `package require Tk` in `tclsh9.1` meldet
trotzdem eine Fassung. Auf dem Debian-Arbeitsplatz, ohne das Paket
`tk9.1`:

```text
% package require Tk
9.0.4
```

`tclsh9.1` findet über `auto_path` den Index von Debians Tk 9.0 unter
`/usr/lib/tcltk/x86_64-linux-gnu/tk9.0` und lädt ihn. Das geht, weil
Tk 9.0 sich über die Stub-Tabelle an Tcl bindet; die Release-Notes von
Tk 9.1.0 nennen ausdrücklich Tcl 9.0 oder 9.1 als Grundlage. Es ist
aber nicht Tk 9.1: Die Neuerungen von 9.1 fehlen. Abhilfe:

```bash
sudo apt install tk9.1
```

Danach liefert `package require Tk` in `tclsh9.1` die Fassung 9.1.0,
und `wish9.1` ist da.

---

## Ein Quellbau, der Debians Bibliothek lädt

Ein Tcl unter `/opt` ist nur dann getrennt, wenn es auch seine eigene
`libtcl` lädt. Die Datei heißt bei Debian und beim Quellbau gleich,
`libtcl9.0.so`. Findet der Lader zuerst Debians Datei, läuft das
Programm aus `/opt` mit Debians Bibliothek. Auf dem
Debian-Arbeitsplatz mit einem BAWT-Build 9.0.1 unter `/opt/Tcl`:

| Aufruf | `info patchlevel` | `$tcl_library` |
|--------|-------------------|----------------|
| `/opt/Tcl/bin/tclsh9.0` | 9.0.4 | `/usr/lib/tcl9.0` |
| `LD_LIBRARY_PATH=/opt/Tcl/lib /opt/Tcl/bin/tclsh9.0` | 9.0.1 | `//zipfs:/lib/tcl/tcl_library` |

Ohne `LD_LIBRARY_PATH` meldet das BAWT-Programm Debians Fassung und
Debians Skriptbibliothek. Es sieht dann auch Debians Pakete zuerst.
Prüfen lässt es sich mit `ldd`:

```bash
ldd /opt/Tcl/bin/tclsh9.0 | grep libtcl
```

Zeigt die Zeile nach `/usr/lib/x86_64-linux-gnu`, braucht das Programm
eine kleine Startdatei, etwa `~/bin/tclsh9b`:

```sh
#!/bin/sh
LD_LIBRARY_PATH=/opt/Tcl/lib${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH} exec /opt/Tcl/bin/tclsh9.0 "$@"
```

Ein Alias reicht nicht: Er gilt nur in der interaktiven Shell, nicht in
Skripten und Makefiles. Der Quellbau im Container nach `/opt/tcl9`
braucht keine Startdatei: `readelf -d /opt/tcl9/bin/tclsh9.0` zeigt
`RUNPATH` `/opt/tcl9/lib`, das Programm findet seine eigene Bibliothek
vor der des Systems. Beim BAWT-Build auf dem Debian-Arbeitsplatz greift
kein solcher
Eintrag; was dort steht, zeigt `readelf -d` auf dem Rechner selbst.

---

## tclsh und wish im PATH

Ein Quellbau nach `/opt/tcl9` legt `tclsh9.0` und `wish9.0` in
`/opt/tcl9/bin`. Im Container gab es dort zusätzlich einen Link
`tclsh -> tclsh9.0`, aber keinen Link `wish`. `make install` legt
diesen Link nicht an: Das Ziel `install-binaries` in
`unix/Makefile.in` von 9.0.4 installiert nur `tclsh9.0`. Der Link ist
also von Hand entstanden, so wie *Tcl/Tk 9.0 bauen* im Kapitel
*Mehrere Installationen* es vorschlägt. Folge: Mit
`/opt/tcl9/bin` vorn im `PATH` startet `tclsh` das Tcl 9, `wish` aber
weiter das `wish8.6` aus `/usr/bin`.

Deshalb immer mit Versionsnummer aufrufen. Für 9.1 neben 9.0 rät das
Debian-Buch, nicht beide Prefixe in den `PATH` zu legen, sondern den
vollen Pfad zu nehmen.

---

## Die Shebang-Zeile

Ein ausführbares Skript nennt seinen Interpreter in der ersten Zeile.
Unter Linux gibt es drei übliche Formen:

```tcl
#!/usr/bin/tclsh8.6
#!/usr/bin/env tclsh9.0
#!/opt/tcl9/bin/wish9.0
```

`/usr/bin/env` sucht im `PATH`. Das macht das Skript beweglich, aber
abhängig von der Sitzung: Ein Programm aus dem Startmenü sieht einen
anderen `PATH` als ein Terminal (siehe
[Native Dialoge und Desktop-Integration](110-dialoge-und-desktop.md)).
Der volle Pfad ist fest, aber an einen Rechner gebunden.

Der Linux-Kernel reicht alles nach dem Interpreterpfad als **ein**
Argument weiter. `#!/usr/bin/env tclsh9.0 -encoding utf-8` sucht also
ein Programm namens `tclsh9.0 -encoding utf-8`. Für Optionen gibt es
`env -S` aus GNU coreutils; auf dem Zielrechner vorher prüfen.

Die alte Form für Systeme, auf denen der Pfad zu `wish` unbekannt ist,
nutzt, dass Tcl einen Backslash am Kommentarende als Fortsetzung liest,
die Shell aber nicht:

```tcl
#!/bin/sh
# Die nächste Zeile liest nur die Shell, für Tcl ist sie Kommentar \
exec wish9.0 "$0" "$@"
```

`serie-tcl9-app` (Howto 02) nimmt für Linux `#!/usr/bin/env tclsh9.0`.

---

## Woran ein Tcl 9 erkennbar ist

```tcl
if {[package vsatisfies [info patchlevel] 9-]} { ... }
```

Ohne Versionsvergleich verraten Tcl 9 drei Dinge (im Container
geprüft):

- `$tcl_library` beginnt mit `//zipfs:/` (beim Quellbau).
- `file volumes` liefert `//zipfs:/ /`, unter 8.6 nur `/`.
- `file attributes /tmp -permissions` liefert `0o41777`, unter 8.6
  `041777`.

Das dritte trifft Code, der den Rechtewert als Zeichenkette vergleicht.
Zahlen mit `0o` liest `expr` unter beiden Fassungen. Code, der
Rechte vergleicht, rechnet deshalb mit dem Zahlenwert:

```tcl
set r [file attributes $datei -permissions]
expr {$r & 0o777}        ;# unter 8.6 und 9 gleich
```

---

## Zusammenfassung

- Debian Stable: 8.6.16 und Paket `tcl9.0` 9.0.1. Testing und
  unstable: 8.6.18, `tcl9.0` 9.0.4 und `tcl9.1` 9.1.0. Angekündigt: 9.0 fällt für
  forky weg, 9.1 bleibt. Eigenes Tcl nach `/opt`, nie
  nach `/usr`.
- Debian legt `$tcl_library` nach `/usr/share/tcltk/tcl8.6` und
  `/usr/lib/tcl9.x`. Ein Quellbau von Tcl 9 legt sie ins Zipfs an
  `libtcl9.0.so`.
- Ohne das Paket `tk9.1` lädt `tclsh9.1` Debians Tk 9.0.
- Ein Programm unter `/opt` kann Debians `libtcl` laden. `ldd` prüft
  das, eine Startdatei mit `LD_LIBRARY_PATH` behebt es.
- Immer mit Versionsnummer aufrufen. `wish` ohne Nummer ist meist 8.6.
- Shebang mit `env` folgt dem `PATH` der Sitzung.
- `file volumes` und das Format der Rechte unterscheiden sich zwischen
  8.6 und 9.

---

*Nächstes Kapitel: [Pfade, Umgebung, XDG](040-pfade-umgebung-xdg.md)*
