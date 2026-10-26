---
CommandName: vwait
title: vwait
ManualSection: n
Version: 8.0
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - global(n)
 - update(n)
Keywords:
 - asynchronous I/O
 - event
 - variable
 - wait
Copyright:
 - Copyright (c) 1995-1996 Sun Microsystems, Inc.
---

# Name

vwait - Verarbeitet Events bis eine Variable geschrieben wird

# Übersicht

::: {.synopsis} :::
[vwait]{.cmd} [varName]{.arg}
[vwait]{.cmd} [options]{.optarg} [varName]{.optdot}
:::

# Beschreibung

Dieser Befehl betritt die Tcl-Event-Schleife zur Verarbeitung von Events und blockiert die Anwendung, wenn keine Events bereitstehen. Er verarbeitet Events weiter, bis ein Event-Handler den Wert der globalen Variable *varName* setzt. Sobald *varName* gesetzt wurde, kehrt der Befehl **vwait** zurück, sobald der Event-Handler, der *varName* geändert hat, abgeschlossen ist. Das Argument *varName* wird stets als Variablenname bezogen auf den globalen Namespace interpretiert, kann aber auf Variablen beliebiger Namespaces verweisen, wenn der vollqualifizierte Name angegeben ist.

In der zweiten, komplexeren Befehlsform ermöglichen *options* feinere Steuerung der Warteoperation und den Umgang mit mehreren Event-Quellen. *Options* können bestehen aus:

[--]{.lit}
: Markiert das Ende der Optionen. Alle folgenden Argumente werden als Variablennamen behandelt.

[-all]{.lit}
: Alle Bedingungen der Warteoperation müssen erfüllt sein, damit die Warteoperation endet. Andernfalls (Standard) beendet das erste Ereignis das Warten.

[-extended]{.lit}
: Es wird ein erweitertes Ergebnis in Listenform zurückgegeben; siehe unten.

[-nofileevents]{.lit}
: Datei-Events werden in der Warteoperation nicht bearbeitet.

[-noidleevents]{.lit}
: Idle-Handler werden während der Warteoperation nicht aufgerufen.

[-notimerevents]{.lit}
: Timer-Handler werden während der Warteoperation nicht bedient.

[-nowindowevents]{.lit}
: Events des Fenstersystems werden während der Warteoperation nicht bearbeitet.

[-readable]{.lit} [channel]{.arg}
: *Channel* muss einen Tcl-Kanal benennen, der zum Lesen geöffnet ist. Ist *channel* lesbar oder wird lesbar, endet die Warteoperation.

[-timeout]{.lit} [milliseconds]{.arg}
: Die Warteoperation ist auf *milliseconds* begrenzt.

[-variable]{.lit} [varName]{.arg}
: *VarName* muss der Name einer globalen Variable sein. Schreiben oder Entfernen dieser Variable beendet die Warteoperation.

[-writable]{.lit} [channel]{.arg}
: *Channel* muss einen Tcl-Kanal benennen, der zum Schreiben geöffnet ist. Ist *channel* beschreibbar oder wird beschreibbar, endet die Warteoperation.


Der Rückgabewert von **vwait** ist bei der einfachen Form eine leere Zeichenkette. Ist die Option **-timeout** angegeben, ist das Ergebnis die verbleibende Anzahl Millisekunden, wenn die Wartebedingung erfüllt wurde, oder -1 bei Zeitüberschreitung.

Ist die Option **-extended** angegeben, besteht das Ergebnis aus einer Tcl-Liste mit gerader Elementanzahl. Ungerade Elemente haben die Werte **readable**, **timeleft**, **variable** und **writable**. Gerade Elemente sind die zugehörigen Variablen- und Kanalnamen bzw. die verbleibende Anzahl Millisekunden. Die Liste ist nach dem Auftreten der Event(s) geordnet, mit Ausnahme von **timeleft**, das stets zuletzt steht.

In manchen Fällen kehrt **vwait** nicht sofort zurück, nachdem *varName* usw. gesetzt wurden. Das passiert, wenn der Event-Handler, der *varName* setzt, nicht sofort abgeschlossen wird. Setzt etwa ein Event-Handler *varName* und ruft anschließend selbst **vwait** auf, um auf eine andere Variable zu warten, kann er lange nicht zurückkehren. In dieser Zeit ist der oberste **vwait** blockiert und wartet auf den Abschluss des Event-Handlers, er kann also ebenfalls nicht zurückkehren. (Siehe [Verschachtelte vwaits anhand eines Beispiels] unten.)

Zur Klarstellung: *mehrere* **vwait**-*Aufrufe verschachteln sich und laufen nicht parallel*. Der äußerste Aufruf von **vwait** kehrt erst zurück, wenn alle inneren zurückgekehrt sind. Es wird empfohlen, **vwait**-Aufrufe nie zu verschachteln (indem man sie nicht in Event-Callbacks platziert); wenn das nicht möglich ist, sollte man Sperrvariablen einbauen, um alle nicht *strikt* notwendigen reentranten **vwait**-Aufrufe zu verhindern. Beachten Sie, dass synchrone Betriebsarten einiger Tcl-Pakete (z. B. **http**) **vwait** intern verwenden; bei Nutzung der Event-Schleife sind nach Möglichkeit die asynchronen, callback-basierten Betriebsarten dieser Pakete zu bevorzugen.

