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

Dieser Befehl sorgt dafür, dass Tcl-Befehle ausgeführt werden, sobald bestimmte Operationen aufgerufen werden. Die zulässigen *option*s (sie dürfen abgekürzt werden) sind:

**trace add** *type name ops ?args?*
: Dabei ist *type* **command**, **execution** oder **variable**.

    **trace add command** *name ops commandPrefix*
    : Sorgt dafür, dass *commandPrefix* (mit zusätzlichen Argumenten) ausgeführt wird, sobald der Befehl *name* auf eine der Arten geändert wird, die die Liste *ops* angibt. *Name* wird nach den üblichen Regeln der Namespace-Auflösung für Befehle aufgelöst. Existiert der Befehl nicht, wird ein Fehler ausgelöst.

        *Ops* gibt an, welche Operationen von Interesse sind. Es ist eine Liste aus einem oder mehreren der folgenden Einträge:

        **rename**
        : Ruft *commandPrefix* auf, sobald der überwachte Befehl umbenannt wird. Beachten Sie, dass das Umbenennen in die leere Zeichenkette als Löschen gilt und nicht mit „**rename**“ überwacht wird.

        **delete**
        : Ruft *commandPrefix* auf, wenn der überwachte Befehl gelöscht wird. Befehle lassen sich explizit löschen, indem Sie sie mit dem Befehl **rename** in eine leere Zeichenkette umbenennen. Befehle werden auch gelöscht, wenn der Interpreter gelöscht wird. Die Traces werden dann aber nicht aufgerufen, weil es keinen Interpreter mehr gibt, in dem sie ausgeführt werden könnten.


        Wenn der Trace auslöst, werden je nach überwachter Operation einige Argumente an *commandPrefix* angehängt, sodass der tatsächliche Befehl so lautet:

        ```
        commandPrefix oldName newName op
        ```

        *OldName* und *newName* geben den aktuellen (alten) Namen des überwachten Befehls an und den Namen, in den er umbenannt wird (die leere Zeichenkette bei einer „delete“-Operation). *Op* gibt an, welche Operation an dem Befehl ausgeführt wird. Es ist **rename** oder **delete**, wie oben definiert. Mit der Trace-Operation lässt sich nicht verhindern, dass ein Befehl gelöscht wird. Tcl entfernt den Befehl immer, sobald der Trace abgeschlossen ist. Rekursives Umbenennen oder Löschen führt nicht dazu, dass weitere Traces desselben Typs ausgewertet werden. Ein Delete-Trace, der selbst den Befehl löscht, oder ein Rename-Trace, der selbst den Befehl umbenennt, löst also keine weiteren Trace-Auswertungen aus. *oldName* und *newName* sind beide vollständig mit den Namespaces qualifiziert, in denen sie vorkommen.

    **trace add execution** *name ops commandPrefix*
    : Sorgt dafür, dass *commandPrefix* (mit zusätzlichen Argumenten) ausgeführt wird, sobald der Befehl *name* ausgeführt wird. Die Traces erfolgen an den Stellen, die die Liste *ops* angibt. *Name* wird nach den üblichen Regeln der Namespace-Auflösung für Befehle aufgelöst. Existiert der Befehl nicht, wird ein Fehler ausgelöst.

        *Ops* gibt an, welche Operationen von Interesse sind. Es ist eine Liste aus einem oder mehreren der folgenden Einträge:

        **enter**
        : Ruft *commandPrefix* auf, sobald der Befehl *name* ausgeführt wird, und zwar unmittelbar bevor die eigentliche Ausführung stattfindet.

        **leave**
        : Ruft *commandPrefix* auf, sobald der Befehl *name* ausgeführt wird, und zwar unmittelbar nachdem die eigentliche Ausführung stattgefunden hat.

        **enterstep**
        : Ruft *commandPrefix* für jeden Tcl-Befehl auf, der vom Beginn der Ausführung der Prozedur *name* bis zu deren Ende ausgeführt wird. *CommandPrefix* wird unmittelbar vor der eigentlichen Ausführung des gemeldeten Tcl-Befehls aufgerufen. Gibt es zum Beispiel „proc foo {} { puts "hello" }“, dann wird ein *enterstep*-Trace unmittelbar vor der Ausführung von „*puts "hello"*“ aufgerufen. Ein *enterstep*-Trace auf einen Befehl *name*, der keine Prozedur bezeichnet, führt nicht zu einem Fehler, sondern wird einfach ignoriert.

        **leavestep**
        : Ruft *commandPrefix* für jeden Tcl-Befehl auf, der vom Beginn der Ausführung der Prozedur *name* bis zu deren Ende ausgeführt wird. *CommandPrefix* wird unmittelbar nach der eigentlichen Ausführung des gemeldeten Tcl-Befehls aufgerufen. Ein *leavestep*-Trace auf einen Befehl *name*, der keine Prozedur bezeichnet, führt nicht zu einem Fehler, sondern wird einfach ignoriert.


        Wenn der Trace auslöst, werden je nach überwachter Operation einige Argumente an *commandPrefix* angehängt, sodass der tatsächliche Befehl so lautet:

        Bei den Operationen **enter** und **enterstep**:

        ```
        commandPrefix command-string op
        ```

        *Command-string* gibt den vollständigen aktuellen Befehl an, der gerade ausgeführt wird (bei einer **enter**-Operation den überwachten Befehl, bei einer **enterstep**-Operation einen beliebigen Befehl), einschließlich aller Argumente in vollständig expandierter Form. *Op* gibt an, welche Operation bei der Befehlsausführung stattfindet. Es ist **enter** oder **enterstep**, wie oben definiert. Mit der Trace-Operation lässt sich die Ausführung des Befehls verhindern, indem der betreffende Befehl gelöscht wird. Wird der Befehl danach ausgeführt, tritt natürlich ein „invalid command“-Fehler auf.

        Bei den Operationen **leave** und **leavestep**:

        ```
        commandPrefix command-string code result op
        ```

        *Command-string* gibt den vollständigen aktuellen Befehl an, der gerade ausgeführt wird (bei einer **enter**-Operation den überwachten Befehl, bei einer **enterstep**-Operation einen beliebigen Befehl), einschließlich aller Argumente in vollständig expandierter Form. *Code* gibt den Ergebniscode dieser Ausführung an und *result* die Ergebniszeichenkette. *Op* gibt an, welche Operation bei der Befehlsausführung stattfindet. Es ist **leave** oder **leavestep**, wie oben definiert. Beachten Sie, dass das Anlegen vieler **enterstep**- oder **leavestep**-Traces zu unerwarteten Ergebnissen führen kann, da die von einem Trace aufgerufenen Befehle ihrerseits weitere Befehlsaufrufe für andere Traces auslösen können.

        *CommandPrefix* wird im selben Kontext ausgeführt wie der Code, der die überwachte Operation aufgerufen hat. Wird *commandPrefix* aus einer Prozedur heraus aufgerufen, hat *commandPrefix* also Zugriff auf dieselben lokalen Variablen wie der Code in der Prozedur. Dieser Kontext kann sich von dem Kontext unterscheiden, in dem der Trace angelegt wurde. Ruft *commandPrefix* eine Prozedur auf (was normalerweise der Fall ist), muss diese Prozedur die Befehle [upvar] oder [uplevel] verwenden, wenn sie auf die lokalen Variablen des Codes zugreifen will, der die Trace-Operation ausgelöst hat.

        Während *commandPrefix* im Rahmen eines Execution-Traces ausgeführt wird, sind die Traces auf *name* vorübergehend deaktiviert. So kann *commandPrefix* in seinem Rumpf *name* ausführen, ohne erneut andere Traces aufzurufen. Tritt bei der Ausführung von *commandPrefix* ein Fehler auf, gibt der Befehl *name* insgesamt denselben Fehler zurück.

        Sind mehrere Traces auf *name* gesetzt, werden bei den Operationen *enter* und *enterstep* die Trace-Befehle in umgekehrter Reihenfolge ihrer Erstellung aufgerufen. Bei den Operationen *leave* und *leavestep* werden die Trace-Befehle in der ursprünglichen Reihenfolge ihrer Erstellung aufgerufen.

        Das Verhalten von Execution-Traces ist für einen Befehl *name*, der in einen anderen Namespace importiert wurde, derzeit undefiniert.

    **trace add variable** *name ops commandPrefix*
    : Sorgt dafür, dass *commandPrefix* ausgeführt wird, sobald auf die Variable *name* auf eine der Arten zugegriffen wird, die die Liste *ops* angibt. *Name* kann eine normale Variable bezeichnen, ein Element eines Arrays oder ein Array als Ganzes (das heißt, *name* kann auch nur der Name eines Arrays ohne Index in Klammern sein). Bezeichnet *name* ein ganzes Array, wird *commandPrefix* aufgerufen, sobald irgendein Element des Arrays bearbeitet wird. Existiert die Variable nicht, wird sie angelegt, erhält aber keinen Wert. Sie ist dann für Abfragen mit [namespace which][namespace] sichtbar, aber nicht für Abfragen mit [info exists][info].

        *Ops* gibt an, welche Operationen von Interesse sind. Es ist eine Liste aus einem oder mehreren der folgenden Einträge:

        [array]
        : Ruft *commandPrefix* auf, sobald über den Befehl [array] auf die Variable zugegriffen oder sie darüber geändert wird. Voraussetzung ist, dass *name* zum Zeitpunkt des Aufrufs von [array] keine skalare Variable ist. Ist *name* eine skalare Variable, löst der Zugriff über den Befehl [array] den Trace nicht aus.

        **read**
        : Ruft *commandPrefix* auf, sobald die Variable gelesen wird.

        **write**
        : Ruft *commandPrefix* auf, sobald die Variable geschrieben wird.

        **unset**
        : Ruft *commandPrefix* auf, sobald die Variable entfernt wird. Variablen können explizit mit dem Befehl **unset** entfernt werden oder implizit, wenn Prozeduren zurückkehren (dabei werden alle ihre lokalen Variablen entfernt). Variablen werden auch entfernt, wenn Interpreter gelöscht werden. Die Traces werden dann aber nicht aufgerufen, weil es keinen Interpreter mehr gibt, in dem sie ausgeführt werden könnten.


        Wenn der Trace auslöst, werden drei Argumente an *commandPrefix* angehängt, sodass der tatsächliche Befehl so lautet:

        ```
        commandPrefix name1 name2 op
        ```

        *Name1* und *name2* geben den oder die Namen der Variablen an, auf die zugegriffen wird: Ist die Variable ein Skalar, gibt *name1* den Namen der Variablen an, und *name2* ist eine leere Zeichenkette. Ist die Variable ein Arrayelement, gibt *name1* den Namen des Arrays an und name2 den Index in das Array. Wird ein ganzes Array gelöscht und wurde der Trace auf das gesamte Array statt auf ein einzelnes Element registriert, gibt *name1* den Namen des Arrays an, und *name2* ist eine leere Zeichenkette. *Name1* und *name2* stimmen nicht unbedingt mit dem Namen überein, der im Befehl **trace variable** verwendet wurde: Der Befehl [upvar] erlaubt es einer Prozedur, eine Variable unter einem anderen Namen anzusprechen. *Op* gibt an, welche Operation an der Variablen ausgeführt wird. Es ist **read**, **write** oder **unset**, wie oben definiert.

        *CommandPrefix* wird im selben Kontext ausgeführt wie der Code, der die überwachte Operation aufgerufen hat. Wurde auf die Variable innerhalb einer Tcl-Prozedur zugegriffen, hat *commandPrefix* Zugriff auf dieselben lokalen Variablen wie der Code in der Prozedur. Dieser Kontext kann sich von dem Kontext unterscheiden, in dem der Trace angelegt wurde. Ruft *commandPrefix* eine Prozedur auf (was normalerweise der Fall ist), muss diese Prozedur [upvar] oder [uplevel] verwenden, wenn sie auf die überwachte Variable zugreifen will. Beachten Sie auch, dass *name1* nicht unbedingt derselbe Name ist, mit dem der Trace auf die Variable gesetzt wurde. Unterschiede können entstehen, wenn der Zugriff über eine Variable erfolgt, die mit dem Befehl [upvar] definiert wurde.

        Bei Lese- und Schreib-Traces kann *commandPrefix* die Variable ändern und so das Ergebnis der überwachten Operation beeinflussen. Ändert *commandPrefix* während eines Lese- oder Schreib-Traces den Wert einer Variablen, wird der neue Wert als Ergebnis der überwachten Operation zurückgegeben. Der Rückgabewert von *commandPrefix* wird ignoriert. Gibt *commandPrefix* jedoch einen Fehler irgendeiner Art zurück, gibt auch die überwachte Operation einen Fehler zurück, und zwar mit derselben Fehlermeldung, die der Trace-Befehl zurückgegeben hat (mit diesem Mechanismus lassen sich zum Beispiel schreibgeschützte Variablen umsetzen). Bei Schreib-Traces wird *commandPrefix* aufgerufen, nachdem der Wert der Variablen geändert wurde. *CommandPrefix* kann einen neuen Wert in die Variable schreiben und so den ursprünglichen Wert überschreiben, den die Schreiboperation angegeben hat. Um schreibgeschützte Variablen umzusetzen, muss *commandPrefix* den alten Wert der Variablen wiederherstellen.

        Während *commandPrefix* im Rahmen eines Lese- oder Schreib-Traces ausgeführt wird, sind die Traces auf die Variable vorübergehend deaktiviert. Lese- und Schreibzugriffe, die *commandPrefix* auslöst, erfolgen also direkt, ohne dass *commandPrefix* (oder ein anderer Trace) erneut aufgerufen wird. Entfernt *commandPrefix* die Variable jedoch, werden die Unset-Traces aufgerufen.

        Wenn ein Unset-Trace aufgerufen wird, ist die Variable bereits gelöscht: Sie erscheint als undefiniert und hat keine Traces. Wird eine Variable entfernt, weil eine Prozedur zurückkehrt, wird der Trace im Variablenkontext der Prozedur aufgerufen, zu der zurückgekehrt wird: Der Stack-Frame der zurückkehrenden Prozedur existiert dann nicht mehr. Während Unset-Traces werden Traces nicht deaktiviert. Legt ein Unset-Trace-Befehl also einen neuen Trace an und greift auf die Variable zu, wird dieser Trace aufgerufen. Fehler in Unset-Traces werden ignoriert.

        Gibt es mehrere Traces auf einer Variablen, werden sie in der Reihenfolge ihrer Erstellung aufgerufen, der zuletzt angelegte zuerst. Gibt ein Trace einen Fehler zurück, werden für die Variable keine weiteren Traces aufgerufen. Hat ein Arrayelement einen Trace und gibt es auch einen Trace auf das Array als Ganzes, wird der Trace auf das gesamte Array vor dem Trace auf das Element aufgerufen.

        Ein einmal angelegter Trace bleibt wirksam, bis er mit dem unten beschriebenen Befehl **trace remove variable** entfernt wird, bis die Variable entfernt wird oder bis der Interpreter gelöscht wird. Wird ein Element eines Arrays entfernt, werden alle Traces auf diesem Element entfernt, nicht aber die Traces auf dem gesamten Array.

        Dieser Befehl gibt eine leere Zeichenkette zurück.


