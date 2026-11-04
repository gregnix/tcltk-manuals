# 11 — Native Dialoge und Clipboard

```tcl
package require Tk
tk_getOpenFile
tk_chooseDirectory
clipboard append "text"
clipboard get                 ;# CLIPBOARD
# selection get -selection PRIMARY   ;# X11-Mausauswahl, oft leer
```

Dialoge nicht in `SERIES_AUTO` öffnen. CLIPBOARD ist das App-Clipboard;
PRIMARY existiert erst nach einer X11-Selektion.

## Demo

```bash
wish howto/11-native-dialoge.tcl
```
