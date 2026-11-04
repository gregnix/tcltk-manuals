# Referenz: XFCE aus Tcl (Kurz)

Nur bei `XDG_CURRENT_DESKTOP` ≈ `XFCE` und erreichbarem Session-DBus.

## Erkennung

```tcl
$env(XDG_CURRENT_DESKTOP)     ;# XFCE
$env(XDG_SESSION_TYPE)        ;# x11 (hier)
$env(XDG_MENU_PREFIX)         ;# xfce-
$env(DBUS_SESSION_BUS_ADDRESS)
```

## xfconf

```tcl
exec xfconf-query -l
exec xfconf-query -c xfwm4 -p /general/workspace_count
exec xfconf-query -c xfwm4 -p /general/theme
# schreiben nur Testkanal, danach reset:
exec xfconf-query -c serie-xfce -p /howto/demo -n -t string -s ok
exec xfconf-query -c serie-xfce -p /howto -r -R
```

Ohne Sitzung: `Verbindung ist gescheitert`.

## Apps (nicht in SERIES_AUTO starten)

| Werkzeug | Rolle |
|----------|--------|
| `xdg-open` / `exo-open` | Datei/URL/bevorzugte App |
| `thunar` | Dateimanager (`inode/directory`) |
| `xfce4-terminal` | Terminal |
| `notify-send` | xfce4-notifyd |
| `xfce4-panel` / `xfwm4` / `xfce4-session` | Shell der Sitzung |

## Weiter

Linux-Builtin: **`serie-linux`** · Windows-Desktop-API: **`serie-twapi`**
