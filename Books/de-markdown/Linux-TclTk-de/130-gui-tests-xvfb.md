# GUI-Tests mit Xvfb

## Einführung

Tk-Tests brauchen eine Anzeige, auch auf einem Server ohne Bildschirm
oder in einer CI-Pipeline. Unter Linux liefert sie [Xvfb]{.index}, ein
X-Server, der nur in den Speicher zeichnet. Xvfb hat keinen
Fenstermanager. Was das für Fokus, Rahmen und Iconify bedeutet, zeigt
das nächste Kapitel. Dieses Kapitel richtet die Anzeige ein: Xvfb und
`xvfb-run`, Bildschirmgröße und DPI, Schriften, und den Rückgabewert,
auf den sich eine Pipeline verlassen kann.

Grundlage ist `serie-xvfb`, geprüft mit Tcl/Tk 8.6.14 und 9.0.4 unter
Xvfb ohne Fenstermanager und mit openbox. Im Container liefen alle
20 Howtos mit beiden Fassungen: 19 OK, 1 SKIP (Howto 10, Iconify,
braucht einen Fenstermanager), 0 FAIL.

---

## Xvfb und xvfb-run

Debian-Paket `xvfb`. Es bringt den Server `Xvfb` und das Hilfsskript
[`xvfb-run`]{.index} (`serie-xvfb`, Howto 17). Fehlt es, meldet eine
Testsuite SKIP, nicht FAIL:

```tcl
if {[auto_execok xvfb-run] eq ""} {
    puts "SKIP: xvfb-run fehlt"
    exit 0
}
```

`xvfb-run` startet einen Server, setzt `DISPLAY`, startet das Programm
und beendet den Server danach (`serie-xvfb`, Howto 18):

```bash
xvfb-run -a wish9.0 test.tcl
xvfb-run -a -s "-screen 0 800x600x16 -dpi 50" wish9.0 test.tcl
xvfb-run -a sh -c 'openbox >/dev/null 2>&1 & sleep 1; wish9.0 test.tcl'
```

- `-a` sucht ein freies Display, beginnend bei `:99`.
- `-s "…"` reicht Optionen an Xvfb: `-screen 0 BxHxT` (Breite, Höhe,
  Farbtiefe) und `-dpi N`.
- Ohne `-s` nahm das `xvfb-run` des Messrechners `-screen 0
  1280x1024x24`. Ältere Fassungen nahmen `640x480x8`. Deshalb immer
  angeben.
- Ein Fenstermanager startet im selben `sh -c` vorab. `sleep 1` gibt
  ihm Zeit, sich anzumelden. openbox ist das Debian-Paket `openbox`.

Ein Skript, das nicht selbst endet, hält `xvfb-run` offen. Testskripte
enden mit `exit`; die Serie erzwingt das über `SERIES_AUTO=1`.

`beispiele/gui-test-xvfb.sh` fasst das zusammen: feste Größe, feste
DPI, Fenstermanager über `WM=openbox`, SKIP ohne `xvfb-run`.

### Eigener Server statt xvfb-run

Für viele kurze Läufe lohnt ein dauerhafter Server:

```bash
Xvfb :93 -screen 0 1280x1024x24 -nolisten tcp -noreset &
export DISPLAY=:93
```

Die Option [`-noreset`]{.index} ist wichtig. Ohne sie setzt Xvfb seinen
Zustand zurück, sobald der letzte Client die Verbindung schließt. Im
Container ging so jede mit `xrdb` geladene Ressource verloren, bevor
der Test startete; `xprop -root` zeigte eine eben gesetzte Eigenschaft
schon nicht mehr. Mit `-noreset` blieben sie stehen.

---

## Bildschirm, DPI und Schriften

`winfo screenwidth`, `screenheight` und `screendepth` liefern genau
die Werte aus `-screen` (`serie-xvfb`, Howto 01). `tk scaling` folgt
`-dpi`: 1,389 ohne Angabe (Xvfb meldet dann 100 dpi), 0,695 bei
`-dpi 50`, 2,770 bei `-dpi 200`.

