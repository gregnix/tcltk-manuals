---
CommandName: tcl::chan::events
title: tcl::chan::events
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: Reflected/virtual channel support
Keywords:
 - event management
 - reflected channel
 - tip 219
 - virtual channel
Copyright:
 - Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

tcl::chan::events - Event support for reflected/virtual channels

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [TclOO]{.lit}
[package]{.cmd} [require]{.sub} [tcl::chan::core]{.lit} [1.1]{.optlit}
[package]{.cmd} [require]{.sub} [tcl::chan::events]{.lit} [1.1]{.optlit}
[::tcl::chan::events]{.cmd} [objectName]{.arg}
[objectName]{.ins} [finalize]{.sub} [thechannel]{.arg}
[objectName]{.ins} [watch]{.sub} [thechannel]{.arg} [eventmask]{.arg}
[objectName]{.ins} [allow]{.sub} [eventname...]{.arg}
[objectName]{.ins} [disallow]{.sub} [eventname...]{.arg}
:::

# Description

The **tcl::chan::events** package provides a **TclOO** class implementing common behaviour needed by virtually every reflected or virtual channel supporting event driven IO. It is a sub-class of **tcl::chan::core**, inheriting all of its behaviour.

This class expects to be used as either superclass of a concrete channel class, or to be mixed into such a class.

# Class API

**::tcl::chan::events** *objectName*
: This command creates a new channel event core object with an associated global Tcl command whose name is *objectName*. This command may be used to invoke various operations on the object, as described in the section for the [Instance API].


# Instance API

The API of channel event core instances provides only four methods, two corresponding to channel handler commands (For reference see [TIP 219](http:/tip.tcl.tk/219)), and the other two for use by sub-classes to control event generation. They former expect to be called from whichever object instance the channel event core was made a part of.

*objectName* **finalize** *thechannel*
: This method implements standard behaviour for the **finalize** method of channel handlers. It overrides the behaviour inherited from **tcl::chan::core** and additionally disables any and all event generation before destroying itself.

*objectName* **watch** *thechannel* *eventmask*
: This method implements standard behaviour for the **watch** method of channel handlers. Called by the IO system whenever the interest in event changes it updates the instance state to activate and/or suppress the generation of the events of (non-)interest.

*objectName* **allow** *eventname*...
: see below ...

*objectName* **disallow** *eventname*...
: These two methods are exported to sub-classes, so that their instances can notify their event core of the events the channel they implement can (allow) or cannot (disallow) generate. Together with the information about the events requested by Tcl's IO system coming in through the **watch** method the event core is able to determine which events it should (not) generate and act accordingly.


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
