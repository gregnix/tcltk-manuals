---
CommandName: proc
title: proc
ManualSection: n
Version: unknown
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - info(n)
 - unknown(n)
Keywords:
 - argument
 - procedure
Copyright:
 - Copyright (c) 1993 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

proc - Erzeugt eine Tcl-Prozedur

# Übersicht

::: {.synopsis} :::
[proc]{.cmd} [name]{.arg} [args]{.arg} [body]{.arg}
:::

# Beschreibung

Der Befehl **proc** erzeugt eine neue Tcl-Prozedur *name* und ersetzt einen vorhandenen Befehl oder eine Prozedur gleichen Namens. Bei jedem Aufruf führt der Interpreter *body* aus. Normalerweise ist *name* unqualifiziert; die Prozedur entsteht im aktuellen Namespace. Enthält *name* Namespace-Qualifizierer, entsteht sie im angegebenen Namespace. *args* listet die formalen Argumente (möglicherweise leer). Jedes Element ist eine Liste mit einem oder zwei Feldern: nur Name, oder Name und Standardwert. Argumente mit Standardwert, denen nicht-standardisierte Argumente folgen, werden faktisch erforderlich — es müssen genug tatsächliche Argumente geliefert werden, um alle formalen Argumente bis einschließlich des letzten erforderlichen abzudecken. Portable Skripte sollten alle optionalen Argumente nach allen erforderlichen platzieren.

Beim Aufruf von *name* entsteht pro formales Argument eine lokale Variable mit dem Wert des Aufrufarguments oder dem Standardwert. Zuweisung strikt in Reihenfolge; optionale Argumente können weggelassen werden, aber es dürfen weder zu wenige noch zu viele tatsächliche Argumente übergeben werden.

Sonderfall variable Argumentanzahl: heißt das letzte formale Argument **args**, darf der Aufruf mehr tatsächliche als formale Argumente haben; ab dem **args** zugewiesenen Argument werden alle restlichen tatsächlichen Argumente zu einer Liste kombiniert (wie mit [list]) und **args** zugewiesen.

Während *body* läuft, beziehen sich Variablennamen auf lokale Variablen (automatisch erzeugt und beim Verlassen der Prozedur gelöscht); pro Argument eine lokale Variable. Andere Variablen nur über [global], [variable], [upvar] oder [namespace upvar][namespace]. Der aktuelle Namespace während *body* ist der des Prozedurnamens (Erstellungs-Namespace, sofern [rename] nicht geändert hat).

**proc** gibt eine leere Zeichenkette zurück. Der Rückgabewert der Prozedur ist der Wert eines [return]-Befehls; ohne explizites [return] der Wert des letzten Befehls in *body*. Tritt in *body* ein Fehler auf, gibt die Prozedur denselben Fehler zurück.

# Beispiele

Summe und Produkt zweier Argumente ausgeben; explizites Ergebnis **OK**:

```
proc printSumProduct {x y} {
    set sum [expr {$x + $y}]
    set prod [expr {$x * $y}]
    puts "sum is $sum, product is $prod"
    return "OK"
}
```

Beliebig viele Argumente ausgeben:

```
proc printArguments args {
    foreach arg $args {
        puts $arg
    }
}
```

Variable mit dem Faktor multiplizieren (Standard 2), ähnlich [incr]:

```
proc mult {varName {multiplier 2}} {
    upvar 1 $varName var
    set var [expr {$var * $multiplier}]
}
```


[global]: global.md
[incr]: incr.md
[list]: list.md
[namespace]: namespace.md
[rename]: rename.md
[return]: return.md
[upvar]: upvar.md
[variable]: variable.md
