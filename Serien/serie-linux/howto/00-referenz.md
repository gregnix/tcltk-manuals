# Referenz: Tcl unter Linux (Kurz)

Nur `$tcl_platform(platform) eq "unix"` und `$tcl_platform(os) eq "Linux"`.

## Pfade & Config

```tcl
file join $env(HOME) .config MeineApp
# Tilde: unter 8.6 HOME, unter 9 ein Dateiname; $env(HOME) nehmen
# XDG: $env(XDG_CONFIG_HOME) oder ~/.config
```

| Variable | Typisch hier |
|----------|----------------|
| `HOME` | `/home/name` |
| `XDG_CONFIG_HOME` | `~/.config` (kann fehlen → Default) |
| `XDG_DATA_HOME` | oft **unset** → `~/.local/share` |
| `XDG_CACHE_HOME` | `~/.cache` |
| `XDG_RUNTIME_DIR` | `/run/user/UID` |
| `TMPDIR` | oft **unset** → `/tmp` |

**Fallen:** `$env(HOME)` auf Linux gesetzt (Windows: oft leer).  
`tcl_platform(user)` ist die effective uid des Interpreters, `$env(USER)`
kann davon abweichen.

## exec

```tcl
auto_execok xdg-open
exec uname -s          ;# Linux
# xdg-open nicht in SERIES_AUTO — oeffnet Dateimanager/Browser
```

## Encoding & Clipboard

```tcl
encoding system        ;# folgt LANG (C: iso8859-1, C.UTF-8: utf-8)
fconfigure $fh -encoding utf-8

# Tcl 8.6 liest Skripte als encoding system. UTF-8-app.tcl:
if {[string length "ü"] != 1} {
    source -encoding utf-8 [file normalize [info script]]
    return
}

clipboard append "text"     ;# Tk CLIPBOARD
# PRIMARY (X11-Mausauswahl) kann fehlen
```

## Weiter

Desktop XFCE: **`serie-xfce`** · Windows: **`serie-mswindows`**
