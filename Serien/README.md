# Howto-Serien

*Deutsch. English: short howto series with runnable Tcl/Tk demos, in
German, that accompany the books in `Books/`.*

Kurze Howtos zu Tcl/Tk: je Howto eine Erklärung `NN-*.md` und eine
lauffähige Demo `NN-*.tcl`, die ihre eigenen Aussagen prüft und OK,
SKIP oder FAIL meldet.

| Serie | Inhalt | Buch |
|---|---|---|
| [`serie-linux`](serie-linux/) | Pfade, XDG, Umgebung, `exec`, Kodierung, `tcl_platform`, Dialoge | [Tcl/Tk unter Linux](../Books/de-markdown/Linux-TclTk-de/) |
| [`serie-xvfb`](serie-xvfb/) | GUI-Tests unter Xvfb: Fenstermanager, Fokus, Iconify, Grab | [Tcl/Tk unter Linux](../Books/de-markdown/Linux-TclTk-de/) |
| [`serie-xfce`](serie-xfce/) | Xfce aus Tcl: xfconf, DBus, Thunar, `exo-open`, `notify-send` | [Tcl/Tk unter Linux](../Books/de-markdown/Linux-TclTk-de/) |

## Starten

Eine ganze Serie:

```bash
tclsh serie-linux/run-all.tcl
xvfb-run -a tclsh serie-xvfb/run-all.tcl
```

Ein einzelnes Howto:

```bash
tclsh serie-linux/howto/02-pfade.tcl
```

`run-all.tcl` startet jedes Howto in einem eigenen Prozess, mit dem
`wish` derselben Fassung wie das aufrufende `tclsh`. Fehlt eine
Voraussetzung (ein Programm, eine Umgebungsvariable, Xfce), meldet das
Howto SKIP statt FAIL.

Jede Serie ist für sich lauffähig; sie braucht nur Tcl/Tk 8.6 oder 9.0
und keine Dateien außerhalb ihres Ordners. Geprüft unter Linux mit X11,
Tcl/Tk 8.6 und 9.0. `serie-xfce` braucht eine Xfce-Sitzung.

Erzeugte Dateien der Läufe landen in `serie-*/out/` und gehören nicht
ins Repository.

## Lizenz

Jede Serie hat ihre eigene `LICENSE`: Texte CC BY-SA 4.0, Tcl-Skripte
MIT. Siehe auch [LICENSES.md](../LICENSES.md).
