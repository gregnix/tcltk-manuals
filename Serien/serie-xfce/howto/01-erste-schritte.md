# 01 — Erste Schritte

```tcl
puts $env(XDG_CURRENT_DESKTOP)    ;# XFCE
exec xfce4-about --version        ;# … (Xfce 4.20)
```

Ohne XFCE-Sitzung (kein DBus) bricht `_bootstrap.tcl` ab.

## Demo

```bash
tclsh howto/01-erste-schritte.tcl
```
