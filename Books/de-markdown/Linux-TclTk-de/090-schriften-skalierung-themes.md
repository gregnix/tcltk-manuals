# Schriften, Skalierung, Themes

## Einführung

Unter X11 zeichnet Tk Schrift mit [Xft]{.index} und sucht sie über
fontconfig. Die Größe der Oberfläche hängt an `tk scaling`, und das
hängt an der Auflösung, die der X-Server meldet. Farben und Themes
kommen aus Tk selbst und aus der X-Ressourcendatenbank, nicht aus den
Einstellungen des Desktops. Dieses Kapitel zeigt, woher jeder Wert
kommt und was Tk 9 an der Skalierung geändert hat.

---

## Schriften: Xft und fontconfig

Ob Tk mit Xft gebaut ist, sagt `tk::pkgconfig get fontsystem`. Im
Container liefert es unter 8.6.14 und 9.0.4 `xft`. Dann setzt Tk die
benannten Schriften auf die fontconfig-Namen `sans-serif` und
`monospace` (Quelltext `ttk/fonts.tcl`). Welche Familie dahinter
steht, entscheidet fontconfig auf dem Rechner, auf dem das
Programm läuft:

```bash
fc-match sans-serif     # Container: Inter-Regular.otf: "Inter" "Regular"
fc-match monospace      # Container: DejaVuSansMono.ttf: "DejaVu Sans Mono" "Book"
```

Container-Prüfung, beide Fassungen gleich:

| Name | Familie | Größe |
|------|---------|-------|
| `TkDefaultFont`, `TkTextFont`, `TkMenuFont`, `TkIconFont` | Inter | 10 |
| `TkHeadingFont` | Inter, fett | 10 |
| `TkCaptionFont` | Inter, fett | 12 |
| `TkTooltipFont`, `TkSmallCaptionFont` | Inter | 9 |
| `TkFixedFont` | DejaVu Sans Mono | 10 |

`serie-xvfb` (Howto 01) meldet ebenfalls `TkDefaultFont` `Inter 10`.
Auf einem Rechner ohne Inter liefert fontconfig eine andere Familie,
meist DejaVu Sans. Der Text darf das nicht voraussetzen.

Die Größen sind **Punkte**, keine Pixel. Ein Wunschname, den es nicht
gibt, führt nicht zu einem Fehler: `font actual {GibtsNicht 10}`
liefert im Container `Inter`. `Helvetica` wird zu `TeX Gyre Heros`,
weil fontconfig dafür einen Ersatz kennt. Wer prüfen will, ob eine
Familie wirklich da ist, fragt `font families`:

```tcl
if {"Noto Sans" in [font families]} {
    font configure TkDefaultFont -family "Noto Sans"
}
```

Die Schriften kommen vom **Client**, nicht vom X-Server. Ein Programm,
das über `ssh -X` auf einem anderen Rechner läuft, zeichnet mit den
Schriften des entfernten Rechners. Dasselbe gilt für Xvfb: Der virtuelle
Server hat keine eigenen Schriften im Sinn von Xft.

---

## tk scaling und DPI

[`tk scaling`]{.index} ist die Zahl der Pixel je Punkt. Tk rechnet sie
beim Start aus der Bildschirmgröße in Pixeln und Millimetern:
Pixel ÷ (mm ÷ 25,4) ÷ 72. Bei 100 dpi ist das 1,389. Alle Größen in
Punkten, auch die Schriften, wachsen mit diesem Wert.

`serie-xvfb` (Howto 01, Tcl/Tk 8.6.14 und 9.0.4) misst das mit
verschiedenen `-dpi`-Werten des Xvfb:

| Xvfb | `tk scaling` |
|------|--------------|
| 1280x1024, ohne `-dpi` | 1,389 (≈ 100 dpi) |
| `-dpi 50` | 0,695 |
| `-dpi 200` | 2,770 |

Container-Prüfung mit einem Label „Hallo Welt“ in `TkDefaultFont` und
einer `ttk::scrollbar`:

