# Quellen

## Einführung

Das Buch erklärt im Text, woher eine Aussage stammt. Dieser Anhang
nennt die Quellen vollständig. Fremde Texte sind zusammengefasst, nicht
übersetzt oder abgeschrieben. Kurze wörtliche Stellen, etwa
Fehlermeldungen und Befehle, stehen im Code-Block.

---

## Eigene Läufe

### Howto-Serien des Autors

Die Serien sind Begleitmaterial des Autors und nicht veröffentlicht.
Jede enthält
`README.md` mit dem Abschnitt „Gemessen“, `TUTORIAL.md`,
`howto/00-referenz.md` und je Howto eine Erklärung `NN-*.md` mit Demo
`NN-*.tcl`; `run-all.tcl` startet alle Demos.

| Serie | Howtos | Stand laut README | verwendet in |
|-------|--------|------------------------|--------------|
| `serie-linux` | 12 | Linux, Tcl 8.6.18, Debian forky; ohne Datum | tcl_platform, Pfade, Kodierung, exec, Dialoge |
| `serie-xvfb` | 20 | Tcl/Tk 8.6.14 und 9.0.4 unter Xvfb, ohne Fenstermanager und mit openbox; ohne Datum | X11, beide Testkapitel |
| `serie-xfce` | 12 | Xfce 4.20, Debian, X11; ohne Datum | Xfce, Desktop-Integration |
| `serie-tcltk-bauen` | 12 | Debian forky, 2026-09-15, `tclsh8.6` und `tclsh9.0`, je 12/12 | Welches Tcl, Tk bauen, Suchpfade |
| `serie-tcl9-app` | 18 | Tcl 9.0.x | Weitergeben |

Die Werte für Xfce mit 29 Pixel Titelleiste stammen aus `serie-xvfb`
(Howto 04 und 13), geprüft auf dem Arbeitsplatz des Autors.

### Container-Prüfung

Am 2026-10-20 in einem Container mit Ubuntu 24.04.5 LTS, Kernel
6.18.44, x86_64, glibc 2.39. Ausgeführt von Claude.

- Tcl/Tk 8.6.14 aus den Ubuntu-Paketen `tcl8.6`, `tk8.6`.
- Tcl/Tk 9.0.4 als Quellbau unter `/opt/tcl9`, Quellen daneben unter
  `tcl9.0.4` und `tk9.0.4`.
- Xvfb 21.1.12 ohne Fenstermanager, 1280x1024x24, 100 dpi; für die
  Skalierung zusätzlich 1920x1080 mit `-dpi 192`; für X-Ressourcen mit
  `-noreset`.
- Werkzeuge: `xdotool`, `xclip`, `xprop`, `xrdb`, `xmodmap`, `readelf`,
  `objdump`, `notify-send` 0.8.3 (libnotify 0.8.3).
- Läufe mit `env -i` für Suchpfade und Kodierung.
- Skripte: `beispiele/messprobe-linux.tcl`, `rad-und-tasten.tcl`,
  `auswahl-probe.tcl`, `wm-probe.tcl`, `spaeter-rahmen.tcl`, `utf8-wache.tcl`,
  `xdg-ordner.tcl`; dazu alle Serien außer `serie-xfce` (siehe
  [CLI](810-anhang-cli.md)).

### Prüfung auf lxpro

Auf dem Arbeitsplatz des Autors, Debian unstable (forky), Oktober 2026,
ausgeführt vom Autor:

- Debian-Pakete `tcl8.6` 8.6.18, `tcl9.0` 9.0.4, `tcl9.1` 9.1.0,
  `tk9.0` 9.0.4, `tk9.1` 9.1.0, `libsqlite3-tcl` 3.53.4-2, ab
  2026-11-03 3.54.1-1 aus unstable.
- BAWT-Builds 9.0.1 und 9.0.4 unter `/opt/Tcl`, Quellbau 9.1.0 unter
  `/opt/tcl91`.
- sqlite3 3.53.4 aus `sqlite3.53.4.tar.gz` der Tcl-9.1.0-Distribution,
  gebaut gegen Debians `tcl8.6-dev`, `tcl9.0-dev` und `tcl9.1-dev`.
