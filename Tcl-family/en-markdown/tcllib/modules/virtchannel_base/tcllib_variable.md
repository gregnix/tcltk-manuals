---
CommandName: tcl::chan::variable
title: tcl::chan::variable
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
 - Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

tcl::chan::variable - In-memory channel using variable for storage

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [TclOO]{.lit}
[package]{.cmd} [require]{.sub} [tcl::chan::events]{.lit} [1.1]{.optlit}
[package]{.cmd} [require]{.sub} [tcl::chan::variable]{.lit} [1.0.5]{.optlit}
[::tcl::chan::variable]{.cmd} [varname]{.arg}
:::

# Description

The **tcl::chan::variable** package provides a command creating channels which live purely in memory. They provide random-access, i.e. are seekable. In contrast to the channels created by **tcl::chan::memchan** the data is not hidden in the channel however, but stored in an associated variable, specified at the time of construction.

Packages related to this are **tcl::chan::memchan** and **tcl::chan::string**.

The internal **TclOO** class implementing the channel handler is a sub-class of the **tcl::chan::events** framework.

# API

**::tcl::chan::variable** *varname*
: This command creates a new variable channel and returns its handle. The content of the channel is stored in the associated namespace variable *varname*.


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
