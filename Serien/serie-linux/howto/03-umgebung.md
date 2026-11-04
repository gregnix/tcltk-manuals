# 03 — Umgebung

```tcl
$env(HOME) $env(USER) $env(SHELL) $env(PATH)
$env(LANG) $env(DISPLAY)          ;# X11, hier :0.0
```

`$env(USER)` ist geerbt. `$tcl_platform(user)` ist der Nutzer des
Prozesses — in Sandbox/sudo können sie **auseinanderlaufen**.

`HOSTNAME` und `TMPDIR` fehlen hier oft; Rechnername: `[info hostname]`,
Temp: `/tmp`.

## Demo

```bash
tclsh howto/03-umgebung.tcl
```
