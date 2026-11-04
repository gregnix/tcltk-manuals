# 01 — DISPLAY, Schirm, DPI, Schriften

```tcl
set ::env(DISPLAY)          ;# nur unter X11
winfo screen .              ;# überall, z. B. :99.0
winfo screenwidth .
tk scaling                  ;# Pixel je Punkt = DPI / 72
```

Ohne Display startet Tk unter X11 nicht. `xvfb-run -a` startet ein
virtuelles und setzt `DISPLAY` (z. B. `:99`). Unter Windows und macOS
gibt es kein `DISPLAY` — dort meldet dieses Howto SKIP.

**Größe und Tiefe** gibt die Xvfb-Option `-screen 0 BxHxT` vor
(Howto 18). `winfo screenwidth/screenheight/screendepth` liefern genau
das.

**DPI und `tk scaling`.** Tk rechnet `tk scaling` aus Pixeln und
Millimetern des Schirms: Pixel ÷ (mm ÷ 25,4) ÷ 72. Xvfb leitet die
Millimeter aus `-dpi` ab. Gemessen (Tcl/Tk 8.6.14 und 9.0.4):

| Xvfb | mm | `tk scaling` |
|------|----|--------------|
| 1280x1024, ohne `-dpi` | 325 | 1,389 (≈ 100 dpi) |
| `-dpi 50` | | 0,695 |
| `-dpi 200` | | 2,770 |

**Schriften.** Tk unter X11 zeichnet mit Xft; die Schriften kommen
über fontconfig vom **Rechner des Clients**, nicht von Xvfb. Auf dem
Messrechner war `TkDefaultFont` `Inter 10` — eine Größe in **Punkten**. Ihre
Pixelgröße wächst also mit `-dpi`: ein Test, der feste Pixel erwartet
(Breite eines Labels, Trefferpunkt eines Tabs), kippt bei anderem
`-dpi` oder anderer Schrift. Solche Tests rechnen relativ zu
`winfo reqwidth` oder `font measure`.

## Demo

```bash
wish howto/01-erste-schritte.tcl
```
