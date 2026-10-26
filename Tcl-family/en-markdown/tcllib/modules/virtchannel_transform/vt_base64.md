---
CommandName: tcl::transform::base64
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: Reflected/virtual channel support
Keywords:
 - base64
 - channel transformation
 - reflected channel
 - tip 230
 - tip 317
 - transformation
 - virtual channel
Copyright:
 - Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

tcl::transform::base64 - Base64 encoding transformation

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [tcl::transform::core]{.lit} [1.1]{.optlit} 
[package]{.cmd} [require]{.sub} [tcl::transform::base64]{.lit} [1.1]{.optlit} 
[::tcl::transform::base64]{.cmd} [chan]{.arg} 
:::

# Description

The **tcl::transform::base64** package provides a command creating a channel transformation which base64 encodes data written to it, and decodes the data read from it.

A related transformations in this module is **tcl::transform::hex**.

The internal **TclOO** class implementing the transform handler is a sub-class of the **tcl::transform::core** framework.

# Api

**::tcl::transform::base64** *chan*
: This command creates a base64 transformation on top of the channel *chan* and returns its handle.


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
