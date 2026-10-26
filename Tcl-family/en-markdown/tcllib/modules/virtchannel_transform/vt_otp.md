---
CommandName: tcl::transform::otp
title: tcl::transform::otp
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: Reflected/virtual channel support
Keywords:
 - channel transformation
 - cipher
 - decryption
 - encryption
 - one time pad
 - otp
 - reflected channel
 - tip 230
 - transformation
 - virtual channel
 - xor
Copyright:
 - Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

tcl::transform::otp - Encryption via one-time pad

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [tcl::transform::core]{.lit} [1.1]{.optlit}
[package]{.cmd} [require]{.sub} [tcl::transform::otp]{.lit} [1.1]{.optlit}
[::tcl::transform::otp]{.cmd} [chan]{.arg} [keychanw]{.arg} [keychanr]{.arg}
:::

# Description

The **tcl::transform::otp** package provides a command creating a channel transformation which uses externally provided one-time pads to perform encryption (on writing) and decryption (on reading).

A related transformations in this module is **tcl::transform::rot**.

The internal **TclOO** class implementing the transform handler is a sub-class of the **tcl::transform::core** framework.

# API

**::tcl::transform::otp** *chan* *keychanw* *keychanr*
: This command creates a one-time pad based encryption transformation on top of the channel *chan* and returns its handle.

    The two channels *keychanw* and *keychanr* contain the one-time pads for the write and read directions, respectively. Their contents are reads and xored with the bytes written to and read from the channel.


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
