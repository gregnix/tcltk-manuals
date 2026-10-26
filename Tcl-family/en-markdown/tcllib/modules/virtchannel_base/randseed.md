---
CommandName: tcl::randomseed
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: Reflected/virtual channel support
Keywords:
 - /dev/random
 - merge
 - random
 - reflected channel
 - seed
 - tip 219
 - virtual channel
Copyright:
 - Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

tcl::randomseed - Utilities for random channels

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [TclOO]{.lit} 
[package]{.cmd} [require]{.sub} [tcl::randomseed]{.lit} [1.1]{.optlit} 
[::tcl::randomseed]{.cmd} 
[::tcl::combine]{.cmd} [seed1]{.arg} [seed2]{.arg} 
:::

# Description

The **tcl::randomseed** package provides a a few utility commands to help with the seeding of **tcl::chan::random** channels.

# Api

**::tcl::randomseed**
: This command creates returns a list of seed integers suitable as seed argument for random channels. The numbers are derived from the process id, current time, and Tcl random number generator.

**::tcl::combine** *seed1* *seed2*
: This command takes to seed lists and combines them into a single list by XORing them elementwise, modulo 256. If the lists are not of equial length the shorter of the two is padded with 0s before merging.


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