| Xvfb | Fassung | `tk scaling` | `::tk::scalingPct` | Zeilenhöhe | Textbreite | Scrollbar |
|------|---------|--------------|--------------------|------------|------------|-----------|
| 100 dpi | 8.6.14 | 1,389 | fehlt | 18 | 69 | 15 |
| 100 dpi | 9.0.4 | 1,389 | 100 | 18 | 69 | 15 |
| 192 dpi | 8.6.14 | 2,667 | fehlt | 33 | 131 | 15 |
| 192 dpi | 9.0.4 | 2,667 | 200 | 33 | 131 | 27 |

Die Schrift wächst in beiden Fassungen mit. Die Scrollbar wächst nur
unter Tk 9: Tk 9 rechnet viele Maße in ttk und in den Standarddialogen
über [`::tk::scalingPct`]{.index}, die Auflösung in Prozent von 96 dpi,
auf 25 gerundet und mindestens 100. Unter 8.6 bleiben Pixelmaße wie
Scrollbarbreite und Checkbox fest.

### Woher Tk 9 die Skalierung nimmt

Ein Desktop stellt die Vergrößerung meist nicht über die DPI des
X-Servers ein, sondern über eigene Einstellungen. Tk 9 liest einige
davon beim Start (Quelltext `library/scaling.tcl`, 9.0.4), in dieser
Reihenfolge:

1. Läuft `xfce4-session`: `xfconf-query -c xsettings -p
   /Gdk/WindowScalingFactor`. Ab Faktor 2 gilt 200 %, und die
   Schriftgrößen werden verdoppelt (`::tk::fontScalingFactor` 2).
2. Läuft `mate-session`: `gsettings` für MATE.
3. Läuft `gnome-session`: der Schlüssel `Gdk/WindowScalingFactor` in
   den xsettings-Overrides.
4. Sonst die X-Ressource [`Xft.dpi`]{.index}, gelesen mit `xrdb -query`:
   Prozent = `Xft.dpi` ÷ 96 × 100.
5. Unter GNOME ohne Wayland zuletzt `~/.config/monitors.xml`.

Weicht der gefundene Wert vom gemessenen ab, setzt Tk 9 `tk scaling`
neu. Container-Prüfung: Xvfb mit 100 dpi, dazu `Xft.dpi: 192` über
`xrdb -merge`:

| Fassung | `tk scaling` | `scalingPct` | `font actual … -size` | Zeilenhöhe | Scrollbar |
|---------|--------------|--------------|------------------------|------------|-----------|
| 8.6.14 | 1,389 | fehlt | 19 | 33 | 15 |
| 9.0.4 | 2,672 | 200 | 10 | 33 | 27 |

Unter 8.6 vergrößert Xft die Schrift selbst, weil fontconfig `Xft.dpi`
kennt. Tk weiß davon nichts: `tk scaling` bleibt 1,389, und `font
actual` meldet die zurückgerechnete Größe 19 statt 10. Pixelmaße bleiben
klein. Unter 9.0 stimmen Schrift, Rechenwert und Maße zusammen.

Wer die Skalierung selbst festlegen will, setzt sie vor dem Aufbau der
Oberfläche:

```tcl
tk scaling 2.0     ;# 144 dpi; vor dem ersten Widget
```

Unter Tk 9 zieht `tk scaling` den Wert `::tk::scalingPct` sofort nach:
`tk scaling 2.0` ergibt 150 (Faktor × 75, auf 25 gerundet; Quelltext
`tkCmds.c`). Wie stark ein Standarddialog dabei wächst, hängt an der
Schrift. `tk_messageBox` vor und nach `tk scaling 2.0`:

| Umgebung | Fassung | `scalingPct` | Dialog | Zeilenhöhe `TkDefaultFont` |
|---|---|---|---|---|
| Container, Xvfb 100 dpi | 8.6.14 | fehlt | 117×95 → 162×114 | 18 → 25 |
| Container, Xvfb 100 dpi | 9.0.4 | 100 → 150 | 117×95 → 164×116 | 18 → 25 |
| Arbeitsplatz, Xfce | 8.6.18 | fehlt | 110×96 → 110×96 | 34 → 34 |
| Arbeitsplatz, Xfce | 9.0.4 | 100 → 150 | 110×96 → 110×100 | 34 → 34 |
| Arbeitsplatz, Xfce | 9.1.0 | 100 → 150 | 112×96 → 128×119 | 31 → 31 |

