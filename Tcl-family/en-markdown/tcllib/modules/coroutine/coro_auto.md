---
CommandName: coroutine::auto
title: coroutine::auto
ManualSection: n
Version: 1.3
TclPart: tcllib
TclDescription: Coroutine utilities
Keywords:
 - after
 - channel
 - coroutine
 - events
 - exit
 - gets
 - global
 - green threads
 - read
 - threads
 - update
 - vwait
Copyright:
 - Copyright (c) 2010-2014 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

coroutine::auto - Automatic event and IO coroutine awareness

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [coroutine::auto]{.lit} [1.3]{.lit}
[package]{.cmd} [require]{.sub} [coroutine]{.lit} [1.4]{.lit}
:::

# Description

The **coroutine::auto** package provides no commands or other directly visible functionality. Built on top of the package **coroutine**, it intercepts various builtin commands of the Tcl core to make any code using them coroutine-oblivious, i.e. able to run inside and outside of a coroutine without changes.

The commands so affected by this package are

- **after**
- **exit**
- **gets**
- **global**
- **puts**
- **read**
- **socket**
- **update**
- **vwait**


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *coroutine* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Coroutine

# Copyright

```
Copyright (c) 2010-2014 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
