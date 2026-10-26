---
CommandName: append
title: append
ManualSection: n
Version: unknown
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - concat(n)
 - lappend(n)
Keywords:
 - append
 - variable
Copyright:
 - Copyright (c) 1993 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

append - Hängt an eine Variable an

# Übersicht

::: {.synopsis} :::
[append]{.cmd} [varName]{.arg} [value value value]{.optdot}
:::

# Beschreibung

Hängt alle *value*-Argumente an den aktuellen Wert der Variable *varName* an. Existiert *varName* noch nicht, erhält sie einen Wert, der der Verkettung aller *value*-Argumente entspricht. [Verweist *varName* auf ein nicht existierendes Element eines Arrays mit gesetztem Standardwert, wird die Verkettung des Standardwerts und aller *value*-Argumente im Array-Element gespeichert.]{version="TIP508"} Das Ergebnis des Befehls ist der neue in *varName* gespeicherte Wert. Der Befehl eignet sich effizient zum schrittweisen Aufbau langer Variablen. Beispielsweise ist „**append a $b**“ deutlich effizienter als „**set a $a$b**“, wenn **$a** lang ist.

# Beispiel

Baut in einer Schleife schrittweise eine Zeichenkette kommagetrennter Zahlen auf:

```
set var 0
for {set i 1} {$i<=10} {incr i} {
    append var "," $i
}
puts $var
# Gibt aus: 0,1,2,3,4,5,6,7,8,9,10
```
