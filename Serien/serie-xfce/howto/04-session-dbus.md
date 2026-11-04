# 04 — Sitzung und DBus

```tcl
$env(DBUS_SESSION_BUS_ADDRESS)    ;# unix:path=/run/user/UID/bus
$env(XDG_SESSION_TYPE)            ;# x11
$env(XDG_RUNTIME_DIR)
```

xfconf spricht über diesen Bus. Fehlt der Socket, schlagen alle
`xfconf-query`-Aufrufe fehl — typisch in einer nackten Sandbox.

## Demo

```bash
tclsh howto/04-session-dbus.tcl
```