Im Container wächst die Schrift mit, und mit ihr der Dialog. Auf dem
Arbeitsplatz bleibt die Schrift gleich; was dort wächst, rechnet Tk
über `scalingPct`: unter 9.0 kaum, unter 9.1 deutlich.

---

## Themes

Unter X11 bringt Tk vier ttk-Themes mit. Container-Prüfung, beide
Fassungen: `ttk::style theme names` liefert `clam alt default classic`,
aktiv ist `default`. Es gibt kein natives Linux-Theme wie `aqua` oder
`vista`. Das Aussehen von GTK- oder Qt-Programmen übernimmt Tk nicht.
Dafür gibt es Zusatzpakete (etwa `ttk::theme::*`-Sammlungen); sie sind
nicht Teil dieses Buches.

Der Hintergrund klassischer Widgets ist `#d9d9d9`. `TButton -padding`
meldet unter 8.6 `3 3`, unter 9.0 `2.25p`: Tk 9 rechnet Abstände in
Punkten, damit sie mit `tk scaling` wachsen.

---

## X-Ressourcen

Unter X11 liest Tk beim Start die [Ressourcendatenbank]{.index} des
X-Servers, die Eigenschaft `RESOURCE_MANAGER` am Wurzelfenster, die
`xrdb` setzt. Fehlt sie, liest Tk `~/.Xdefaults`. Container-Prüfung,
8.6.14 und 9.0.4 gleich:

```text
*background:  lightyellow     -> option get . background Background: lightyellow
                                 button -background: lightyellow
*Label.font:  {DejaVu Sans} 14 -> label -font: {DejaVu Sans} 14
*TkTheme:     clam            -> ttk::style theme use: clam
```

`*TkTheme` wählt also das ttk-Theme, ohne eine Zeile Code. Die Datei
`~/.Xdefaults` mit `*background: pink` wirkte im Container, solange
keine Ressourcen geladen waren. Mit `XENVIRONMENT` auf eine Datei
gesetzt änderte sich nichts.

Das hat zwei Seiten. Ein Benutzer kann so Farbe, Schrift und Theme
eines Tk-Programms anpassen. Ein Programm, das auf einem fremden
Rechner seltsam aussieht, hat dort vielleicht eine `~/.Xdefaults` aus
alten Zeiten. `xrdb -query` zeigt, was geladen ist.

Ein Programm lädt eigene Vorgaben mit niedriger Priorität, damit der
Benutzer sie überschreiben kann:

```tcl
option add *Entry.background white widgetDefault
option readfile [file join $hier app.Xdefaults] startupFile
```

Eine Eigenheit von Xvfb: Ohne `-noreset` setzt der Server seinen
Zustand zurück, sobald der letzte Client die Verbindung schließt.
Ressourcen, die ein `xrdb` vorher geladen hat, sind dann weg, bevor das
Tk-Programm startet. Im Container blieb `xrdb -query` aus diesem Grund
leer, bis Xvfb mit `-noreset` lief. Für Tests mit Ressourcen gehört
`-noreset` in die Xvfb-Optionen, siehe
[GUI-Tests mit Xvfb](130-gui-tests-xvfb.md).

---

## Zusammenfassung

- Xft und fontconfig: `sans-serif` und `monospace`, Familie vom
  Rechner des Programms. Größen in Punkten.
- `tk scaling` aus Pixeln und Millimetern. Tk 9 liest zusätzlich
  Xfce-, MATE-, GNOME-Einstellungen und `Xft.dpi` und skaliert auch
  Pixelmaße.
- Unter 8.6 vergrößert `Xft.dpi` nur die Schrift.
- Themes: `clam alt default classic`, Vorgabe `default`.
- X-Ressourcen wirken: `*background`, `*TkTheme`. Fehlt
  `RESOURCE_MANAGER`, gilt `~/.Xdefaults`.

---

*Nächstes Kapitel: [Maus, Tastatur, Zwischenablage](100-maus-tastatur-zwischenablage.md)*
