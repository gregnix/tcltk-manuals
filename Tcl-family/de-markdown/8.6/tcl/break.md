---
CommandName: break
title: break
ManualSection: n
Version: unknown
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - catch(n)
 - continue(n)
 - for(n)
 - foreach(n)
 - return(n)
 - while(n)
Keywords:
 - abort
 - break
 - loop
Copyright:
 - Copyright (c) 1993-1994 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

break - Bricht eine Schleife ab

# Übersicht

::: {.synopsis} :::
[break]{.cmd}
:::

# Beschreibung

Dieser Befehl wird typischerweise im Rumpf eines Schleifenbefehls wie [for], [foreach] oder [while] aufgerufen. Er liefert den Ergebniscode 3 ([TCL\_BREAK][catch]), wodurch eine Break-Ausnahme ausgelöst wird. Die Ausnahme bricht die aktuelle Skriptausführung bis zum innersten enthaltenden Schleifenbefehl ab, der seine Ausführung dann beendet und normal zurückkehrt. Break-Ausnahmen werden auch in einigen anderen Situationen behandelt, etwa beim Befehl [catch], in Tk-Event-Bindings und in den äußersten Skripten von Prozedurrümpfen.

# Beispiele

Gibt für jede Ganzzahl von 0 bis 5 eine Zeile aus:

```
for {set x 0} {$x<10} {incr x} {
    if {$x > 5} {
        break
    }
    puts "x is $x"
}
```


[catch]: catch.md
[for]: for.md
[foreach]: foreach.md
[while]: while.md
