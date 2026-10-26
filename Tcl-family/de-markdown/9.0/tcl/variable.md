---
CommandName: variable
title: variable
ManualSection: n
Version: 8.0
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - global(n)
 - namespace(n)
 - upvar(n)
Keywords:
 - global
 - namespace
 - procedure
 - variable
Copyright:
 - Copyright (c) 1993-1997 Bell Labs Innovations for Lucent Technologies
 - Copyright (c) 1997 Sun Microsystems, Inc.
---

# Name

variable - Erstellt und initialisiert eine Namespace-Variable

# Übersicht

::: {.synopsis} :::
[variable]{.cmd} [name]{.arg}
[variable]{.cmd} [name value...]{.optarg}
:::

# Beschreibung

Dieser Befehl wird normalerweise innerhalb eines [namespace eval][namespace]-Befehls verwendet, um eine oder mehrere Variablen innerhalb eines Namespace zu erstellen. Jede Variable *name* wird mit *value* initialisiert. Der *value* für die letzte Variable ist optional.

Existiert eine Variable *name* noch nicht, wird sie erstellt. In diesem Fall wird, wenn *value* angegeben ist, der neu erstellten Variable dieser Wert zugewiesen. Ist kein *value* angegeben, bleibt die neue Variable undefiniert. Existiert die Variable bereits, wird sie auf *value* gesetzt, wenn *value* angegeben ist, oder unverändert gelassen, wenn kein *value* übergeben wird. Normalerweise ist *name* unqualifiziert (enthält keine Namen umgebender Namespaces), und die Variable wird im aktuellen Namespace erstellt. Enthält *name* Namespace-Qualifizierer, wird die Variable im angegebenen Namespace erstellt. Ist die Variable nicht definiert, ist sie für den Befehl [namespace which][namespace] sichtbar, aber nicht für [info exists][info].

Wird der Befehl **variable** innerhalb einer Tcl-Prozedur ausgeführt, erzeugt er lokale Variablen, die mit den entsprechenden Namespace-Variablen verknüpft sind (und daher von [info vars][info] aufgelistet werden). So ähnelt der Befehl **variable** dem Befehl [global], wobei [global] Variablennamen bezüglich des globalen Namespace auflöst statt bezüglich des aktuellen Namespace der Prozedur. Werden *value*-Argumente angegeben, werden sie verwendet, um die Werte der zugehörigen Namespace-Variablen zu ändern. Existiert eine Namespace-Variable noch nicht, wird sie erstellt und optional initialisiert.

Ein *name*-Argument kann nicht auf ein Element innerhalb eines Arrays verweisen. Stattdessen sollte *name* auf das gesamte Array verweisen, und der Initialisierungs-*value* sollte weggelassen werden. Nach der Deklaration der Variable können Elemente innerhalb des Arrays mit den üblichen Befehlen [set] oder [array] gesetzt werden.

# Beispiele

Variable in einem Namespace erstellen:

```
namespace eval foo {
    variable bar 12345
}
```

Array in einem Namespace erstellen:

```
namespace eval someNS {
    variable someAry
    array set someAry {
        someName  someValue
        otherName otherValue
    }
}
```

Variablen in Namespaces aus einer Prozedur heraus zugreifen:

```
namespace eval foo {
    proc spong {} {
        # Variable in diesem Namespace
        variable bar
        puts "bar is $bar"

        # Variable in einem anderen Namespace
        variable ::someNS::someAry
        parray someAry
    }
}
```


[array]: array.md
[global]: global.md
[info]: info.md
[namespace]: namespace.md
[set]: set.md
