# 13 — keine feste +80

```tcl
set wrong [expr {$gy + 80}]
set right [winfo rooty .]
```

`wrong == right` nur, wenn der Rahmen oben zufällig 80 px hat. Gemessen:
ohne WM 0, openbox 20, XFCE auf dem Rechner des Autors 29. Die Demo
misst den Rahmen und prüft, dass `+80` hier falsch wäre; hat der
Rahmen wirklich 80 px, meldet sie SKIP.

## Demo

```bash
wish howto/13-keine-80.tcl
```
