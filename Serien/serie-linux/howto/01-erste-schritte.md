# 01 — Erste Schritte

```tcl
puts $tcl_platform(platform)   ;# unix
puts $tcl_platform(os)         ;# Linux
puts [info patchlevel]         ;# 8.6.x
```

Diese Serie setzt Linux voraus. Unter Windows bricht `_bootstrap.tcl` ab.

## Demo

```bash
tclsh howto/01-erste-schritte.tcl
```
