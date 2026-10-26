---
CommandName: debug::timestamp
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: debug narrative
Keywords:
 - debug
 - log
 - narrative
 - timestamps
 - trace
Copyright:
 - Copyright (c) 200?, Colin McCormack, Wub Server Utilities
 - Copyright (c) 2012, Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

debug::timestamp - debug narrative - timestamping

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [debug::timestamp]{.lit} [1.1]{.optlit} 
[package]{.cmd} [require]{.sub} [debug]{.lit} [1.0.7]{.optlit} 
[debug]{.cmd} [timestamp]{.sub} 
:::

# Description

# Api

**debug** **timestamp**
: This method returns millisecond timing information since a baseline or last call, making it useful in a tag-specific prefix to automatically provide caller information for all uses of the tag. Or in a message, when only specific places need such detail.


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
