# 11 — Panel und Session

```tcl
exec xfce4-panel --version
exec xfce4-session --version
puts $env(XDG_MENU_PREFIX)    ;# xfce-
```

Panel-Layout liegt in xfconf-Kanal `xfce4-panel` — Howtos lesen nicht
in die Nutzereinstellungen hinein.

## Demo

```bash
tclsh howto/11-panel-session.tcl
```
