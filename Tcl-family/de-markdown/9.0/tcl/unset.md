---
CommandName: unset
ManualSection: n
Version: 8.4
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - set(n)
 - trace(n)
 - upvar(n)
Keywords:
 - remove
 - variable
Copyright:
 - Copyright (c) 1993 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
 - Copyright (c) 2000 Ajuba Solutions.
---

# NAME

unset - Löscht Variablen

# ÜBERSICHT

::: {.synopsis} :::
[unset]{.cmd} [-nocomplain]{.optlit} [--]{.optlit} [name name name]{.optdot} 
:::

# BESCHREIBUNG

Dieser Befehl entfernt eine oder mehrere Variablen. Jedes *name* ist ein Variablenname, angegeben auf eine der für den Befehl **set** zulässigen Arten. Verweist *name* auf ein Array-Element, wird nur dieses Element entfernt, ohne den Rest des Arrays zu beeinflussen. Besteht *name* aus einem Array-Namen ohne indexierende Klammern, wird das gesamte Array gelöscht. Der Befehl **unset** gibt als Ergebnis eine leere Zeichenkette zurück. Wird **-nocomplain** als erstes Argument angegeben, werden mögliche Fehler unterdrückt. Die Option darf nicht abgekürzt werden, um sie von möglichen Variablennamen zu unterscheiden. Die Option **--** markiert das Ende der Optionen und sollte verwendet werden, wenn eine Variable denselben Namen wie eine der Optionen trägt. Tritt beim Löschen ein Fehler auf, werden alle Variablen nach der fehlerauslösenden nicht gelöscht. Ein Fehler kann auftreten, wenn die benannte Variable nicht existiert, der Name auf ein Array-Element verweist, die Variable aber skalar ist, oder der Name auf eine Variable in einem nicht existierenden Namespace verweist.

# BEISPIELE

Erzeugt ein Array mit einer Abbildung von Zahlen auf ihre Quadrate und entfernt die Array-Elemente für Nicht-Primzahlen:

```
array set squares {
    1 1    6 36
    2 4    7 49
    3 9    8 64
    4 16   9 81
    5 25  10 100
}

puts "The squares are:"
parray squares

unset squares(1) squares(4) squares(6)
unset squares(8) squares(9) squares(10)

puts "The prime squares are:"
parray squares
```
