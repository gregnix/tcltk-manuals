---
CommandName: term::send
ManualSection: n
Version: 0.3
TclPart: tcllib
TclDescription: Terminal control
Keywords:
 - character output
 - control
 - terminal
Copyright:
 - Copyright (c) 2006 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

term::send - General output to terminals

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [term::send]{.lit} [0.2]{.optlit} 
[::term::send::wrch]{.cmd} [chan]{.arg} [str]{.arg} 
[::term::send::wr]{.cmd} [str]{.arg} 
:::

# Description

This package provides the most primitive commands for sending characters to a terminal. They are in essence convenient wrappers around the builtin command **puts**.

**::term::send::wrch** *chan* *str*
: Send the text *str* to the channel specified by the handle *chan*. In contrast to the builtin command **puts** this command does not terminate the string with a line terminator. It also forces an  flush of Tcl internal and OS buffers to ensure that the characters are processed immediately.

**::term::send::wr** *str*
: This convenience command is like **::term::send::wrch**, except that the destination channel is fixed to *stdout*.


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *term* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Terminal control

# Copyright

```
Copyright (c) 2006 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
