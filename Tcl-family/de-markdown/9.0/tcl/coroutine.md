---
CommandName: coroutine
title: coroutine
ManualSection: n
Version: 8.6
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - apply(n)
 - info(n)
 - proc(n)
 - return(n)
Keywords:
 - coroutine
 - generator
Copyright:
 - Copyright (c) 2009 Donal K. Fellows.
---

# Name

coroutine, yield, yieldto, coroinject, coroprobe - Coroutinen erzeugen und Werte aus ihnen liefern

# Übersicht

::: {.synopsis} :::
[coroutine]{.cmd} [name]{.arg} [command]{.arg} [arg...]{.optarg}

[yield]{.cmd} [value]{.optarg}
[yieldto]{.cmd} [command]{.arg} [arg...]{.optarg}
[name]{.ins} [value...]{.optarg}

[coroinject]{.cmd version="TIP383"} [coroName]{.arg} [command]{.arg} [arg...]{.optarg}
[coroprobe]{.cmd version="TIP383"} [coroName]{.arg} [command]{.arg} [arg...]{.optarg}
:::

# Beschreibung

Der Befehl **coroutine** erzeugt einen neuen Coroutine-Kontext (mit zugehörigem Befehl) namens *name* und führt diesen Kontext aus, indem er *command* aufruft und die übrigen Argumente ohne weitere Interpretation übergibt. Kehrt *command* normal oder mit einer Ausnahme zurück (z. B. einem Fehler), wird der Coroutine-Kontext *name* gelöscht.

Innerhalb des Kontexts können mit **yield** Werte als Ergebnisse erzeugt werden; fehlt *value*, wird die leere Zeichenkette verwendet. Beim Aufruf von **yield** wird die Ausführung des Kontexts ausgesetzt und der Befehl **coroutine** gibt das Argument von **yield** zurück. Die Ausführung des Kontexts kann fortgesetzt werden, indem der Kontextbefehl aufgerufen wird — optional mit dem *einen* Wert, der als Ergebnis des **yield**-Aufrufs gelten soll, der den Kontext ausgesetzt hat. Liefert der Coroutine-Kontext nie **yield** und kehrt stattdessen konventionell zurück, ist das Ergebnis von **coroutine** das Ergebnis der Auswertung des Kontexts.

Die Coroutine kann die Ausführung auch mit **yieldto** aussetzen, der statt zurückzukehren die Ausführung an einen Befehl *command* (im Kontext der Coroutine aufgelöst) übergibt, dem *beliebig viele* Argumente übergeben werden können. Da jede Coroutine einen Kontextbefehl hat, kann **yieldto** die Kontrolle direkt von einer Coroutine zur anderen übergeben (sinnvoll nur, wenn beide Coroutinen das erwarten), aber *jeder* Befehl kann Ziel sein. Wurde eine Coroutine auf diese Weise ausgesetzt, kann die Coroutine-Verarbeitung fortgesetzt werden, indem der Kontextbefehl aufgerufen wird — optional mit beliebig vielen Argumenten. Der Rückgabewert des **yieldto**-Aufrufs ist die Liste der Argumente, die an den Kontextbefehl übergeben wurden; der Aufrufer entscheidet, was damit geschieht.

Die empfohlene Art, eine Variante von **yield** zu schreiben, die die Fortsetzung mit mehreren Argumenten erlaubt, nutzt **yieldto** und den Befehl [return], etwa so:

```
proc yieldMultiple {value} {
    tailcall yieldto string cat $value
}
```

Die Coroutine kann auch gelöscht werden, indem der Befehl *name* zerstört wird; der Name der aktuellen Coroutine lässt sich mit [info coroutine][info] abfragen. Gibt es Lösch-Spuren auf Variablen in der Coroutine-Implementierung, werden sie ausgelöst, wenn die Coroutine explizit gelöscht wird (oder natürlich, wenn der Befehl konventionell zurückkehrt).

Zum Zeitpunkt des Aufrufs von *command* ist der aktuelle Namespace der globale Namespace, und es gibt keine Stackframes darüber (im Sinne von [upvar] und [uplevel]). Welcher Befehl aufgerufen wird, wird jedoch im Namespace bestimmt, aus dem **coroutine** aufgerufen wurde.

[Eine ausgesetzte Coroutine (also eine, die **yield** oder **yieldto** ausgeführt hat) kann an diesem Punkt mit **coroprobe** inspiziert oder verändert werden, indem an der aktuellen Position der Coroutine ein Befehl ausgeführt wird. Der Befehl nimmt den Namen der Coroutine *coroName*, in der ausgeführt werden soll, und den Namen eines Befehls (sowie alle benötigten Argumente), der sofort an dieser Stelle ausgeführt wird. Das Ergebnis dieses Befehls ist das Ergebnis von **coroprobe**; der Gesamtzustand der Coroutine bleibt danach gleich (die Coroutine erwartet weiterhin die Ergebnisse eines **yield** oder **yieldto** wie zuvor), Variablen können sich jedoch geändert haben.]{version="TIP383"}

Entsprechend kann **coroinject** einen Befehl in eine ausgesetzte Coroutine einfügen (der bei Fortsetzung ausgeführt wird), um Argumente zu verarbeiten — mit großer Ähnlichkeit zu **coroprobe**. Bei **coroinject** gibt es jedoch mehrere wesentliche Unterschiede:

- [Die Coroutine wird nach der Injektion nicht sofort fortgesetzt. Dadurch sind mehrere Injektionen möglich, bevor die Coroutine fortgesetzt wird. Die injizierten Befehle werden in *umgekehrter Definitionsreihenfolge* ausgeführt (intern auf einem Stack gespeichert).]{version="TIP383"}

