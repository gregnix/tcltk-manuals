---
CommandName: grammar::me::util
ManualSection: n
Version: 0.2
TclPart: tcllib
TclDescription: Grammar operations and usage
Keywords:
 - abstract syntax tree
 - syntax tree
 - tree
Copyright:
 - Copyright (c) 2005 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

grammar::me::util - AST utilities

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [grammar::me::util]{.lit} [0.2]{.optlit} 
[::grammar::me::util::ast2tree]{.cmd} [ast]{.arg} [tree]{.arg} [root]{.optarg} 
[::grammar::me::util::ast2etree]{.cmd} [ast]{.arg} [mcmd]{.arg} [tree]{.arg} [root]{.optarg} 
[mcmd]{.cmd} [lc]{.sub} [location]{.arg} 
[mcmd]{.cmd} [tok]{.sub} [from]{.arg} [to]{.optarg} 
[::grammar::me::util::tree2ast]{.cmd} [tree]{.arg} [root]{.optarg} 
:::

# Description

This package provides a number of utility command for the conversion between the various representations of abstract syntax trees as specified in the document **grammar::me_ast**.

**::grammar::me::util::ast2tree** *ast* *tree* ?*root*?
: This command converts an *ast* from value to object representation. All nodes in the *ast* will be converted into nodes of this *tree*, with the root of the AST a child of the node *root*. If this node is not explicitly specified the root of the tree is used. Existing content of tree is not touched, i.e.  neither removed nor changed, with the exception of the specified root node, which will gain a new child.

**::grammar::me::util::ast2etree** *ast* *mcmd* *tree* ?*root*?
: This command is like **::grammar::me::util::ast2tree**, except that the result is in the extended object representation of the input AST. The source of the extended information is the command prefix *mcmd*. It has to understand two methods, **lc**, and **tok**, with the semantics specified below.


**mcmd** **lc** *location*
: Takes the location of a token given as offset in the input stream and return a 2-element list containing the associated line number and column index, in this order.

**mcmd** **tok** *from* ?*to*?
: Takes one or two locations *from* and *to* as offset in the input stream and returns a Tcl list containing the specified part of the input stream. Both location are inclusive. If *to* is not specified it will default to the value of *from*. Each element of the returned list is a list containing the token, its associated lexeme, the line number, and column index, in this order.


Both the ensemble command **::grammar::me::tcl** provided by the package **grammar::me::tcl** and the objects command created by the package **::grammar::me::cpu** fit the above specification.

**::grammar::me::util::tree2ast** *tree* ?*root*?
: This command converts an *ast* in (extended) object representation into a value and returns it. If a *root* node is specified the AST is generated from that node downward. Otherwise the root of the tree object is used as the starting point.


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *grammar_me* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Grammars and finite automata

# Copyright

```
Copyright (c) 2005 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
