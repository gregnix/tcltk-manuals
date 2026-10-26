---
CommandName: tcl::chan::std
title: tcl::chan::std
ManualSection: n
Version: 1.2
TclPart: tcllib
TclDescription: Reflected/virtual channel support
Keywords:
 - reflected channel
 - standard io
 - stdin
 - stdout
 - tip 219
 - virtual channel
Copyright:
 - Copyright (c) 2011 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

tcl::chan::std - Standard I/O, unification of stdin and stdout

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [TclOO]{.lit}
[package]{.cmd} [require]{.sub} [tcl::chan::core]{.lit} [1.1]{.optlit}
[package]{.cmd} [require]{.sub} [tcl::chan::std]{.lit} [1.2]{.optlit}
[::tcl::chan::std]{.cmd}
:::

# Description

The **tcl::chan::std** package provides a command creating a standard channel which unifies stdin and stdout into a single read- and writable channel. The result is not seek-able, like the original standard channels.

The internal **TclOO** class implementing the channel handler is a sub-class of the **tcl::chan::core** framework.

# API

**::tcl::chan::std**
: This command creates the std channel and returns its handle.

    The channel is created only once, on the first call, and all future calls simply return this handle.


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *virtchannel* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Channels

# Copyright

```
Copyright (c) 2011 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
