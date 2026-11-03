# Glossar

---

## Zeichen

**.desktop-Datei**
: Starter nach der Desktop Entry Specification, in
  `~/.local/share/applications/` oder `/usr/share/applications/`.
  Schlüssel `Exec`, `Icon`, `StartupWMClass`.

**//zipfs:/**
: Wurzel des ZIP-Dateisystems von Tcl 9. Beim Quellbau liegt die
  Tcl-Bibliothek unter `//zipfs:/lib/tcl`, angehängt an
  `libtcl9.0.so`. Unter Tcl 9 auch in `file volumes`.

## A

**auto_execok**
: Sucht ein Programm im `PATH`, liefert eine Liste oder leer. Merkt sich
  jede Antwort in `auto_execs`.

**auto_path**
: Suchliste für `package require`. Debian: `/usr/share/tcltk` und
  `/usr/lib/tcltk/<multiarch>`. Quellbau unter `/opt/tcl9`: nur Zipfs
  und `/opt/tcl9/lib`.

## C

**CLIPBOARD**
: Die X11-Auswahl für Kopieren und Einfügen. Gesetzt durch `<<Copy>>`
  oder `clipboard append`. Verschwindet mit dem Besitzer, wenn kein
  Verwalter sie übernimmt.

**Command**
: Modifier-Name in `bind`. Unter Aqua die Befehlstaste. Unter X11 in
  Tk 8.6 gleich Mod1 (Alt), in Tk 9.0.4 gleich Meta.

**Container-Prüfung**
: In diesem Buch: Prüfung in einem Ubuntu-24.04-Container am
  2026-10-20 mit Tcl/Tk 8.6.14 (Paket) und 9.0.4 (`/opt/tcl9`), Xvfb
  ohne Fenstermanager.

## D

**DISPLAY**
: Umgebungsvariable mit der Adresse des X-Servers, etwa `:0` oder
  `:99`. Ohne sie startet Tk unter X11 nicht.

**DBus**
: Nachrichtenbus der Sitzung. `xfconf-query`, `notify-send` und
  libnotify brauchen ihn. Adresse in `DBUS_SESSION_BUS_ADDRESS`.

## E

**encoding system**
: Vorgabe-Kodierung von Tcl. Unter Linux aus `LC_ALL`, `LC_CTYPE`,
  `LANG`. `C` und keine Locale: iso8859-1.

**EWMH**
: Extended Window Manager Hints, die `_NET_WM_*`-Eigenschaften.
  Darüber setzt Tk Vollbild, `-zoomed`, `-type`, Deckkraft und
  Fenstersymbol.

**exo-open**
: Xfce-Werkzeug, das bevorzugte Programme nach Rolle startet
  (`--launch FileManager`). `xdg-open` reicht unter Xfce dorthin weiter.

## F

**Fenstermanager**
: Programm, das unter X11 Rahmen, Titelleiste, Fokus und Iconify
  beisteuert. Unter Xfce xfwm4. Xvfb hat keinen.

**fontconfig**
: Bibliothek, die Schriftnamen auf Dateien abbildet. Tk fragt nach
  `sans-serif` und `monospace`. `fc-match` zeigt das Ergebnis.

**forky**
: Codename von Debian 14, zurzeit Testing. Messsystem der Serien.

## L

**libnotify**
: Bibliothek für Desktop-Meldungen. Tk 9 lädt `libnotify.so.4` zur
  Laufzeit für `tk sysnotify`.

**Locale**
: Sprach- und Zeichensatzeinstellung aus `LC_ALL`, `LC_CTYPE`, `LANG`.
  Bestimmt unter Linux `encoding system`.

## M

**Mod1, Mod4**
: X11-Modifier-Bits. In der Vorgabebelegung Mod1 = Alt, Mod4 = Super.

**MouseWheel**
: Rad-Ereignis in Tk. Unter X11 erst ab Tk 9; Tk 8.6 meldet das Rad als
  `<Button-4>` und `<Button-5>`.

