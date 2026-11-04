# 11 — grab

```tcl
grab .t
grab current    ;# .t
```

Ein lokaler Grab ist Tk-intern und braucht keinen Fenstermanager —
gemessen unter Xvfb ohne WM und mit openbox. Das Fenster muss
sichtbar sein (`update` vorher).

## Demo

```bash
wish howto/11-grab.tcl
```
