# 09 — Dateisystem

```tcl
file volumes                          ;# /
file attributes $f                    ;# -owner -group -permissions
file attributes $f -permissions 00644
```

Unix-Attribute, keine Laufwerksbuchstaben. `/tmp` ist oft sticky (`1777`).

## Demo

```bash
tclsh howto/09-dateisystem.tcl
```
