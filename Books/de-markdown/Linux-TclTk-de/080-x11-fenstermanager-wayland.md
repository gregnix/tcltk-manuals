# X11, Fenstermanager und Wayland

## Einführung

Tk spricht unter Linux nur X11. `tk windowingsystem` liefert immer
`x11`. Anders als unter Windows und macOS ist das Fenstersystem dabei
in zwei Programme geteilt: den X-Server, der zeichnet und Eingaben
liefert, und den [Fenstermanager]{.index}, der Rahmen, Titelleiste,
Fokus und Iconify beisteuert. Ein Tk-Programm kann ohne
Fenstermanager laufen, aber dann fehlt ihm einiges. Dieses Kapitel
trennt, was Tk selbst tut, was der Fenstermanager tut, und was eine
Wayland-Sitzung daran ändert.

---

## DISPLAY und der Start ohne Anzeige

Tk verbindet sich beim Start mit dem X-Server aus
[`DISPLAY`]{.index}. Fehlt die Variable oder antwortet der Server
nicht, scheitert Tk. Container-Prüfung, 8.6.14 und 9.0.4 gleich:

```text
$ env -i wish9.0 probe.tcl
application-specific initialization failed: no display name and no $DISPLAY environment variable
$ env -i DISPLAY=:77 wish9.0 probe.tcl
application-specific initialization failed: couldn't connect to display ":77"
```

Bemerkenswert ist, was danach passiert: `wish` bricht **nicht** ab. Es
führt das Skript ohne Tk aus, `package require Tk` liefert dann den
Fehler, und der Rückgabewert von `wish` ist 0. Ein Testlauf in einer
Pipeline, der nur auf den Rückgabewert schaut, meldet Erfolg, obwohl
keine Zeile der Oberfläche gelaufen ist. Abhilfe am Anfang des Skripts:

```tcl
if {[catch {package require Tk} fehler]} {
    puts stderr "Tk fehlt: $fehler"
    exit 1
}
```

`tclsh` mit `package require Tk` verhält sich wie erwartet: Der Fehler
bricht das Skript ab.

Was Tk über den Server weiß:

```tcl
winfo server .          ;# X11R0 The X.Org Foundation 12101011 (Xvfb)
winfo screen .          ;# :93.0
winfo screenwidth .     ;# 1280
winfo screenmmwidth .   ;# 325
winfo visual .          ;# truecolor
```

---

## Fensterklasse und WM_CLASS

Jedes Hauptfenster trägt die X-Eigenschaft [`WM_CLASS`]{.index} mit
zwei Teilen: Name und Klasse. Der Fenstermanager, die Taskleiste und
`.desktop`-Dateien erkennen ein Programm daran. Tk leitet beide aus dem
Programmnamen ab. Container-Prüfung mit `xprop`, 8.6.14 und 9.0.4
gleich:

| Start | `tk appname` | `WM_CLASS` |
|-------|--------------|------------|
| `wish9.0 meinprog.tcl` | `meinprog.tcl` | `"meinprog.tcl", "Meinprog.tcl"` |
| `wish9.0 meinprog.tcl -name meinname` | `meinname` | `"meinname", "Meinname"` |
| `tclsh9.0 meinprog` mit `package require Tk` | `meinprog` | `"meinprog", "Meinprog"` |

Die Klasse ist der Name mit großem Anfangsbuchstaben. Einen eigenen
Klassennamen für `.` nimmt Tk über die Befehlszeile nicht an: Ein
`-class` in `argv` bleibt unbeachtet in `argv` stehen. `-name` dagegen
wirkt auch, wenn ein Skript es vor `package require Tk` in `::argv`
setzt:

```tcl
set ::argv [list -name meineapp]
set ::argc 2
package require Tk           ;# WM_CLASS "meineapp", "Meineapp"
```

Für ein Programm, das als `meineapp.tcl` startet, heißt die Klasse
also `Meineapp.tcl`, mit Endung. Wer eine `.desktop`-Datei mit
`StartupWMClass` schreibt, muss genau diesen Wert treffen, siehe
[Native Dialoge und Desktop-Integration](110-dialoge-und-desktop.md).
Weitere Toplevels tragen ihren Fensternamen und ihre Klasse: Ein
`toplevel .t -class Zweit` hat im Container `WM_CLASS` `"t", "Zweit"`
(8.6.14 und 9.0.4). Für `.` selbst gibt es diesen Weg nicht.

Tk setzt außerdem `WM_NAME` und `_NET_WM_NAME` aus `wm title` und
`_NET_WM_PID`, sobald `WM_CLIENT_MACHINE` gesetzt ist (Quelltext
`tkUnixWm.c`). Im Container fehlte `_NET_WM_PID` am Fenster; die
Bedingung dafür ist nicht untersucht.

---

## Was der Fenstermanager beisteuert

