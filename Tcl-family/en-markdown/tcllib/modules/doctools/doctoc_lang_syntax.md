---
CommandName: doctoc_lang_syntax
title: doctoc_lang_syntax
ManualSection: n
Version: 1.0
TclPart: tcllib
TclDescription: Documentation tools
Links:
 - doctoc_intro
 - doctoc_lang_cmdref
 - doctoc_lang_faq
 - doctoc_lang_intro
Keywords:
 - doctoc commands
 - doctoc language
 - doctoc markup
 - doctoc syntax
 - markup
 - semantic markup
Copyright:
 - Copyright (c) 2007-2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

doctoc\_lang\_syntax - doctoc language syntax

# Description

This document contains the formal specification of the syntax of the doctoc markup language, version 1.1 in Backus-Naur-Form. This document is intended to be a reference, complementing the *doctoc language command reference*. A beginner should read the much more informally written *doctoc language introduction* first before trying to understand either this document or the command reference.

# Fundamentals

In the broadest terms possible the *doctoc markup language* is like SGML and similar languages. A document written in this language consists primarily of markup commands, with text embedded into it at some places.

Each markup command is a just Tcl command surrounded by a matching pair of **\[** and **\]**. Which commands are available, and their arguments, i.e. syntax is specified in the *doctoc language command reference*.

In this document we specify first the lexeme, and then the syntax, i.e. how we can mix text and markup commands with each other.

# Lexical definitions

In the syntax rules listed in the next section

1. <TEXT> stands for all text except markup commands.

2. Any XXX stands for the markup command \[xxx\] including its arguments. Each markup command is a Tcl command surrounded by a matching pair of **\[** and **\]**. Inside of these delimiters the usual rules for a Tcl command apply with regard to word quotation, nested commands, continuation lines, etc.

3. <WHITE> stands for all text consisting only of spaces, newlines, tabulators and the [comment][docidx_lang_cmdref] markup command.


# Syntax

The rules listed here specify only the syntax of doctoc documents. The lexical level of the language was covered in the previous section.

Regarding the syntax of the (E)BNF itself

1. The construct { X } stands for zero or more occurrences of X.

2. The construct \[ X \] stands for zero or one occurrence of X.


The syntax:

```
toc       = defs
            TOC_BEGIN
            contents
            TOC_END
            { <WHITE> }

defs      = { INCLUDE | VSET | <WHITE> }
contents  = { defs entry } [ defs ]

entry     = ITEM | division

division  = DIVISION_START
            contents
            DIVISION_END
```

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *doctools* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Documentation tools

# Copyright

```
Copyright (c) 2007-2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```


[docidx_lang_cmdref]: docidx_lang_cmdref.md