**trace remove** *type name opList commandPrefix*
: Dabei ist *type* **command**, **execution** oder **variable**.

    **trace remove command** *name opList commandPrefix*
    : Ist auf den Befehl *name* ein Trace mit den Operationen und dem Befehl gesetzt, die *opList* und *commandPrefix* angeben, wird dieser Trace entfernt, sodass *commandPrefix* nie wieder aufgerufen wird. Gibt eine leere Zeichenkette zurück. Existiert *name* nicht, löst der Befehl einen Fehler aus.

    **trace remove execution** *name opList commandPrefix*
    : Ist auf den Befehl *name* ein Trace mit den Operationen und dem Befehl gesetzt, die *opList* und *commandPrefix* angeben, wird dieser Trace entfernt, sodass *commandPrefix* nie wieder aufgerufen wird. Gibt eine leere Zeichenkette zurück. Existiert *name* nicht, löst der Befehl einen Fehler aus.

    **trace remove variable** *name opList commandPrefix*
    : Ist auf die Variable *name* ein Trace mit den Operationen und dem Befehl gesetzt, die *opList* und *commandPrefix* angeben, wird dieser Trace entfernt, sodass *commandPrefix* nie wieder aufgerufen wird. Gibt eine leere Zeichenkette zurück.


**trace info** *type name*
: Dabei ist *type* **command**, **execution** oder **variable**.

    **trace info command** *name*
    : Gibt eine Liste zurück, die für jeden derzeit auf den Befehl *name* gesetzten Trace ein Element enthält. Jedes Element der Liste ist selbst eine Liste aus zwei Elementen: der *opList* und dem *commandPrefix*, die zu dem Trace gehören. Sind auf *name* keine Traces gesetzt, ist das Ergebnis des Befehls eine leere Zeichenkette. Existiert *name* nicht, löst der Befehl einen Fehler aus.

    **trace info execution** *name*
    : Gibt eine Liste zurück, die für jeden derzeit auf den Befehl *name* gesetzten Trace ein Element enthält. Jedes Element der Liste ist selbst eine Liste aus zwei Elementen: der *opList* und dem *commandPrefix*, die zu dem Trace gehören. Sind auf *name* keine Traces gesetzt, ist das Ergebnis des Befehls eine leere Zeichenkette. Existiert *name* nicht, löst der Befehl einen Fehler aus.

    **trace info variable** *name*
    : Gibt eine Liste zurück, die für jeden derzeit auf die Variable *name* gesetzten Trace ein Element enthält. Jedes Element der Liste ist selbst eine Liste aus zwei Elementen: der *opList* und dem *commandPrefix*, die zu dem Trace gehören. Existiert *name* nicht oder sind darauf keine Traces gesetzt, ist das Ergebnis des Befehls eine leere Zeichenkette.



