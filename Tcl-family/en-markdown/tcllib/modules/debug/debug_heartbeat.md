---
CommandName: debug::heartbeat
ManualSection: n
Version: 1.0.2
TclPart: tcllib
TclDescription: debug narrative
Keywords:
 - debug
 - heartbeat
 - log
 - narrative
 - trace
Copyright:
 - Copyright (c) 200?, Colin McCormack, Wub Server Utilities
 - Copyright (c) 2012, Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

debug::heartbeat - debug narrative - heartbeat

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [debug::heartbeat]{.lit} [1.0.2]{.optlit} 
[package]{.cmd} [require]{.sub} [debug]{.lit} [1]{.optlit} 
[debug]{.cmd} [heartbeat]{.sub} [delta]{.optarg} 
:::

# Description

# Api

**debug** **heartbeat** ?*delta*?
: This method activates or disables a heartbeat with which to monitor the event loop of an event-based Tcl application. It reserves the debug tag **heartbeat** for its operation and writes a message every *delta* milliseconds. A *delta*-value <= 0 disables the heartbeat. The message produced by the heartbeat contains a sequence counter and the time in milliseconds since the last beat, thus providing insight into timing variationsn and deviations from the nominal *delta*.


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *debug* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

debugging, tracing, and logging

# Copyright

```
Copyright (c) 200?, Colin McCormack, Wub Server Utilities
Copyright (c) 2012, Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
