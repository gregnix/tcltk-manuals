---
CommandName: trace
title: trace
ManualSection: n
Version: 8.4
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - set(n)
 - unset(n)
Keywords:
 - read
 - command
 - rename
 - variable
 - write
 - trace
 - unset
Copyright:
 - Copyright (c) 1993 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
 - Copyright (c) 2000 Ajuba Solutions.
---

# Name

trace - Überwacht Variablenzugriffe, Befehlsnutzung und Befehlsausführungen

# Übersicht

::: {.synopsis} :::
[trace]{.cmd} [option]{.arg} [arg arg]{.optdot}
:::

# Beschreibung

Dieser Befehl führt Tcl-Befehle aus, sobald bestimmte Operationen ausgelöst werden. Die zulässigen *option*s (abkürzbar) sind:

[trace]{.cmd} [add]{.sub} [type]{.arg} [name]{.arg} [ops]{.arg} [args]{.optarg}
: Dabei ist *type* **command**, **execution** oder **variable**.

    [trace]{.cmd} [add]{.sub} [command]{.lit} [name]{.arg} [ops]{.arg} [commandPrefix]{.arg}
    : *commandPrefix* wird (mit zusätzlichen Argumenten) ausgeführt, sobald der Befehl *name* auf eine der in der Liste *ops* genannten Weisen geändert wird. *Name* wird mit den üblichen Namespace-Auflösungsregeln für Befehle aufgelöst. Existiert der Befehl nicht, wird ein Fehler ausgelöst.

        *Ops* gibt an, welche Operationen von Interesse sind, als Liste aus einem oder mehreren der folgenden Einträge:

        **rename**
        : *commandPrefix* wird aufgerufen, sobald der überwachte Befehl umbenannt wird. Umbenennung in die leere Zeichenkette gilt als Löschen und wird nicht mit „**rename**“ überwacht.

        **delete**
        : *commandPrefix* wird aufgerufen, wenn der überwachte Befehl gelöscht wird. Befehle können explizit mit **rename** auf eine leere Zeichenkette gelöscht werden. Befehle werden auch gelöscht, wenn der Interpreter gelöscht wird; Traces werden dann nicht aufgerufen, weil kein Interpreter zur Ausführung existiert.


        Beim Auslösen des Traces werden je nach überwachter Operation Argumente an *commandPrefix* angehängt, sodass der tatsächliche Befehl lautet:

        ```
        commandPrefix oldName newName op
        ```

        *OldName* und *newName* sind der aktuelle (alte) Name des überwachten Befehls bzw. der Zielname der Umbenennung (leere Zeichenkette bei „delete“). *Op* ist **rename** oder **delete** wie oben. Der Trace kann das Löschen eines Befehls nicht verhindern; Tcl entfernt den Befehl nach Abschluss des Traces. Rekursives Umbenennen oder Löschen löst keine weiteren Traces desselben Typs aus; ein Delete-Trace, der den Befehl selbst löscht, oder ein Rename-Trace, der selbst umbenennt, führt nicht zu weiteren Trace-Auswertungen. *oldName* und *newName* sind vollständig mit allen Namespaces qualifiziert.

    [trace]{.cmd} [add]{.sub} [execution]{.lit} [name]{.arg} [ops]{.arg} [commandPrefix]{.arg}
    : *commandPrefix* wird (mit zusätzlichen Argumenten) ausgeführt, sobald der Befehl *name* ausgeführt wird; die Traces erfolgen an den in *ops* genannten Punkten. *Name* wird mit den üblichen Namespace-Auflösungsregeln aufgelöst. Existiert der Befehl nicht, wird ein Fehler ausgelöst.

        *Ops* ist eine Liste aus einem oder mehreren der folgenden Einträge:

        **enter**
        : *commandPrefix* wird aufgerufen, sobald der Befehl *name* ausgeführt wird, unmittelbar vor der eigentlichen Ausführung.

        **leave**
        : *commandPrefix* wird aufgerufen, sobald der Befehl *name* ausgeführt wird, unmittelbar nach der eigentlichen Ausführung.

        **enterstep**
        : *commandPrefix* wird für jeden Tcl-Befehl aufgerufen, der von Beginn der Ausführung der Prozedur *name* bis zu deren Ende ausgeführt wird. *commandPrefix* wird unmittelbar vor der Ausführung des gemeldeten Tcl-Befehls aufgerufen. Hat man z. B. „proc foo {} { puts "hello" }“, wird ein *enterstep*-Trace unmittelbar vor der Ausführung von „*puts "hello"*“ aufgerufen. Ein *enterstep*-Trace auf einen *name*, der keine Prozedur bezeichnet, führt nicht zu einem Fehler und wird ignoriert.

        **leavestep**
        : *commandPrefix* wird für jeden Tcl-Befehl aufgerufen, der von Beginn der Ausführung der Prozedur *name* bis zu deren Ende ausgeführt wird. *commandPrefix* wird unmittelbar nach der Ausführung des gemeldeten Tcl-Befehls aufgerufen. Ein *leavestep*-Trace auf einen *name*, der keine Prozedur bezeichnet, führt nicht zu einem Fehler und wird ignoriert.


        Beim Auslösen werden je nach Operation Argumente an *commandPrefix* angehängt:

        Bei **enter** und **enterstep**:

        ```
        commandPrefix command-string op
        ```

        *Command-string* ist der vollständige aktuelle Befehl (der überwachte Befehl bei **enter**, ein beliebiger Befehl bei **enterstep**), einschließlich aller Argumente in voll expandierter Form. *Op* ist **enter** oder **enterstep** wie oben. Der Trace kann die Ausführung stoppen, indem der betreffende Befehl gelöscht wird; bei späterer Ausführung tritt ein „invalid command“-Fehler auf.

        Bei **leave** und **leavestep**:

        ```
        commandPrefix command-string code result op
        ```

        *Command-string* wie oben. *Code* ist der Ergebniscode der Ausführung, *result* die Ergebniszeichenkette. *Op* ist **leave** oder **leavestep** wie oben.

        Viele **enterstep**- oder **leavestep**-Traces können zu unintuitiven Ergebnissen führen, weil aus einem Trace aufgerufene Befehle weitere Befehlsaufrufe für andere Traces auslösen können.

        *commandPrefix* läuft im gleichen Kontext wie der Code, der die überwachte Operation auslöste: wird er aus einer Prozedur aufgerufen, hat er Zugriff auf dieselben lokalen Variablen. Der Kontext kann vom Erstellungskontext des Traces abweichen. Ruft *commandPrefix* eine Prozedur auf (üblich), muss diese [upvar] oder [uplevel] nutzen, um auf lokale Variablen des auslösenden Codes zuzugreifen.

        Während *commandPrefix* bei einem Execution-Trace läuft, sind Traces auf *name* vorübergehend deaktiviert. So kann *commandPrefix* *name* im Rumpf ausführen, ohne weitere Traces auszulösen. Tritt beim Ausführen von *commandPrefix* ein Fehler auf, liefert der Befehl *name* insgesamt denselben Fehler.

        Sind mehrere Traces auf *name* gesetzt, werden bei *enter* und *enterstep* die Trace-Befehle in umgekehrter Erstellungsreihenfolge aufgerufen; bei *leave* und *leavestep* in der ursprünglichen Erstellungsreihenfolge.

        Das Verhalten von Execution-Traces ist für einen in einen anderen Namespace importierten Befehlsnamen *name* derzeit undefiniert.

    [trace]{.cmd} [add]{.sub} [variable]{.lit} [name]{.arg} [ops]{.arg} [commandPrefix]{.arg}
    : *commandPrefix* wird ausgeführt, sobald auf die Variable *name* auf eine der in *ops* genannten Weisen zugegriffen wird. *Name* kann eine normale Variable, ein Arrayelement oder ein ganzes Array sein (d. h. *name* nur der Arrayname ohne Index in Klammern). Verweist *name* auf ein ganzes Array, wird *commandPrefix* bei jeder Manipulation eines Elements aufgerufen. Existiert die Variable nicht, wird sie erzeugt, aber ohne Wert; sie ist für [namespace which][namespace] sichtbar, nicht für [info exists][info].

        *Ops* ist eine Liste aus einem oder mehreren der folgenden Einträge:

        [array]
        : *commandPrefix* wird aufgerufen, wenn auf die Variable über den Befehl [array] zugegriffen oder sie darüber geändert wird, sofern *name* zum Zeitpunkt des [array]-Aufrufs kein Skalar ist. Ist *name* ein Skalar, löst Zugriff über [array] den Trace nicht aus.

        **read**
        : *commandPrefix* wird aufgerufen, wenn die Variable gelesen wird.

        **write**
        : *commandPrefix* wird aufgerufen, wenn die Variable geschrieben wird.

        **unset**
        : *commandPrefix* wird aufgerufen, wenn die Variable entfernt wird. Variablen können explizit mit **unset** oder implizit beim Prozedurrückkehr entfernt werden. Variablen werden auch entfernt, wenn Interpreter gelöscht werden; Traces werden dann nicht aufgerufen.


        Beim Auslösen werden drei Argumente an *commandPrefix* angehängt:

        ```
        commandPrefix name1 name2 op
        ```

        *Name1* gibt den Namen der Variablen an, auf die zugegriffen wird. Das ist nicht notwendigerweise derselbe Name wie im Befehl **trace add variable**: mit [upvar] kann eine Prozedur eine Variable unter anderem Namen referenzieren. War der Trace ursprünglich auf ein Array oder ein Arrayelement gesetzt, liefert *name2* den betroffenen Array-Index. Diese Information liegt auch vor, wenn *name1* auf einen Skalar verweist, was vorkommen kann, wenn [upvar] eine Referenz auf ein einzelnes Arrayelement erzeugt hat. Wird ein ganzes Array gelöscht und der Trace auf das gesamte Array (nicht ein einzelnes Element) registriert, ist *name1* der Arrayname und *name2* eine leere Zeichenkette. *Op* ist **read**, **write** oder **unset** wie oben.

        *commandPrefix* läuft im gleichen Kontext wie der auslösende Code: wurde die Variable in einer Tcl-Prozedur verwendet, hat *commandPrefix* Zugriff auf dieselben lokalen Variablen. Der Kontext kann vom Erstellungskontext abweichen. Ruft *commandPrefix* eine Prozedur auf, muss diese [upvar] oder [uplevel] nutzen, um auf die überwachte Variable zuzugreifen. *name1* kann vom beim Setzen des Traces verwendeten Namen abweichen, z. B. bei Zugriff über mit [upvar] definierte Variablen.

        Bei Lese- und Schreib-Traces kann *commandPrefix* die Variable ändern und so das Ergebnis der überwachten Operation beeinflussen. Ändert *commandPrefix* den Wert während eines Lese- oder Schreib-Traces, wird der neue Wert als Ergebnis der überwachten Operation zurückgegeben. Der Rückgabewert von *commandPrefix* wird ignoriert, außer liefert er einen Fehler — dann liefert auch die überwachte Operation denselben Fehlertext (z. B. für schreibgeschützte Variablen). Bei Schreib-Traces wird *commandPrefix* nach der Wertänderung aufgerufen; er kann einen neuen Wert setzen und den ursprünglichen überschreiben. Für schreibgeschützte Variablen muss *commandPrefix* den alten Wert wiederherstellen.

        Während *commandPrefix* bei einem Lese- oder Schreib-Trace läuft, sind Traces auf die Variable vorübergehend deaktiviert: Lese- und Schreibzugriffe in *commandPrefix* erfolgen direkt ohne erneuten Aufruf von *commandPrefix* (oder anderer Traces). Entfernt *commandPrefix* die Variable, werden Unset-Traces aufgerufen.

        Bei einem Unset-Trace ist die Variable bereits gelöscht: sie erscheint undefiniert ohne Traces. Erfolgt das Unset wegen Prozedurrückkehr, läuft der Trace im Variablenkontext der Zielprozedur; der Stack-Frame der zurückkehrenden Prozedur existiert nicht mehr. Unset-Traces werden nicht deaktiviert; legt ein Unset-Trace einen neuen Trace an und greift auf die Variable zu, wird der Trace aufgerufen. Fehler in Unset-Traces werden ignoriert.

        Gibt es mehrere Traces auf einer Variable, werden sie in Erstellungsreihenfolge aufgerufen, zuletzt erstellter zuerst. Liefert ein Trace einen Fehler, werden keine weiteren Traces für die Variable aufgerufen. Hat ein Arrayelement einen Trace und das Array als Ganzes ebenfalls, wird zuerst der Trace auf dem gesamten Array aufgerufen.

        Der Trace bleibt bis zum Entfernen mit **trace remove variable** (unten), bis zum Unset der Variable oder bis zum Löschen des Interpreters aktiv. Entfernen eines Arrayelements entfernt Traces auf diesem Element, nicht auf dem gesamten Array.

        Der Befehl gibt eine leere Zeichenkette zurück.


