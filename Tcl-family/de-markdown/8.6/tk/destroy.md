---
CommandName: destroy
title: destroy
ManualSection: n
Version: unknown
TclPart: Tk
TclDescription: Tk Built-In Commands
Keywords:
 - application
 - destroy
 - window
Copyright:
 - Copyright (c) 1990 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

destroy - Zerstört ein oder mehrere Fenster

# Übersicht

::: {.synopsis} :::
[destroy]{.cmd} [window window]{.optdot}
:::

# Beschreibung

Dieser Befehl löscht die durch die *window*-Argumente angegebenen Fenster sowie alle ihre Nachkommen. Wird das Fenster „.“ gelöscht, werden alle Fenster zerstört und die Anwendung beendet (normalerweise) sich. Die Fenster werden in der angegebenen Reihenfolge zerstört; tritt beim Zerstören eines Fensters ein Fehler auf, bricht der Befehl ab, ohne die verbleibenden Fenster zu zerstören. Existiert *window* nicht, wird kein Fehler zurückgegeben.

# Beispiele

Zerstört alle Checkbuttons, die direkte Kinder des angegebenen Widgets sind:

```
proc killCheckbuttonChildren {parent} {
   foreach w [winfo children $parent] {
      if {[winfo class $w] eq "Checkbutton"} {
         destroy $w
      }
   }
}
```