Zur Abwärtskompatibilität stehen drei weitere Unterbefehle zur Verfügung:

**trace variable** *name ops command*
: Dies entspricht **trace add variable** *name ops command*.

**trace vdelete** *name ops command*
: Dies entspricht **trace remove variable** *name ops command*

**trace vinfo** *name*
: Dies entspricht **trace info variable** *name*


Diese Unterbefehle sind veraltet und werden in einer zukünftigen Tcl-Version wahrscheinlich entfernt. Sie verwenden eine ältere Syntax, in der [array], **read**, **write**, **unset** durch **a**, **r**, **w** und **u** ersetzt sind und das Argument *ops* keine Liste ist, sondern eine Zeichenkette aus aneinandergereihten Operationen, z. B. **rwua**.

# Beispiele

Eine Meldung ausgeben, sobald eine der globalen Variablen **foo** und **bar** aktualisiert wird, auch wenn sie zu diesem Zeitpunkt einen anderen lokalen Namen haben (was mit dem Befehl [upvar] möglich ist):

```
proc tracer {varname args} {
    upvar #0 $varname var
    puts "$varname was updated to be \"$var\""
}
trace add variable foo write "tracer foo"
trace add variable bar write "tracer bar"
```

Sicherstellen, dass die globale Variable **foobar** immer das Produkt der globalen Variablen **foo** und **bar** enthält:

```
proc doMult args {
    global foo bar foobar
    set foobar [expr {$foo * $bar}]
}
trace add variable foo write doMult
trace add variable bar write doMult
```

Protokollieren, welche Befehle bei der Verarbeitung einer Tcl-Prozedur ausgeführt werden:

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