**Multiarch**
: Debian-Ordnung für Bibliotheken je Architektur, etwa
  `/usr/lib/x86_64-linux-gnu`. Dort liegt die echte `tclConfig.sh`.

## O

**os-release**
: Datei `/etc/os-release` mit `ID`, `ID_LIKE`, `VERSION_CODENAME`.
  Quelle für die Distribution.

## P

**PRIMARY**
: Die X11-Auswahl des zuletzt markierten Textes. Eingefügt mit der
  mittleren Maustaste (`<<PasteSelection>>`).

## R

**Reparenting**
: Ein Fenstermanager hängt das Fenster in einen eigenen Rahmen.
  Erkennbar daran, dass `wm frame .` und `winfo id .` verschieden sind.

**RUNPATH**
: Suchpfad für Bibliotheken, in einer ELF-Datei eingetragen. Der
  Quellbau setzt `/opt/tcl9/lib`.

## S

**scalingPct**
: `::tk::scalingPct`, Tk 9: Auflösung in Prozent von 96 dpi, auf 25
  gerundet, mindestens 100.

**StartupWMClass**
: Schlüssel in einer `.desktop`-Datei. Muss der Klasse aus `WM_CLASS`
  entsprechen.

## T

**TCLLIBPATH**
: Umgebungsvariable, deren Einträge vorn an `auto_path` kommen.
  Tcl-Liste, getrennt durch Leerzeichen.

**TCL9_0_TM_PATH**
: Zusätzliche tm-Pfade für Tcl 9.0, auch von 9.1 gelesen. Getrennt
  durch Doppelpunkt, eingefügt in umgekehrter Reihenfolge. Für 8.6:
  `TCL8_6_TM_PATH`.

**tk scaling**
: Pixel je Punkt. Bei 100 dpi 1,389.

## W

**Wayland**
: Anzeigeprotokoll als Nachfolger von X11. Tk 9.0.4 hat kein
  Wayland-Backend und läuft dort über XWayland.

**WM_CLASS**
: X-Eigenschaft mit Name und Klasse eines Fensters. Tk: Programmname
  und Programmname mit großem Anfang.

## X

**X-Ressourcen**
: Einstellungsdatenbank des X-Servers (`xrdb`). Tk liest sie beim
  Start. `*TkTheme` wählt das ttk-Theme.

**X11**
: Fenstersystem von Tk unter Linux. `tk windowingsystem` liefert `x11`.

**XDG**
: Freedesktop-Spezifikationen. Hier vor allem Base Directory
  (`XDG_CONFIG_HOME` und Verwandte) und `user-dirs`.

**xdg-open**
: Öffnet Datei oder Adresse mit dem Standardprogramm. Paket
  `xdg-utils`.

**xdg-user-dir**
: Liefert den lokalisierten Pfad eines Benutzerordners
  (`DOCUMENTS`). Paket `xdg-user-dirs`.

**Xfce**
: Desktop auf dem Arbeitsplatz des Autors, Fassung 4.20.

**xfconf**
: Einstellungsdienst von Xfce, gelesen und geschrieben mit
  `xfconf-query`.

**Xft**
: X FreeType, die Schriftdarstellung von Tk unter X11.
  `tk::pkgconfig get fontsystem` liefert `xft`.

**Xft.dpi**
: X-Ressource für die Schrift-DPI. Tk 9 leitet daraus
  `tk scaling` ab, Tk 8.6 nicht.

**Xvfb**
: X-Server ohne Bildschirm und ohne Fenstermanager. Für Tests.
  `xvfb-run` startet ihn für einen Befehl.

**XWayland**
: X-Server, den ein Wayland-Compositor für X11-Programme mitbringt.

## Z

**Zipkit**
: Statisch gebauter Interpreter mit angehängter Tcl-Bibliothek, Basis
  für weitergebbare `zipfs mkimg`-Programme.

---

*Nächstes Kapitel: [Fehlermeldungen](830-anhang-fehlermeldungen.md)*
