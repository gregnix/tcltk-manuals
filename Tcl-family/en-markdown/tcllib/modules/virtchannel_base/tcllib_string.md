---
CommandName: tcl::chan::string
title: tcl::chan::string
ManualSection: n
Version: 1.0.4
TclPart: tcllib
TclDescription: Reflected/virtual channel support
Keywords:
 - in-memory channel
 - reflected channel
 - tip 219
 - virtual channel
Copyright:
 - Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

tcl::chan::string - Read-only in-memory channel

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [TclOO]{.lit}
[package]{.cmd} [require]{.sub} [tcl::chan::events]{.lit} [1.1]{.optlit}
[package]{.cmd} [require]{.sub} [tcl::chan::string]{.lit} [1.0.4]{.optlit}
[::tcl::chan::string]{.cmd} [content]{.arg}
:::

# Description

The **tcl::chan::string** package provides a command creating channels which live purely in memory. They provide random-access, i.e. are seekable. In contrast to the channels created by **tcl::chan::memchan** they are read-only however, their content is provided at the time of construction and immutable afterward.

Packages related to this are **tcl::chan::memchan** and **tcl::chan::variable**.

The internal **TclOO** class implementing the channel handler is a sub-class of the **tcl::chan::events** framework.

# API

**::tcl::chan::string** *content*
: This command creates a new string channel and returns its handle. The channel provides random read-only access to the *content* string.


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
