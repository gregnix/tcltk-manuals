---
CommandName: pt_parse_peg
title: pt_parse_peg
ManualSection: i
Version: 1.1
TclPart: tcllib
TclDescription: Parser Tools
Keywords:
 - EBNF
 - LL(k)
 - PEG
 - TDPL
 - context-free languages
 - expression
 - grammar
 - matching
 - parser
 - parsing expression
 - parsing expression grammar
 - push down automaton
 - recursive descent
 - state
 - top-down parsing languages
 - transducer
Copyright:
 - Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

pt\_parse\_peg - Parser Tools PEG Parser

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [pt::parse::peg]{.lit} [1]{.lit}
[pt::parse::peg]{.cmd} [objectName]{.optarg}
[objectName]{.ins} [destroy]{.sub}
[objectName]{.ins} [parse]{.sub} [chan]{.arg}
[objectName]{.ins} [parset]{.sub} [text]{.arg}
:::

# Description

Are you lost ? Do you have trouble understanding this document ? In that case please read the overview provided by the *Introduction to Parser Tools*. This document is the entrypoint to the whole system the current package is a part of.

This package provides a class whose instances are parsers for parsing expression grammars in textual form.

# Class API

**pt::parse::peg** ?*objectName*?
: The class command constructs parser instances, i.e. objects. The result of the command is the fully-qualified name of the instance command.

    If no *objectName* is specified the class will generate and use an automatic name. If the *objectName* was specified, but is not fully qualified the command will be created in the current namespace.


# Instances API

All parser instances provide at least the methods shown below:

*objectName* **destroy**
: This method destroys the parser instance, releasing all claimed memory and other resources, and deleting the instance command.

    The result of the command is the empty string.

*objectName* **parse** *chan*
: This method runs the parser using the contents of *chan* as input (starting at the current location in the channel), until parsing is not possible anymore, either because parsing has completed, or run into a syntax error.

    Note here that the Parser Tools are based on Tcl 8.5+. In other words, the channel argument is not restricted to files, sockets, etc. We have the full power of *reflected channels* available.

    It should also be noted that the parser pulls the characters from the input stream as it needs them. If a parser created by this package has to be operated in a push aka event-driven manner it will be necessary to go to Tcl 8.6+ and use the **coroutine::auto** to wrap it into a coroutine where **read** is properly changed for push-operation.

    Upon successful completion the command returns an abstract syntax tree as its result. This AST is in the form specified in section **AST serialization format**. As a plain nested Tcl-list it can then be processed with any Tcl commands the user likes, doing transformations, semantic checks, etc. To help in this the package **pt::ast** provides a set of convenience commands for validation of the tree's basic structure, printing it for debugging, and walking it either from the bottom up, or top down.

    When encountering a syntax error the command will throw an error instead. This error will be a 4-element Tcl-list, containing, in the order listed below:

    1. The string **pt::rde** identifying it as parser runtime error.

    2. The location of the parse error, as character offset from the beginning of the parsed input.

    3. The location of parse error, now as a 2-element list containing line-number and column in the line.

    4. A set of atomic parsing expressions indicating encoding the characters and/or nonterminal symbols the parser expected to see at the location of the parse error, but did not get. For the specification of atomic parsing expressions please see the section **PE serialization format**.


*objectName* **parset** *text*
: This method runs the parser using the string in *text* as input. In all other ways it behaves like the method **parse**, shown above.


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *pt* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Parsing and Grammars

# Copyright

```
Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
