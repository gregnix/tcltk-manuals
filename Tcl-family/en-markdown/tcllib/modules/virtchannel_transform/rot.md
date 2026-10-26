---
CommandName: tcl::transform::rot
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: Reflected/virtual channel support
Keywords:
 - caesar cipher
 - channel transformation
 - cipher
 - decryption
 - encryption
 - reflected channel
 - rot
 - rot13
 - tip 230
 - transformation
 - virtual channel
Copyright:
 - Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

tcl::transform::rot - rot-encryption

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [tcl::transform::core]{.lit} [1.1]{.optlit} 
[package]{.cmd} [require]{.sub} [tcl::transform::rot]{.lit} [1.1]{.optlit} 
[::tcl::transform::rot]{.cmd} [chan]{.arg} [key]{.arg} 
:::

# Description

The **tcl::transform::rot** package provides a command creating a channel transformation which performs primitive encryption (on writing) and decryption (on reading) on the alphabetic characters. The algorithm is the Caesar-cipher, a specific variant of which is rot13.

A related transformations in this module is **tcl::transform::otp**.

The internal **TclOO** class implementing the transform handler is a sub-class of the **tcl::transform::core** framework.

# Api

**::tcl::transform::rot** *chan* *key*
: This command creates a rot encryption transformation on top of the channel *chan* and returns its handle. The "*key*" specifies how far characters are rotated in the alphabet, and is wrapped to the range "0...25". Note that this transformation affects only bytes in the ranges ASCII 65...90, and 97...122, i.e. the upper- and lower-case alphabetic characters, i.e. "A...Z" and "a...z". All other bytes are passed through unchanged.


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
