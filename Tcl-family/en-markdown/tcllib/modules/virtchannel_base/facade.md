---
CommandName: tcl::chan::facade
ManualSection: n
Version: 1.1
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

tcl::chan::facade - Facade channel

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [TclOO]{.lit} 
[package]{.cmd} [require]{.sub} [logger]{.lit} 
[package]{.cmd} [require]{.sub} [tcl::chan::core]{.lit} [1.1]{.optlit} 
[package]{.cmd} [require]{.sub} [tcl::chan::facade]{.lit} [1.1]{.optlit} 
[::tcl::chan::facade]{.cmd} [chan]{.arg} 
:::

# Description

The **tcl::chan::facade** package provides a command creating facades to other channels. These are channels which own a single subordinate channel and delegate all operations to.

The main use for facades is the debugging of actions on a channel. While most of the information could be tracked by a virtual channel transformation it does not have access to the event-related operation, and furthermore they are only available in Tcl 8.6.

Therefore this channel, usable with Tcl 8.5, and having access to everything going on for a channel.

The intercepted actions on channel are logged through package **logger**.

Beyond that facades provide the following additional channel configuration options:

**-self**
: The TclOO object handling the facade.

**-fd**
: The handle of the subordinate, i.e. wrapped channel.

**-used**
: The last time the wrapped channel was read from or written to by the facade, as per **clock milliseconds**. A value of **0** indicates that the subordinate channel was not accessed at all, yet.

**-created**
: The time the facade was created, as per **clock milliseconds**.

**-user**
: A free-form value identifying the user of the facade and its wrapped channel. Of these only option **-user** is writable.


# Api

**::tcl::chan::facade** *chan*
: This command creates the facade channel around the provided channel *chan*, and returns its handle.


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
