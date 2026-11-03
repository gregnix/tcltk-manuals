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

Der Befehl **proc** erzeugt eine neue Tcl-Prozedur mit dem Namen *name* und ersetzt dabei einen eventuell vorhandenen Befehl oder eine Prozedur dieses Namens. Bei jedem Aufruf des neuen Befehls führt der Tcl-Interpreter den Inhalt von *body* aus. Normalerweise ist *name* unqualifiziert (enthält also keine Namen umgebender Namespaces), und die neue Prozedur wird im aktuellen Namespace erzeugt. Enthält *name* Namespace-Qualifizierer, wird die Prozedur im angegebenen Namespace erzeugt. *args* legt die formalen Argumente der Prozedur fest. Es besteht aus einer, möglicherweise leeren, Liste, deren Elemente jeweils ein Argument festlegen. Jede Argumentangabe ist ebenfalls eine Liste mit einem oder zwei Feldern. Enthält die Angabe nur ein Feld, ist es der Name des Arguments. Enthält sie zwei Felder, ist das erste der Name des Arguments und das zweite sein Vorgabewert. Argumente mit Vorgabewert, auf die Argumente ohne Vorgabewert folgen, werden zu erforderlichen Argumenten. Es müssen so viele tatsächliche Argumente übergeben werden, dass alle Argumente bis einschließlich des letzten erforderlichen formalen Arguments abgedeckt sind.

Wenn *name* aufgerufen wird, wird für jedes formale Argument der Prozedur eine lokale Variable erzeugt. Ihr Wert ist der Wert des entsprechenden Arguments im aufrufenden Befehl oder der Vorgabewert des Arguments. Tatsächliche Argumente werden den formalen Argumenten streng der Reihe nach zugewiesen. Argumente mit Vorgabewert müssen beim Aufruf einer Prozedur nicht angegeben werden. Es muss jedoch genügend tatsächliche Argumente für alle formalen Argumente ohne Vorgabewert geben, und es darf keine überzähligen tatsächlichen Argumente geben. Argumente mit Vorgabewert, auf die Argumente ohne Vorgabewert folgen, werden de facto zu erforderlichen Argumenten; dies kann sich allerdings in einer künftigen Version von Tcl ändern. Portierbarer Code sollte sicherstellen, dass alle optionalen Argumente nach allen erforderlichen Argumenten stehen.

Es gibt einen Sonderfall, der Prozeduren mit variabler Argumentanzahl ermöglicht. Hat das letzte formale Argument den Namen „**args**“, darf ein Aufruf der Prozedur mehr tatsächliche Argumente enthalten, als die Prozedur formale Argumente hat. In diesem Fall werden alle tatsächlichen Argumente ab dem, das **args** zugewiesen würde, zu einer Liste zusammengefasst (so, als wäre der Befehl [list] verwendet worden). Dieser zusammengefasste Wert wird der lokalen Variablen **args** zugewiesen.

Während *body* ausgeführt wird, beziehen sich Variablennamen normalerweise auf lokale Variablen. Diese werden beim ersten Zugriff automatisch erzeugt und gelöscht, wenn die Prozedur zurückkehrt. Für jedes Argument der Prozedur wird automatisch eine lokale Variable erzeugt. Auf andere Variablen kann nur zugegriffen werden, indem einer der Befehle [global], [variable], [upvar] oder [namespace upvar][namespace] aufgerufen wird. Der aktuelle Namespace während der Ausführung von *body* ist der Namespace, in dem der Name der Prozedur existiert. Das ist der Namespace, in dem die Prozedur erzeugt wurde, sofern er nicht mit [rename] geändert wurde.

Der Befehl **proc** gibt eine leere Zeichenkette zurück. Wenn eine Prozedur aufgerufen wird, ist ihr Rückgabewert der Wert, der in einem [return]-Befehl angegeben ist. Führt die Prozedur kein explizites [return] aus, ist ihr Rückgabewert der Wert des letzten Befehls, der im Rumpf der Prozedur ausgeführt wurde. Tritt beim Ausführen des Prozedurrumpfs ein Fehler auf, gibt die Prozedur als Ganzes denselben Fehler zurück.

# Beispiele

Dies ist eine Prozedur, die zwei Argumente entgegennimmt und sowohl deren Summe als auch deren Produkt ausgibt. Außerdem gibt sie die Zeichenkette „OK“ als explizites Ergebnis an den Aufrufer zurück.

```
proc printSumProduct {x y} {
    set sum [expr {$x + $y}]
    set prod [expr {$x * $y}]
    puts "sum is $sum, product is $prod"
    return "OK"
}
```

Dies ist eine Prozedur, die beliebig viele Argumente entgegennimmt und sie nacheinander ausgibt.

```
proc printArguments args {
    foreach arg $args {
        puts $arg
    }
}
```

Diese Prozedur ähnelt ein wenig dem Befehl [incr], multipliziert aber den Inhalt der benannten Variablen mit dem Wert, dessen Vorgabe **2** ist:

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
