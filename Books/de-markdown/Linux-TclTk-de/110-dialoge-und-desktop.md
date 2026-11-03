# Native Dialoge und Desktop-Integration

## Einführung

Unter Windows und macOS ruft `tk_getOpenFile` den Dialog des Systems.
Unter Linux gibt es kein „System“ in diesem Sinn, sondern GTK, Qt und
die Desktop-Portale, und Tk benutzt keines davon. Die Standarddialoge
zeichnet Tk selbst. Zur Integration in den Desktop gehören außerdem
eine `.desktop`-Datei, ein Symbol, Benachrichtigungen und, ab Tk 9, ein
Symbol in der Leiste und der Druck über CUPS.

---

## Die Standarddialoge sind Tk-Dialoge

```tcl
set datei [tk_getOpenFile -title "Öffnen" \
    -filetypes {{Tcl {.tcl}} {Alle *}}]
set ordner [tk_chooseDirectory -mustexist 1]
tk_messageBox -message "Gespeichert." -type ok
```

Unter X11 führt `tk_getOpenFile` zu `::tk::dialog::file::`
(Container-Prüfung, Rumpf der Prozedur unter 8.6.14 und 9.0.4):

```tcl
if {$::tk_strictMotif} {
    return [::tk::MotifFDialog open {*}$args]
} else {
    return [::tk::dialog::file:: open {*}$args]
}
```

Der Dialog sieht deshalb auf jedem Linux gleich aus, unabhängig von
Xfce, GNOME oder KDE. Er kennt keine Lesezeichen des Dateimanagers und
keine Netzwerkorte von GVfs. `tk_messageBox`, `tk_chooseColor` und
`tk fontchooser` sind ebenfalls Tk-Dialoge.

Eine Eigenheit des X11-Dateidialogs: Er zeigt versteckte Dateien
(Punktdateien) in der Grundeinstellung **an**. Im Quelltext von
`tkfbox.tcl` (8.6.14 und 9.0.4) steht `showHiddenVar 1` und
`showHiddenBtn 0`. Wer sie ausblenden und einen Schalter anbieten will,
lädt den Dialog einmal und setzt beide Variablen:

```tcl
catch {tk_getOpenFile -gibtsnicht}      ;# lädt tkfbox.tcl
set ::tk::dialog::file::showHiddenVar 0
set ::tk::dialog::file::showHiddenBtn 1
```

`serie-linux` (Howto 11) öffnet die Dialoge nur, wenn `SERIES_AUTO`
nicht gesetzt ist. Im Container sind sie nicht geöffnet worden.

Wer den Dialog des Desktops will, ruft ein Hilfsprogramm, etwa
`zenity --file-selection` (GTK) oder `kdialog --getopenfilename` (KDE),
über `exec` und liest die Ausgabe. Beide fehlten im Container. Auf dem
Arbeitsplatz (Xfce) ist `zenity` 4.2.2 installiert, `kdialog` fehlt.
`zenity --file-selection` aus `wish` 8.6.18, 9.0.4 und 9.1.0, gleich:

| Aufruf | Datei gewählt | Abbrechen |
|---|---|---|
| `exec zenity …` | `catch` 1, Ergebnis Pfad **plus** GTK-Warnung, `-errorcode NONE` | `catch` 1, `CHILDSTATUS … 1` |
| `exec -ignorestderr zenity …` | `catch` 0, Ergebnis nur der Pfad | `catch` 1, `child process exited abnormally` |

GTK schreibt bei jedem Aufruf eine Warnung nach stderr
(`Gtk-WARNING … Failed to measure available space`). Ohne
`-ignorestderr` macht `exec` daraus einen Fehler, auch wenn eine Datei
gewählt wurde. Also:

```tcl
proc dateiWaehlen {} {
    if {[catch {exec -ignorestderr zenity --file-selection} pfad]} {
        return ""          ;# Abbrechen: Exit 1
    }
    return $pfad
}
```

Welches Hilfsprogramm da ist, vorher prüfen:

```tcl
foreach p {zenity kdialog} {
    if {[auto_execok $p] ne ""} { set hilfe $p; break }
}
```

---

## Die .desktop-Datei

Ein Programm erscheint im Startmenü über eine
[`.desktop`]{.index}-Datei nach der Desktop Entry Specification. Für
einen Benutzer liegt sie in `~/.local/share/applications/`, für alle in
`/usr/share/applications/`. Vorlage `beispiele/meinapp.desktop`:

```text
[Desktop Entry]
Type=Application
Name=MeineApp
Name[de]=Meine Anwendung
Comment=Beispiel aus "Tcl/Tk unter Linux"
Exec=/opt/meineapp/bin/meineapp %F
Icon=meineapp
Terminal=false
Categories=Utility;
StartupWMClass=Meineapp
```

Hinweise zu den Schlüsseln:

- `Exec` mit vollem Pfad. Ein Programm aus dem Startmenü bekommt den
  `PATH` der Sitzung, nicht den aus `~/.bashrc`. Ein
  `/opt/tcl9/bin`, das nur in der Shell vorn steht, fehlt dort.
  `%F` reicht ausgewählte Dateien weiter.
- `Icon` ohne Endung und ohne Pfad sucht im Symbolthema, etwa
  `~/.local/share/icons/hicolor/48x48/apps/meineapp.png`. Ein voller
  Pfad geht auch.
- [`StartupWMClass`]{.index} verbindet das laufende Fenster mit dem
  Eintrag, damit die Leiste das richtige Symbol zeigt. Der Wert ist die
  Klasse aus `WM_CLASS`. Ein mit `wish9.0 meineapp.tcl` gestartetes
  Programm hat die Klasse `Meineapp.tcl`; mit `-name meineapp` wird
  daraus `Meineapp`. Siehe
  [X11, Fenstermanager und Wayland](080-x11-fenstermanager-wayland.md).

