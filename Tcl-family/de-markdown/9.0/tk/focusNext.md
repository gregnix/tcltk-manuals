---
CommandName: tk_focusNext
ManualSection: n
Version: 4.0
TclPart: Tk
TclDescription: Tk Built-In Commands
Keywords:
 - focus
 - keyboard traversal
 - top-level
Copyright:
 - Copyright (c) 1994 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# NAME

tk_focusNext, tk_focusPrev, tk_focusFollowsMouse - Hilfsprozeduren zur Verwaltung des Eingabefokus

# ÜBERSICHT

::: {.synopsis} :::
[tk_focusNext]{.cmd} [window]{.arg} 
[tk_focusPrev]{.cmd} [window]{.arg} 
[tk_focusFollowsMouse]{.cmd} 
:::

# BESCHREIBUNG

**tk_focusNext** ist eine Hilfsprozedur für die Tastatur-Navigation. Sie liefert das „nächste“ Fenster nach *window* in der Fokusreihenfolge. Die Fokusreihenfolge ergibt sich aus der Stapelreihenfolge der Fenster und der Fensterhierarchie. Unter Geschwistern entspricht die Fokusreihenfolge der Stapelreihenfolge; das unterste Fenster ist zuerst. Hat ein Fenster Kinder, wird zuerst das Fenster selbst besucht, dann rekursiv die Kinder, danach das nächste Geschwister. Andere **toplevel**-Fenster als *window* werden übersprungen — **tk_focusNext** liefert nie ein Fenster in einem anderen Toplevel als *window*.

Nach dem nächsten Fenster prüft **tk_focusNext** die Option **-takefocus**, ob es übersprungen werden soll. Ist das der Fall, geht **tk_focusNext** zum nächsten Fenster in der Fokusreihenfolge, bis ein Fenster gefunden wird, das den Fokus annimmt, oder wieder *window* erreicht ist.

**tk_focusPrev** entspricht **tk_focusNext**, liefert aber das Fenster unmittelbar vor *window* in der Fokusreihenfolge.

**tk_focusFollowsMouse** stellt die Anwendung auf ein implizites Fokusmodell um: Das Fenster unter dem Mauszeiger erhält den Fokus. Nach dem Aufruf gibt Tk dem Fenster automatisch den Eingabefokus, sobald die Maus hineinbewegt wird. Mit dem Befehl **focus** kann der Fokus auf ein anderes Fenster als das unter der Maus gesetzt werden; bewegt sich die Maus in ein neues Fenster, springt der Fokus dorthin.

Derzeit gibt es keine eingebaute Unterstützung, zur expliziten Fokussteuerung zurückzukehren; dazu muss ein Skript die von **tk_focusFollowsMouse** angelegten Bindings entfernen.