Ein [reparentierender]{.index} Fenstermanager hängt jedes Hauptfenster
in einen eigenen Rahmen mit Titelleiste. Daraus folgen zwei
Koordinaten: `wm geometry` setzt und liefert die **Rahmenecke**,
`winfo rootx` und `winfo rooty` die Ecke der **Clientfläche**. Die
Differenz ist der Rahmen.

```tcl
wm geometry . 360x220+30+40
update
scan [wm geometry .] {%dx%d+%d+%d} w h gx gy
set titel [expr {[winfo rooty .] - $gy}]
```

Gemessen in `serie-xvfb` (Howto 04 und 13, Tcl/Tk 8.6.14 und 9.0.4):

| Umgebung | Titelleiste `rooty - gy` | `wm frame .` gegen `winfo id .` |
|----------|---------------------------|----------------------------------|
| Xvfb ohne Fenstermanager | 0 | gleich |
| Xvfb mit openbox | 20 (seitlich 1) | verschieden |
| Xfce auf dem Arbeitsplatz des Autors | 29 (seitlich 5) | verschieden |

Unter Xfce gleich bei 8.6.18, 9.0.4 und 9.1.0; Beispiel 9.0.4:
`wm frame` `0x92e055`, `winfo id` `0x7a00009`.

Eine feste Zahl wie 80 für „unter das Hauptfenster“ trifft keine
dieser Umgebungen. Wer einen Dialog unter die Titelleiste des
Hauptfensters setzen will, nimmt `winfo rooty .`.

Was ohne Fenstermanager fehlt, Container-Prüfung mit
`beispiele/wm-probe.tcl`, 8.6.14 und 9.0.4 gleich:

| Vorgang | ohne Fenstermanager |
|---------|---------------------|
| Fokus nach `update` | leer, niemand vergibt ihn |
| `wm iconify .` | Zustand bleibt `normal`, Tk wartet rund 2000 ms |
| `wm attributes . -fullscreen 1` | Attribut bleibt 0, Größe unverändert |
| `focus -force .` | wirkt |
| `grab` | wirkt (Tk-intern, `serie-xvfb`, Howto 11) |

Mit openbox wird das Fenster nach `wm iconify` zu `iconic`, und `.`
hat nach `update` meist schon den Fokus (`serie-xvfb`, Howto 09 und 10).
Vollbild, `-zoomed` und `-type` setzt Tk über die
[EWMH]{.index}-Eigenschaften `_NET_WM_STATE` und
`_NET_WM_WINDOW_TYPE`. Ob sie wirken, entscheidet der Fenstermanager.
`wm attributes . -alpha 0.8` setzt `_NET_WM_WINDOW_OPACITY`, und zwar
am Hüllfenster, das Tk um die Clientfläche legt (Quelltext
`tkUnixWm.c`). Unter einem reparentierenden Fenstermanager ist das
weder `wm frame` noch `winfo id`: Mit openbox steht die Eigenschaft am
Hüllfenster und am Rahmen, den openbox damit versorgt, nicht am Client
(Container, 8.6.14 und 9.0.4). Das Hüllfenster nennt `xwininfo` als
Elternfenster des Clients:

```tcl
regexp {Parent window id: (0x[0-9a-f]+)} [exec xwininfo -tree -id [winfo id .]] -> huelle
exec xprop -id $huelle _NET_WM_WINDOW_OPACITY
```

Unter Xfce 4.20 mit Compositor (`use_compositing` wahr) nimmt
`-alpha` 0,35 an und liefert 0,35 zurück, und das Fenster ist am Bild
durchsichtig; mit `use_compositing` falsch ist es undurchsichtig
(8.6.18, 9.0.4, 9.1.0). Am Rahmen und am Client steht die Eigenschaft
nicht, am Hüllfenster schon: `1503238553`, also 0,35 × `0xFFFFFFFF`,
bei 8.6.18, 9.0.4 und 9.1.0, mit und ohne Compositor. Tk setzt sie
also immer; ob man etwas sieht, entscheidet allein der Compositor.

Die unter X11 bekannten Attribute, Container-Prüfung:

```text
8.6.14   -alpha 1.0 -topmost 0 -zoomed 0 -fullscreen 0 -type {}
9.0.4    -alpha 1.0 -fullscreen 0 -topmost 0 -type {} -zoomed 0
```

Gleicher Inhalt, andere Reihenfolge. Wer die Ausgabe als Liste
vergleicht, vergleicht sie als `dict`.

---

## Einen Fenstermanager erkennen

`winfo manager .` hilft nicht: Für ein Toplevel ist es immer `wm`, mit
und ohne Fenstermanager (`serie-xvfb`, Howto 02). Was trägt, zeigt
`serie-xvfb` in Howto 09:

1. `wm frame .` gegen `winfo id .`. Verschieden heißt: Ein
   reparentierender Fenstermanager läuft.
