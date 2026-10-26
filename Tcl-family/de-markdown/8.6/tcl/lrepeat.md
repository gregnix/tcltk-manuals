---
CommandName: lrepeat
ManualSection: n
Version: 8.5
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - list(n)
 - lappend(n)
 - linsert(n)
 - llength(n)
 - lset(n)
Keywords:
 - element
 - index
 - list
Copyright:
 - Copyright (c) 2003 Simon Geard. All rights reserved.
---

# NAME

lrepeat - Erzeugt eine Liste durch Wiederholen von Elementen

# ÜBERSICHT

::: {.synopsis} :::
[lrepeat]{.cmd} [count]{.arg} [element]{.optdot} 
:::

# BESCHREIBUNG

Der Befehl **lrepeat** erzeugt eine Liste der Größe *count × Anzahl der Elemente*, indem die Elementfolge *element ...* *count*-mal wiederholt wird. *count* muss eine nicht-negative Ganzzahl sein; *element* kann ein beliebiger Tcl-Wert sein.

Beachten Sie, dass **lrepeat 1 element ...** identisch zu **list element ...** ist.

# BEISPIELE

```
lrepeat 3 a
      → a a a
lrepeat 3 [lrepeat 3 0]
      → {0 0 0} {0 0 0} {0 0 0}
lrepeat 3 a b c
      → a b c a b c a b c
lrepeat 3 [lrepeat 2 a] b c
      → {a a} b c {a a} b c {a a} b c
```
