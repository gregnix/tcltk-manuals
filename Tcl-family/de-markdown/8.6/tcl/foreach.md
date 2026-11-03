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

Der Befehl **foreach** implementiert eine Schleife, in der die Schleifenvariable(n) Werte aus einer oder mehreren Listen annehmen. Im einfachsten Fall gibt es eine Schleifenvariable *varname* und eine Liste *list*, die eine Liste von Werten ist, die *varname* zugewiesen werden. Das Argument *body* ist ein Tcl-Skript. Für jedes Element von *list* (der Reihe nach vom ersten bis zum letzten) weist **foreach** den Inhalt des Elements *varname* zu, so als wäre das Element mit dem Befehl [lindex] entnommen worden. Anschließend ruft es den Tcl-Interpreter auf, um *body* auszuführen.

Im allgemeinen Fall kann es mehr als eine Werteliste geben (z. B. *list1* und *list2*), und jeder Werteliste kann eine Liste von Schleifenvariablen zugeordnet sein (z. B. *varlist1* und *varlist2*). Bei jedem Schleifendurchlauf werden den Variablen jeder *varlist* aufeinanderfolgende Werte aus der zugehörigen *list* zugewiesen. Die Werte in jeder *list* werden der Reihe nach vom ersten bis zum letzten verwendet, und jeder Wert wird genau einmal verwendet. Die Gesamtzahl der Schleifendurchläufe ist so groß, dass alle Werte aus allen Wertelisten verbraucht werden. Enthält eine Werteliste in einem Durchlauf nicht genügend Elemente für jede ihrer Schleifenvariablen, werden für die fehlenden Elemente leere Werte verwendet.

Die Anweisungen [break] und [continue] können innerhalb von *body* aufgerufen werden und haben dieselbe Wirkung wie beim Befehl [for]. **foreach** gibt eine leere Zeichenkette zurück.

# Beispiele

Diese Schleife gibt jeden Wert einer Liste zusammen mit seinem Quadrat und seiner dritten Potenz aus:

```
set values {1 3 5 7 2 4 6 8}	;# Ungerade zuerst
puts "Value\tSquare\tCube"	;# Neat-looking header
foreach x $values {	;# Now loop and print...
    puts " $x\t [expr {$x**2}]\t [expr {$x**3}]"
}
```

Die folgende Schleife verwendet i und j als Schleifenvariablen, um über Paare von Elementen einer einzelnen Liste zu iterieren.

```
set x {}
foreach {i j} {a b c d e f} {
    lappend x $j $i
}
# The value of x is "b a d c f e"
# There are 3 iterations of the loop.
```

Die nächste Schleife verwendet i und j, um parallel über zwei Listen zu iterieren.

```
set x {}
foreach i {a b c} j {d e f g} {
    lappend x $i $j
}
# The value of x is "a d b e c f {} g"
# There are 4 iterations of the loop.
```

Im folgenden Beispiel werden beide Formen kombiniert.

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
