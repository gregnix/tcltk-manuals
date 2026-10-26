---
CommandName: tcl::transform::limitsize
title: tcl::transform::limitsize
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: Reflected/virtual channel support
Keywords:
 - channel transformation
 - limitsize
 - reflected channel
 - size limit
 - tip 230
 - transformation
 - virtual channel
Copyright:
 - Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

tcl::transform::limitsize - limiting input

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [tcl::transform::core]{.lit} [1.1]{.optlit}
[package]{.cmd} [require]{.sub} [tcl::transform::limitsize]{.lit} [1.1]{.optlit}
[::tcl::transform::limitsize]{.cmd} [chan]{.arg} [max]{.arg}
:::

# Description

The **tcl::transform::limitsize** package provides a command creating a channel transformation which limits the number of characters which can be read from the channel. A generator for an artificial EOF.

The internal **TclOO** class implementing the transform handler is a sub-class of the **tcl::transform::core** framework.

# API

**::tcl::transform::limitsize** *chan* *max*
: This command creates a size limiting transformation on top of the channel *chan* and returns its handle.

    *max* is the number of bytes which can be read from the channel before EOF is signaled by the transformation. Note that popping the transformation clears the EOF it generated as well.


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
