---
CommandName: while
ManualSection: n
Version: unknown
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - break(n)
 - continue(n)
 - for(n)
 - foreach(n)
Keywords:
 - boolean
 - loop
 - test
 - while
Copyright:
 - Copyright (c) 1993 The Regents of the University of California.
 - Copyright (c) 1994-1997 Sun Microsystems, Inc.
---

# NAME

while - Führt ein Script wiederholt aus, solange eine Bedingung erfüllt ist

# ÜBERSICHT

::: {.synopsis} :::
[while]{.cmd} [test]{.arg} [body]{.arg} 
:::

# BESCHREIBUNG

Der Befehl **while** wertet *test* als Ausdruck aus (auf dieselbe Weise wie **expr** sein Argument auswertet). Der Wert des Ausdrucks muss ein gültiger Boolean-Wert sein; wenn er wahr ist, wird *body* ausgeführt, indem es an den Tcl-Interpreter übergeben wird. Sobald *body* ausgeführt wurde, wird *test* erneut ausgewertet, und der Prozess wiederholt sich, bis *test* schließlich zu einem falschen Boolean-Wert ausgewertet wird. **continue**-Befehle können innerhalb von *body* ausgeführt werden, um die aktuelle Iteration der Schleife zu beenden, und **break**-Befehle können innerhalb von *body* ausgeführt werden, um den **while**-Befehl sofort zu beenden. Der **while**-Befehl gibt immer einen leeren String zurück.

Hinweis: *test* sollte fast immer in geschweifte Klammern eingeschlossen werden. Wenn nicht, werden Variablenersetzungen vorgenommen, bevor der **while**-Befehl mit der Ausführung beginnt, was bedeutet, dass Variablenänderungen durch den Schleifenkörper nicht im Ausdruck berücksichtigt werden. Dies führt wahrscheinlich zu einer Endlosschleife. Wenn *test* in geschweifte Klammern eingeschlossen ist, werden Variablenersetzungen verzögert, bis der Ausdruck ausgewertet wird (vor jeder Schleifeniteration), sodass Änderungen an den Variablen sichtbar werden. Probieren Sie als Beispiel das folgende Script mit und ohne die geschweiften Klammern um **$x<10**:

```
set x 0
while {$x<10} {
    puts "x is $x"
    incr x
}
```

# BEISPIEL

Liest Zeilen aus einem Kanal bis zum Ende des Streams und gibt sie mit vorangestellter Zeilennummer aus:

```
set lineCount 0
while {[gets $chan line] >= 0} {
    puts "[incr lineCount]: $line"
}
```

