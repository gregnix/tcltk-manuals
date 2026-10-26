---
CommandName: raise
ManualSection: n
Version: 3.3
TclPart: Tk
TclDescription: Tk Built-In Commands
Links:
 - lower(n)
Keywords:
 - obscure
 - raise
 - stacking order
Copyright:
 - Copyright (c) 1990 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# NAME

raise - Ändert die Position eines Fensters in der Stapelreihenfolge

# ÜBERSICHT

::: {.synopsis} :::
[raise]{.cmd} [window]{.arg} [aboveThis]{.optarg} 
:::

# BESCHREIBUNG

Ist das Argument *aboveThis* weggelassen, hebt **raise** *window* so an, dass es über allen Geschwister-Fenstern in der Stapelreihenfolge liegt (es wird von keinem Geschwister verdeckt und verdeckt überlappende Geschwister). Ist *aboveThis* angegeben, muss es der Pfadname eines Fensters sein, das Geschwister von *window* ist oder Nachkomme eines Geschwisters von *window*. Dann fügt **raise** *window* in die Stapelreihenfolge direkt über *aboveThis* ein (oder über den Vorfahren von *aboveThis*, der Geschwister von *window* ist); das kann *window* anheben oder absenken.

Alle **toplevel**-Fenster können zueinander umgestapelt werden, unabhängig von ihren Pfadnamen; der Window-Manager ist jedoch nicht verpflichtet, Umstapelungswünsche strikt zu erfüllen.

Unter macOS führt das Anheben eines iconisierten **toplevel**-Fensters zur De-Iconifizierung.

# BEISPIELE

Ein Button soll in einem Geschwister-Frame erscheinen, der nach dem Button erzeugt wurde — oft nötig, wenn Widgets zuerst erzeugt und dann layoutet werden:

```
button .b -text "Hi there!"
pack [frame .f -background blue]
pack [label .f.l1 -text "This is above"]
pack .b -in .f
pack [label .f.l2 -text "This is below"]
raise .b
```
