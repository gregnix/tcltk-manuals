# 07 — focus -force

```tcl
focus -force .t
update
event generate .t <Escape>
```

Der Test stellt den Fokus her. Ohne Fenstermanager tut es sonst
niemand: `focus` bleibt leer, die Taste kommt nicht an. Mit
Fenstermanager (openbox) hat `.` nach `update` meist schon den Fokus —
der Test wartet nicht darauf.

Eine erzeugte Taste geht an das **Fokus-Widget**, nicht an das Fenster,
das man `event generate` nennt: mit Fokus auf `.e1` landet
`event generate .e2 <Key-x>` bei `.e1`. Gemessen mit Tcl/Tk 8.6.14 und
9.0.4, ohne WM und mit openbox.

## Demo

```bash
wish howto/07-focus-force.tcl
```
