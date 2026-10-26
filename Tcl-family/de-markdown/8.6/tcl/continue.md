---
CommandName: continue
ManualSection: n
Version: unknown
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - break(n)
 - for(n)
 - foreach(n)
 - return(n)
 - while(n)
Keywords:
 - continue
 - iteration
 - loop
Copyright:
 - Copyright (c) 1993-1994 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# NAME

continue - Springt zur nächsten Schleifeniteration

# ÜBERSICHT

::: {.synopsis} :::
[continue]{.cmd} 
:::

# BESCHREIBUNG

Dieser Befehl wird typischerweise im Rumpf eines Schleifenbefehls wie **for**, **foreach** oder **while** aufgerufen. Er liefert den Ergebniscode 4 (**TCL_CONTINUE**), wodurch eine Continue-Ausnahme ausgelöst wird. Die Ausnahme bricht die aktuelle Skriptausführung bis zum innersten enthaltenden Schleifenbefehl ab, der dann mit der nächsten Schleifeniteration fortfährt. Continue-Ausnahmen werden auch in einigen anderen Situationen behandelt, etwa beim Befehl **catch** und in den äußersten Skripten von Prozedurrümpfen.

# BEISPIELE

Gibt für jede Ganzzahl von 0 bis 10 *außer* 5 eine Zeile aus:

```
for {set x 0} {$x<10} {incr x} {
    if {$x == 5} {
        continue
    }
    puts "x is $x"
}
```
