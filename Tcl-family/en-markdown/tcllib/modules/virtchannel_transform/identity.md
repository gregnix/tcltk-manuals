---
CommandName: tcl::transform::identity
title: tcl::transform::identity
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: Reflected/virtual channel support
Keywords:
 - channel transformation
 - identity
 - reflected channel
 - tip 230
 - transformation
 - virtual channel
Copyright:
 - Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

tcl::transform::identity - Identity transformation

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [tcl::transform::core]{.lit} [1.1]{.optlit}
[package]{.cmd} [require]{.sub} [tcl::transform::identity]{.lit} [1.1]{.optlit}
[::tcl::transform::identity]{.cmd} [chan]{.arg}
:::

# Description

The **tcl::transform::identity** package provides a command creating an identity channel transformation, which does nothing but pass the read and written bytes through it unchanged. Not really useful in an application, however as the prototypical observer transformation its code is a useful starting point for any other observers people may wish to write.

The transformations in this module which derived from identity's code are **tcl::transform::adler32**, **tcl::transform::counter**, **tcl::transform::crc32**, and **tcl::transform::observe**.

The internal **TclOO** class implementing the transform handler is a sub-class of the **tcl::transform::core** framework.

# API

**::tcl::transform::identity** *chan*
: This command creates an identity transformation on top of the channel *chan* and returns its handle.


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
