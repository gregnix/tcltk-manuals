---
CommandName: next
title: next
ManualSection: n
Version: 0.1
TclPart: TclOO
TclDescription: TclOO Commands
Links:
 - oo::class(n)
 - oo::define(n)
 - oo::object(n)
 - self(n)
Keywords:
 - call
 - method
 - method chain
Copyright:
 - Copyright (c) 2007 Donal K. Fellows
---

# Name

next, nextto - Implementierungen von Oberklassenmethoden aufrufen

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [TclOO]{.lit}

[next]{.cmd} [arg]{.optdot}
[nextto]{.cmd} [class]{.arg} [arg]{.optdot}
:::

# Beschreibung

Der Befehl **next** wird verwendet, um Implementierungen einer Methode durch eine Klasse, Oberklasse oder Mixin aufzurufen, die von der aktuellen Methode überschrieben wurden. Er kann nur innerhalb einer Methode verwendet werden. Er wird auch innerhalb von Filtern verwendet, um die Stelle anzugeben, an der ein Filter die eigentliche Implementierung aufruft (der Filter kann entscheiden, die Kette nicht fortzusetzen, und kann die Ergebnisse der Methodenkette nach Belieben verarbeiten). Das Ergebnis des Befehls **next** ist das Ergebnis der nächsten Methode in der Methodenkette; gibt es keine weiteren Methoden in der Methodenkette, ist das Ergebnis von **next** ein Fehler. Die Argumente *arg* von **next** sind die Argumente, die an die nächste Methode in der Kette übergeben werden.

Der Befehl **nextto** entspricht dem Befehl **next**, nimmt jedoch ein zusätzliches Argument *class* entgegen, das eine Klasse identifiziert, deren Implementierung der aktuellen Methodenkette (siehe [info object][info] **call**) verwendet werden soll; die ausgewählte Methodenimplementierung ist die von der angegebenen Klasse bereitgestellte, und sie muss sich auf einen existierenden Nicht-Filter-Aufruf beziehen, der weiter entlang der Kette liegt als die aktuelle Implementierung.

# Die Methodenkette

Wenn eine Methode eines Objekts aufgerufen wird, geschieht dies in mehreren Schritten:

1. Die Struktur des Objekts, seiner Klasse, Oberklassen, Filter und Mixins wird untersucht, um eine *Methodenkette* aufzubauen, die eine Liste von aufzurufenden Methodenimplementierungen enthält.

2. Die erste Methodenimplementierung in der Kette wird aufgerufen.

3. Ruft diese Methodenimplementierung den Befehl **next** auf, wird die nächste Methodenimplementierung aufgerufen (mit den Argumenten, die an **next** übergeben wurden).

4. Das Ergebnis des gesamten Methodenaufrufs ist das Ergebnis der äußersten Methodenimplementierung; innere Methodenimplementierungen geben ihre Ergebnisse über **next** zurück.

5. Die Methodenkette wird für die spätere Verwendung zwischengespeichert.


## Suchreihenfolge für Methoden

Beim Aufbau der Methodenkette werden Methodenimplementierungen in folgender Reihenfolge gesucht:

1. In die Objekte eingemischten Klassen, in Traversierungsreihenfolge der Klassen. Die Liste der Mixins wird in natürlicher Reihenfolge geprüft.

2. In die Klassen des Objekts eingemischten Klassen, wobei Quellen des Einschmischens in Traversierungsreihenfolge der Klassen gesucht werden. Innerhalb jeder Klasse wird die Liste der Mixins in natürlicher Reihenfolge verarbeitet.

3. Im Objekt selbst.

4. In der Klasse des Objekts.

5. In den Oberklassen der Klasse, wobei jede Oberklasse in Tiefensuche in der natürlichen Reihenfolge der Oberklassenliste durchlaufen wird.


Jede bestimmte Methodenimplementierung steht in der resultierenden Implementierungsliste stets so *spät* wie möglich; das bedeutet, wenn eine Klasse A sowohl in eine Klasse B eingemischt ist als auch Oberklasse von B ist, behandeln Instanzen von B A stets als Oberklasse aus Sicht der Vererbung. Dies gilt auch, wenn die Mehrfachvererbung indirekt verarbeitet wird.

