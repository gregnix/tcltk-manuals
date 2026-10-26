---
CommandName: tcl::chan::cat
title: tcl::chan::cat
ManualSection: n
Version: 1.0.4
TclPart: tcllib
TclDescription: Reflected/virtual channel support
Keywords:
 - concatenation channel
 - reflected channel
 - tip 219
 - virtual channel
Copyright:
 - Copyright (c) 2011 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

tcl::chan::cat - Concatenation channel

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [TclOO]{.lit}
[package]{.cmd} [require]{.sub} [tcl::chan::core]{.lit} [1.1]{.optlit}
[package]{.cmd} [require]{.sub} [tcl::chan::cat]{.lit} [1.0.4]{.optlit}
[::tcl::chan::cat]{.cmd} [chan...]{.arg}
:::

# Description

The **tcl::chan::cat** package provides a command creating concatenation channels. These are non-seekable channels owning a list of subordinate channels whose contents they return in order, until all are exhausted. In this manner the channel is the concatentation of the contents of all the sub-ordinate channels.

Note that the created channels take ownership of the channels they were constructed with. Whenever they have exhausted one of their channel it will be closed. Similarly, closing the cat channel will close all the sub-ordinates it still has.

The internal **TclOO** class implementing the channel handler is a sub-class of the **tcl::chan::core** framework.

Event handling is delegated to the currently active sub-channel.

# API

**::tcl::chan::cat** *chan*...
: This command creates the concatenation channel using all the provided channels, and returns its handle.


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *virtchannel* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Channels

# Copyright

```
Copyright (c) 2011 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
