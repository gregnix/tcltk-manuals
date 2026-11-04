# 04 — Dekoration messen

```tcl
wm geometry . 360x220+30+40
update
scan [wm geometry .] {%dx%d%[+-]%d%[+-]%d} gw gh sx gx sy gy
set dekoY [expr {[winfo rooty .] - $gy}]
```

`+X+Y` ist die Rahmenecke, `winfo rootx/rooty` die Clientfläche; die
Differenz ist der Rahmen. Gemessen mit Tcl/Tk 8.6.14 und 9.0.4:

- Xvfb ohne Fenstermanager: **immer 0** (kein Rahmen).
- Xvfb mit openbox: `dekoX` 1, `dekoY` 20.
- XFCE auf dem Rechner des Autors: `dekoY` 29.

Nie eine Zahl wie `80` fest verdrahten. `scan` mit `%[+-]` liest auch
die Form `-X-Y`; dann zählt X von rechts und die Rechnung oben gilt
nicht — vorher mit `+X+Y` setzen.

## Demo

```bash
wish howto/04-deko.tcl
```
