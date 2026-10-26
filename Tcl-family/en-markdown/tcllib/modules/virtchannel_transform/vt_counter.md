---
CommandName: tcl::transform::counter
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: Reflected/virtual channel support
Keywords:
 - channel transformation
 - counter
 - reflected channel
 - tip 230
 - transformation
 - virtual channel
Copyright:
 - Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

tcl::transform::counter - Counter transformation

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [tcl::transform::core]{.lit} [1.1]{.optlit} 
[package]{.cmd} [require]{.sub} [tcl::transform::counter]{.lit} [1.1]{.optlit} 
[::tcl::transform::counter]{.cmd} [chan]{.arg} [-option]{.lit} [value...]{.arg} 
:::

# Description

The **tcl::transform::counterr** package provides a command creating a channel transformation which passes the read and written bytes through unchanged (like **tcl::transform::identity**), but additionally counts the bytes it has seen for each direction and stores these counts in Tcl variables specified at construction time.

Related transformations in this module are **tcl::transform::adler32**, **tcl::transform::crc32**, **tcl::transform::identity**, and **tcl::transform::observe**.

The internal **TclOO** class implementing the transform handler is a sub-class of the **tcl::transform::core** framework.

# Api

**::tcl::transform::counter** *chan* **-option** *value*...
: This command creates a counter transformation on top of the channel *chan* and returns its handle. The accepted options are


**-read-variable** varname
: The value of the option is the name of a global or namespaced variable, the location where the transformation has to store the byte count of the data read from the channel. If not specified, or the empty string, the counter of the read direction is not saved.

**-write-variable** varname
: The value of the option is the name of a global or namespaced variable, the location where the transformation has to store the byte count of the data written to the channel. If not specified, or the empty string, the counter of the write direction is not saved.


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