Prüfen mit `desktop-file-validate` aus dem Paket `desktop-file-utils`.
`serie-xfce` (Howto 07) schreibt eine minimale Datei
(`Type`, `Name`, `Exec=true`, `Terminal`, `Categories`) und prüft sie
damit; unter Xfce 4.20 ohne Meldung. Im Container fehlte das
Werkzeug. Die Vorlage oben, `beispiele/meinapp.desktop`, prüft es auf
dem Arbeitsplatz ohne Meldung, Exit 0.

---

## Fenstersymbol

```tcl
image create photo ikon -file [file join $hier meineapp.png]
wm iconphoto . -default ikon
```

`-default` gilt für alle späteren Toplevels. Unter X11 legt Tk das Bild
in die Eigenschaft `_NET_WM_ICON`; die Leiste nimmt es, wenn sie über
`StartupWMClass` keinen besseren Eintrag findet. Im Container lief
der Aufruf ohne Fehler; sichtbar ist das Symbol ohne Leiste nicht.
Mehrere Größen in einem Aufruf (`wm iconphoto . -default ikon16
ikon32 ikon48`) überlassen die Wahl dem Desktop.

---

## Benachrichtigungen

Zwei Wege: das Programm `notify-send` und, ab Tk 9, `tk sysnotify`.

`serie-xfce` (Howto 06) ruft unter Xfce 4.20:

```tcl
exec {*}[auto_execok notify-send] -t 1000 -e --app-name meineapp \
    "Titel" "Text"
```

Den Dienst stellt dort `xfce4-notifyd`. `notify-send` braucht den
Sitzungs-DBus. Im Container ohne Sitzung endet es mit

```text
Failed to execute child process “dbus-launch” (No such file or directory)
```

und Rückgabewert 1.

[`tk sysnotify`]{.index} lädt unter X11 zur Laufzeit `libnotify.so.4`
(oder ältere Fassungen) per `Tcl_LoadFile`; Tk ist nicht dagegen
gelinkt (Quelltext `tkUnixSysNotify.c`). Gelingt das, gibt es den
Befehl `::tk::sysnotify::_sysnotify`, und die Meldung geht an
libnotify. Fehlt die Bibliothek, zeichnet Tk ein eigenes, randloses
Fenster oben rechts, das nach einer Weile ausblendet (`systray.tcl`,
Prozedur `_notifywindow`).

Container-Prüfung mit 9.0.4: `libnotify4` ist installiert,
`_sysnotify` ist vorhanden. `tk sysnotify Titel Text` kehrt ohne Fehler
zurück, es erscheint aber nichts, und es bleibt kein Fenster zurück:
Ohne DBus hat libnotify niemanden, dem es die Meldung geben kann. Ein
Programm erfährt davon nichts. Mit Xfce ist `tk sysnotify` nicht
geprüft.

---

## Symbol in der Leiste

`tk systray` legt unter X11 ein Symbol im Benachrichtigungsbereich an.
Tk benutzt dafür das Protokoll des System-Tray (XEmbed), übernommen
aus dem Paket tktray (Quelltext `tkUnixSysTray.c`). Container-Prüfung
mit 9.0.4:

```tcl
image create photo ikon -width 16 -height 16
tk systray exists                       ;# 0
tk systray create -image ikon -text Probe
tk systray exists                       ;# 1
```

`exists` meldet 1, obwohl im Container kein Benachrichtigungsbereich
läuft. Der Wert sagt nur, dass `create` gelaufen ist, nicht, dass
jemand das Symbol zeigt. Unter Tk 8.6 gibt es den Befehl nicht
(„unknown or ambiguous subcommand "systray"“). Auf dem Arbeitsplatz
(Xfce, 9.0.4 und 9.1.0) ebenso `exists` 1 nach `create`; der Text aus
`-text` ist der Tooltip und erscheint nicht als Fenstername im
Fensterbaum. Ob das Xfce-Panel das Symbol zeigt, ist nicht am Bild
geprüft.

---

## Drucken

`tk print` gibt es ab Tk 9. Unter X11 zeigt es einen eigenen
Tk-Dialog und druckt über die Befehle `lpstat` und `lpr` von
[CUPS]{.index} (Quelltext `print.tcl`). Ein Canvas geht als PostScript
an den Drucker, ein Text-Widget als Text. Container-Prüfung ohne CUPS:

```text
tk print                     wrong # args: should be "tk print w"
::tk::print::cups            Tcl-Ensemble (lpstat/lpr)
::tk::print::cups getprinters
    Unable to obtain the list of printers. Command "lpstat" not found.
    Please install the CUPS package for your system.
```

Die Druckerliste entsteht aus `lpstat -e`, der Standarddrucker aus
`lpstat -d`. Druck über CUPS, PDF-Wege und Etikettendrucker behandelt
das Buch *Printing*.

---

## Zusammenfassung

- `tk_getOpenFile` und Verwandte sind unter X11 Tk-Dialoge, keine
  GTK- oder Qt-Dialoge. Versteckte Dateien sind sichtbar, bis
  `showHiddenVar` 0 ist.
- `.desktop` in `~/.local/share/applications`, `Exec` mit vollem Pfad,
  `StartupWMClass` gleich der Klasse aus `WM_CLASS`.
- `notify-send` und `tk sysnotify` brauchen den Sitzungs-DBus.
  `tk sysnotify` schweigt, wenn er fehlt.
- `tk systray exists` sagt nichts über die Sichtbarkeit.
- `tk print` unter X11: CUPS-Befehle `lpstat` und `lpr`.

---

*Nächstes Kapitel: [Xfce aus Tcl](120-xfce.md)*
