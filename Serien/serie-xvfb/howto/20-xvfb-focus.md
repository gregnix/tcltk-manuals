# 20 — Xvfb und focus

Auf einem frischen Xvfb ohne Fenstermanager vergibt niemand den Fokus:
nach `update` ist `focus` leer, eine erzeugte Taste kommt nicht an.
Nach `focus -force .` kommt sie an. Die Demo misst das auf einem
**eigenen** Xvfb (`serie::aufEigenemXvfb`). SKIP, wenn `xvfb-run` fehlt.
Gemessen mit Tcl/Tk 8.6.14 und 9.0.4.

## Demo

```bash
wish howto/20-xvfb-focus.tcl
```
