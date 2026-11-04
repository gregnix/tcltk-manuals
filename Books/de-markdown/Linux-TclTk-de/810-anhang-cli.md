# CLI

Kurzreferenz der Befehle dieses Buches und der Beispielskripte. Die
Ergebnisse stammen aus der Container-Prüfung am 2026-10-20 (Ubuntu
24.04, Tcl/Tk 8.6.14 und 9.0.4, Xvfb ohne Fenstermanager), wo nicht
anders angegeben.

---

## Zur Laufzeit

```tcl
array get tcl_platform
info patchlevel
info nameofexecutable
puts $tcl_library
puts $auto_path
tcl::tm::path list
tcl::pkgconfig get libdir,runtime
zipfs mount                         ;# nur Tcl 9
encoding system
tk windowingsystem                  ;# x11
winfo server .
tk scaling
tk::pkgconfig get fontsystem        ;# xft
ttk::style theme names              ;# clam alt default classic
```

---

## Shell

```bash
type -a tclsh tclsh8.6 tclsh9.0 wish9.0
dpkg -S /usr/bin/tclsh8.6
cat /etc/os-release
locale -a
echo "$XDG_SESSION_TYPE $DISPLAY $WAYLAND_DISPLAY $XDG_CURRENT_DESKTOP"
xdg-user-dir DOCUMENTS
xdg-mime query default inode/directory
fc-match sans-serif
xrdb -query
xmodmap -pm
xprop WM_CLASS                      # danach ins Fenster klicken
readelf -d /opt/tcl9/lib/libtcl9tk9.0.so | grep -E 'NEEDED|RUNPATH'
xvfb-run -a -s "-screen 0 1280x1024x24 -dpi 96" wish9.0 test.tcl
xfconf-query -c xsettings -p /Gdk/WindowScalingFactor
```

---

## Prüfskript

`beispiele/messprobe-linux.tcl` druckt alle Werte, die die Tabellen
dieses Buches verwenden: Plattform und `os-release`, Interpreter und
Suchpfade, Locale, Tilde und `file volumes`, XDG-Variablen,
`exec`-Fehlerfälle, Tk mit Bildschirm, Skalierung und Mausrad-Bindungen,
Schriften, Themes und X-Ressourcen, Fensterattribute, `tk systray`,
`tk sysnotify`, `tk print` und die Zwischenablage. Jede Abfrage läuft
für sich; fehlt ein Werkzeug, steht die Fehlermeldung in der Zeile.

```bash
tclsh8.6 messprobe-linux.tcl            # nur Tcl-Teil
env -i HOME=$HOME PATH=/usr/bin:/bin DISPLAY=$DISPLAY LANG=C.UTF-8 \
    /opt/tcl9/bin/wish9.0 messprobe-linux.tcl
wish9.0 messprobe-linux.tcl -keys       # danach Fenster für Tasten
```

Unterschiede zwischen 8.6.14 und 9.0.4 im Container (gleiche Werte
weggelassen):

```text
                        8.6.14                        9.0.4
threaded                1                             (Schlüssel fehlt)
tcl_library             /usr/share/tcltk/tcl8.6       //zipfs:/lib/tcl/tcl_library
tk_library              /usr/share/tcltk/tk8.6        //zipfs:/lib/tk/tk_library
zipfs mount             (kein zipfs)                  //zipfs:/lib/tk  …/libtcl9tk9.0.so
                                                      //zipfs:/lib/tcl …/libtcl9.0.so
file home               Fehler                        /root
file normalize ~        /root                         <Arbeitsordner>/~
file volumes            /                             //zipfs:/ /
file tempdir            Fehler                        /tmp/tcl_…
Rechte /tmp             041777                        0o41777
tk::scalingPct          fehlt                         100
tk Unterbefehle         ohne print/sysnotify/systray  mit print, sysnotify, systray
Mausrad Text            Button-4/5, MouseWheel        nur MouseWheel
TButton -padding        3 3                           2.25p
<<Copy>>                ohne XF86Copy                 mit <Key-XF86Copy>
systray                 fehlt                         angelegt, exists=1
sysnotify               fehlt                         libnotify geladen
tk::print::cups         fehlt                         Tcl-Ensemble (lpstat/lpr)
```

