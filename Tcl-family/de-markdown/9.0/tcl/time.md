---
CommandName: time
ManualSection: n
Version: unknown
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - clock(n)
Keywords:
 - script
 - time
Copyright:
 - Copyright (c) 1993 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# NAME

time - Misst die Ausführungszeit eines Skripts

# ÜBERSICHT

::: {.synopsis} :::
[time]{.cmd} [script]{.arg} [count]{.optarg} 
:::

# BESCHREIBUNG

Der Befehl wertet *script* *count*-mal aus (oder einmal, wenn *count* fehlt) und gibt eine Zeichenkette der Form

```
503.2 microseconds per iteration
```

zurück — die durchschnittliche Dauer pro Durchlauf in Mikrosekunden. Gemessen wird verstrichene Zeit, nicht CPU-Zeit.

# BEISPIELE

Schätzt, wie lange eine einfache **for**-Schleife bis 1000 braucht:

```
time {
    for {set i 0} {$i<1000} {incr i} {
        # leerer Rumpf
    }
}
```
