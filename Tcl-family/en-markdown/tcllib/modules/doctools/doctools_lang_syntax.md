---
CommandName: doctools_lang_syntax
title: doctools_lang_syntax
ManualSection: n
Version: 1.0
TclPart: tcllib
TclDescription: Documentation tools
Links:
 - doctools_intro
 - doctools_lang_cmdref
 - doctools_lang_faq
 - doctools_lang_intro
Keywords:
 - doctools commands
 - doctools language
 - doctools markup
 - doctools syntax
 - markup
 - semantic markup
Copyright:
 - Copyright (c) 2007 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

doctools\_lang\_syntax - doctools language syntax

# Description

This document contains the formal specification of the syntax of the doctools markup language, version 1 in Backus-Naur-Form. This document is intended to be a reference, complementing the *doctools language command reference*. A beginner should read the much more informally written *doctools language introduction* first before trying to understand either this document or the command reference.

# Fundamentals

In the broadest terms possible the *doctools markup language* is LaTeX-like, instead of like SGML and similar languages. A document written in this language consists primarily of text, with markup commands embedded into it.

Each markup command is a just Tcl command surrounded by a matching pair of **\[** and **\]**. Which commands are available, and their arguments, i.e. syntax is specified in the *doctools language command reference*.

In this document we specify first the lexeme, and then the syntax, i.e. how we can mix text and markup commands with each other.

# Lexical definitions

In the syntax rules listed in the next section

1. <TEXT> stands for all text except markup commands.

2. Any XXX stands for the markup command \[xxx\] including its arguments. Each markup command is a Tcl command surrounded by a matching pair of **\[** and **\]**. Inside of these delimiters the usual rules for a Tcl command apply with regard to word quotation, nested commands, continuation lines, etc.

3. <WHITE> stands for all text consisting only of spaces, newlines, tabulators and the [comment][docidx_lang_cmdref] markup command.


# Syntax

The rules listed here specify only the syntax of doctools documents. The lexical level of the language was covered in the previous section.

Regarding the syntax of the (E)BNF itself

1. The construct { X } stands for zero or more occurrences of X.

2. The construct \[ X \] stands for zero or one occurrence of X.

3. The construct LIST\_BEGIN<X> stands for the markup command [list\_begin][doctools_lang_cmdref] with **X** as its type argument.


The syntax:

```
manpage = defs
          MANPAGE_BEGIN
          header
          DESCRIPTION
          body
          MANPAGE_END
          { <WHITE> }

defs    = { INCLUDE | VSET | <WHITE> }

header  = { TITLEDESC | MODDESC | COPYRIGHT | REQUIRE | defs | xref }

xref    = KEYWORDS | SEE_ALSO | CATEGORY

body    = paras { SECTION    sbody  }
sbody   = paras { SUBSECTION ssbody }
ssbody  = paras

paras   = tblock { (PARA | NL) tblock }

tblock  = { <TEXT> | defs | markup | xref | an_example | a_list }

markup  = ARG     | CLASS | CMD     | CONST     | EMPH   | FILE
        | FUN     | LB    | METHOD  | NAMESPACE | OPT    | OPTION
        | PACKAGE | RB    | SECTREF | STRONG    | SYSCMD | TERM
        | TYPE    | URI   | USAGE   | VAR       | WIDGET

example = EXAMPLE
        | EXAMPLE_BEGIN extext EXAMPLE_END

extext  = { <TEXT> | defs | markup }

a_list  = LIST_BEGIN<arguments>   argd_list   LIST_END
        | LIST_BEGIN<commands>    cmdd_list   LIST_END
        | LIST_BEGIN<definitions> def_list    LIST_END
        | LIST_BEGIN<enumerated>  enum_list   LIST_END
        | LIST_BEGIN<itemized>    item_list   LIST_END
        | LIST_BEGIN<options>     optd_list   LIST_END
        | LIST_BEGIN<tkoptions>   tkoptd_list LIST_END

argd_list   = [ <WHITE> ] { ARG_DEF      paras }
cmdd_list   = [ <WHITE> ] { CMD_DEF      paras }
def_list    = [ <WHITE> ] { (DEF|CALL)   paras }
enum_list   = [ <WHITE> ] { ENUM         paras }
item_list   = [ <WHITE> ] { ITEM         paras }
optd_list   = [ <WHITE> ] { OPT_DEF      paras }
tkoptd_list = [ <WHITE> ] { TKOPTION_DEF paras }
```

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *doctools* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Documentation tools

# Copyright

```
Copyright (c) 2007 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```


[docidx_lang_cmdref]: docidx_lang_cmdref.md
[doctools_lang_cmdref]: doctools_lang_cmdref.md
