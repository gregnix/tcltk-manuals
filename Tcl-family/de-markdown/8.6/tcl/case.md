---
CommandName: case
ManualSection: n
Version: 7.0
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - switch(n)
Keywords:
 - case
 - match
 - regular expression
Copyright:
 - Copyright (c) 1993 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# NAME

case - Eines von mehreren Skripten auswerten, abhängig von einem Wert

# ÜBERSICHT

::: {.synopsis} :::
[case]{.cmd} [string]{.arg} [in]{.optlit} [patList]{.arg} [body]{.arg} [patList body]{.optdot} 
[case]{.cmd} [string]{.arg} [in]{.optlit} { [patList]{.arg} [body]{.arg} [patList body]{.optdot} } 
:::

# BESCHREIBUNG

*Hinweis: Der Befehl* **case** *ist veraltet und wird nur noch aus Kompatibilitätsgründen unterstützt. In Zukunft kann er vollständig entfernt werden. Verwenden Sie stattdessen den Befehl* **switch**_._

Der Befehl **case** vergleicht *string* nacheinander mit jedem Argument *patList*. Jedes Argument *patList* ist eine Liste aus einem oder mehreren Mustern. Passt eines dieser Muster zu *string*, wertet **case** das folgende Argument *body* aus, indem es rekursiv an den Tcl-Interpreter übergeben wird, und gibt das Ergebnis dieser Auswertung zurück. Jedes Argument *patList* besteht aus einem einzelnen Muster oder einer Liste von Mustern. Jedes Muster darf die unter **string match** beschriebenen Wildcards enthalten. Ist ein Argument *patList* **default**, wird der zugehörige *body* ausgewertet, wenn kein *patList* zu *string* passt. Passt kein Argument *patList* zu *string* und ist kein **default** angegeben, gibt der Befehl **case** eine leere Zeichenkette zurück.

Für die Argumente *patList* und *body* gibt es zwei Syntaxformen. Die erste verwendet ein separates Argument für jedes Muster und jeden Befehl; diese Form ist praktisch, wenn Ersetzungen in einigen Mustern oder Befehlen gewünscht sind. Die zweite Form fasst alle Muster und Befehle in einem einzigen Argument zusammen; das Argument muss eine gültige Listenstruktur haben, deren Elemente die Muster und Befehle sind. Die zweite Form erleichtert mehrzeilige **case**-Befehle, da die geschweiften Klammern um die gesamte Liste kein Backslash am Zeilenende erfordern. Da die Argumente *patList* in der zweiten Form in geschweiften Klammern stehen, werden auf ihnen keine Befehls- oder Variablenersetzungen ausgeführt; dadurch unterscheidet sich das Verhalten der zweiten Form in manchen Fällen von der ersten.
