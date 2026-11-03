# Fallen

Kurze Liste. Jede Zeile beschreibt, was man **nicht** tun sollte. Die
Begründung steht im genannten Kapitel.

---

## Plattform und Interpreter

- Linux mit `tcl_platform(platform) eq "unix"` erkennen. Das trifft
  auch macOS. `os` nehmen.
- Die Distribution aus `tcl_platform(osVersion)` lesen. Das ist der
  Kernel, im Container sogar der des Wirts.
- Debian an `/etc/debian_version` erkennen. Ubuntu hat die Datei auch
  (Container: `trixie/sid`).
- `tcl_platform(threaded)` ohne `info exists` lesen. Unter Tcl 9 fehlt
  der Schlüssel.
- `$env(USER)` für den Benutzer halten. Er kann fehlen.
  `tcl_platform(user)` ist verlässlich.
- `wish` ohne Versionsnummer aufrufen und Tk 9 erwarten. Ein Quellbau
  legt keinen Link `wish` an.
- Ein eigenes Tcl nach `/usr` installieren. `/opt` nehmen.
- Rechte aus `file attributes -permissions` als Zeichenkette
  vergleichen. 8.6 liefert `041777`, 9.0 `0o41777`.
- `[lindex [file volumes] 0]` für `/` halten. Unter Tcl 9 steht
  `//zipfs:/` davor.
- Unter Debian `tcl9.1` ohne `tk9.1` installieren und Tk 9.1 erwarten.
  `package require Tk` lädt dann Debians Tk 9.0.
- Ein Tcl unter `/opt` für getrennt halten, ohne `ldd` zu prüfen. Es
  kann Debians `libtcl` gleichen Namens laden.
- Ein Alias als Startdatei nehmen. In Skripten und Makefiles gilt er
  nicht.

## Pfade und Suchpfade

- `file normalize ~` unter Tcl 9. Das ergibt `./~`. `$env(HOME)` oder
  `file home`.
- `~/Documents` fest eintragen. Der Ordner ist lokalisiert;
  `xdg-user-dir DOCUMENTS` fragen.
- Einstellungen als Punktdatei direkt in `$HOME` ablegen. XDG:
  `~/.config/<programm>/`.
- `TCLLIBPATH` mit Doppelpunkten trennen. Es ist eine Tcl-Liste.
- `TCL9_0_TM_PATH` mit Leerzeichen trennen. Hier gilt der Doppelpunkt.
- `TCLLIBPATH` für alle Fassungen auf einen Ordner mit 9er-Paketen
  setzen. `tclsh8.6` sieht ihn auch.
- Erwarten, dass ein Tcl 9 unter `/opt` die Pakete aus
  `/usr/share/tcltk` sieht.
- Eigene Pakete für das System-Tcl nach `/usr/share/tcltk` legen. Das
  gehört `apt`; `/usr/local/share/tcltk` nehmen.
- `libsqlite3-tcl` bis 3.53.4-2 unter Debians Tcl 9 erwarten. Es ist
  nur für 8.6 gebaut; erst 3.54.1-1 (unstable) bringt Tcl 9 mit.
- Ein zweites sqlite3 mit niedrigerer Nummer daneben legen. Die höchste
  Nummer gewinnt, der Ordner zählt nur bei gleicher.
- Ein Paket als `.tm` und daneben als `pkgIndex.tcl`. Welche Kopie
  lädt, hängt davon ab, was vorher geladen wurde; siehe *Welche Kopie
  gewinnt* im Kapitel *Suchpfade*.
- Ein eigenes sqlite3 nur für Tcl 9 vor Debians Ordner legen. Unter 8.6
  verdrängt der Index dann Debians Fassung.
- `package ifneeded` für den Beweis halten, welche Bibliothek geladen
  ist. `info loaded` nehmen.
- Einen Paketentwurf mit `dpkg -i` testen. Auspacken mit `dpkg-deb -x`
  und Laden über `auto_path` reicht und ändert nichts unter `/usr`.
- Beim Test eines ausgepackten `libsqlite3-tcl` das passende
  `libsqlite3-0` vergessen. Die dynamisch gelinkte Anbindung braucht
  dieselbe SQLite-Fassung.

## Kodierung

- Annehmen, Linux sei immer UTF-8. Ohne Locale ist `encoding system`
  iso8859-1.
- Eine Datei ohne `fconfigure -encoding` öffnen.
- Ein UTF-8-Skript mit Umlauten unter Tcl 8.6 aus Cron starten, ohne
  Wache oder `-encoding utf-8`.
- Sich darauf verlassen, dass `LANG=de_DE` unter 8.6 und 9 gleich wirkt.
  8.6: iso8859-1, 9.0: utf-8.
- `LANGUAGE` für `msgcat` setzen. `msgcat` liest `LC_ALL`,
  `LC_MESSAGES`, `LANG`.

## Prozesse

- `exec` ohne `auto_execok` auf ein Programm, das fehlen kann.
- Jeden `exec`-Fehler als Rückgabewert ungleich 0 deuten. Auch eine
  Zeile auf stderr ist ein Fehler.
- `xdg-open` ohne `&` aufrufen.
- Mit blockierendem `exec` ein Programm rufen, das die eigene
  X-Auswahl liest. Beide warten aufeinander.