2. Sind sie gleich, entscheidet eine Iconify-Probe an einem
   Hilfsfenster. Wird es `iconic`, läuft ein Fenstermanager ohne
   Rahmen (dwm, xmonad). Bleibt es `normal`, läuft keiner.

Die Ids **numerisch** vergleichen. Tk 8.6 schreibt `winfo id` mit
führenden Nullen, `wm frame` ohne (Container: `0x200003` gegen
`0x00200003`), Tk 9.0 schreibt beide ohne. Vor dem ersten Mappen ist
`wm frame` `0x0`, also erst `update`.

```tcl
update
set rahmen [expr {[wm frame .] != [winfo id .]}]
```

Die Iconify-Probe kostet ohne Fenstermanager rund zwei Sekunden. Die
Prozeduren `serie::wmRahmen` und `serie::wmDa` in der Serie erlauben
deshalb, das Ergebnis über `SERIE_WM=0` oder `1` vorzugeben.

---

## Wayland

Tk 9.0.4 hat kein Wayland-Backend. Der Quelltext erwähnt Wayland an
genau zwei Stellen: in `scaling.tcl` (siehe
[Schriften, Skalierung, Themes](090-schriften-skalierung-themes.md))
und in `tkUnixEvent.c`, wo Tk eine unsinnige Bildschirmbreite in
Millimetern unter XWayland auf 75 dpi zurücksetzt.

In einer [Wayland]{.index}-Sitzung läuft ein Tk-Programm deshalb über
**XWayland**, den X-Server, den der Wayland-Compositor mitbringt. Dann
sind `DISPLAY` und `WAYLAND_DISPLAY` beide gesetzt, und
`XDG_SESSION_TYPE` ist `wayland`. `tk windowingsystem` bleibt `x11`.

```tcl
set sitzung [expr {[info exists env(XDG_SESSION_TYPE)]
                   ? $env(XDG_SESSION_TYPE) : "unbekannt"}]
```

Was unter XWayland anders ist (globale Fensterpositionen, Fokus aus
fremden Programmen holen, Bildschirmfotos, Skalierung bei mehreren
Bildschirmen), hängt am Compositor. Auf dem Arbeitsplatz des Autors
läuft Xfce unter X11 (`serie-xfce`: `XDG_SESSION_TYPE=x11`,
`WAYLAND_DISPLAY` leer); das Debian-Buch meldet für den
Debian-Arbeitsplatz ebenfalls `x11`. Eine echte Wayland-Sitzung (GNOME, KDE, Xfce mit Wayland) ist
für dieses Buch **nicht geprüft**.

### XWayland unter Weston

Geprüft ist XWayland im Container: Weston 13.0.0 verschachtelt im Xvfb
(`weston --backend=x11-backend.so --xwayland`), Tk über `DISPLAY=:0`,
8.6.14 und 9.0.4 gleich:

| Probe | unter XWayland (Weston) |
|---|---|
| `tk windowingsystem` | `x11` |
| `wm frame .` gegen `winfo id .` | verschieden, Weston setzt einen Rahmen |
| `wm geometry . +100+100` | Weston setzt das Fenster selbst, `wm geometry` meldet `+32+32` |
| `wm geometry . +400+300` | meldet `+400+300`, das Fenster bleibt stehen |
| `winfo rootx`/`rooty` | `6,27` für jedes Fenster, fest |
| `focus -force .` | wirkungslos, der Fokus bleibt beim zuletzt gezeigten Fenster |
| `wm iconify .` | Zustand bleibt `normal` |
| `-fullscreen 1` | wirkt, ganze Ausgabe |
| `xwd -root` | `BadMatch`, kein Bild |

Unter XWayland sind Fensterpositionen also weder setzbar noch lesbar:
Tk meldet, was es verlangt hat, nicht, wo das Fenster steht. Code, der
Dialoge selbst platziert oder Bildschirmfotos über X holt, verlässt
sich darauf nicht. Andere Compositoren können sich anders verhalten.

---

## Zusammenfassung

- `tk windowingsystem` ist unter Linux immer `x11`, auch unter
  Wayland (über XWayland). Dort sind Positionen weder setzbar noch
  lesbar, kein Iconify, kein `focus -force` (Weston).
- Ohne Anzeige meldet `wish` den Fehler, läuft ohne Tk weiter und endet
  mit 0. Skripte prüfen `package require Tk` selbst.
- `WM_CLASS` ist Programmname und Programmname mit großem Anfang,
  `-name` ändert beide.
- `wm geometry` ist die Rahmenecke, `winfo rooty` die Clientfläche.
  Rahmen: 0, 20 oder 29 Pixel, nie fest annehmen.
- Ohne Fenstermanager: kein Fokus, kein Iconify, kein Vollbild.
  Erkennen über `wm frame` und eine Iconify-Probe.

---

*Nächstes Kapitel: [Schriften, Skalierung, Themes](090-schriften-skalierung-themes.md)*
