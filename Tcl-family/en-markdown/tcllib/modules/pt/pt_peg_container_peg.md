---
CommandName: pt::peg::container::peg
title: pt::peg::container::peg
ManualSection: n
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

pt::peg::container::peg - PEG Storage. Canned PEG grammar specification

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [snit]{.lit}
[package]{.cmd} [require]{.sub} [pt::peg::container::peg]{.lit} [1]{.optlit}
[package]{.cmd} [require]{.sub} [pt::peg::container]{.lit}
:::

# Description

Are you lost ? Do you have trouble understanding this document ? In that case please read the overview provided by the *Introduction to Parser Tools*. This document is the entrypoint to the whole system the current package is a part of.

This package provides a sub-type of **pt::peg::container** which is preloaded with a parsing expression grammar describing a textual format for parsing expression grammars.

The sub-type provides the exact same API as **pt::peg::container**. Instead of duplicating its contents the reader is asked to read the referenced document.

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
