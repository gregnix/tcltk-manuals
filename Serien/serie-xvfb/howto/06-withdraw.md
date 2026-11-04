# 06 — withdraw

```tcl
wm withdraw .t
focus -force .
event generate .t <Escape>    ;# 0
```

Ein zurückgezogenes Fenster bekommt die Taste nicht. Nach `deiconify`
plus `focus -force` ja. Gemessen ohne WM und mit openbox.

## Demo

```bash
wish howto/06-withdraw.tcl
```
