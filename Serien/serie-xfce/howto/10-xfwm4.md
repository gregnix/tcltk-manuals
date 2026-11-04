# 10 — xfwm4

```tcl
exec xfwm4 --version
exec xfconf-query -c xfwm4 -p /general/workspace_count
exec xfconf-query -c xfwm4 -p /general/theme
```

Fenstermanager der Sitzung. Workspace-Zahl und Theme sind Nutzersache;
Howtos prüfen nur Typ/Länge.

## Demo

```bash
tclsh howto/10-xfwm4.tcl
```
