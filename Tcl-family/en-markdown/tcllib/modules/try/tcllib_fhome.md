---
CommandName: file::home
title: file::home
ManualSection: n
Version: 1
TclPart: tcllib
TclDescription: Forward compatibility implementation of [file home]
Copyright:
 - Copyright (c) 2024 Andreas Kupries, BSD licensed
---

# Name

file::home - file home - Return home directory of current or other user

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.x]{.lit}
[package]{.cmd} [require]{.sub} [fhome]{.lit} [1]{.optlit}
[file]{.cmd} [home]{.lit} [user]{.optarg}
:::

# Description

This package provides a forward-compatibility implementation of Tcl 9's [file home](https://www.tcl-lang.org/man/tcl/TclCmd/file.html) subcommand (TIP 602), for Tcl 8.x.

**file** **home** ?*user*?
: Returns the home directory of the current user, or of the specified *user* if given.


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *file* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Utility

# Copyright

```
Copyright (c) 2024 Andreas Kupries, BSD licensed
```