Die Schriften kommen über fontconfig vom Rechner, auf dem der Test
läuft, nicht von Xvfb. Ihre Größe ist in Punkten angegeben, die
Pixelgröße wächst also mit `-dpi`. Ein Test, der feste Pixel erwartet
(Breite eines Labels, Klickpunkt auf einem Reiter), kippt bei anderer
DPI oder auf einem Rechner mit anderer Standardschrift. Solche Tests
rechnen relativ:

```tcl
set breite [font measure TkDefaultFont "Hallo Welt"]
set soll   [winfo reqwidth .l]
```

Unter Tk 9 wachsen zusätzlich die Pixelmaße von ttk mit der DPI (im
Container: Scrollbar 15 Pixel bei 100 dpi, 27 bei 192 dpi). Ein Test,
der unter 8.6 grün ist, kann unter 9 an derselben Stelle kippen, siehe
[Schriften, Skalierung, Themes](090-schriften-skalierung-themes.md).

Für reproduzierbare Läufe gehören Größe, Tiefe und DPI deshalb fest in
den Testaufruf, und die Schrift fest in den Test:

```tcl
font configure TkDefaultFont -family "DejaVu Sans" -size 10
```

---

## Rückgabewert und Abbruch

Ein `wish` ohne Anzeige endet mit 0, nachdem es das Skript ohne Tk
ausgeführt hat (Container-Prüfung, siehe
[X11, Fenstermanager und Wayland](080-x11-fenstermanager-wayland.md)).
Für eine Pipeline ist das gefährlich: Ein falsch gesetztes `DISPLAY`
sieht wie ein bestandener Test aus. Testskripte beginnen deshalb mit:

```tcl
if {[catch {package require Tk} fehler]} {
    puts stderr "FAIL: $fehler"
    exit 1
}
```

Auch `tcltest` setzt den Rückgabewert nicht von selbst.
`tcltest::runAllTests` liefert in der Fassung aus Tcl 9.0.4 den Wert 1,
wenn eine Testdatei fehlschlägt (Quelltext `tcltest.tcl`). `all.tcl`
reicht ihn weiter:

```tcl
exit [tcltest::runAllTests]
```

Die Einzelheiten stehen im Buch *Testen*.

Für Hänger hilft ein äußeres `timeout`:

```bash
timeout 60 xvfb-run -a wish9.0 tests/all.tcl
```

---

## tclsh oder wish

`wish` lädt Tk beim Start, `tclsh` erst mit `package require Tk`.
Danach verhalten sich beide gleich (`serie-xvfb`, Howto 14): `.`
existiert, ist aber beim Lauf des Skripts **noch nicht gemappt**,
`winfo ismapped .` ist 0. Gemappt wird erst beim nächsten `update`
oder wenn die Ereignisschleife läuft.

Unter `tclsh` läuft die Ereignisschleife nicht von selbst. Ein Test
unter `tclsh` braucht `update` oder `vwait`, ein Programm unter `tclsh`
ein `vwait forever` am Ende. `serie-xvfb` wählt den Interpreter über
die erste Zeile des Howtos: Steht `wish` darin, startet `run-all.tcl`
das passende `wish` zur Fassung des laufenden `tclsh`.

---

## Zusammenfassung

- Debian-Paket `xvfb`, `xvfb-run -a -s "-screen 0 BxHxT -dpi N"`.
- Ohne `xvfb-run`: SKIP, nicht FAIL.
- Eigener Xvfb mit `-noreset`, sonst verliert er Ressourcen.
- DPI bestimmt `tk scaling`, Schriften kommen vom Client. Größe, DPI
  und Schrift im Test festlegen.
- `wish` ohne Anzeige endet mit 0. Tests prüfen `package require Tk`
  selbst und enden mit einem Rückgabewert.

---

*Nächstes Kapitel: [Was der Test selbst herstellt](135-gui-tests-fenstermanager.md)*