- Berichte mit `examples/demo-tuappinfo.tcl` aus tclutils 0.69.0.
- Messung der offenen Punkte am 2026-11-02 unter Xfce 4.20, X11,
  `wish` 8.6.18, 9.0.4 und 9.1.0: `os-release`, `wm frame`, `-alpha`,
  `scalingPct` am Dialog, `<Command-c>`, Super, `xfce4-clipman`,
  `zenity`, `desktop-file-validate`, `tk systray`, Xfce-Erkennung,
  `grab -global`, `readelf -d`.

### Was im Container fehlte

Für XWayland nachinstalliert: `weston` 13.0.0, `xwayland`, `x11-apps`
(Ubuntu-Pakete), Weston verschachtelt im Xvfb.

Im Container nicht vorhanden und deshalb nicht geprüft: Desktop-Sitzung,
Sitzungs-DBus, Xfce, Fenstermanager, Wayland, CUPS, `xdg-user-dirs`,
`desktop-file-utils`, `zenity`, `kdialog`, Debian selbst.

---

## Tcl und Tk

- **Tcl/Tk-Quelltext 9.0.4**, gelesen im Container:
  - `tk/generic/tkEvent.c`: Umsetzung der Tasten 4 bis 7 in
    `MouseWheel`.
  - `tk/generic/tkBind.c`: Modifier-Tabelle (`Command`, `Option`),
    Tastennummern ab 4 bei `event generate`.
  - `tk/unix/tkUnixKey.c`: Ermittlung der Meta- und Alt-Bits.
  - `tk/unix/tkUnixWm.c`: `WM_CLASS`, `_NET_WM_*`.
  - `tk/unix/tkUnixEvent.c`: Rückfall auf 75 dpi unter XWayland.
  - `tk/unix/tkUnixSysNotify.c`, `tk/unix/tkUnixSysTray.c`,
    `tk/library/systray.tcl`: `tk sysnotify`, `tk systray`.
  - `tk/library/print.tcl`: `tk print` unter X11.
  - `tk/library/scaling.tcl`: Skalierung unter X11.
  - `tk/library/ttk/fonts.tcl`: Standardschriften.
  - `tk/library/tkfbox.tcl`: Dateidialog, versteckte Dateien.
  - `tcl/library/init.tcl`, `tcl/library/auto.tcl`: `auto_execok`,
    `auto_reset`.
  - `tcl/library/msgcat/msgcat.tcl`: Locale-Variablen.
  - `tcl/library/tcltest/tcltest.tcl` (2.5.11): Rückgabewert von
    `runAllTests`.
  - `tcl/unix/Makefile.in`, `tk/unix/Makefile.in`: installierte
    Programme.
  <https://core.tcl-lang.org/tcl/>, <https://core.tcl-lang.org/tk/>
- **Tcl/Tk-Handbuchseiten** 9.0: `bind`, `event`, `selection`,
  `clipboard`, `wm`, `winfo`, `tk`, `file`, `exec`, `encoding`,
  `zipfs`, `tm`. <https://www.tcl-lang.org/man/tcl9.0/>
- **TIP 602**: Tilde nicht mehr im Dateisystem auflösen.
  <https://core.tcl-lang.org/tips/doc/trunk/tip/602.md>
- **TIP 656**: Kodierungsprofile, `strict` als Vorgabe.
  <https://core.tcl-lang.org/tips/doc/trunk/tip/656.md>
- **Tcl/Tk 9.1.0**, Download-Seite mit Release-Notes und den
  mitgelieferten Paketen, darunter `sqlite3.53.4.tar.gz`.
  <https://sourceforge.net/projects/tcl/files/Tcl/9.1.0/>

---

## Debian

- **tcltk-defaults**: Standardfassung von Tcl/Tk in Debian.
  <https://tracker.debian.org/pkg/tcltk-defaults>

---

## Spezifikationen

- **XDG Base Directory Specification**, freedesktop.org.
  <https://specifications.freedesktop.org/basedir-spec/latest/>
- **Desktop Entry Specification**, freedesktop.org.
  <https://specifications.freedesktop.org/desktop-entry-spec/latest/>
- **Extended Window Manager Hints (EWMH)**, freedesktop.org.
  <https://specifications.freedesktop.org/wm-spec/latest/>
- **xdg-user-dirs**, freedesktop.org.
  <https://www.freedesktop.org/wiki/Software/xdg-user-dirs/>
