# Serie: xfce

Howto-Serie zu **XFCE** aus Tcl — xfconf, DBus, Thunar, exo-open,
Benachrichtigungen. Linux-Builtin ohne Desktop: **`serie-linux`**.

## Voraussetzungen

- Linux mit laufender **XFCE-Sitzung** (Session-DBus)
- `xfconf-query`, Tcl 8.6+ (`tclsh`)

Ohne DBus (z. B. nackte Sandbox) bricht `_bootstrap.tcl` ab.

## Start

```bash
tclsh howto/01-erste-schritte.tcl
tclsh run-all.tcl
```

## Struktur

| Datei | Inhalt |
|--------|--------|
| `_bootstrap.tcl` | XFCE/DBus-Check, `xfconf` |
| `howto/00-referenz.md` | Kurzreferenz |
| `howto/NN-….md` / `.tcl` | Erklärung und Demo |
| `TUTORIAL.md` | Lernpfad |

Buch: *Tcl/Tk unter Linux* ([Markdown](../../Books/de-markdown/Linux-TclTk-de/), [PDF](../../Books/de-pdf/Linux-TclTk-de.pdf)).

## Gemessen (Xfce **4.20**, Debian, X11)

- `XDG_CURRENT_DESKTOP=XFCE`, `XDG_SESSION_TYPE=x11`, `XDG_MENU_PREFIX=xfce-`
- `xfconf-query -l` listet Kanäle (`xfwm4`, `thunar`, `xfce4-panel`, …)
- Schreiben nur in Testkanal `serie-xfce`, danach `-r -R`
- `xdg-open` / `exo-open` / `notify-send` nicht in `SERIES_AUTO` starten
- Ordner: `thunar.desktop`; Text: `org.xfce.mousepad.desktop`
