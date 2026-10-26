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

# Name

grammar::peg::interp - Interpreter for parsing expression grammars

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [grammar::mengine]{.lit} [0.1]{.optlit} 
[package]{.cmd} [require]{.sub} [grammar::peg::interp]{.lit} [0.1.2]{.optlit} 
[::grammar::peg::interp::setup]{.cmd} [peg]{.arg} 
[::grammar::peg::interp::parse]{.cmd} [nextcmd]{.arg} [errorvar]{.arg} [astvar]{.arg} 
:::

# Description

This package provides commands for the controlled matching of a character stream via a parsing expression grammar and the creation of an abstract syntax tree for the stream and partials.

It is built on top of the virtual machine provided by the package **grammar::me::tcl** and directly interprets the parsing expression grammar given to it. In other words, the grammar is *not* pre-compiled but used as is.

The grammar to be interpreted is taken from a container object following the interface specified by the package **grammar::peg::container**. Only the relevant parts are copied into the state of this package.

It should be noted that the package provides exactly one instance of the interpreter, and interpreting a second grammar requires the user to either abort or complete a running interpretation, or to put them into different Tcl interpreters.

Also of note is that the implementation assumes a pull-type handling of the input. In other words, the interpreter pulls characters from the input stream as it needs them. For usage in a push environment, i.e. where the environment pushes new characters as they come we have to put the engine into its own thread.

# The interpreter api

The package exports the following API

**::grammar::peg::interp::setup** *peg*
: This command (re)initializes the interpreter. It returns the empty string. This command has to be invoked first, before any matching run. Its argument *peg* is the handle of an object containing the parsing expression grammar to interpret. This grammar has to be valid, or an error will be thrown.

**::grammar::peg::interp::parse** *nextcmd* *errorvar* *astvar*
: This command interprets the loaded grammar and tries to match it against the stream of characters represented by the command prefix *nextcmd*. The command prefix *nextcmd* represents the input stream of characters and is invoked by the interpreter whenever the a new character from the stream is required. The callback has to return either the empty list, or a list of 4 elements containing the token, its lexeme attribute, and its location as line number and column index, in this order. The empty list is the signal that the end of the input stream has been reached. The lexeme attribute is stored in the terminal cache, but otherwise not used by the machine. The result of the command is a boolean value indicating whether the matching process was successful (**true**), or not (**false**). In the case of a match failure error information will be stored into the variable referenced by *errorvar*. The variable referenced by *astvar* will always contain the generated abstract syntax tree, however in the case of an error it will be only partial and possibly malformed. The abstract syntax tree is represented by a nested list, as described in section **AST VALUES** of document *grammar::me_ast*.


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *grammar_peg* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Grammars and finite automata

# Copyright

```
Copyright (c) 2005-2011 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
