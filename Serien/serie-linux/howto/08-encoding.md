# 08 — Encoding

`encoding system` folgt `LANG` / `LC_ALL`, nicht automatisch UTF-8:

```
LANG=C         encoding system = iso8859-1
LANG=C.UTF-8   encoding system = utf-8
```

**Dateien** immer mit `-encoding utf-8` öffnen — unabhängig von `LANG`.

Tcl 8.6 liest **Skripte** als `encoding system`. Eine UTF-8-`app.tcl` mit
Umlauten wird unter `LANG=C` zu Mojibake (`Rückgängig` → `RÃ¼ckgÃ¤ngig`).
Tcl 9 liest Skripte als UTF-8; `open` bleibt bei `encoding system`.

Wache am Dateianfang (Datei ist UTF-8). Unter 8.6 mit Latin-1/cp1252 ist
`ü` zwei Zeichen, dann neu einlesen:

```tcl
if {[string length "ü"] != 1} {
    source -encoding utf-8 [file normalize [info script]]
    return
}
```

Windows: **`serie-mswindows`** Howto 08 (dort `encoding system` oft cp1252).

```tcl
puts [encoding system]
set fh [open $path w]
fconfigure $fh -encoding utf-8
puts $fh "Grüße"
close $fh
```

## Demo

```bash
tclsh howto/08-encoding.tcl
LANG=C tclsh howto/08-encoding.tcl
```
