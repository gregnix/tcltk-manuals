# Xfce aus Tcl

## Einführung

[Xfce]{.index} ist der Desktop auf dem Arbeitsplatz des Autors. Ein
Tcl-Programm spricht mit ihm über Kommandozeilenwerkzeuge: Einstellungen
über `xfconf-query`, bevorzugte Programme über `exo-open`, Meldungen über
`notify-send`. Alle drei brauchen den Sitzungs-DBus. Dieses Kapitel
folgt `serie-xfce`, geprüft mit Xfce **4.20** unter X11 auf Debian.
Im Container gibt es kein Xfce; jeder Wert hier stammt aus der Serie.

---

## Xfce erkennen

`serie-xfce` (Howto 01 und 04):

```tcl
$env(XDG_CURRENT_DESKTOP)        ;# XFCE
$env(XDG_SESSION_TYPE)           ;# x11
$env(XDG_MENU_PREFIX)            ;# xfce-
$env(DBUS_SESSION_BUS_ADDRESS)   ;# unix:path=/run/user/UID/bus
exec xfce4-about --version       ;# … Xfce 4.20
```

`XDG_CURRENT_DESKTOP` kann eine Liste mit Doppelpunkten sein
(`ubuntu:GNOME`). Eine Prüfung sucht daher ein Element:

```tcl
proc desktop {} {
    if {![info exists ::env(XDG_CURRENT_DESKTOP)]} { return "" }
    return [split [string toupper $::env(XDG_CURRENT_DESKTOP)] :]
}
if {"XFCE" in [desktop]} { ... }
```

Ohne Desktop-Sitzung bricht die Serie ab, bevor sie etwas prüft. Im
Container meldet Howto 01:

```text
SKIP: serie-xfce braucht XFCE (XDG_CURRENT_DESKTOP=)
```

---

## xfconf: Einstellungen lesen

Xfce speichert seine Einstellungen in [xfconf]{.index}, einem Dienst
am Sitzungs-DBus. Er ist in Kanäle geteilt, jeder Kanal in
Eigenschaften mit Pfaden (`serie-xfce`, Howto 02):

```tcl
exec xfconf-query -l                           ;# Kanäle
exec xfconf-query -c xfwm4 -l                  ;# Eigenschaften
exec xfconf-query -c xfwm4 -p /general/theme
exec xfconf-query -c xfwm4 -p /general/workspace_count
```

Vorhandene Kanäle unter anderem `xfwm4`, `thunar`, `xfce4-panel`,
`xfce4-session`, `xsettings`. Die Werte (Theme, Zahl der
Arbeitsflächen) sind Sache des Benutzers. Die Serie prüft deshalb nur
Typ und Länge, nicht einen bestimmten Wert. Ohne Sitzung scheitert
jeder Aufruf mit „Verbindung ist gescheitert“.

Ein Leser mit Vorgabe:

```tcl
proc xfconf {kanal pfad {vorgabe ""}} {
    set p [auto_execok xfconf-query]
    if {$p eq ""} { return $vorgabe }
    if {[catch {exec {*}$p -c $kanal -p $pfad 2>/dev/null} wert]} {
        return $vorgabe
    }
    return $wert
}
set skala [xfconf xsettings /Gdk/WindowScalingFactor 1]
```

Der Kanal `xsettings` ist für Tk wichtig: Tk 9 liest beim Start unter
Xfce genau `/Gdk/WindowScalingFactor` und setzt bei 2 die Oberfläche
auf 200 % (Quelltext `scaling.tcl`, siehe
[Schriften, Skalierung, Themes](090-schriften-skalierung-themes.md)).
Tk erkennt Xfce dabei nicht an `XDG_CURRENT_DESKTOP`, sondern daran,
dass `ps -e` einen Prozess `xfce4-session` zeigt. Auf dem Arbeitsplatz
findet `ps -e` ihn aus `wish9.0` und `wish9.1`.
`WindowScalingFactor` ist dort 1, also bleibt alles beim
Wert aus der Anzeige: `tk scaling` 1,332, `scalingPct` 100, unter 9.0
`::tk::fontScalingFactor` 1.

---

## xfconf: Einstellungen schreiben

