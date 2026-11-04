# 14 — tclsh und wish

```tcl
info nameofexecutable
package require Tk
winfo ismapped .        ;# 0 — auch unter wish
```

`wish` lädt Tk beim Start, `tclsh` erst mit `package require Tk`.
Danach verhalten sich beide gleich: `.` existiert, ist aber beim Lauf
des Skripts **noch nicht gemappt** — erst beim nächsten `update` bzw.
wenn die Ereignisschleife läuft. Gemessen unter wish und unter tclsh
mit Tk (Tcl/Tk 8.6.14 und 9.0.4). Tastentests deshalb: `update`, dann
`focus -force`.

## Demo

```bash
wish howto/14-tclsh-wish.tcl
```
