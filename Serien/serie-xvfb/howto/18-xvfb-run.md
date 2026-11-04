# 18 — xvfb-run und seine Optionen

```bash
SERIES_AUTO=1 xvfb-run -a wish howto/03-ismapped.tcl
xvfb-run -a -s "-screen 0 800x600x16 -dpi 50" wish app.tcl
xvfb-run -a sh -c 'openbox >/dev/null 2>&1 & sleep 1; wish app.tcl'
```

- `-a` wählt ein freies Display (ab `:99`).
- `-s "…"` reicht Optionen an Xvfb durch: `-screen 0 BxHxT` (Breite,
  Höhe, Farbtiefe), `-dpi N`. Ohne `-s` nimmt das xvfb-run des
  Messrechners `-screen 0 1280x1024x24`; ältere Fassungen nahmen
  `640x480x8` — im Zweifel immer angeben.
- `-dpi` bestimmt `tk scaling` (DPI / 72) und damit die Pixelgröße
  aller Punkt-Schriften (Howto 01).
- Einen Fenstermanager startet man im selben `sh -c` vorab (openbox,
  Debian-Paket `openbox`); `sleep 1` gibt ihm Zeit, sich anzumelden.
- Ohne `SERIES_AUTO=1` bleibt eine Demo offen und `xvfb-run` kehrt
  nicht zurück.

Die Demo startet einen eigenen Xvfb mit `800x600x16 -dpi 50` und misst
dort. SKIP, wenn `xvfb-run` fehlt.

## Demo

```bash
wish howto/18-xvfb-run.tcl
```
