---
CommandName: pt_peg_op
ManualSection: i
Version: 1.2.0
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

pt_peg_op - Parser Tools PE Grammar Utility Operations

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [pt::peg::op]{.lit} [1.2.0]{.optlit} 
[::peg::peg::op]{.cmd} [called]{.sub} [container]{.arg} 
[::peg::peg::op]{.cmd} [dechain]{.sub} [container]{.arg} 
[::peg::peg::op]{.cmd} [drop]{.sub} [unreachable]{.lit} [container]{.arg} 
[::peg::peg::op]{.cmd} [drop]{.sub} [unrealizable]{.lit} [container]{.arg} 
[::peg::peg::op]{.cmd} [flatten]{.sub} [container]{.arg} 
[::peg::peg::op]{.cmd} [minimize]{.sub} [container]{.arg} 
[::peg::peg::op]{.cmd} [modeopt]{.sub} [container]{.arg} 
[::peg::peg::op]{.cmd} [reachable]{.sub} [container]{.arg} 
[::peg::peg::op]{.cmd} [realizable]{.sub} [container]{.arg} 
:::

# Description

Are you lost ? Do you have trouble understanding this document ? In that case please read the overview provided by the *Introduction to Parser Tools*. This document is the entrypoint to the whole system the current package is a part of.

This package provides a number of utility commands manipulating a PE grammar (container) in various ways.

# Api

**::peg::peg::op** **called** *container*
: This command determines the static call structure for the nonterminal symbols of the grammar stored in the *container*. The result of the command is a dictionary mapping from each symbol to the symbols it calls. The empty string is the key used to represent the start expression of the grammar. The grammar in the container is not modified. The *container* instance has to expose a method API as is provided by the package **pt::peg::container**.

**::peg::peg::op** **dechain** *container*
: This command simplifies all symbols which just chain to a different symbol by inlining the right hand side of the called symbol in its callers. This works if and only the modes match properly, per the decision table below.


```
caller called | dechain | notes
--------------+---------+-----------------------
value  value  |  yes    |  value is passed
value  leaf   |  yes    |  value is passed
value  void   |  yes    |  caller is implied void
leaf   value  |  no     |  generated value was discarded, inlined would not. called may be implied void.
leaf   leaf   |  no     |  s.a.
leaf   void   |  no     |  s.a.
void   value  |  no     |  caller drops value, inlined would not.
void   leaf   |  no     |  s.a.
void   void   |  yes    |
```

The result of the command is the empty string.

The grammar in the container is directly modified. If that is not wanted, a copy of the original container has to be used.

The *container* instance has to expose a method API as is provided by the package **pt::peg::container**.

**::peg::peg::op** **drop unreachable** *container*
: This command removes all symbols from the grammar which are not **reachable**. The result of the command is the empty string. The grammar in the container is directly modified. If that is not wanted, a copy of the original container has to be used. The *container* instance has to expose a method API as is provided by the package **pt::peg::container**.

**::peg::peg::op** **drop unrealizable** *container*
: This command removes all symbols from the grammar which are not **realizable**. The result of the command is the empty string. The grammar in the container is directly modified. If that is not wanted, a copy of the original container has to be used. The *container* instance has to expose a method API as is provided by the package **pt::peg::container**.

**::peg::peg::op** **flatten** *container*
: This command flattens (see **pt::pe::op**) all expressions in the grammar, i.e. the start expression and the right hand sides of all nonterminal symbols. The result of the command is the empty string. The grammar in the container is directly modified. If that is not wanted, a copy of the original container has to be used. The *container* instance has to expose a method API as is provided by the package **pt::peg::container**.

**::peg::peg::op** **minimize** *container*
: This command reduces the provided grammar by applying most of the other methods of this package. After flattening the expressions it removes unreachable and unrealizable symbols, flattens the expressions again, then optimizes the symbol modes before collapsing symbol chains as much as possible. The result of the command is the empty string. The grammar in the container is directly modified. If that is not wanted, a copy of the original container has to be used. The *container* instance has to expose a method API as is provided by the package **pt::peg::container**.

**::peg::peg::op** **modeopt** *container*
: This command optimizes the semantic modes of non-terminal symbols according to the two rules below.


**\[1\]**
: If a symbol X with mode **value** calls no other symbols, i.e. uses only terminal symbols in whatever combination, then this can be represented simpler by using mode **leaf**.

**\[2\]**
: If a symbol X is only called from symbols with modes **leaf** or **void** then this symbol should have mode **void** also, as any AST it could generate will be discarded anyway.


The result of the command is the empty string.

The grammar in the container is directly modified. If that is not wanted, a copy of the original container has to be used.

The *container* instance has to expose a method API as is provided by the package **pt::peg::container**.

**::peg::peg::op** **reachable** *container*
: This command computes the set of all nonterminal symbols which are reachable from the start expression of the grammar. This is essentially the transitive closure over **called** and the symbol's right hand sides, beginning with the start expression. The result of the command is the list of reachable symbols. The grammar in the container is not modified. The *container* instance has to expose a method API as is provided by the package **pt::peg::container**.

**::peg::peg::op** **realizable** *container*
: This command computes the set of all nonterminal symbols which are realizable, i.e. can derive pure terminal phrases. This is done iteratively, starting with state unrealizable for all and any, and then updating all symbols which are realizable, propagating changes, until nothing changes any more. The result of the command is the list of realizable symbols. The grammar in the container is not modified. The *container* instance has to expose a method API as is provided by the package **pt::peg::container**.


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