[trace]{.cmd} [remove]{.sub} [type]{.arg} [name]{.arg} [opList]{.arg} [commandPrefix]{.arg}
: *type* ist **command**, **execution** oder **variable**.

    [trace]{.cmd} [remove]{.sub} [command]{.lit} [name]{.arg} [opList]{.arg} [commandPrefix]{.arg}
    : Gibt es einen Trace auf den Befehl *name* mit den Operationen und dem Befehl aus *opList* und *commandPrefix*, wird er entfernt; *commandPrefix* wird nicht mehr aufgerufen. Gibt eine leere Zeichenkette zurück. Existiert *name* nicht, wird ein Fehler ausgelöst.

    [trace]{.cmd} [remove]{.sub} [execution]{.lit} [name]{.arg} [opList]{.arg} [commandPrefix]{.arg}
    : Wie bei **trace remove command**; *commandPrefix* wird nicht mehr aufgerufen. Leere Zeichenkette. Existiert *name* nicht, Fehler.

    [trace]{.cmd} [remove]{.sub} [variable]{.lit} [name]{.arg} [opList]{.arg} [commandPrefix]{.arg}
    : Gibt es einen Trace auf die Variable *name* mit *opList* und *commandPrefix*, wird er entfernt. Leere Zeichenkette.


[trace]{.cmd} [info]{.sub} [type]{.arg} [name]{.arg}
: *type* ist **command**, **execution** oder **variable**.

    [trace]{.cmd} [info]{.sub} [command]{.lit} [name]{.arg}
    : Gibt eine Liste zurück mit einem Element pro Trace auf dem Befehl *name*. Jedes Element ist eine Liste mit *opList* und *commandPrefix*. Hat *name* keine Traces, leere Zeichenkette. Existiert *name* nicht, Fehler.

    [trace]{.cmd} [info]{.sub} [execution]{.lit} [name]{.arg}
    : Wie **trace info command**.

    [trace]{.cmd} [info]{.sub} [variable]{.lit} [name]{.arg}
    : Gibt eine Liste zurück mit einem Element pro Trace auf der Variable *name*. Jedes Element enthält *opList* und *commandPrefix*. Existiert *name* nicht oder hat keine Traces, leere Zeichenkette.



# Beispiele

Eine Meldung ausgeben, sobald eine der globalen Variablen **foo** oder **bar** aktualisiert wird, auch bei anderem lokalem Namen (z. B. mit [upvar]):

```
proc tracer {varname args} {
    upvar #0 $varname var
    puts "$varname was updated to be \"$var\""
}
trace add variable foo write "tracer foo"
trace add variable bar write "tracer bar"
```

Sicherstellen, dass die globale Variable **foobar** stets das Produkt von **foo** und **bar** enthält:

```
proc doMult args {
    global foo bar foobar
    set foobar [expr {$foo * $bar}]
}
trace add variable foo write doMult
trace add variable bar write doMult
```

Ausgabe, welche Befehle während der Verarbeitung einer Tcl-Prozedur ausgeführt werden:

```
proc x {} { y }
proc y {} { z }
proc z {} { puts hello }
proc report args {puts [info level 0]}
trace add execution x enterstep report
x
  → report y enterstep
    report z enterstep
    report {puts hello} enterstep
    hello
```


[array]: array.md
[info]: info.md
[namespace]: namespace.md
[uplevel]: uplevel.md
[upvar]: upvar.md