- `auto_reset` aufrufen, nur um `auto_execok` neu suchen zu lassen.
  Es entfernt auch nachgeladene Befehle.

## X11 und Fenstermanager

- Sich auf den Rückgabewert von `wish` verlassen. Ohne Anzeige endet
  es mit 0.
- Einen Fenstermanager mit `winfo manager .` erkennen. Das ist immer
  `wm`.
- `wm frame .` und `winfo id .` als Zeichenketten vergleichen. 8.6
  schreibt führende Nullen.
- Einen Dialog mit `gy + 80` unter das Hauptfenster setzen. Rahmen
  sind 0, 20 oder 29 Pixel hoch. `winfo rooty .`.
- `wm geometry` für die Lage der Clientfläche halten. Es ist die
  Rahmenecke.
- Die Lage eines Dialogs einmal nach fester Wartezeit korrigieren.
  Manche Fenstermanager legen den Rahmen später an.
- Unter openbox `wm geometry` eines mittig gesetzten transienten
  Dialogs für die Rahmenecke halten. openbox setzt ihn selbst; Tk meldet
  die verlangte Lage.
- `-fullscreen`, `-zoomed`, `iconify` ohne Fenstermanager erwarten.
- `StartupWMClass=meineapp` schreiben und `wish meineapp.tcl` starten.
  Die Klasse ist `Meineapp.tcl`.
- Unter Wayland `tk windowingsystem` gleich `wayland` erwarten. Es ist
  `x11`.

## Schrift, Skalierung, Themes

- Eine Schriftfamilie voraussetzen. fontconfig ersetzt still.
- Pixelmaße in Tests fest verdrahten. Sie hängen an DPI, Schrift und
  unter Tk 9 an der Skalierung.
- Unter Tk 8.6 annehmen, `Xft.dpi` wirke auf `tk scaling`. Es wirkt
  nur auf die Schrift.
- Ein natives Linux-Theme erwarten. Es gibt `clam alt default classic`.
- Xvfb ohne `-noreset` starten und mit `xrdb` Ressourcen laden. Der
  Server vergisst sie, sobald der letzte Client geht.

## Maus, Tastatur, Zwischenablage

- Unter Tk 9 das Rad über `<Button-4>`/`<Button-5>` binden. Das sind
  dort die Seitentasten 8 und 9.
- Unter Tk 8.6 auf X11 nur `<MouseWheel>` binden. Das Rad kommt dort
  als `<Button-4>`/`<Button-5>`.
- `<Command-c>` unter X11 binden. 8.6: Alt, 9.0 und 9.1: keine Taste
  (Container und Xfce).
- `<Super-c>` binden. Der Name ist `Mod4`.
- Markieren für Kopieren halten. Markieren setzt PRIMARY, Kopieren
  CLIPBOARD.
- Erwarten, dass die Zwischenablage das Programmende überlebt.
- `selection get -selection PRIMARY` ohne `catch`.

## Desktop

- Den GTK-Dateidialog erwarten. Tk zeichnet seinen eigenen, und der
  zeigt versteckte Dateien.
- In `Exec=` einer `.desktop`-Datei auf den `PATH` der Shell bauen.
- `zenity` ohne `-ignorestderr` aufrufen. Die GTK-Warnung auf stderr
  wird ein Fehler, auch wenn eine Datei gewählt wurde.
- `tk systray exists` für „Symbol sichtbar“ halten.
- `xfce4-clipman` installiert für „Zwischenablage bleibt“ halten. Es
  muss laufen.
- `tk sysnotify` für „Meldung angezeigt“ halten. Ohne DBus schweigt es.

## Tests

- Einen Tastentest ohne `update` und `focus -force`.
- `event generate .w <Key>` an ein Widget ohne Fokus schicken und die
  Bindung von `.w` erwarten. Die Taste geht ans Fokus-Widget.
- Ohne `xvfb-run` FAIL melden. SKIP ist richtig.
- `xvfb-run` ohne `-s` aufrufen und die Bildschirmgröße einer anderen
  Fassung erwarten.
- `exit [tcltest::runAllTests]` vergessen. Sonst endet `all.tcl` mit 0.

## Bauen und Weitergeben

- `libxi-dev` beim Tk-9-Quellbau weglassen.
- `--enable-threads` an Tcl 9 übergeben. Unbekannter Schalter.
- `TCL_LIBS` in `/usr/lib/tcl8.6/tclConfig.sh` suchen. Das ist ein
  Wrapper.
- Ein `zipfs mkimg` auf einem dynamischen `tclsh9.0` weitergeben. Es
  hängt an `/opt/tcl9/lib`.
- Ein Image auf einer neueren glibc bauen als das Ziel hat.
- Das Passwortargument von `zipfs mkimg` weglassen, wenn die Basis
  folgt.
- Ein TEA-Paket gegen Debians Tcl mit `make install-binaries`
  installieren. Es will nach `/usr/bin`; `install-lib-binaries` nehmen.
- Eine Erweiterung für Tcl 9 gegen 9.1 bauen und unter 9.0 erwarten.
  Gegen 9.0 bauen.

---

*Nächstes Kapitel: [CLI](810-anhang-cli.md)*
