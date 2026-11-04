# Referenz: Xvfb / GUI-Tests (Kurz)

```tcl
update
winfo ismapped .
::serie::fokusVorbereiten    ;# focus -force . ; update
event generate . <Escape>
```

## Was wo gilt

Gemessen mit Tcl/Tk 8.6.14 und 9.0.4 unter Xvfb.

| | Xvfb ohne WM | Xvfb + openbox |
|--|----------------|---------------------|
| `DISPLAY` | z. B. `:99` (`xvfb-run -a`) | dito |
| `winfo manager .` | `wm` | `wm` |
| `wm frame .` vs. `winfo id .` | gleich | verschieden |
| `ismapped` / `viewable` | ja | ja |
| `focus -force` | ja | ja |
| Fokus nach `update` ohne `focus -force` | nein (`focus` leer) | ja (`.`) |
| Titelleiste (`rooty - gy`) | 0 | 20 (XFCE beim Autor: 29) |
| Iconify | bleibt `normal` | `iconic` |

## Fallen

- Ohne WM kommt eine erzeugte Taste ohne `focus -force` nie an; mit WM
  nach `update` meist schon. Der Test setzt den Fokus trotzdem selbst.
- `event generate` einer Taste geht an das **Fokus-Widget**, nicht an
  das genannte Fenster.
- `wm geometry +x+y` ist Rahmenlage, `winfo rooty` die Clientfläche
- feste `+80` ist unter dem anderen WM rot
- Pixelmaße hängen an `-dpi` des Xvfb (`tk scaling` = DPI/72)
- `xvfb-run` fehlt → SKIP, nicht FAIL

Serie tk-test. `serie::brauchtWM` in `_bootstrap.tcl`.