- **os-release**, Handbuchseite `os-release(5)` von systemd.
- Handbuchseiten: `Xvfb(1)`, `xvfb-run(1)`, `xrdb(1)`, `xprop(1)`,
  `xmodmap(1)`, `xclip(1)`, `xdotool(1)`, `xdg-open(1)`, `notify-send(1)`,
  `fc-match(1)`, `readelf(1)`, `ld.so(8)`, `locale(7)`.

---

## Nachbarbücher derselben Reihe

| Buch | Verwendet für |
|------|---------------|
| *Debian unter Linux* (`book-linux-debian`), Kapitel *Tcl unter Linux*, *Debian erkennen*, *Suite und Codename* | Lage der Tcl-Installationen auf lxpro und decoder, Regeln für `/opt`, `os-release` |
| *Tcl/Tk unter macOS* (`book-macos-tcltk`) | Aufbau und Stil; Vergleich mit Aqua |
| *Tcl/Tk 9.0 bauen* (`book-tcltk9.0-bauen`), *Tcl/Tk 9.1 bauen* (`book-tcltk9.1-bauen`) | Unix-Abhängigkeiten, `libxi-dev`, mehrere Installationen, statisch bauen |
| *Tcl-Anwendungen ausliefern* (`book-tcl-ausliefern`), im Text *Ausliefern* | zipfs, Zipkits, `.deb` und `.rpm` |
| *C-Erweiterungen* (`book-tcl-erweiterungen`) | TEA gegen `tclConfig.sh` |
| *Pakete und Module* (`book-package-module`) | `auto_path`, `.tm` |
| *Tcl/Tk-Versionen nebeneinander* (`book-tcltk-versionen`) | gleiche Paketversion, Binärerweiterungen je Fassung |
| *tclutils* (`book-tclutils`) | `tuappinfo` |
| *Tcl/Tk 9.1* (`book-tcltk9.1`) | `tk fileicon`, BiDi unter X11 |
| *Encoding* (`book-encoding`) | Profile, TIP 656 |
| *Testen* (`book-tcl-testen`) | `tcltest` |
| *Printing* (`book-printing`) | Druck über CUPS |

---

## Widersprüche zwischen den Quellen

Wo Ergebnisse voneinander abweichen, steht das im Kapitel. Die
wichtigsten:

- *Debian unter Linux*, Kapitel *Tcl unter Linux*: „`<Command-c>` …
  reagiert unter Linux also auf Alt+C.“ Gilt für Tk 8.6; unter Tk 9.0
  und 9.1 keine Taste, im Container und auf dem Xfce-Arbeitsplatz. Siehe
  [Maus, Tastatur, Zwischenablage](100-maus-tastatur-zwischenablage.md).
- `serie-linux`, README: `file volumes` liefert `/`. Unter Tcl 9
  zusätzlich `//zipfs:/`.
- `serie-tcltk-bauen`, Howto 03: `TCL_LIBS` von 9.0.4 enthält
  `-ltommath`. Gilt für das Debian-Paket, nicht für den Quellbau.
- `serie-tcltk-bauen`, Howto 04 und 07: Tk 9 linkt zusätzlich `libpng`.
  Im Container und auf dem Arbeitsplatz erscheint `libpng16` bei allen
  Tk-Fassungen nur über freetype (`readelf -d`).
- *Tcl/Tk 9.0 bauen*: `libxi-dev` nötig wegen `XInput2.h`. Im
  Quelltext von Tk 9.0.4 kommt `XInput2` nicht vor.

---

## KI-Unterstützung

Text, Skripte und Beispiele sind im Dialog mit **Claude** (Anthropic)
erarbeitet, im Oktober 2026. Claude hat die Howto-Serien ausgewertet und
zu Kapiteln geordnet, die Beispielskripte geschrieben, die
Container-Prüfung ausgeführt und den Tk-Quelltext gelesen. Die
Ergebnisse vom Debian-Arbeitsplatz stammen aus den Serien des Autors.

---

## Marken

Linux ist eine Marke von Linus Torvalds. Debian ist eine Marke von
Software in the Public Interest, Inc. Ubuntu ist eine Marke von
Canonical Ltd. Xfce, X.Org und freedesktop.org sind Namen der jeweiligen
Projekte. Tcl und Tk stehen unter einer BSD-artigen Lizenz. Dieses
Buch steht in keiner Verbindung zu diesen Organisationen.

---

*Ende des Buches.*
