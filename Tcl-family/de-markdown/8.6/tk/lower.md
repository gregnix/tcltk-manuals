---
CommandName: lower
ManualSection: n
Version: 3.3
TclPart: Tk
TclDescription: Tk Built-In Commands
Links:
 - raise
Keywords:
 - lower
 - obscure
 - stacking order
Copyright:
 - Copyright (c) 1990 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# NAME

lower - Ändert die Position eines Fensters in der Stapelreihenfolge

# ÜBERSICHT

::: {.synopsis} :::
[lower]{.cmd} [window]{.arg} [belowThis]{.optarg} 
:::

# BESCHREIBUNG

Ist das Argument *belowThis* weggelassen, senkt **lower** *window* so ab, dass es unter allen Geschwister-Fenstern in der Stapelreihenfolge liegt (es wird von überlappenden Geschwistern verdeckt und verdeckt keine Geschwister). Ist *belowThis* angegeben, muss es der Pfadname eines Fensters sein, das Geschwister von *window* ist oder Nachkomme eines Geschwisters von *window*. Dann fügt **lower** *window* in die Stapelreihenfolge direkt unter *belowThis* ein (oder unter den Vorfahren von *belowThis*, der Geschwister von *window* ist); das kann *window* anheben oder absenken.

Alle **toplevel**-Fenster können zueinander umgestapelt werden, unabhängig von ihren Pfadnamen; der Window-Manager ist jedoch nicht verpflichtet, Umstapelungswünsche strikt zu erfüllen.
