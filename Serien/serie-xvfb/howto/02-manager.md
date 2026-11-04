# 02 — winfo manager

```tcl
winfo manager .     ;# immer: wm
```

Für ein Toplevel liefert `winfo manager` immer `wm` — mit und ohne
Fenstermanager, gemessen unter Xvfb ohne WM und mit openbox (Tcl/Tk
8.6.14 und 9.0.4). Es taugt also **nicht**, um einen Fenstermanager zu
erkennen. Das leisten `wm frame` gegen `winfo id` und eine
Iconify-Probe: Howto 09.

## Demo

```bash
wish howto/02-manager.tcl
```
