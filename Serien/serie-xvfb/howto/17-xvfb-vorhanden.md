# 17 — Xvfb vorhanden

```tcl
auto_execok Xvfb
auto_execok xvfb-run
```

Fehlt das Paket: **SKIP**, nicht FAIL. Debian: `apt install xvfb`.
Howtos 18–20 starten mit `serie::aufEigenemXvfb` einen eigenen,
frischen Xvfb und messen dort.

## Demo

```bash
wish howto/17-xvfb-vorhanden.tcl
```
