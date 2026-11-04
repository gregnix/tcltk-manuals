# 05 — XDG-Benutzerordner

```tcl
exec {*}[auto_execok xdg-user-dir] DOCUMENTS
exec {*}[auto_execok xdg-user-dir] DESKTOP
exec {*}[auto_execok xdg-user-dir] DOWNLOAD
```

Namen sind **lokalisiert** (`Dokumente`, `Schreibtisch`, …). Nicht
`~/Documents` hart kodieren. Quelle: `~/.config/user-dirs.dirs`.
Das Programm `xdg-user-dir` kommt aus dem Paket `xdg-user-dirs`; fehlt
es, etwa in einem Container, überspringt das Howto.

## Demo

```bash
tclsh howto/05-xdg-user-dirs.tcl
```
