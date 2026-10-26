---
CommandName: flush
title: flush
ManualSection: n
Version: 7.5
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - file(n)
 - open(n)
 - socket(n)
 - Tcl_StandardChannels(3)
Keywords:
 - blocking
 - buffer
 - channel
 - flush
 - nonblocking
 - output
Copyright:
 - Copyright (c) 1993 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

flush - Flush buffered output for a channel

# Synopsis

::: {.synopsis} :::
[flush]{.cmd} [channelId]{.arg}
:::

# Description

Flushes any output that has been buffered for *channelId*.

*ChannelId* must be an identifier for an open channel such as a Tcl standard channel (**stdout** or **stderr**), the return value from an invocation of [open] or [socket], or the result of a channel creation command provided by a Tcl extension.  The channel must have been opened for writing.

If the channel is in blocking mode the command does not return until all the buffered output has been flushed to the channel. If the channel is in nonblocking mode, the command may return before all buffered output has been flushed; the remainder will be flushed in the background as fast as the underlying file or device is able to absorb it.

# Example

Prompt for the user to type some information in on the console:

```
puts -nonewline "Please type your name: "
flush stdout
gets stdin name
puts "Hello there, $name!"
```


[open]: open.md
[socket]: socket.md
