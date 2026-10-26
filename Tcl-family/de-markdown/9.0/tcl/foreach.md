---
CommandName: foreach
title: foreach
ManualSection: n
Version: unknown
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - for(n)
 - while(n)
 - break(n)
 - continue(n)
Keywords:
 - foreach
 - iteration
 - list
 - loop
Copyright:
 - Copyright (c) 1993 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

foreach - Iteriert über alle Elemente einer oder mehrerer Listen

# Übersicht

::: {.synopsis} :::
[foreach]{.cmd} [varname]{.arg} [list]{.arg} [body]{.arg}
[foreach]{.cmd} [varlist1]{.arg} [list1]{.arg} [varlist2 list2]{.optdot} [body]{.arg}
:::

# Beschreibung

**foreach** implementiert eine Schleife, in der die Schleifenvariable(n) Werte aus einer oder mehreren Listen annehmen. Im einfachsten Fall gibt es *varname* und *list*. Das Argument *body* ist ein Tcl-Skript. Für jedes Element von *list* (von vorne nach hinten) wird der Inhalt *varname* zugewiesen (wie mit [lindex]) und *body* ausgeführt.

Allgemein können mehrere Wertelisten (*list1*, *list2*, …) jeweils mit Variablenlisten (*varlist1*, *varlist2*, …) verknüpft sein. Pro Iteration erhalten die Variablen jeder *varlist* aufeinanderfolgende Werte aus der zugehörigen Liste; Werte werden der Reihe nach verbraucht, jeder genau einmal. Die Iterationsanzahl reicht aus, alle Wertelisten zu erschöpfen. Reicht eine Liste für ihre Variablen in einer Iteration nicht, werden fehlende Elemente leer gesetzt.

[break] und [continue] in *body* wirken wie bei [for]. **foreach** gibt eine leere Zeichenkette zurück.

# Beispiele

Jeden Wert mit Quadrat und Kubik ausgeben:

```
set values {1 3 5 7 2 4 6 8}	;# Ungerade zuerst
puts "Value\tSquare\tCube"	;# Neat-looking header
foreach x $values {	;# Now loop and print...
    puts " $x\t [expr {$x**2}]\t [expr {$x**3}]"
}
```

*i* und *j* iterieren über Paare einer Liste:

```
set x {}
foreach {i j} {a b c d e f} {
    lappend x $j $i
}
# The value of x is "b a d c f e"
# There are 3 iterations of the loop.
```

Parallele Iteration über zwei Listen:

```
set x {}
foreach i {a b c} j {d e f g} {
    lappend x $i $j
}
# The value of x is "a d b e c f {} g"
# There are 4 iterations of the loop.
```

Kombination beider Formen:

```
set x {}
foreach i {a b c} {j k} {d e f g} {
    lappend x $i $j $k
}
# The value of x is "a d e b f g c {} {}"
# There are 3 iterations of the loop.
```


[break]: break.md
[continue]: continue.md
[for]: for.md
[lindex]: lindex.md
