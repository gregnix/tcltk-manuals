---
CommandName: tcl::chan::memchan
title: tcl::chan::memchan
ManualSection: n
Version: 1.0.5
TclPart: tcllib
TclDescription: Reflected/virtual channel support
Keywords:
 - in-memory channel
 - reflected channel
 - tip 219
 - virtual channel
Copyright:
 - Copyright (c) 2009-2017 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

tcl::chan::memchan - In-memory channel

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [TclOO]{.lit}
[package]{.cmd} [require]{.sub} [tcl::chan::events]{.lit} [1.1]{.optlit}
[package]{.cmd} [require]{.sub} [tcl::chan::memchan]{.lit} [1.0.5]{.optlit}
[::tcl::chan::memchan]{.cmd}
:::

# Description

The **tcl::chan::memchan** package provides a command creating channels which live purely in memory. They provide random-access, i.e. are seekable. This is equivalent to the memchan channels provided by the package **Memchan**, except that this is written in pure Tcl, not C. On the other hand, **Memchan** is usable with Tcl 8.4 and before, whereas this package requires Tcl 8.5 or higher, and **TclOO**.

Packages related to this are **tcl::chan::string** and **tcl::chan::variable**.

The internal **TclOO** class implementing the channel handler is a sub-class of the **tcl::chan::events** framework.

# API

**::tcl::chan::memchan**
: This command creates a new memchan channel and returns its handle.


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *virtchannel* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Channels

# Copyright

```
Copyright (c) 2009-2017 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
