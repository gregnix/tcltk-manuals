# 07 — Desktop-Dateien

```tcl
# Minimal:
# [Desktop Entry]
# Type=Application
# Name=…
# Exec=true
exec {*}[auto_execok desktop-file-validate] $path
```

Systemdateien unter `/usr/share/applications/` (z. B. `xfce4-about.desktop`
mit `OnlyShowIn=XFCE;`). Nicht in `SERIES_AUTO` installieren.

## Demo

```bash
tclsh howto/07-desktop-dateien.tcl
```
