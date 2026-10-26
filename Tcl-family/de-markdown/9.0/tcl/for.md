---
CommandName: for
title: for
ManualSection: n
Version: unknown
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - break(n)
 - continue(n)
 - foreach(n)
 - while(n)
Keywords:
 - boolean
 - for
 - iteration
 - loop
Copyright:
 - Copyright (c) 1993 The Regents of the University of California.
 - Copyright (c) 1994-1997 Sun Microsystems, Inc.
---

# Name

for - 'For'-Schleife

# Übersicht

::: {.synopsis} :::
[for]{.cmd} [start]{.arg} [test]{.arg} [next]{.arg} [body]{.arg}
:::

# Beschreibung

**for** ist ein Schleifen-Befehl, ähnlich in der Struktur zur C **for**-Anweisung. Die Argumente *start*, *next* und *body* müssen Tcl-Befehlsstrings sein, und *test* ist ein Ausdrucksstring. Der **for**-Befehl ruft zuerst den Tcl-Interpreter auf, um *start* auszuführen. Dann wertet er wiederholt *test* als Ausdruck aus; wenn das Ergebnis nicht null ist, ruft er den Tcl-Interpreter für *body* auf, dann ruft er den Tcl-Interpreter für *next* auf und wiederholt dann die Schleife. Der Befehl endet, wenn *test* zu 0 ausgewertet wird. Wenn ein [continue]-Befehl innerhalb von *body* aufgerufen wird, werden alle verbleibenden Befehle in der aktuellen Ausführung von *body* übersprungen; die Verarbeitung wird fortgesetzt, indem der Tcl-Interpreter für *next* aufgerufen wird, dann *test* ausgewertet wird und so weiter. Wenn ein [break]-Befehl innerhalb von *body* oder *next* aufgerufen wird, kehrt der **for**-Befehl sofort zurück. Die Funktionsweise von [break] und [continue] ist ähnlich den entsprechenden Anweisungen in C. **for** gibt einen leeren String zurück.

Beachten Sie, dass *test* fast immer in geschweifte Klammern eingeschlossen werden sollte. Wenn nicht, werden Variablenersetzungen vorgenommen, bevor der **for**-Befehl mit der Ausführung beginnt, was bedeutet, dass Variablenänderungen durch den Schleifenkörper nicht im Ausdruck berücksichtigt werden. Dies führt wahrscheinlich zu einer Endlosschleife. Wenn *test* in geschweifte Klammern eingeschlossen ist, werden Variablenersetzungen verzögert, bis der Ausdruck ausgewertet wird (vor jeder Schleifeniteration), sodass Änderungen an den Variablen sichtbar werden. Siehe unten ein Beispiel:

# Beispiele

Gibt eine Zeile für jede Ganzzahl von 0 bis 9 aus:

```
for {set x 0} {$x<10} {incr x} {
    puts "x is $x"
}
```

Entweder läuft die Schleife endlos oder überhaupt nicht, weil der auszuwertende Ausdruck tatsächlich die Konstante ist, oder es wird sogar ein Fehler erzeugt! Das tatsächliche Verhalten hängt davon ab, ob die Variable *x* vor der Ausführung des **for**-Befehls existiert und ob ihr Wert kleiner als oder größer/gleich zehn ist, und das liegt daran, dass der Ausdruck ersetzt wird, bevor der **for**-Befehl ausgeführt wird.

```
for {set x 0} $x<10 {incr x} {
    puts "x is $x"
}
```

Gibt die Zweierpotenzen von 1 bis 1024 aus:

```
for {set x 1} {$x<=1024} {set x [expr {$x * 2}]} {
    puts "x is $x"
}
```


[break]: break.md
[continue]: continue.md
