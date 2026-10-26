---
CommandName: grammar::aycock
title: grammar::aycock
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: Aycock-Horspool-Earley parser generator for Tcl
Keywords:
 - Aycock
 - Earley
 - Horspool
 - parser
 - compiler
Keywords:
 - ambiguous
 - aycock
 - earley
 - grammar
 - horspool
 - parser
 - parsing
 - transducer
Copyright:
 - Copyright (c) 2006 by Kevin B. Kenny <kennykb@acm.org>
---

# Name

grammar::aycock – Aycock-Horspool-Earley-Parsergenerator für Tcl

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [grammar::aycock]{.lit} [1.1]{.optlit}
[::aycock::parser]{.cmd} [grammar]{.arg} [-verbose]{.optlit}
[parserName]{.ins} [parse]{.sub} [symList]{.arg} [valList]{.arg} [clientData]{.optarg}
[parserName]{.ins} [destroy]{.sub}
[parserName]{.ins} [terminals]{.sub}
[parserName]{.ins} [nonterminals]{.sub}
[parserName]{.ins} [save]{.sub}
:::

# Beschreibung

Das Paket **grammar::aycock** implementiert einen Parsergenerator für die Klasse von Parsern, die beschrieben ist in John Aycock und R. Nigel Horspool, Practical Earley Parsing, *The Computer Journal,* *45*(6):620-630, 2002. <http://citeseerx.ist.psu.edu/viewdoc/summary?doi=10.1.1.12.4254>

# Prozeduren

Das Paket **grammar::aycock** exportiert die folgende einzelne Prozedur:

**::aycock::parser** *grammar* ?**-verbose**?
: Erzeugt einen Parser für die angegebene *grammar* und gibt dessen Namen zurück. Wird das optionale Flag **-verbose** angegeben, gibt der Befehl ausführliche Informationen zum erzeugten Parser auf der Standardausgabe aus. Der zurückgegebene Parser ist ein Objekt, das die im Abschnitt [Objektbefehl] gezeigten Befehle akzeptiert.


# Objektbefehl

*parserName* **parse** *symList* *valList* ?*clientData*?
: Ruft einen von **::aycock::parser** zurückgegebenen Parser auf. *symList* ist eine Liste von Grammatiksymbolen, die die Terminale einer Eingabezeichenkette darstellen, und *valList* ist eine Liste ihrer semantischen Werte. Das Ergebnis ist der semantische Wert der gesamten Zeichenkette nach dem Parsen.

*parserName* **destroy**
: Löscht einen von **::aycock::parser** erstellten Parser.

*parserName* **terminals**
: Gibt eine Liste von Terminalsymbolen zurück, die im Argument *symList* des Objektbefehls **parse** angegeben werden können.

*parserName* **nonterminals**
: Gibt eine Liste der nichtterminalen Symbole zurück, die in der Grammatik des Parsers definiert wurden.

*parserName* **save**
: Gibt ein Tcl-Skript zurück, das den Parser rekonstruiert, ohne dass zur Laufzeit der gesamte Mechanismus des Parsergenerators benötigt wird. Der rekonstruierte Parser stützt sich auf eine Reihe von Befehlen im Paket **grammar::aycock::runtime**, das ebenfalls automatisch geladen wird, wenn das Paket **grammar::aycock** geladen wird.


# Beschreibung

Der Befehl **grammar::aycock::parser** akzeptiert eine Grammatik, die als Tcl-Liste ausgedrückt wird. Die Liste muss als Verkettung einer Reihe von *Regeln* aufgebaut sein. Jede *Regel* umfasst eine variable Anzahl von Elementen in der Liste:

- Der Name des nichtterminalen Symbols, auf das die Regel reduziert wird.

- Die literale Zeichenkette **::=**

- Null oder mehr Namen von terminalen oder nichtterminalen Symbolen, aus denen die rechte Seite der Regel besteht.

- Abschließend ein Tcl-Skript, das ausgeführt werden soll, wenn die Regel reduziert wird. Innerhalb des angegebenen Skripts enthält eine Variable namens **\_** eine Liste der semantischen Werte der Symbole auf der rechten Seite. Der vom Skript zurückgegebene Wert soll dem semantischen Wert der linken Seite entsprechen. Wenn der Parameter *clientData* an die Methode **parse** übergeben wurde, steht er in einer Variable namens **clientData** zur Verfügung.  Es ist zulässig, dass das Skript eine leere Zeichenkette ist. In diesem Fall entspricht der semantische Wert der Regel dem semantischen Wert des ersten Symbols auf der rechten Seite.  Wenn die rechte Seite ebenfalls leer ist, entspricht der semantische Wert der leeren Zeichenkette.


Die Analyse erfolgt mit einem Earley-Parser, der zwar hinsichtlich Geschwindigkeit und Speicherverbrauch nicht besonders effizient ist, jedoch effektiv mit mehrdeutigen Grammatiken umgeht.  Aus diesem Grund eignet sich das Paket **grammar::aycock** möglicherweise am besten für die Verarbeitung natürlicher Sprache oder das Parsen außerordentlich komplexer Sprachen, in denen Mehrdeutigkeiten toleriert werden können.

# Beispiel

Der folgende Code veranschaulicht einen einfachen Tischrechner, der als Operatoren ausschließlich **+**, **\*** und Klammern zulässt. Er zeigt zudem das Format, in dem der lexikalische Analysator die Terminalsymbole dem Parser bereitstellen soll.

```
set p [aycock::parser {
    start ::= E {}
    E ::= E + T {expr {[lindex $_ 0] + [lindex $_ 2]}}
    E ::= T {}
    T ::= T * F {expr {[lindex $_ 0] * [lindex $_ 2]}}
    T ::= F {}
    F ::= NUMBER {}
    F ::= ( E ) {lindex $_ 1}
}]
puts [$p parse {(  NUMBER +  NUMBER )  *  ( NUMBER +  NUMBER ) }  {{} 2      {} 3      {} {} {} 7     {} 1      {}}]
$p destroy
```

Wird das Beispiel ausgeführt, gibt es **40** aus.

# Kategorie

Grammatiken und endliche Automaten

# Copyright

```
Copyright (c) 2006 by Kevin B. Kenny <kennykb@acm.org>
Redistribution permitted under the terms of the Open Publication License <http://www.opencontent.org/openpub/>
```
