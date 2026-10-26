---
CommandName: tcl::transform::spacer
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: Reflected/virtual channel support
Keywords:
 - channel transformation
 - reflected channel
 - spacing
 - tip 230
 - transformation
 - virtual channel
Copyright:
 - Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

tcl::transform::spacer - Space insertation and removal

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [tcl::transform::core]{.lit} [1.1]{.optlit} 
[package]{.cmd} [require]{.sub} [tcl::transform::spacer]{.lit} [1.1]{.optlit} 
[::tcl::transform::spacer]{.cmd} [chan]{.arg} [n]{.arg} [space]{.optarg} 
:::

# Description

The **tcl::transform::spacer** package provides a command creating a channel transformation which adds spacing to the data written to it, and removes such spacing from the data read from it.

The internal **TclOO** class implementing the transform handler is a sub-class of the **tcl::transform::core** framework.

# Api

**::tcl::transform::spacer** *chan* *n* ?*space*?
: This command creates a spacer transformation on top of the channel *chan* and returns its handle. The *space* character sequence will be added every *n* bytes of data written, and on the read side the same is done in reverse, removing the spacing. If *space* is not specified it defaults to a single space character (ASCII 32).


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *virtchannel* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Channels

# Copyright

```
Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
