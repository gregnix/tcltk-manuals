---
CommandName: pt::cparam::configuration::critcl
title: pt::cparam::configuration::critcl
ManualSection: n
Version: 1.0.3
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

pt::cparam::configuration::critcl - C/PARAM, Canned configuration, Critcl

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [pt::cparam::configuration::critcl]{.lit} [1.0.3]{.optlit}
[::pt::cparam::configuration::critcl]{.cmd} [def]{.lit} [name]{.arg} [pkg]{.arg} [version]{.arg} [cmdprefix]{.arg}
:::

# Description

Are you lost ? Do you have trouble understanding this document ? In that case please read the overview provided by the *Introduction to Parser Tools*. This document is the entrypoint to the whole system the current package is a part of.

This package is an adjunct to [pt::peg::to::cparam][pt_peg_to_cparam], to make the use of this highly configurable package easier by providing a canned configuration. When applied this configuration causes the package [pt::peg::to::cparam][pt_peg_to_cparam] to generate **critcl**-based parser packages.

It is a supporting package in the Core Layer of Parser Tools.

IMAGE: arch\_core\_support

# API

**::pt::cparam::configuration::critcl** **def** *name* *pkg* *version* *cmdprefix*
: The command applies the configuration provided by this package to the *cmdprefix*, causing the creation of **critcl**-based parsers whose class is *name*, in package *pkg* with *version*.

    The use of a command prefix as API allows application of the configuration to not only [pt::peg::to::cparam][pt_peg_to_cparam] ([pt::peg::to::cparam configure][pt_peg_to_cparam]), but also export manager instances and PEG containers (**$export configuration set** and **\[$container exporter\] configuration set** respectively).

    Or anything other command prefix accepting two arguments, option and value.


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


[pt_peg_to_cparam]: pt_peg_to_cparam.md
