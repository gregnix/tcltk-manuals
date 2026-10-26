---
CommandName: lassign
ManualSection: n
Version: 8.5
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - list(n)
 - lappend(n)
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
 - assign
 - element
 - list
 - multiple
 - set
 - variable
Copyright:
 - Copyright (c) 1992-1999 Karl Lehenbauer & Mark Diekhans
 - Copyright (c) 2004 Donal K. Fellows
---

# NAME

lassign - Weist Listenelemente Variablen zu

# ÜBERSICHT

::: {.synopsis} :::
[lassign]{.cmd} [list]{.arg} [varName]{.optdot} 
:::

# BESCHREIBUNG

Der Befehl behandelt *list* als Liste und weist aufeinanderfolgende Elemente der *varName*-Argumente in Reihenfolge zu. Gibt es mehr Variablen als Elemente, erhalten die übrigen Variablen eine leere Zeichenkette. Gibt es mehr Elemente als Variablen, wird eine Liste der nicht zugewiesenen Elemente zurückgegeben.

# BEISPIELE

Mehrfachzuweisung; zu wenige oder zu viele Elemente:

```
lassign {a b c} x y z       ;# Leerer Rückgabewert
puts $x                     ;# Gibt a aus
puts $y                     ;# Gibt b aus
puts $z                     ;# Gibt c aus

lassign {d e} x y z         ;# Leerer Rückgabewert
puts $x                     ;# Gibt d aus
puts $y                     ;# Gibt e aus
puts $z                     ;# Gibt "" aus

lassign {f g h i} x y       ;# Gibt "h i" zurück
puts $x                     ;# Gibt f aus
puts $y                     ;# Gibt g aus
```

Analog zu „shift“ in Shell-Sprachen:

```
set ::argv [lassign $::argv argumentToReadOff]
```
