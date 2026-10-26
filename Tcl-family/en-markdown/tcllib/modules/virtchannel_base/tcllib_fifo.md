---
CommandName: tcl::chan::fifo
title: tcl::chan::fifo
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: Reflected/virtual channel support
Keywords:
 - fifo
 - in-memory channel
 - reflected channel
 - tip 219
 - virtual channel
Copyright:
 - Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

tcl::chan::fifo - In-memory fifo channel

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [TclOO]{.lit}
[package]{.cmd} [require]{.sub} [tcl::chan::events]{.lit} [1.1]{.optlit}
[package]{.cmd} [require]{.sub} [tcl::chan::fifo]{.lit} [1.1]{.optlit}
[::tcl::chan::fifo]{.cmd}
:::

# Description

The **tcl::chan::fifo** package provides a command creating channels which live purely in memory. Access is fifo-like, i.e. things are read out of the channel in the order they were written to it. This is equivalent to the fifo channels provided by the package **Memchan**, except that this is written in pure Tcl, not C. On the other hand, **Memchan** is usable with Tcl 8.4 and before, whereas this package requires Tcl 8.5 or higher, and **TclOO**.

The internal **TclOO** class implementing the channel handler is a sub-class of the **tcl::chan::events** framework.

# API

**::tcl::chan::fifo**
: This command creates a new fifo channel and returns its handle.


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
