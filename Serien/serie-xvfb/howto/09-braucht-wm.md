# 09 — brauchtWM: einen Fenstermanager erkennen

```tcl
serie::wmRahmen     ;# 1: ein WM hat das Fenster in einen Rahmen gehängt
serie::wmDa         ;# 1: irgendein WM läuft
serie::brauchtWM    ;# SKIP ohne WM
serie::brauchtRahmen;# SKIP ohne Rahmen
```

`winfo manager .` hilft nicht — es ist immer `wm` (Howto 02). Was
trägt (gemessen unter X11 mit Tcl/Tk 8.6.14 und 9.0.4):

| | `wm frame .` vs. `winfo id .` | `wm iconify` |
|--|--|--|
| kein WM | gleich | bleibt `normal`, Tk wartet ~2 s |
| openbox (reparentierend) | verschieden | `iconic` |
| WM ohne Reparenting (dwm, xmonad …) | gleich | `iconic` |

Also: erst `wm frame` gegen `winfo id` (schnell); sind sie gleich,
entscheidet eine Iconify-Probe an einem Hilfsfenster. Ids **numerisch**
vergleichen — 8.6 schreibt `0x00200003` und `0x200003`. Vor dem ersten
Mappen ist `wm frame` `0x0`, deshalb erst `update`.

`SERIE_WM=0` bzw. `1` erzwingt das Ergebnis (CI ohne Probe). Unter
Windows und macOS gibt es immer einen WM; dort skippt nichts.

## Demo

```bash
wish howto/09-braucht-wm.tcl
```
