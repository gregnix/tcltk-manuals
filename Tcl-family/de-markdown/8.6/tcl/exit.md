---
CommandName: exit
ManualSection: n
Version: unknown
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - exec(n)
Keywords:
 - abort
 - exit
 - process
Copyright:
 - Copyright (c) 1993 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# NAME

exit - Beendet die Anwendung

# ÜBERSICHT

::: {.synopsis} :::
[exit]{.cmd} [returnCode]{.optarg} 
:::

# BESCHREIBUNG

Beendet den Prozess und übergibt *returnCode* dem System als Exit-Status. Ist *returnCode* nicht angegeben, ist der Standardwert 0.

# BEISPIELE

Da der aufrufende Prozess Exit-Codes ungleich null meist als Fehler interpretiert, ist **exit** wichtig, um schwerwiegende Probleme zu signalisieren. Dieses Codefragment eignet sich in Skripten als allgemeine Fehlerfalle:

```
proc main {} {
    # ... den eigentlichen Hauptcode hier einfügen ...
}

if {[catch {main} msg options]} {
    puts stderr "unexpected script error: $msg"
    if {[info exists env(DEBUG)]} {
        puts stderr "---- BEGIN TRACE ----"
        puts stderr [dict get $options -errorinfo]
        puts stderr "---- END TRACE ----"
    }

    # Code 1 für „erwartete“ Fehler-Exits reservieren...
    exit 2
}
```
