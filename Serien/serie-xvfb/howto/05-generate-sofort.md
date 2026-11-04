# 05 — generate ohne Fokus

```tcl
toplevel .t
bind .t <Escape> {incr ::n}
event generate .t <Escape>    ;# 0 — .t ist noch nicht gemappt, hat keinen Fokus
```

Eine erzeugte Taste geht an das Fenster mit dem Tastaturfokus. Ein
gerade erzeugtes Toplevel ist vor `update` nicht gemappt und hat ihn
nicht. Gemessen ohne Fenstermanager und mit openbox (Tcl/Tk 8.6.14 und
9.0.4) — das ist **kein** Xvfb-Unterschied.

## Demo

```bash
wish howto/05-generate-sofort.tcl
```
