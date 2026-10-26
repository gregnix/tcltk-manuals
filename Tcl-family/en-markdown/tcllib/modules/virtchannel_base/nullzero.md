---
CommandName: tcl::chan::nullzero
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: Reflected/virtual channel support
Keywords:
 - /dev/null
 - /dev/zero
 - null
 - reflected channel
 - tip 219
 - virtual channel
 - zero
Copyright:
 - Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

tcl::chan::nullzero - Null/Zero channel combination

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [TclOO]{.lit} 
[package]{.cmd} [require]{.sub} [tcl::chan::events]{.lit} [1.1]{.optlit} 
[package]{.cmd} [require]{.sub} [tcl::chan::nullzero]{.lit} [1.1]{.optlit} 
[::tcl::chan::nullzero]{.cmd} 
:::

# Description

The **tcl::chan::nullzero** package provides a command creating channels, which are a combination of null and zero devices. They immediately forget whatever is written to them, and on reading return an infinite stream of null characters.

Packages related to this are **tcl::chan::null** and **tcl::chan::zero**.

The internal **TclOO** class implementing the channel handler is a sub-class of the **tcl::chan::events** framework.

# Api

**::tcl::chan::nullzero**
: This command creates a new nullzero channel and returns its handle.


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
