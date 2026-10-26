---
CommandName: docidx_lang_syntax
ManualSection: n
Version: 1.0
TclPart: tcllib
TclDescription: Documentation tools
Links:
 - docidx_intro
 - docidx_lang_cmdref
 - docidx_lang_faq
 - docidx_lang_intro
Keywords:
 - docidx commands
 - docidx language
 - docidx markup
 - docidx syntax
 - markup
 - semantic markup
Copyright:
 - Copyright (c) 2007-2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

docidx_lang_syntax - docidx language syntax

# Description

This document contains the formal specification of the syntax of the docidx markup language, version 1 in Backus-Naur-Form. This document is intended to be a reference, complementing the *docidx language command reference*. A beginner should read the much more informally written *docidx language introduction* first before trying to understand either this document or the command reference.

# Fundamentals

In the broadest terms possible the *docidx markup language* is like SGML and similar languages. A document written in this language consists primarily of markup commands, with text embedded into it at some places.

Each markup command is a just Tcl command surrounded by a matching pair of **\[** and **\]**. Which commands are available, and their arguments, i.e. syntax is specified in the *docidx language command reference*.

In this document we specify first the lexeme, and then the syntax, i.e. how we can mix text and markup commands with each other.

# Lexical definitions

In the syntax rules listed in the next section

**\[1\]**
: \<TEXT> stands for all text except markup commands.

**\[2\]**
: Any XXX stands for the markup command \[xxx\] including its arguments. Each markup command is a Tcl command surrounded by a matching pair of **\[** and **\]**. Inside of these delimiters the usual rules for a Tcl command apply with regard to word quotation, nested commands, continuation lines, etc.

**\[3\]**
: \<WHITE> stands for all text consisting only of spaces, newlines, tabulators and the **comment** markup command.


# Syntax

The rules listed here specify only the syntax of docidx documents. The lexical level of the language was covered in the previous section.

Regarding the syntax of the (E)BNF itself

**\[1\]**
: The construct { X } stands for zero or more occurrences of X.

**\[2\]**
: The construct \[ X \] stands for zero or one occurrence of X. The syntax:


```
index     = defs
            INDEX_BEGIN
            [ contents ]
            INDEX_END
            { <WHITE> }

defs      = { INCLUDE | VSET | <WHITE> }
contents  = keyword { keyword }

keyword   = defs KEY ref { ref }
ref       = MANPAGE | URL | defs
```

At last a rule we were unable to capture in the EBNF syntax, as it is about the arguments of the markup commands, something which is not modeled here.

**\[1\]**
: The arguments of all markup commands have to be plain text, and/or text markup commands, i.e. one of


**\[1\]**
: **lb**,

**\[2\]**
: **rb**, or

**\[3\]**
: **vset** (1-argument form).


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
