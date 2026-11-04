# 05 — xdg-open und exo-open

```tcl
auto_execok xdg-open
auto_execok exo-open
# nicht in SERIES_AUTO:
# exec {*}[auto_execok exo-open] --launch FileManager
```

`exo-open --launch TYP` startet die in XFCE bevorzugte Anwendung
(FileManager, TerminalEmulator, WebBrowser, …). Howtos prüfen nur
`auto_execok`.

## Demo

```bash
tclsh howto/05-xdg-open-exo.tcl
```
