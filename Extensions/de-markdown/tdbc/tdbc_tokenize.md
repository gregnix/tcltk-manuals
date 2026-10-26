---
CommandName: tdbc::tokenize
ManualSection: n
Version: 8.6
TclPart: Tcl
TclDescription: Tcl Database Connectivity
Links:
 - tdbc(n)
 - tdbc::connection(n)
 - tdbc::statement(n)
 - tdbc::resultset(n)
Keywords:
 - TDBC
 - SQL
 - database
 - tokenize
Copyright:
 - Copyright (c) 2008 by Kevin B. Kenny.
---

# NAME

tdbc::tokenize - SQL-Tokenizer für TDBC

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [tdbc]{.lit} [1.0]{.lit} 

[tdbc::tokenize]{.cmd} [string]{.arg} 
:::

# BESCHREIBUNG

Als Hilfe für Datenbanktreiber stellt Tcl Database Connectivity (TDBC) einen Befehl bereit, der SQL-Code in Token zerlegt, damit gebundene Variablen leicht erkannt und eingesetzt werden können.

Der Befehl **tdbc::tokenize** nimmt als Parameter eine Zeichenkette entgegen, die eine oder mehrere SQL-Anweisungen enthalten soll. Er gibt eine Liste von Teilzeichenketten zurück; aneinandergereiht ergeben diese Teilzeichenketten wieder die ursprüngliche Zeichenkette. Jede Teilzeichenkette ist eines der Folgenden:

**\[1\]**
: Eine gebundene Variable, die mit einem der Zeichen „**:**“, „**@**“ oder „**\$**“ beginnt. Der Rest der Zeichenkette ist der Variablenname und besteht aus alphanumerischen Zeichen und Unterstrichen. (Das führende Zeichen ist nicht numerisch.)

**\[2\]**
: Ein Semikolon, das zwei SQL-Anweisungen trennt.

**\[3\]**
: Etwas anderes in einer SQL-Anweisung. Der Tokenizer versucht nicht, SQL zu parsen; er erkennt lediglich gebundene Variablen (und unterscheidet sie von ähnlichen Zeichenketten innerhalb von Anführungszeichen oder Kommentaren) und die Trennzeichen von Anweisungen.


# COPYRIGHT

Copyright (c) 2008 by Kevin B. Kenny.
