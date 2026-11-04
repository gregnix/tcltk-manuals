# 02 — xfconf lesen

```tcl
exec xfconf-query -l                      ;# Kanaele
exec xfconf-query -c xfwm4 -l             ;# Eigenschaften
exec xfconf-query -c xfwm4 -p /general/theme
```

Kanäle u. a. `xfwm4`, `thunar`, `xfce4-panel`, `xfce4-session`, `xsettings`.
Werte nicht hart auf „Default“ prüfen — Theme ist Nutzersache.

## Demo

```bash
tclsh howto/02-xfconf-lesen.tcl
```
