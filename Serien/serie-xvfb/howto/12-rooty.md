# 12 — Dialoglage aus rooty

```tcl
set y [winfo rooty .]
wm geometry $dlg +${x}+${y}
```

Nicht `gy + 80` (Howto 13). `+x+y` setzt die **Rahmenecke** des
Dialogs: sein Rahmen beginnt an der Oberkante der Clientfläche des
Hauptfensters, seine eigene Clientfläche liegt um die eigene
Titelleiste tiefer. Gemessen: ohne WM `winfo rooty .dlg` = `y`, unter
openbox `y + 20`. Siehe Serie wm, Howto 13; Serie tk-test.

## Demo

```bash
wish howto/12-rooty.tcl
```
