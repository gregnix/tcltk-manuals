---
CommandName: lappend
ManualSection: n
Version: unknown
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - list(n)
 - lassign(n)
 - ledit(n)
 - lindex(n)
 - linsert(n)
 - llength(n)
 - lmap(n)
 - lpop(n)
 - lrange(n)
 - lremove(n)
 - lrepeat(n)
 - lreplace(n)
 - lreverse(n)
 - lsearch(n)
 - lseq(n)
 - lset(n)
 - lsort(n)
Keywords:
 - append
 - element
 - list
 - variable
Copyright:
 - Copyright (c) 1993 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
 - Copyright (c) 2001 Kevin B. Kenny <kennykb@acm.org>. All rights reserved.
---

# NAME

lappend - Hängt Listenelemente an eine Variable an

# ÜBERSICHT

::: {.synopsis} :::
[lappend]{.cmd} [varName]{.arg} [value value value]{.optdot} 
:::

# BESCHREIBUNG

Der Befehl behandelt die Variable *varName* als Liste und hängt jedes *value*-Argument als separates Element mit Leerzeichen dazwischen an. Existiert *varName* nicht, wird sie als Liste mit den *value*-Argumenten als Elementen angelegt.

::: {.info -version="TIP508"}
Verweist *varName* auf ein nicht existierendes Element eines Arrays mit gesetztem Standardwert, wird eine Liste aus dem Standardwert und allen angehängten *value*-Elementen im Array-Element gespeichert.
:::

**lappend** ähnelt **append**, hängt die *value*s aber als Listenelemente an, nicht als Rohtext. Der Befehl eignet sich relativ effizient zum Aufbau großer Listen. Beispielsweise ist „**lappend a \$b**“ deutlich effizienter als „**set a [concat \$a [list \$b]]**“, wenn **\$a** lang ist.

# BEISPIELE

**lappend** zum Aufbau einer Zahlenliste:

```
% set var 1
1
% lappend var 2
1 2
% lappend var 3 4 5
1 2 3 4 5
```
