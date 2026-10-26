---
CommandName: pt_introduction
title: pt_introduction
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

pt\_introduction - Introduction to Parser Tools

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
:::

# Description

Welcome to the Parser Tools, a system for the creation and manipulation of parsers and the grammars driving them.

What are your goals which drove you here ?

1. Do you simply wish to create a parser for some language ?

    In that case have a look at our parser generator application, **pt**, or, for a slightly deeper access, the package underneath it, **pt::pgen**.

2. Do you wish to know more about the architecture of the system ?

    This is described in the section [Parser Tools architecture], below

3. Is your interest in the theoretical background upon which the packages and tools are build ?

    See the *Introduction to Parsing Expression Grammars*.


# Parser Tools architecture

The system can be split into roughly three layers, as seen in the figure below

IMAGE: architecture

These layers are, from high to low:

1. At the top we have the application and the packages using the packages of the layer below to implement common usecases. One example is the aforementioned **pt::pgen** which provides a parser generator.

    The list of packages belonging to this layer can be found in section [User packages]

2. In this layer we have the packages which provide the core of the functionality for the whole system. They are, in essence, a set of blocks which can be combined in myriad ways, like Lego (tm). The packages in the previous level are 'just' pre-fabricated combinations to cover the most important use cases.

    The list of packages belonging to this layer can be found in section [Core packages]

3. Last, but not least is the layer containing support packages providing generic functionality which not necessarily belong into the module.

    The list of packages belonging to this layer can be found in section [Support packages]


## User packages

- **pt::pgen**


## Core packages

This layer is further split into six sections handling the storage, import, export, transformation, and execution of grammars, plus grammar specific support packages.

Storage
: see below ...

    - **pt::peg::container**


Export
: see below ...

    - **pt::peg::export**
    - **pt::peg::export::container**
    - **pt::peg::export::json**
    - **pt::peg::export::peg**
    - [pt::peg::to::container][pt_peg_to_container]
    - [pt::peg::to::json][pt_peg_to_json]
    - [pt::peg::to::peg][pt_peg_to_peg]
    - [pt::peg::to::param][pt_peg_to_param]
    - [pt::peg::to::tclparam][pt_peg_to_tclparam]
    - [pt::peg::to::cparam][pt_peg_to_cparam]


Import
: see below ...

    - **pt::peg::import**
    - [pt::peg::import::container][pt_peg_import_container]
    - **pt::peg::import::json**
    - **pt::peg::import::peg**
    - [pt::peg::from::container][pt_peg_from_container]
    - [pt::peg::from::json][pt_peg_from_json]
    - [pt::peg::from::peg][pt_peg_from_peg]


Transformation
: see below ...

Execution
: see below ...

    - **pt::peg::interp**
    - **pt::rde**


Support
: see below ...

    - **pt::tclparam::configuration::snit**
    - **pt::tclparam::configuration::tcloo**
    - **pt::cparam::configuration::critcl**
    - **pt::ast**
    - **pt::pe**
    - **pt::peg**



## Support packages

- [pt::peg::container::peg][pt_peg_container_peg]
- **text::write**
- **configuration**
- **paths**
- **char**


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


[pt_peg_container_peg]: pt_peg_container_peg.md
[pt_peg_from_container]: pt_peg_from_container.md
[pt_peg_from_json]: pt_peg_from_json.md
[pt_peg_from_peg]: pt_peg_from_peg.md
[pt_peg_import_container]: pt_peg_import_container.md
[pt_peg_to_container]: pt_peg_to_container.md
[pt_peg_to_cparam]: pt_peg_to_cparam.md
[pt_peg_to_json]: pt_peg_to_json.md
[pt_peg_to_param]: pt_peg_to_param.md
[pt_peg_to_peg]: pt_peg_to_peg.md
[pt_peg_to_tclparam]: pt_peg_to_tclparam.md
