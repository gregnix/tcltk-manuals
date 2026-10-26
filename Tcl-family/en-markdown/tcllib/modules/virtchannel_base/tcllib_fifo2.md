---
CommandName: tcl::chan::fifo2
title: tcl::chan::fifo2
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: Reflected/virtual channel support
Keywords:
 - connected fifos
 - fifo
 - in-memory channel
 - inter-thread communication
 - reflected channel
 - tip 219
 - virtual channel
Copyright:
 - Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

tcl::chan::fifo2 - In-memory interconnected fifo channels

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [TclOO]{.lit}
[package]{.cmd} [require]{.sub} [tcl::chan::events]{.lit} [1.1]{.optlit}
[package]{.cmd} [require]{.sub} [tcl::chan::halfpipe]{.lit} [1.1]{.optlit}
[package]{.cmd} [require]{.sub} [tcl::chan::fifo2]{.lit} [1.1]{.optlit}
[::tcl::chan::fifo2]{.cmd}
:::

# Description

The **tcl::chan::fifo2** package provides a command creating pairs of channels which live purely in memory and are connected to each other in a fifo manner. What is written to one half of the pair can be read from the other half, in the same order. One particular application for this is communication between threads, with one half of the pair moved to the thread to talk to. This is equivalent to the fifo2 channels provided by the package **Memchan**, except that this is written in pure Tcl, not C. On the other hand, **Memchan** is usable with Tcl 8.4 and before, whereas this package requires Tcl 8.5 or higher, and **TclOO**.

The internal **TclOO** class implementing the channel handler is a sub-class of the **tcl::chan::events** framework.

# API

**::tcl::chan::fifo2**
: This command creates a new connected pair of fifo channels and returns their handles, as a list containing two elements.


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
