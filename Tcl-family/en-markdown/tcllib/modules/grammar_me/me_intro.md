---
CommandName: grammar::me_intro
title: grammar::me_intro
ManualSection: n
Version: 0.2
TclPart: tcllib
TclDescription: Grammar operations and usage
Keywords:
 - CFG
 - CFL
 - LL(k)
 - PEG
 - TPDL
 - context-free grammar
 - context-free languages
 - expression
 - grammar
 - matching
 - parsing
 - parsing expression grammar
 - push down automaton
 - recursive descent
 - top-down parsing languages
 - transducer
 - virtual machine
Copyright:
 - Copyright (c) 2005 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

grammar::me\_intro - Introduction to virtual machines for parsing token streams

# Description

This document is an introduction to and overview of the basic facilities for the parsing and/or matching of *token* streams. One possibility often used for the token domain are characters.

The packages themselves all provide variants of one *virtual machine*, called a *match engine* (short *ME*), which has all the facilities needed for the matching and parsing of a stream, and which are either controlled directly, or are customized with a match program. The virtual machine is basically a pushdown automaton, with additional elements for backtracking and/or handling of semantic data and construction of abstract syntax trees (*AST*).

Because of the high degree of similarity in the actual implementations of the aforementioned virtual machine and the data structures they receive and generate these common parts are specified in a separate document which will be referenced by the documentation for packages actually implementing it.

The relevant documents are:

[grammar::me\_vm][me_vm]
: Virtual machine specification.

[grammar::me\_ast][me_ast]
: Specification of various representations used for abstract syntax trees.

**grammar::me::util**
: Utility commands.

**grammar::me::tcl**
: Singleton ME virtual machine implementation tied to Tcl for control flow and stacks. Hardwired for pull operation. Uninteruptible during processing.

**grammar::me::cpu**
: Object-based ME virtual machine implementation with explicit control flow, and stacks, using bytecodes. Suspend/Resumable. Push/pull operation.

**grammar::me::cpu::core**
: Core functionality for state manipulation and stepping used in the bytecode based implementation of ME virtual machines.


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *grammar\_me* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Grammars and finite automata

# Copyright

```
Copyright (c) 2005 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```


[me_ast]: me_ast.md
[me_vm]: me_vm.md
