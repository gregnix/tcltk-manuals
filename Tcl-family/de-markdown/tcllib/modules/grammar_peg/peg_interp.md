---
CommandName: grammar::peg::interp
ManualSection: n
Version: 0.1.2
TclPart: tcllib
TclDescription: Grammar operations and usage
Keywords:
 - LL(k)
 - TDPL
 - context-free languages
 - expression
 - grammar
 - matching
 - parsing
 - parsing expression
 - parsing expression grammar
 - push down automaton
 - recursive descent
 - state
 - top-down parsing languages
 - transducer
 - virtual machine
Copyright:
 - Copyright (c) 2005-2011 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

grammar::peg::interp – Interpreter zum Parsen von Ausdrucksgrammatiken

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [grammar::mengine]{.lit} [0.1]{.optlit} 
[package]{.cmd} [require]{.sub} [grammar::peg::interp]{.lit} [0.1.2]{.optlit} 
[::grammar::peg::interp::setup]{.cmd} [peg]{.arg} 
[::grammar::peg::interp::parse]{.cmd} [nextcmd]{.arg} [errorvar]{.arg} [astvar]{.arg} 
:::

# BESCHREIBUNG

Dieses Paket stellt Befehle für den kontrollierten Abgleich eines Zeichenstroms anhand einer Parsing Expression Grammar sowie für die Erstellung eines abstrakten Syntaxbaums für den Strom und Teilausdrücke bereit.

Es baut auf der vom Paket **grammar::me::tcl** bereitgestellten virtuellen Maschine auf und interpretiert die ihm übergebene Parsing Expression Grammar direkt. Mit anderen Worten: Die Grammatik wird *nicht* vorkompiliert, sondern unverändert verwendet.

Die zu interpretierende Grammatik wird aus einem Container-Objekt entnommen, das der durch das Paket **grammar::peg::container** festgelegten Schnittstelle entspricht. Es werden lediglich die relevanten Teile in den Zustand dieses Pakets kopiert.

Zu beachten ist, dass das Paket genau eine Instanz des Interpreters bereitstellt. Um eine zweite Grammatik zu interpretieren, muss man eine laufende Interpretation entweder abbrechen oder abschließen oder die Grammatiken in verschiedene Tcl-Interpreter legen.

Außerdem ist zu beachten, dass die Implementierung eine Pull-Verarbeitung der Eingabe voraussetzt. Der Interpreter ruft Zeichen aus dem Eingabestrom ab, sobald er sie benötigt. Für den Einsatz in einer Push-Umgebung, in der die Umgebung neue Zeichen übergibt, sobald sie eintreffen, muss die Engine in einen eigenen Thread gelegt werden.

# DIE INTERPRETER-API

Das Paket exportiert die folgende API

**::grammar::peg::interp::setup** *peg*
: Dieser Befehl initialisiert den Interpreter neu. Er gibt die leere Zeichenkette zurück. Dieser Befehl muss vor jedem Abgleich als Erstes aufgerufen werden. Sein Argument *peg* ist das Handle eines Objekts, das die zu interpretierende Parsing Expression Grammar enthält. Diese Grammatik muss gültig sein, andernfalls wird ein Fehler ausgelöst.

**::grammar::peg::interp::parse** *nextcmd* *errorvar* *astvar*
: Dieser Befehl interpretiert die geladene Grammatik und versucht, sie mit dem Zeichenstrom abzugleichen, der durch das Befehlspräfix *nextcmd* dargestellt wird. Das Befehlspräfix *nextcmd* steht für den Eingabezeichenstrom und wird vom Interpreter aufgerufen, sobald ein neues Zeichen aus dem Strom benötigt wird. Die Rückruffunktion muss entweder eine leere Liste zurückgeben oder eine Liste mit vier Elementen: das Token, sein Lexem-Attribut und seine Position als Zeilennummer und Spaltenindex, in dieser Reihenfolge. Die leere Liste signalisiert, dass das Ende des Eingabestroms erreicht wurde. Das Lexem-Attribut wird im Terminal-Cache gespeichert, von der Maschine aber sonst nicht verwendet. Das Ergebnis des Befehls ist ein boolescher Wert, der angibt, ob der Abgleich erfolgreich war (**true**) oder nicht (**false**). Schlägt der Abgleich fehl, werden Fehlerinformationen in der Variablen gespeichert, auf die *errorvar* verweist. Die Variable, auf die *astvar* verweist, enthält stets den erzeugten abstrakten Syntaxbaum; im Fehlerfall ist er nur unvollständig und möglicherweise fehlerhaft. Der abstrakte Syntaxbaum ist eine verschachtelte Liste, wie im Abschnitt **AST-WERTE** des Dokuments *grammar::me_ast* beschrieben.


# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *grammar_peg* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Grammatiken und endliche Automaten

# COPYRIGHT

```
Copyright (c) 2005-2011 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