Gleiche Werte in beiden: `os` Linux, `machine` x86_64, `encoding system`
utf-8 unter `C.UTF-8`, `windowingsystem` x11, Bildschirm 1280x1024 px,
325x260 mm, `tk scaling` 1,389, `TkDefaultFont` Inter 10, Themes
`clam alt default classic`, Hintergrund `#d9d9d9`, Klasse
`Messprobe-linux.tcl`.

---

## Weitere Beispielskripte

| Datei | Zweck | Kapitel |
|-------|-------|---------|
| `xdg-ordner.tcl` | XDG-Ordner und Benutzerordner, 8.6 und 9 | Pfade, Umgebung, XDG |
| `utf8-wache.tcl` | UTF-8-Skript, das unter `LANG=C` mit 8.6 stimmt | Kodierung und Locale |
| `rad-und-tasten.tcl` | Mausrad und Modifier mit `xdotool` auslösen und auslesen | Maus, Tastatur, Zwischenablage |
| `auswahl-probe.tcl` | PRIMARY und CLIPBOARD, ohne Verklemmung | Maus, Tastatur, Zwischenablage |
| `wm-probe.tcl` | Fokus, Rahmen, Iconify, Vollbild, `WM_CLASS` | X11, Fenstermanager; Tests |
| `spaeter-rahmen.tcl` | Dialoglage bei spätem Rahmen, einmal korrigiert gegen beobachtet | Tests |
| `meinapp.desktop` | Vorlage für den Starter | Native Dialoge und Desktop-Integration |
| `gui-test-xvfb.sh` | Test unter `xvfb-run`, optional mit openbox | GUI-Tests mit Xvfb |

Alle `.tcl`-Skripte enden selbst und laufen damit auch unter
`xvfb-run`. `rad-und-tasten.tcl` braucht `xdotool` und meldet ohne
es SKIP.

---

## Howto-Serien

Drei der Serien sind veröffentlicht (Kapitel 1). Festgehalten ist hier,
wie alle fünf im
Container liefen und mit welchem Ergebnis:

```bash
cd serie-linux && tclsh8.6 run-all.tcl
cd serie-xvfb  && xvfb-run -a tclsh9.0 run-all.tcl
cd serie-xvfb  && xvfb-run -a sh -c 'openbox >/dev/null 2>&1 & sleep 1; ./run-all.tcl'
cd serie-xfce  && tclsh8.6 run-all.tcl          # nur in einer Xfce-Sitzung
cd serie-tcltk-bauen && tclsh9.0 run-all.tcl
cd serie-tcl9-app    && tclsh9.0 run-all.tcl
```

Ergebnisse im Container am 2026-10-20 (Läufe mit `env -i`):

| Serie | 8.6.14 | 9.0.4 |
|-------|--------|-------|
| `serie-linux` | 10 OK, 2 FAIL (03: kein `USER`; 05: kein `xdg-user-dir`) | 9 OK, 3 FAIL (zusätzlich 02: Tilde) |
| `serie-xvfb` (ohne Fenstermanager) | 19 OK, 1 SKIP (10: Iconify) | 19 OK, 1 SKIP |
| `serie-tcltk-bauen` | 11 OK, 1 SKIP (10: Itcl fehlt) | 11 OK, 1 FAIL (03: kein `-ltommath`) |
| `serie-tcl9-app` | nicht anwendbar | 18 OK |
| `serie-xfce` | SKIP (kein Xfce) | nicht gelaufen |

Die FAILs sind Unterschiede der Umgebung, keine Fehler der Serien:
`env -i` setzt kein `USER`, Ubuntu hat kein `xdg-user-dirs` installiert,
Tcl 9 löst die Tilde nicht auf (siehe
[Pfade, Umgebung, XDG](040-pfade-umgebung-xdg.md)), und der Quellbau
linkt libtommath fest hinein (siehe
[Tk bauen: Abhängigkeiten](140-tk-bauen-abhaengigkeiten.md)).

---

*Nächstes Kapitel: [Glossar](820-anhang-glossar.md)*
