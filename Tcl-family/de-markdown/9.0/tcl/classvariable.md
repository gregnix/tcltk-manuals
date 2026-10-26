---
CommandName: classvariable
ManualSection: n
Version: 0.3
TclPart: TclOO
TclDescription: TclOO Commands
Links:
 - global(n)
 - namespace(n)
 - oo::class(n)
 - oo::define(n)
 - upvar(n)
 - variable(n)
Keywords:
 - class
 - class variable
 - variable
Copyright:
 - Copyright (c) 2011-2015 Andreas Kupries
 - Copyright (c) 2018 Donal K. Fellows
---

# NAME

classvariable - Verknüpft lokale Variable mit Variable in der Klasse

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [tcl::oo]{.lit} 

[classvariable]{.cmd} [variableName]{.arg} [...]{.optdot} 
:::

# BESCHREIBUNG

Der Befehl **classvariable** ist innerhalb von Methoden verfügbar. Er nimmt eine Reihe von einem oder mehr Variablennamen und macht sie im Gültigkeitsbereich der Methode verfügbar; diese Namen dürfen nicht qualifiziert sein und dürfen sich nicht auf Array-Elemente beziehen. Der Ursprungs-Gültigkeitsbereich für die Variablen ist der Namespace der Klasse, in der die Methode definiert wurde. Die referenzierten Variablen werden also von allen Instanzen dieser Klasse geteilt.

Beachten Sie, dass dieser Befehl dem Befehl **typevariable** aus dem snit-Paket in tcllib für denselben Zweck entspricht. Wird er in einer direkt auf einer Klasseninstanz definierten Methode verwendet (z. B. über **oo::objdefine** **method**), entspricht er im Wesentlichen für jede an **classvariable** übergebene Variable:

```
namespace upvar [namespace current] $var $var
```

# BEISPIELE

Diese Klasse zählt, wie viele Instanzen erzeugt wurden.

```
oo::class create Counted {
    initialise {
        variable count 0
    }

    variable number
    constructor {} {
        classvariable count
        set number [incr count]
    }

    method report {} {
        classvariable count
        puts "This is instance $number of $count"
    }
}

set a [Counted new]
set b [Counted new]
$a report
        → gibt "This is instance 1 of 2" aus
set c [Counted new]
$b report
        → gibt "This is instance 2 of 3" aus
$c report
        → gibt "This is instance 3 of 3" aus
```
