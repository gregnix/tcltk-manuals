---
CommandName: page_util_quote
title: page_util_quote
ManualSection: n
Version: 1.0
TclPart: tcllib
TclDescription: Parser generator tools
Keywords:
 - page
 - parser generator
 - quoting
 - text processing
Copyright:
 - Copyright (c) 2007 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

page\_util\_quote - page character quoting utilities

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [page::util::quote]{.lit} [0.2]{.optlit}
[package]{.cmd} [require]{.sub} [snit]{.lit}
[::page::util::quote::unquote]{.cmd} [char]{.arg}
[::page::util::quote::quote'tcl]{.cmd} [char]{.arg}
[::page::util::quote::quote'tclstr]{.cmd} [char]{.arg}
[::page::util::quote::quote'tclcom]{.cmd} [char]{.arg}
:::

# Description

This package provides a few utility commands to convert characters into various forms.

# API

**::page::util::quote::unquote** *char*
: A character, as stored in an abstract syntax tree by a PEG processor (See the packages **grammar::peg::interpreter**, **grammar::me**, and their relations), i.e. in some quoted form, is converted into the equivalent Tcl character. The character is returned as the result of the command.

**::page::util::quote::quote'tcl** *char*
: This command takes a Tcl character (internal representation) and converts it into a string which is accepted by the Tcl parser, will regenerate the character in question and is 7bit ASCII. The string is returned as the result of this command.

**::page::util::quote::quote'tclstr** *char*
: This command takes a Tcl character (internal representation) and converts it into a string which is accepted by the Tcl parser and will generate a human readable representation of the character in question. The string is returned as the result of this command.

    The string does not use any unprintable characters. It may use backslash-quoting. High UTF characters are quoted to avoid problems with the still prevalent ascii terminals. It is assumed that the string will be used in a double-quoted environment.

**::page::util::quote::quote'tclcom** *char*
: This command takes a Tcl character (internal representation) and converts it into a string which is accepted by the Tcl parser when used within a Tcl comment. The string is returned as the result of this command.


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *page* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Page Parser Generator

# Copyright

```
Copyright (c) 2007 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