```tcl
exec xfconf-query -c serie-xfce -p /howto/demo -n -t string -s ok
exec xfconf-query -c serie-xfce -p /howto/demo
exec xfconf-query -c serie-xfce -p /howto -r -R
```

`-n` legt eine neue Eigenschaft an, `-t` nennt ihren Typ, `-r -R`
löscht rekursiv. Die Serie (Howto 03) schreibt nur in einen eigenen
Testkanal und räumt ihn danach weg. Einstellungen des Benutzers in
`xfwm4` oder im Panel schreibt ein Programm nur, wenn das seine Aufgabe
ist.

Ein eigener Kanal ist ein bequemer Ort für die Einstellungen eines
Xfce-Programms, aber er bindet das Programm an Xfce. Für ein Programm,
das auch unter anderen Desktops läuft, ist eine Datei unter
`XDG_CONFIG_HOME` (siehe [Pfade, Umgebung, XDG](040-pfade-umgebung-xdg.md))
die bessere Wahl.

---

## Bevorzugte Programme: exo-open

`xdg-open` fragt unter Xfce `exo-open`. Direkt aufgerufen startet
`exo-open` die in Xfce eingestellten Programme nach Rolle
(`serie-xfce`, Howto 05 und 09):

```tcl
exec {*}[auto_execok exo-open] --launch FileManager &
exec {*}[auto_execok exo-open] --launch TerminalEmulator &
exec {*}[auto_execok exo-open] --launch WebBrowser https://www.tcl-lang.org &
```

Unter Xfce 4.20: Dateimanager ist Thunar 4.20,
`xdg-mime query default inode/directory` liefert `thunar.desktop`.
Textdateien öffnet `org.xfce.mousepad.desktop`. Das Terminal ist
`xfce4-terminal` 1.2.0.

Ein Ordner im Dateimanager:

```tcl
exec {*}[auto_execok xdg-open] $ordner &
```

Thunar direkt: `exec thunar $ordner &`. Die Serie öffnet unter
`SERIES_AUTO` kein Fenster und prüft nur, ob die Werkzeuge da sind.

---

## Benachrichtigungen

Den Dienst stellt `xfce4-notifyd`. Er liegt auf dem Arbeitsplatz unter
`/usr/lib/x86_64-linux-gnu/xfce4/notifyd/`, also nicht im `PATH`.
`auto_execok xfce4-notifyd` findet ihn nicht; ob der Dienst läuft,
fragt man über `notify-send` selbst oder über DBus. Der Aufruf von
`notify-send` und das Verhalten von `tk sysnotify` stehen in
[Native Dialoge und Desktop-Integration](110-dialoge-und-desktop.md).

---

## Fenstermanager, Panel, Sitzung

`serie-xfce` (Howto 10 und 11):

```tcl
exec xfwm4 --version
exec xfce4-panel --version
exec xfce4-session --version
```

[xfwm4]{.index} ist der Fenstermanager der Sitzung. Er reparentiert:
Die Titelleiste ist auf dem Arbeitsplatz 29 Pixel hoch (`serie-xvfb`,
Howto 04), gemessen als `winfo rooty . - gy`. Mit einem anderen Theme
ändert sich der Wert. Ein Tk-Programm unter Xfce bekommt Fokus,
Iconify und Vollbild vom Fenstermanager; unter Xvfb ohne
Fenstermanager fehlt das alles, siehe
[X11, Fenstermanager und Wayland](080-x11-fenstermanager-wayland.md).

Das Panel-Layout liegt im Kanal `xfce4-panel`. Die Serie liest dort
nicht hinein.

---

## Zusammenfassung

- Xfce erkennen: `XFCE` in `XDG_CURRENT_DESKTOP`, als Liste mit `:`
  lesen.
- Einstellungen: `xfconf-query -c Kanal -p Pfad`. Schreiben nur in
  eigene Kanäle.
- Tk 9 liest unter Xfce `xsettings /Gdk/WindowScalingFactor`.
- Programme nach Rolle: `exo-open --launch`. Ordner: Thunar.
- Alles hängt am Sitzungs-DBus. Ohne ihn scheitert jeder Aufruf.

---

*Nächstes Kapitel: [GUI-Tests mit Xvfb](130-gui-tests-xvfb.md)*
