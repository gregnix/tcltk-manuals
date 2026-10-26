---
CommandName: uplevel
ManualSection: n
Version: unknown
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - apply(n)
 - namespace(n)
 - upvar(n)
Keywords:
 - context
 - level
 - namespace
 - stack frame
 - variable
Copyright:
 - Copyright (c) 1993 The Regents of the University of California.
 - Copyright (c) 1994-1997 Sun Microsystems, Inc.
---

# NAME

uplevel - Führt ein Skript in einem anderen Stack-Frame aus

# ÜBERSICHT

::: {.synopsis} :::
[uplevel]{.cmd} [level]{.optarg} [arg]{.arg} [arg]{.optdot} 
:::

# BESCHREIBUNG

Alle *arg*-Argumente werden verkettet, als wären sie an **concat** übergeben worden; das Ergebnis wird im durch *level* angegebenen Variablenkontext ausgewertet. **Uplevel** gibt das Ergebnis dieser Auswertung zurück.

Ist *level* eine Ganzzahl, gibt sie einen Abstand (aufwärts auf dem Prozeduraufrufstack) an, um den vor der Ausführung des Befehls verschoben wird. Besteht *level* aus **#** gefolgt von einer Zahl, gibt die Zahl eine absolute Ebenennummer an. Fehlt *level*, ist der Standardwert **1**. *Level* kann nicht weggelassen werden, wenn das erste *command*-Argument mit einer Ziffer oder **#** beginnt.

Angenommen, die Prozedur **a** wurde von der obersten Ebene aufgerufen, **a** rief **b** auf und **b** rief **c** auf. **c** ruft **uplevel** auf. Ist *level* **1** oder **#2** oder weggelassen, wird der Befehl im Variablenkontext von **b** ausgeführt. Ist *level* **2** oder **#1**, im Kontext von **a**. Ist *level* **3** oder **#0**, auf der obersten Ebene (nur globale Variablen sind sichtbar).

Der Befehl **uplevel** lässt die aufrufende Prozedur während der Ausführung des Befehls vom Prozeduraufrufstack verschwinden. Im obigen Beispiel ruft **c** auf:

```
uplevel 1 {set x 43; d}
```

wobei **d** eine weitere Tcl-Prozedur ist. Der Befehl **set** ändert die Variable **x** im Kontext von **b**, und **d** läuft auf Ebene 3, als wäre sie von **b** aufgerufen. Führt **d** wiederum aus:

```
uplevel {set x 42}
```

so ändert **set** dieselbe Variable **x** im Kontext von **b**: die Prozedur **c** scheint beim Ausführen von **d** nicht auf dem Aufrufstack zu liegen. Mit **info level** kann die Ebene der aktuellen Prozedur ermittelt werden.

**Uplevel** ermöglicht neue Steuerkonstrukte als Tcl-Prozeduren (z. B. ließe sich **while** als Tcl-Prozedur mit **uplevel** implementieren).

Die Befehle **namespace eval** und **apply** bieten weitere Wege (neben Prozeduraufrufen), den Tcl-Namenskontext zu wechseln. Sie legen einen Aufrufframe auf den Stack, der den Namespace-Kontext repräsentiert. Jeder Befehl **namespace eval** zählt damit als weitere Aufrufebene für **uplevel** und **upvar**. **info level 1** liefert zum Beispiel eine Liste, die einen Befehl beschreibt, der entweder der äußerste Prozeduraufruf oder der äußerste **namespace eval**-Befehl ist. **uplevel #0** wertet ein Skript auf der obersten Ebene im äußersten Namespace (dem globalen Namespace) aus.

# BEISPIEL

Wie oben beschrieben, eignet sich **uplevel** zum Erzeugen neuer Steuerkonstrukte. Dieses Beispiel zeigt (ohne Fehlerbehandlung), wie ein **do**-Befehl als Gegenstück zu **while** erstellt wird, der die Bedingung stets nach dem Schleifenkörper prüft:

```
proc do {body while condition} {
    if {$while ne "while"} {
        error "required word missing"
    }
    set conditionCmd [list expr $condition]
    while {1} {
        uplevel 1 $body
        if {![uplevel 1 $conditionCmd]} {
            break
        }
    }
}
```
