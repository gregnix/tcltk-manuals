---
CommandName: uevent::onidle
ManualSection: n
Version: 0.2
TclPart: tcllib
TclDescription: User events
Keywords:
 - callback
 - deferal
 - event
 - idle
 - merge
 - on-idle
Copyright:
 - Copyright (c) 2008 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

uevent::onidle - Request merging and deferal to idle time

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [uevent::onidle]{.lit} [0.2]{.optlit} 
[package]{.cmd} [require]{.sub} [logger]{.lit} 
[::uevent::onidle]{.cmd} [objectName]{.arg} [commandprefix]{.arg} 
[objectName]{.ins} [request]{.sub} 
:::

# Description

This package provides objects which can merge multiple requestes for an action and execute the action the moment the system (event loop) becomes idle. The action to be run is configured during object construction.

# Api

The package exports a class, **uevent::onidle**, as specified below.

**::uevent::onidle** *objectName* *commandprefix*
: The command creates a new *onidle* object with an associated global Tcl command whose name is *objectName*.  This command may be used to invoke various operations on the object. The *commandprefix* is the action to perform when the event loop is idle and the user asked for it using the method **request** (See below). The object commands created by the class commands above have the form:

*objectName* **request**
: This method requests the execution of the command prefix specified during the construction of *objectName* the next time the event loop is idle. Multiple requests are merged and cause only one execution of the command prefix.


# Examples

Examples of this type of deferal are buried in the (C-level) implementations all the Tk widgets, defering geometry calculations and window redraw activity in this manner.

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *uevent* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Copyright

```
Copyright (c) 2008 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