# Beispiele

Die Event-Schleife dauerhaft laufen lassen, bis ein Event [exit] aufruft. (Sie können jede Variable verwenden, die sonst nicht vorkommt; der Name *forever* erinnert auf den ersten Blick an die Absicht.)

```
vwait forever
```

Fünf Sekunden auf eine Verbindung zu einem Server-Socket warten, andernfalls den Socket schließen und das Skript fortsetzen:

```
# Zustand initialisieren
after 5000 set state timeout
set server [socket -server accept 12345]
proc accept {args} {
    global state connectionInfo
    set state accepted
    set connectionInfo $args
}

# Auf ein Ereignis warten
vwait state

# Mögliche Events aufräumen
close $server
after cancel set state timeout

# Je nach vwait-Ende handeln ...
switch $state {
    timeout {
        puts "no connection on port 12345"
    }
    accepted {
       puts "connection: $connectionInfo"
       puts [lindex $connectionInfo 0] "Hello there!"
    }
}
```

Ein Befehl, der eine Zeitverzögerung abwartet, indem auf das Setzen einer Namespace-Variable gewartet wird. Enthält eine Sperre gegen verschachtelte Waits.

```
namespace eval example {
    variable v done
    proc wait {delay} {
        variable v
        if {$v ne "waiting"} {
            set v waiting
            after $delay [namespace code {set v done}]
            vwait [namespace which -variable v]
        }
        return $v
    }
}
```

Läuft der Code in einer [coroutine], ist eine Alternative zu **vwait**, mit [yield][coroutine] an eine äußere Event-Schleife zu übergeben und fortgesetzt zu werden, wenn die Variable gesetzt wird oder danach in einem Idle-Moment.

```
coroutine task apply {{} {
    # [after 1000] simulieren
    after 1000 [info coroutine]
    yield

    # Setzen einer globalen Variable planen, wie üblich
    after 2000 {set var 1}

    # [vwait var] simulieren
    proc updatedVar {task args} {
        after idle $task
        trace remove variable ::var write "updatedVar $task"
    }
    trace add variable ::var write "updatedVar [info coroutine]"
    yield
}}
```

## Verschachtelte vwaits anhand eines Beispiels

Dieses Beispiel zeigt, was bei verschachtelten **vwait**-Befehlen passieren kann. Das Skript wird nie enden, weil das Warten auf die Variable *a* nie abgeschlossen wird; dieser **vwait** wartet noch darauf, dass ein mit [after] geplantes Skript endet, das zufällig einen inneren **vwait** (für *b*) ausführt, obwohl das Ereignis, auf das der äußere **vwait** wartete (das Setzen von *a*), bereits eingetreten ist.

```
after 500 {
    puts "waiting for b"
    vwait b
    puts "b was set"
}
after 1000 {
    puts "setting a"
    set a 10
}
puts "waiting for a"
vwait a
puts "a was set"
puts "setting b"
set b 42
```

Führt man den obigen Code aus, erscheint diese Ausgabe:

```
waiting for a
waiting for b
setting a
```

Das Skript gibt „a was set“ erst aus, nachdem „b was set“ gedruckt wurde, wegen der Verschachtelung der **vwait**-Befehle; *b* wird jedoch erst gesetzt, nachdem der äußere **vwait** zurückkehrt — das Skript ist verklemmt. Vermeiden lässt sich das nur, indem man das Gesamtprogramm im Continuation-Passing-Stil strukturiert oder [coroutine] nutzt, um die Fortsetzungen implizit zu machen. Die erste Option sieht so aus:

```
after 500 {
    puts "waiting for b"
    trace add variable b write {apply {args {
        global a b
        trace remove variable ::b write \
                [lrange [info level 0] 0 1]
        puts "b was set"
        set ::done ok
    }}}
}
after 1000 {
    puts "setting a"
    set a 10
}
puts "waiting for a"
trace add variable a write {apply {args {
    global a b
    trace remove variable a write [lrange [info level 0] 0 1]
    puts "a was set"
    puts "setting b"
    set b 42
}}}
vwait done
```

Die zweite Option mit [coroutine] und einigen Hilfsprozeduren:

```
# Koroutine-basierter Befehl: auf Variable warten
proc waitvar globalVar {
    trace add variable ::$globalVar write \
            [list apply {{v c args} {
        trace remove variable $v write \
                [lrange [info level 0] 0 3]
        after 0 $c
    }} ::$globalVar [info coroutine]]
    yield
}
# Koroutine-basierter Befehl: Zeit abwarten
proc waittime ms {
    after $ms [info coroutine]
    yield
}

coroutine task-1 eval {
    puts "waiting for a"
    waitvar a
    puts "a was set"
    puts "setting b"
    set b 42
}
coroutine task-2 eval {
    waittime 500
    puts "waiting for b"
    waitvar b
    puts "b was set"
    set done ok
}
coroutine task-3 eval {
    waittime 1000
    puts "setting a"
    set a 10
}
vwait done
```


[after]: after.md
[coroutine]: coroutine.md
[exit]: exit.md