## Filter

Hat ein Objekt eine Liste von Filternamen oder ist es Instanz einer Klasse (oder hat eine Klasse eingemischt), die eine Liste von Filternamen hat, werden vor jedem Aufruf einer Methode die Filter verarbeitet. Filterimplementierungen werden in Traversierungsreihenfolge der Klassen gefunden, ebenso die Listen von Filternamen (jede wird in natürlicher Listenreihenfolge durchlaufen). Der explizite Aufruf einer als Filter verwendeten Methode führt dazu, dass diese Methode zweimal aufgerufen wird — einmal als Filter und einmal als normale Methode.

Jeder Filter sollte selbst entscheiden, ob die Ausführung zur eigentlichen Implementierung der Methode fortgesetzt werden darf (was durch Aufruf des Befehls **next** geschieht, da Filter an den Anfang der Methodenaufrufkette eingefügt werden), und ist dafür verantwortlich, das Ergebnis von **next** zurückzugeben.

Filter werden bei der Verarbeitung eines Aufrufs der Methode **unknown** aufgerufen, weil keine Methodenimplementierung gefunden werden konnte, aber *nicht* beim Aufruf von Konstruktoren oder Destruktoren. (Beachten Sie jedoch, dass die Methode **destroy** eine konventionelle Methode ist und Filter bei ihrem Aufruf normal verarbeitet werden.)

# Beispiele

Dieses Beispiel zeigt, wie der Befehl **next** verwendet wird, um die Implementierung einer Methode der (Ober-)Klasse aufzurufen. Das Skript:

```
oo::class create theSuperclass {
    method example {args} {
        puts "in the superclass, args = $args"
    }
}
oo::class create theSubclass {
    superclass theSuperclass
    method example {args} {
        puts "before chaining from subclass, args = $args"
        next a {*}$args b
        next pureSynthesis
        puts "after chaining from subclass"
    }
}
theSubclass create obj
oo::objdefine obj method example args {
    puts "per-object method, args = $args"
    next x {*}$args y
    next
}
obj example 1 2 3
```

gibt Folgendes aus:

```
per-object method, args = 1 2 3
before chaining from subclass, args = x 1 2 3 y
in the superclass, args = a x 1 2 3 y b
in the superclass, args = pureSynthesis
after chaining from subclass
before chaining from subclass, args =
in the superclass, args = a b
in the superclass, args = pureSynthesis
after chaining from subclass
```

Dieses Beispiel zeigt, wie eine einfache Cache-Klasse erstellt wird, die Memoization auf alle Methodenaufrufe der Objekte anwendet, in die sie eingemischt ist, und wie sich dies auf die Berechnungszeiten auswirken kann:

```
oo::class create cache {
    filter Memoize
    method Memoize args {
        # Do not filter the core method implementations
        if {[lindex [self target] 0] eq "::oo::object"} {
            return [next {*}$args]
        }

        # Check if the value is already in the cache
        my variable ValueCache
        set key [self target],$args
        if {[info exist ValueCache($key)]} {
            return $ValueCache($key)
        }

        # Compute value, insert into cache, and return it
        return [set ValueCache($key) [next {*}$args]]
    }
    method flushCache {} {
        my variable ValueCache
        unset ValueCache
        # Skip the caching
        return -level 2 ""
    }
}

oo::object create demo
oo::objdefine demo {
    mixin cache
    method compute {a b c} {
        after 3000 ;# Simulate deep thought
        return [expr {$a + $b * $c}]
    }
    method compute2 {a b c} {
        after 3000 ;# Simulate deep thought
        return [expr {$a * $b + $c}]
    }
}

puts [demo compute  1 2 3]      → prints "7" after delay
puts [demo compute2 4 5 6]      → prints "26" after delay
puts [demo compute  1 2 3]      → prints "7" instantly
puts [demo compute2 4 5 6]      → prints "26" instantly
puts [demo compute  4 5 6]      → prints "34" after delay
puts [demo compute  4 5 6]      → prints "34" instantly
puts [demo compute  1 2 3]      → prints "7" instantly
demo flushCache
puts [demo compute  1 2 3]      → prints "7" after delay
```


[info]: info.md
