---
CommandName: link
ManualSection: n
Version: 0.3
TclPart: TclOO
TclDescription: TclOO Commands
Links:
 - interp(n)
 - my(n)
 - oo::class(n)
 - oo::define(n)
Keywords:
 - command
 - method
 - object
Copyright:
 - Copyright (c) 2011-2015 Andreas Kupries
 - Copyright (c) 2018 Donal K. Fellows
---

# NAME

link - Verknüpfung von Befehl mit Methode eines Objekts erstellen

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [tcl::oo]{.lit} 

[link]{.cmd} [methodName]{.arg} [...]{.optdot} 
[link]{.cmd} { [commandName]{.arg} [methodName]{.arg} } [...]{.optdot} 
:::

# BESCHREIBUNG

Der Befehl **link** steht innerhalb von Methoden zur Verfügung. Er nimmt eine Reihe von einem oder mehreren Methodennamen (*methodName ...*) und/oder Paaren aus Befehls- und Methodennamen (**{***commandName methodName***}**) entgegen und macht die genannten Methoden als Befehle verfügbar, ohne dass der Objektname oder der Befehl **my** ausdrücklich verwendet werden muss. Die Methode muss zum Zeitpunkt der Verknüpfung noch nicht existieren; wird der verknüpfte Befehl aufgerufen, während die Methode nicht existiert, greift das übliche **unknown**-Behandlungssystem für Methoden.

Der Befehlsname, unter dem die Methode verfügbar wird, entspricht standardmäßig dem Methodennamen, außer wenn er über ein Alias-/Methoden-Paar ausdrücklich angegeben wird. Formal muss jedes Argument eine Liste sein; hat die Liste zwei Elemente, ist das erste Element der Name des zu erzeugenden Befehls und das zweite Element der Name der Methode des aktuellen Objekts, mit der der Befehl verknüpft wird; andernfalls sind Befehlsname und Methodenname dieselbe Zeichenkette (das erste Element der Liste).

Ist der Befehlsname kein voll qualifizierter Befehlsname, wird er relativ zum aktuellen Namespace aufgelöst (d. h. dem Objekt-Namespace).

# BEISPIELE

Dies zeigt die Verknüpfung einer einzelnen Methode auf verschiedene Weise. Zuerst eine einfache Verknüpfung, dann eine umbenannte Verknüpfung, dann eine externe Verknüpfung. Beachten Sie, dass die Methode selbst nicht exportiert ist, aber dennoch direkt von außerhalb der Klasse aufgerufen werden kann.

```
oo::class create ABC {
    method Foo {} {
        puts "This is Foo in [self]"
    }

    constructor {} {
        link Foo
        # Die Methode Foo ist hier jetzt direkt als Foo aufrufbar
        link {bar Foo}
        # Die Methode Foo ist jetzt direkt als bar aufrufbar
        link {::ExternalCall Foo}
        # Die Methode Foo ist jetzt im globalen
        # Namespace als ExternalCall direkt aufrufbar
    }

    method grill {} {
        puts "Step 1:"
        Foo
        puts "Step 2:"
        bar
    }
}

ABC create abc
abc grill
        → Step 1:
        → This is Foo in ::abc
        → Step 2:
        → This is Foo in ::abc
# Direkter Zugriff über den verknüpften Befehl
puts "Step 3:"; ExternalCall
        → Step 3:
        → This is Foo in ::abc
```

Dieses Beispiel zeigt, dass in einem Aufruf von **link** mehrere verknüpfte Befehle erzeugt werden können und dass diese Argumente verarbeiten können.

```
oo::class create Ex {
    constructor {} {
        link a b c
        # Die Methoden a, b und c (unten definiert) sind nun
        # in Methoden direkt unter ihren eigenen Namen aufrufbar.
    }

    method a {} {
        puts "This is a"
    }
    method b {x} {
        puts "This is b($x)"
    }
    method c {y z} {
        puts "This is c($y,$z)"
    }

    method call {p q r} {
        a
        b $p
        c $q $r
    }
}

set o [Ex new]
$o call 3 5 7
        → This is a
        → This is b(3)
        → This is c(5,7)
```
