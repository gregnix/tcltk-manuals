---
CommandName: coroutine
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

# NAME

coroutine, yield, yieldto - Coroutinen erzeugen und Werte aus ihnen liefern

# ÜBERSICHT

::: {.synopsis} :::
[coroutine]{.cmd} [name]{.arg} [command]{.arg} [arg]{.optdot} 
[yield]{.cmd} [value]{.optarg} 
[yieldto]{.cmd} [command]{.arg} [arg]{.optdot} 
*name* ?*value...*?
:::

# BESCHREIBUNG

Der Befehl **coroutine** erzeugt einen neuen Coroutine-Kontext (mit zugehörigem Befehl) namens *name* und führt diesen Kontext aus, indem er *command* aufruft und die übrigen Argumente ohne weitere Interpretation übergibt. Kehrt *command* normal oder mit einer Ausnahme zurück (z. B. einem Fehler), wird der Coroutine-Kontext *name* gelöscht.

Innerhalb des Kontexts können mit **yield** Werte als Ergebnisse erzeugt werden; fehlt *value*, wird die leere Zeichenkette verwendet. Beim Aufruf von **yield** wird die Ausführung des Kontexts ausgesetzt und der Befehl **coroutine** gibt das Argument von **yield** zurück. Die Ausführung des Kontexts kann fortgesetzt werden, indem der Kontextbefehl aufgerufen wird — optional mit dem *einen* Wert, der als Ergebnis des **yield**-Aufrufs gelten soll, der den Kontext ausgesetzt hat. Liefert der Coroutine-Kontext nie **yield** und kehrt stattdessen konventionell zurück, ist das Ergebnis von **coroutine** das Ergebnis der Auswertung des Kontexts.

::: {.info -version="TIP396"}
Die Coroutine kann die Ausführung auch mit **yieldto** aussetzen, der statt zurückzukehren die Ausführung an einen Befehl *command* (im Kontext der Coroutine aufgelöst) übergibt, dem *beliebig viele* Argumente übergeben werden können. Da jede Coroutine einen Kontextbefehl hat, kann **yieldto** die Kontrolle direkt von einer Coroutine zur anderen übergeben (sinnvoll nur, wenn beide Coroutinen das erwarten), aber *jeder* Befehl kann Ziel sein. Wurde eine Coroutine auf diese Weise ausgesetzt, kann die Coroutine-Verarbeitung fortgesetzt werden, indem der Kontextbefehl aufgerufen wird — optional mit beliebig vielen Argumenten. Der Rückgabewert des **yieldto**-Aufrufs ist die Liste der Argumente, die an den Kontextbefehl übergeben wurden; der Aufrufer entscheidet, was damit geschieht.
:::

Die empfohlene Art, eine Variante von **yield** zu schreiben, die die Fortsetzung mit mehreren Argumenten erlaubt, nutzt **yieldto** und den Befehl **return**, etwa so:

```
proc yieldm {value} {
    yieldto return -level 0 $value
}
```

Die Coroutine kann auch gelöscht werden, indem der Befehl *name* zerstört wird; der Name der aktuellen Coroutine lässt sich mit **info coroutine** abfragen. Gibt es Lösch-Spuren auf Variablen in der Coroutine-Implementierung, werden sie ausgelöst, wenn die Coroutine explizit gelöscht wird (oder natürlich, wenn der Befehl konventionell zurückkehrt).

Zum Zeitpunkt des Aufrufs von *command* ist der aktuelle Namespace der globale Namespace, und es gibt keine Stackframes darüber (im Sinne von **upvar** und **uplevel**). Welcher Befehl aufgerufen wird, wird jedoch im Namespace bestimmt, aus dem **coroutine** aufgerufen wurde.

# BEISPIELE

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

::: {.info -version="TIP396"}
Dieses Beispiel zeigt, wie ein Wert zwischen drei Coroutinen weitergegeben wird, die sich gegenseitig **yieldto** aufrufen:
:::

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

