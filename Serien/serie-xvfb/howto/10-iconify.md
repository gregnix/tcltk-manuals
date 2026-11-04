# 10 — iconify

```tcl
wm iconify .t
wm state .t    ;# iconic
```

Braucht einen Fenstermanager. Unter nacktem Xvfb bleibt das Fenster
`normal` (Tk wartet ~2 s): `serie::brauchtWM` meldet dann SKIP.

## Demo

```bash
wish howto/10-iconify.tcl
```
