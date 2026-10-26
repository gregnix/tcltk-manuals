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

grammar::aycock - Aycock-Horspool-Earley parser generator for Tcl

# Synopsis

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

# Description

The **grammar::aycock** package implements a parser generator for the class of parsers described in John Aycock and R. Nigel Horspool. Practical Earley Parsing. *The Computer Journal,* *45*(6):620-630, 2002. <http://citeseerx.ist.psu.edu/viewdoc/summary?doi=10.1.1.12.4254>

# Procedures

The **grammar::aycock** package exports the single procedure:

**::aycock::parser** *grammar* ?**-verbose**?
: Generates a parser for the given *grammar*, and returns its name.  If the optional **-verbose** flag is given, dumps verbose information relating to the generated parser to the standard output. The returned parser is an object that accepts commands as shown in [Object command] below.


# Object command

*parserName* **parse** *symList* *valList* ?*clientData*?
: Invokes a parser returned from **::aycock::parser**. *symList* is a list of grammar symbols representing the terminals in an input string, and *valList* is a list of their semantic values. The result is the semantic value of the entire string when parsed.

*parserName* **destroy**
: Destroys a parser constructed by **::aycock::parser**.

*parserName* **terminals**
: Returns a list of terminal symbols that may be presented in the *symList* argument to the **parse** object command.

*parserName* **nonterminals**
: Returns a list of nonterminal symbols that were defined in the parser's grammar.

*parserName* **save**
: Returns a Tcl script that will reconstruct the parser without needing all the mechanism of the parser generator at run time. The reconstructed parser depends on a set of commands in the package **grammar::aycock::runtime**, which is also automatically loaded when the **grammar::aycock** package is loaded.


# Description

The **grammar::aycock::parser** command accepts a grammar expressed as a Tcl list.  The list must be structured as the concatenation of a set of *rule*s. Each *rule* comprises a variable number of elements in the list:

- The name of the nonterminal symbol that the rule reduces.

- The literal string, **::=**

- Zero or more names of terminal or nonterminal symbols that comprise the right-hand-side of the rule.

- Finally, a Tcl script to execute when the rule is reduced. Within the given script, a variable called **\_** contains a list of the semantic values of the symbols on the right-hand side. The value returned by the script is expected to be the semantic value of the left-hand side.  If the *clientData* parameter was passed to the **parse** method, it is available in a variable called **clientData**.  It is permissible for the script to be the empty string.  In this case, the semantic value of the rule will be the same as the semantic value of the first symbol on the right-hand side.  If the right-hand side is also empty, the semantic value will be the empty string.


Parsing is done with an Earley parser, which is not terribly efficient in speed or memory consumption, but which deals effectively with ambiguous grammars.  For this reason, the **grammar::aycock** package is perhaps best adapted to natural-language processing or the parsing of extraordinarily complex languages in which ambiguity can be tolerated.

# Example

The following code demonstrates a trivial desk calculator, admitting only **+**, **\*** and parentheses as its operators.  It also shows the format in which the lexical analyzer is expected to present terminal symbols to the parser.

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

The example, when run, prints **40**.

# Category

Grammars and finite automata

# Copyright

```
Copyright (c) 2006 by Kevin B. Kenny <kennykb@acm.org>
Redistribution permitted under the terms of the Open Publication License <http://www.opencontent.org/openpub/>
```
