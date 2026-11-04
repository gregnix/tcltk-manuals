# 04 — Konfigurationsordner (XDG)

```tcl
# Default wenn unset:
file join $env(HOME) .config          ;# XDG_CONFIG_HOME
file join $env(HOME) .local share     ;# XDG_DATA_HOME
file join $env(HOME) .cache           ;# XDG_CACHE_HOME
```

Apps gehören nach `…/config/<AppName>/`, nicht nach `$HOME` selbst.
`XDG_DATA_HOME` ist hier oft **unset**. Die Demo schreibt nach `out/`,
nicht nach `~/.config`.

## Demo

```bash
tclsh howto/04-konfigordner.tcl
```
