---
CommandName: tcl::chan::core
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: Reflected/virtual channel support
Keywords:
 - reflected channel
 - tip 219
 - virtual channel
Copyright:
 - Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

tcl::chan::core - Basic reflected/virtual channel support

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [TclOO]{.lit} 
[package]{.cmd} [require]{.sub} [tcl::chan::core]{.lit} [1.1]{.optlit} 
[::tcl::chan::core]{.cmd} [objectName]{.arg} 
[objectName]{.ins} [initialize]{.sub} [thechannel]{.arg} [mode]{.arg} 
[objectName]{.ins} [finalize]{.sub} [thechannel]{.arg} 
[objectName]{.ins} [destroy]{.sub} 
:::

# Description

The **tcl::chan::core** package provides a **TclOO** class implementing common behaviour needed by virtually every reflected or virtual channel (initialization, finalization).

This class expects to be used as either superclass of a concrete channel class, or to be mixed into such a class.

# Class api

**::tcl::chan::core** *objectName*
: This command creates a new channel core object with an associated global Tcl command whose name is *objectName*. This command may be used to invoke various operations on the object, as described in the section for the **Instance API**.


# Instance api

The API of channel core instances provides only two methods, both corresponding to channel handler commands (For reference see [TIP 219](http:/tip.tcl.tk/219)). They expect to be called from whichever object instance the channel core was made a part of.

*objectName* **initialize** *thechannel* *mode*
: This method implements standard behaviour for the **initialize** method of channel handlers. Using introspection it finds the handler methods supported by the instance and returns a list containing their names, as expected by the support for reflected channels in the Tcl core. It further remembers the channel handle in an instance variable for access by sub-classes.

*objectName* **finalize** *thechannel*
: This method implements standard behaviour for the **finalize** method of channel handlers. It simply destroys itself.

*objectName* **destroy**
: Destroying the channel core instance closes the channel it was initialized for, see the method **initialize**. When destroyed from within a call of **finalize** this does not happen, under the assumption that the channel is being destroyed by Tcl.


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
