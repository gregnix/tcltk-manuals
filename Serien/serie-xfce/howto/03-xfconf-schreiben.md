# 03 — xfconf schreiben

```tcl
exec xfconf-query -c serie-xfce -p /howto/demo -n -t string -s ok
exec xfconf-query -c serie-xfce -p /howto/demo
exec xfconf-query -c serie-xfce -p /howto -r -R
```

Nur den eigenen Testkanal anfassen. Nutzereinstellungen (`xfwm4`, Panel)
nicht in Howtos schreiben.

## Demo

```bash
tclsh howto/03-xfconf-schreiben.tcl
```
