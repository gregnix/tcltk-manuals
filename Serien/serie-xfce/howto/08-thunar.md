# 08 — Thunar

```tcl
exec thunar --version
exec {*}[auto_execok xdg-mime] query default inode/directory
# → thunar.desktop
```

Standard-Dateimanager hier: Thunar 4.20. In `SERIES_AUTO` kein Fenster
öffnen.

## Demo

```bash
tclsh howto/08-thunar.tcl
```
