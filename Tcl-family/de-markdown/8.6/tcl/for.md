---
CommandName: for
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

# NAME

for - For-Schleife

# ÜBERSICHT

::: {.synopsis} :::
[for]{.cmd} [start]{.arg} [test]{.arg} [next]{.arg} [body]{.arg} 
:::

# BESCHREIBUNG

**for** ist ein Schleifenbefehl, strukturell ähnlich der C-Anweisung **for**. Die Argumente *start*, *next* und *body* müssen Tcl-Befehlszeichenketten sein; *test* ist ein Ausdrucksstring. **for** ruft zuerst den Tcl-Interpreter auf, um *start* auszuführen. Dann wird *test* wiederholt als Ausdruck ausgewertet; ist das Ergebnis ungleich null, ruft es den Tcl-Interpreter für *body* auf, dann für *next*, und wiederholt die Schleife. Der Befehl endet, wenn *test* zu 0 auswertet. Wird **continue** innerhalb von *body* aufgerufen, werden verbleibende Befehle in der aktuellen Ausführung von *body* übersprungen; die Verarbeitung setzt fort mit Aufruf des Tcl-Interpreters für *next*, dann Auswertung von *test* usw. Wird **break** innerhalb von *body* oder *next* aufgerufen, kehrt **for** sofort zurück. Die Wirkung von **break** und **continue** entspricht den entsprechenden Anweisungen in C. **for** gibt eine leere Zeichenkette zurück.

Hinweis: *test* sollte fast immer in geschweifte Klammern eingeschlossen sein. Andernfalls erfolgen Variablensubstitutionen, bevor **for** ausführt — Änderungen durch den Schleifenkörper fließen dann nicht in den Ausdruck ein, was leicht zu einer Endlosschleife führt. Ist *test* in Klammern, werden Substitutions verzögert bis zur Auswertung (vor jeder Iteration), sodass Variablenänderungen sichtbar sind. Siehe Beispiele unten.

# BEISPIELE

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
