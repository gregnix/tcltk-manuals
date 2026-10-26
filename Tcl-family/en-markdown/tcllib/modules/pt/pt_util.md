---
CommandName: pt::util
ManualSection: n
Version: 1.2
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

pt::util - General utilities

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [pt::ast]{.lit} [1.2]{.optlit} 
[::pt::util]{.cmd} [error2readable]{.sub} [error]{.arg} [text]{.arg} 
[::pt::util]{.cmd} [error2position]{.sub} [error]{.arg} [text]{.arg} 
[::pt::util]{.cmd} [error2text]{.sub} [error]{.arg} 
:::

# Description

Are you lost ? Do you have trouble understanding this document ? In that case please read the overview provided by the *Introduction to Parser Tools*. This document is the entrypoint to the whole system the current package is a part of.

This package provides general utility commands.

This is a supporting package in the Core Layer of Parser Tools.

IMAGE: arch_core_support

# Api

**::pt::util** **error2readable** *error* *text*
: This command takes the structured form of a syntax *error* as thrown by parser runtimes and the input *text* to the parser which caused that error and returns a string describing the error in a human-readable form. The input *text* is required to convert the character position of the error into a more readable line/column format, and to provide excerpts of the input around the error position.

**::pt::util** **error2position** *error* *text*
: This command takes the structured form of a syntax *error* as thrown by parser runtimes and the input *text* to the parser which caused that error and returns a 2-element list containing the line number and column index for the error's character position in the input, in this order.

**::pt::util** **error2text** *error*
: This command takes the structured form of a syntax *error* as thrown by parser runtimes and returns a list of strings, each describing a possible expected input in a human-readable form.


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
