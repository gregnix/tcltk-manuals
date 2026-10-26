---
CommandName: lrepeat
title: lrepeat
ManualSection: n
Version: 8.5
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - list(n)
 - lappend(n)
 - lassign(n)
 - ledit(n)
 - lindex(n)
 - linsert(n)
 - llength(n)
 - lmap(n)
 - lpop(n)
 - lrange(n)
 - lremove(n)
 - lreplace(n)
 - lreverse(n)
 - lsearch(n)
 - lseq(n)
 - lset(n)
 - lsort(n)
Keywords:
 - element
 - index
 - list
Copyright:
 - Copyright (c) 2003 Simon Geard. All rights reserved.
---

# Name

lrepeat - Erzeugt eine Liste durch Wiederholen von Elementen

# Übersicht

::: {.synopsis} :::
[lrepeat]{.cmd} [count]{.arg} [element]{.optdot}
:::

# Beschreibung

Der Befehl **lrepeat** erzeugt eine Liste der Größe *count × Anzahl der Elemente*, indem die Elementfolge *element ...* *count*-mal wiederholt wird. *count* muss eine nicht-negative Ganzzahl sein; *element* kann ein beliebiger Tcl-Wert sein.

Beachten Sie, dass **lrepeat 1 element ...** identisch zu **list element ...** ist.

# Beispiele

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
