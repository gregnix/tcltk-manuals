---
CommandName: pt_introduction
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

pt_introduction - Introduction to Parser Tools

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
:::

# Description

Welcome to the Parser Tools, a system for the creation and manipulation of parsers and the grammars driving them.

What are your goals which drove you here ?

**\[1\]**
: Do you simply wish to create a parser for some language ? In that case have a look at our parser generator application, **pt**, or, for a slightly deeper access, the package underneath it, **pt::pgen**.

**\[2\]**
: Do you wish to know more about the architecture of the system ? This is described in the section **Parser Tools Architecture**, below

**\[3\]**
: Is your interest in the theoretical background upon which the packages and tools are build ? See the *Introduction to Parsing Expression Grammars*.


# Parser tools architecture

The system can be split into roughly three layers, as seen in the figure below

IMAGE: architecture

These layers are, from high to low:

**\[1\]**
: At the top we have the application and the packages using the packages of the layer below to implement common usecases. One example is the aforementioned **pt::pgen** which provides a parser generator. The list of packages belonging to this layer can be found in section **User Packages**

**\[2\]**
: In this layer we have the packages which provide the core of the functionality for the whole system. They are, in essence, a set of blocks which can be combined in myriad ways, like Lego (tm). The packages in the previous level are 'just' pre-fabricated combinations to cover the most important use cases. The list of packages belonging to this layer can be found in section **Core Packages**

**\[3\]**
: Last, but not least is the layer containing support packages providing generic functionality which not necessarily belong into the module. The list of packages belonging to this layer can be found in section **Support Packages**


## User packages

**pt::pgen**
: 


## Core packages

This layer is further split into six sections handling the storage, import, export, transformation, and execution of grammars, plus grammar specific support packages.

**Storage**
: 


**pt::peg::container**
: 


**Export**
: 


**pt::peg::export**
: ...see next...

**pt::peg::export::container**
: ...see next...

**pt::peg::export::json**
: ...see next...

**pt::peg::export::peg**
: ...see next...

**pt::peg::to::container**
: ...see next...

**pt::peg::to::json**
: ...see next...

**pt::peg::to::peg**
: ...see next...

**pt::peg::to::param**
: ...see next...

**pt::peg::to::tclparam**
: ...see next...

**pt::peg::to::cparam**
: 


**Import**
: 


**pt::peg::import**
: ...see next...

**pt::peg::import::container**
: ...see next...

**pt::peg::import::json**
: ...see next...

**pt::peg::import::peg**
: ...see next...

**pt::peg::from::container**
: ...see next...

**pt::peg::from::json**
: ...see next...

**pt::peg::from::peg**
: 


**Transformation**
: ...see next...

**Execution**
: 


**pt::peg::interp**
: ...see next...

**pt::rde**
: 


**Support**
: 


**pt::tclparam::configuration::snit**
: ...see next...

**pt::tclparam::configuration::tcloo**
: ...see next...

**pt::cparam::configuration::critcl**
: ...see next...

**pt::ast**
: ...see next...

**pt::pe**
: ...see next...

**pt::peg**
: 


## Support packages

**pt::peg::container::peg**
: ...see next...

**text::write**
: ...see next...

**configuration**
: ...see next...

**paths**
: ...see next...

**char**
: 


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
