# 06 — notify-send

```tcl
auto_execok notify-send
# nicht in SERIES_AUTO (Popup):
# exec {*}[auto_execok notify-send] -t 1000 -e --app-name serie-xfce "Titel" "Text"
```

Daemon: `xfce4-notifyd` (hier unter
`/usr/lib/x86_64-linux-gnu/xfce4/notifyd/`, oft nicht in `PATH`).

## Demo

```bash
tclsh howto/06-notify-send.tcl
```
