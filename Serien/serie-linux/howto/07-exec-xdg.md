# 07 — exec und xdg-open

```tcl
auto_execok xdg-open
exec uname -s                 ;# Linux
# nicht in SERIES_AUTO:
# exec {*}[auto_execok xdg-open] https://www.tcl.tk &
```

`xdg-open` ist das Linux-Gegenstück zu `start` unter Windows. In Demos
nur `auto_execok` prüfen, nicht wirklich öffnen.

## Demo

```bash
tclsh howto/07-exec-xdg.tcl
```
