---
CommandName: tcl::chan::halfpipe
ManualSection: n
Version: 1.0.2
TclPart: tcllib
TclDescription: Reflected/virtual channel support
Keywords:
 - callbacks
 - fifo
 - in-memory channel
 - reflected channel
 - tip 219
 - virtual channel
Copyright:
 - Copyright (c) 2009, 2019 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

tcl::chan::halfpipe - In-memory channel, half of a fifo2

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [TclOO]{.lit} 
[package]{.cmd} [require]{.sub} [tcl::chan::events]{.lit} [1.1]{.optlit} 
[package]{.cmd} [require]{.sub} [tcl::chan::halfpipe]{.lit} [1.0.2]{.optlit} 
[::tcl::chan::halfpipe]{.cmd} [-option value]{.optdot} 
[objectCmd]{.ins} [put]{.sub} [bytes]{.arg} 
:::

# Description

The **tcl::chan::halfpipe** package provides a command creating one half of a **tcl::chan::fifo2** pair. Writing into such a channel invokes a set of callbacks which then handle the data. This is similar to a channel handler, except having a much simpler API.

The internal **TclOO** class implementing the channel handler is a sub-class of the **tcl::chan::events** framework.

# Api

**::tcl::chan::halfpipe** ?**-option** *value*...?
: This command creates a halfpipe channel and configures it with the callbacks to run when the channel is closed, data was written to it, or ran empty. See the section **Options** for the list of options and associated semantics. The result of the command is a list containing two elements, the handle of the new channel, and the object command of the channel handler, in this order. The latter is supplied to the caller to provide her with access to the **put** method for adding data to the channel. Two halfpipes with a bit of glue logic in the callbacks make for one **tcl::chan::fifo2**.

*objectCmd* **put** *bytes*
: This method of the channel handler object puts the data *bytes* into the channel so that it can be read from it.


# Options

**-close-command** cmdprefix
: This callback is invoked when the channel is closed. A single argument is supplied, the handle of the channel being closed. The result of the callback is ignored.

**-write-command** cmdprefix
: This callback is invoked when data is written to the channel. Two arguments are supplied, the handle of the channel written to, and the data written. The result of the callback is ignored.

**-empty-command** cmdprefix
: This callback is invoked when the channel has run out of data to read. A single argument is supplied, the handle of the channel.


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *virtchannel* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Channels

# Copyright

```
Copyright (c) 2009, 2019 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