- [Der Liste der auszuführenden Argumente (also *command* und seinen *args*) werden zwei weitere Elemente angehängt. Das erste ist der Name des Befehls, der die Coroutine ausgesetzt hat (**yield** oder **yieldto**), das zweite das Argument (bzw. bei **yieldto** die Liste der Argumente), das der aktuelle Fortsetzungswert ist.]{version="TIP383"}

- [Das Ergebnis des injizierten Befehls wird als Ergebnis des **yield** oder **yieldto** verwendet, das die Coroutine ausgesetzt hat. Bei mehreren Injektionen wird das Ergebnis eines zum Fortsetzungswert des nächsten.]{version="TIP383"}


Die Injektion ist einmalig. Sie bleibt nach der Ausführung nicht erhalten. Der injizierte Befehl darf im Verlauf **yield** oder **yieldto** ausführen.

Beachten Sie, dass laufende Coroutinen weder untersucht noch injiziert werden können; die Operationen gelten nur für ausgesetzte Coroutinen. (Läuft eine Coroutine, würde Introspektionscode nur den Zustand der aktuellen Ausführung betrachten; **coroinject**/**coroprobe** sind dann unnötig.)

# Beispiele

Dieses Beispiel zeigt eine Coroutine, die eine unendliche Folge gerader Werte erzeugt, und eine Schleife, die die ersten zehn davon verbraucht.

```
proc allNumbers {} {
    yield
    set i 0
    while 1 {
        yield $i
        incr i 2
    }
}
coroutine nextNumber allNumbers
for {set i 0} {$i < 10} {incr i} {
    puts "received [nextNumber]"
}
rename nextNumber {}
```

In diesem Beispiel addiert die Coroutine die an sie übergebenen Argumente.

```
coroutine accumulator apply {{} {
    set x 0
    while 1 {
        incr x [yield $x]
    }
}}
for {set i 0} {$i < 10} {incr i} {
    puts "$i -> [accumulator $i]"
}
```

Dieses Beispiel zeigt Coroutinen zur Implementierung des klassischen Sieb des Eratosthenes zur Primzahlsuche. Beachten Sie die Erzeugung von Coroutinen innerhalb einer Coroutine.

```
proc filterByFactor {source n} {
    yield [info coroutine]
    while 1 {
        set x [$source]
        if {$x % $n} {
            yield $x
        }
    }
}
coroutine allNumbers apply {{} {while 1 {yield [incr x]}}}
coroutine eratosthenes apply {c {
    yield
    while 1 {
        set n [$c]
        yield $n
        set c [coroutine prime$n filterByFactor $c $n]
    }
}} allNumbers
for {set i 1} {$i <= 20} {incr i} {
    puts "prime#$i = [eratosthenes]"
}
```

Dieses Beispiel zeigt, wie ein Wert zwischen drei Coroutinen weitergegeben wird, die sich gegenseitig **yieldto** aufrufen:

```
proc juggler {name target {value ""}} {
    if {$value eq ""} {
        set value [yield [info coroutine]]
    }
    while {$value ne ""} {
        puts "$name : $value"
        set value [string range $value 0 end-1]
        lassign [yieldto $target $value] value
    }
}
coroutine j1 juggler Larry [
    coroutine j2 juggler Curly [
        coroutine j3 juggler Moe j1]] "Nyuck!Nyuck!Nyuck!"
```

[Dieses Beispiel zeigt eine einfache Coroutine, die nicht-leere Werte sammelt und ohne Argument eine Liste davon zurückgibt. Es zeigt auch, wie man in die Coroutine hineinschauen und die Eingabe einmalig ändern kann.]{version="TIP383"}

```
proc collectorImpl {} {
    set me [info coroutine]
    set accumulator {}
    for {set val [yield $me]} {$val ne ""} {set val [yield]} {
        lappend accumulator $val
    }
    return $accumulator
}

coroutine collect collectorImpl
collect 123
collect "abc def"
collect 456

puts [coroprobe collect set accumulator]
# ==> 123 {abc def} 456

collect "pqr"

coroinject collect apply {{type value} {
    puts "Received '$value' at a $type in [info coroutine]"
    return [string toupper $value]
}}

collect rst
# ==> Received 'rst' at a yield in ::collect
collect xyz

puts [collect]
# ==> 123 {abc def} 456 pqr RST xyz
```

## Detaillierte Semantik

Dieses Beispiel zeigt, dass Coroutinen im globalen Namespace starten und dass die Auflösung von *command* erfolgt, bevor der Coroutine-Stack erzeugt wird.

```
proc report {where level} {
    # Wo wurde der Aufrufer aufgerufen?
    set ns [uplevel 2 {namespace current}]
    yield "made $where $level context=$ns name=[info coroutine]"
}
proc example {} {
    report outer [info level]
}
namespace eval demo {
    proc example {} {
        report inner [info level]
    }
    proc makeExample {} {
        puts "making from [info level]"
        puts [coroutine coroEg example]
    }
    makeExample
}
```

Das erzeugt die unten stehende Ausgabe. Insbesondere ist Stack-Manipulation erfolgt (Vergleich der Ebenen der ersten und zweiten Zeile), und die übergeordnete Ebene in der Coroutine ist der globale Namespace. Coroutine-Namen sind ohne Qualifizierung lokal zum aktuellen Namespace, und Coroutinen können in der Tiefe **yield**en (z. B. in aufgerufenen Prozeduren).

```
making from 2
made inner 1 context=:: name=::demo::coroEg
```


[info]: info.md
[return]: return.md
[uplevel]: uplevel.md
[upvar]: upvar.md
