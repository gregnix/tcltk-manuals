---
CommandName: doctools::tcl::parse
ManualSection: n
Version: 0.2
TclPart: tcllib
TclDescription: Documentation tools
Keywords:
 - Tcl syntax
 - command
 - doctools
 - parser
 - subst
 - word
Copyright:
 - Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

doctools::tcl::parse - Processing text in 'subst -novariables' format

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [snit]{.lit} 
[package]{.cmd} [require]{.sub} [fileutil]{.lit} 
[package]{.cmd} [require]{.sub} [logger]{.lit} 
[package]{.cmd} [require]{.sub} [struct::list]{.lit} 
[package]{.cmd} [require]{.sub} [struct::stack]{.lit} 
[package]{.cmd} [require]{.sub} [struct::set]{.lit} 
[package]{.cmd} [require]{.sub} [treeql]{.lit} 
[package]{.cmd} [require]{.sub} [doctools::tcl::parse]{.lit} [0.2]{.optlit} 
[::doctools::tcl::parse]{.cmd} [text]{.sub} [tree]{.arg} [text]{.arg} [root]{.optarg} 
[::doctools::tcl::parse]{.cmd} [file]{.sub} [tree]{.arg} [path]{.arg} [root]{.optarg} 
:::

# Description

This package provides commands for parsing text with embedded Tcl commands as accepted by the Tcl builtin command **subst -novariables**. The result of the parsing is an abstract syntax tree.

This is an internal package of doctools, for use by the higher level parsers processing the *docidx*, *doctoc*, and *doctools* markup languages.

# Api

**::doctools::tcl::parse** **text** *tree* *text* ?*root*?
: The command takes the *text* and parses it under the assumption that it contains a string acceptable to the Tcl builtin command **subst -novariables**. Errors are thrown otherwise during the parsing. The format used for these errors in described in section **Error format**. The command returns the empty string as it result. The actual result of the parsing is entered into the tree structure *tree*, under the node *root*. If *root* is not specified the root of *tree* is used. The *tree* has to exist and be the command of a tree object which supports the same methods as trees created by the package **struct::tree**. In case of errors *tree* will be left in an undefined state.

**::doctools::tcl::parse** **file** *tree* *path* ?*root*?
: The same as **text**, except that the text to parse is read from the file specified by *path*.


# Error format

When the parser encounters a problem in the input it will throw an error using the format described here.

**\[1\]**
: The message will contain the reason for the problem (unexpected character or end of input in input), the character in question, if any, and the line and column the problem was found at, in a human readable form. This part is not documented further as its format may change as we see fit. It is intended for human consumption, not machine.

**\[2\]**
: The error code however will contain a machine-readable representation of the problem, in the form of a 5-element list containing, in the order listed below


**\[1\]**
: the constant string **doctools::tcl::parse**

**\[2\]**
: the cause of the problem, one of


**char**
: Unexpected character in input

**eof**
: Unexpected end of the input


**\[3\]**
: The location of the problem as offset from the beginning of the input, counted in characters. Note: Line markers count as one character.

**\[4\]**
: The line the problem was found on (counted from 1 (one)),

**\[5\]**
: The column the problem was found at (counted from 0 (zero))


# Tree structure

After successfully parsing a string the generated tree will have the following structure:

**\[1\]**
: In the following items the word 'root' refers to the node which was specified as the root of the tree when invoking either **text** or **file**. This may be the actual root of the tree.

**\[2\]**
: All the following items further ignore the possibility of pre-existing attributes in the pre-existing nodes. If attributes exists with the same names as the attributes used by the parser the pre-existing values are written over. Attributes with names not clashing with the parser's attributes are not touched.

**\[3\]**
: The root node has no attributes.

**\[4\]**
: All other nodes have the attributes


**type**
: The value is a string from the set { Command , Text , Word }

**range**
: The value is either empty or a 2-element list containing integer numbers. The numbers are the offsets of the first and last character in the input text, of the token described by the node,.

**line**
: The value is an integer, it describes the line in the input the token described by the node ends on. Lines are counted from 1 (**one**).

**col**
: The value is an integer, it describes the column in the line in the input the token described by the node ends on. Columns are counted from 0 (**zero**).


**\[5\]**
: The children of the root, if any, are of type Command and Text, in semi-alternation. This means: After a Text node a Command node has to follow, and anything can follow a Command node, a Text or other Command node.

**\[6\]**
: The children of a Command node, if any, are of type Command, and Text, and Word, they describe the arguments of the command.

**\[7\]**
: The children of a Word node, if any, are of type Command, Text, in semi-alternation. This means: After a Text node a Command node has to follow, and anything can follow a Command node, a Text or other Command node.

**\[8\]**
: A Word node without children represents the empty string.

**\[9\]**
: All Text nodes are leaves of the tree.

**\[10\]**
: All leaves of the tree are either Text or Command nodes. Word nodes cannot be leaves.


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *doctools* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Documentation tools

# Copyright

```
Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
