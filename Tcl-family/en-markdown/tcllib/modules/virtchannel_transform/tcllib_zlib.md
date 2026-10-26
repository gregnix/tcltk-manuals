---
CommandName: tcl::transform::zlib
title: tcl::transform::zlib
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: Reflected/virtual channel support
Keywords:
 - channel transformation
 - compression
 - decompression
 - reflected channel
 - tip 230
 - tip 234
 - transformation
 - virtual channel
 - zlib
Copyright:
 - Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

tcl::transform::zlib - zlib (de)compression

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [tcl::transform::core]{.lit} [1.1]{.optlit}
[package]{.cmd} [require]{.sub} [tcl::transform::zlib]{.lit} [1.1]{.optlit}
[::tcl::transform::zlib]{.cmd} [chan]{.arg} [level]{.optarg}
:::

# Description

The **tcl::transform::zlib** package provides a command creating a channel transformation which zlib compresses the written data, and decompresses on reading.

The internal **TclOO** class implementing the transform handler is a sub-class of the **tcl::transform::core** framework.

# API

**::tcl::transform::zlib** *chan* ?*level*?
: This command creates a zlib compressor transformation on top of the channel *chan* and returns its handle.

    The *level* specifies how much effort is put into the compression, from **0** to **9**, and defaults to **4**.


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
