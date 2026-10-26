---
CommandName: tcl::transform::hex
title: tcl::transform::hex
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: Reflected/virtual channel support
Keywords:
 - channel transformation
 - hexadecimal
 - reflected channel
 - tip 230
 - transformation
 - virtual channel
Copyright:
 - Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

tcl::transform::hex - Hexadecimal encoding transformation

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [tcl::transform::core]{.lit} [1.1]{.optlit}
[package]{.cmd} [require]{.sub} [tcl::transform::hex]{.lit} [1.1]{.optlit}
[::tcl::transform::hex]{.cmd} [chan]{.arg}
:::

# Description

The **tcl::transform::hex** package provides a command creating a channel transformation which hex encodes data written to it, and decodes the data read from it.

A related transformations in this module is **tcl::transform::base64**.

The internal **TclOO** class implementing the transform handler is a sub-class of the **tcl::transform::core** framework.

# API

**::tcl::transform::hex** *chan*
: This command creates a hex transformation on top of the channel *chan* and returns its handle.


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
