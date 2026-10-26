---
CommandName: grammar::fa::dacceptor
title: grammar::fa::dacceptor
ManualSection: n
Version: 0.1.2
TclPart: tcllib
TclDescription: Finite automaton operations and usage
Keywords:
 - acceptance
 - acceptor
 - automaton
 - finite automaton
 - grammar
 - parsing
 - regular expression
 - regular grammar
 - regular languages
 - state
 - transducer
Copyright:
 - Copyright (c) 2004 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

grammar::fa::dacceptor - Create and use deterministic acceptors

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [snit]{.lit}
[package]{.cmd} [require]{.sub} [struct::set]{.lit}
[package]{.cmd} [require]{.sub} [grammar::fa::dacceptor]{.lit} [0.1.2]{.optlit}
[::grammar::fa::dacceptor]{.cmd} [daName]{.arg} [fa]{.arg} [[-any]{.lit} [any]{.arg}]{.optarg}
[daName]{.cmd} [option]{.arg} [arg arg]{.optdot}
[daName]{.ins} [destroy]{.sub}
[daName]{.ins} [accept?]{.sub} [symbols]{.arg}
:::

# Description

This package provides a class for acceptors constructed from deterministic *finite automatons* (DFA). Acceptors are objects which can be given a string of symbols and tell if the DFA they are constructed from would *accept* that string. For the actual creation of the DFAs the acceptors are based on we have the packages **grammar::fa** and **grammar::fa::op**.

# API

The package exports the API described here.

**::grammar::fa::dacceptor** *daName* *fa* ?**-any** *any*?
: Creates a new deterministic acceptor with an associated global Tcl command whose name is *daName*. This command may be used to invoke various operations on the acceptor. It has the following general form:

    **daName** *option* ?*arg arg ...*?
    : *Option* and the *arg*s determine the exact behavior of the command. See section [Acceptor methods] for more explanations.

        The acceptor will be based on the deterministic finite automaton stored in the object *fa*. It will keep a copy of the relevant data of the FA in its own storage, in a form easy to use for its purposes. This also means that changes made to the *fa* after the construction of the acceptor *will not* influence the acceptor.

        If *any* has been specified, then the acceptor will convert all symbols in the input which are unknown to the base FA to that symbol before proceeding with the processing.



# Acceptor methods

All acceptors provide the following methods for their manipulation:

*daName* **destroy**
: Destroys the automaton, including its storage space and associated command.

*daName* **accept?** *symbols*
: Takes the list of *symbols* and checks if the FA the acceptor is based on would accept it. The result is a boolean value. **True** is returned if the symbols are accepted, and **False** otherwise. Note that bogus symbols in the input are either translated to the *any* symbol (if specified), or cause the acceptance test to simply fail. No errors will be thrown. The method will process only just that prefix of the input which is enough to fully determine (non-)acceptance.


# Examples

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *grammar\_fa* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Grammars and finite automata

# Copyright

```
Copyright (c) 2004 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
