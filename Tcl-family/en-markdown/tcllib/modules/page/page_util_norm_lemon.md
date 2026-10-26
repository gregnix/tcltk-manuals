---
CommandName: page_util_norm_lemon
title: page_util_norm_lemon
ManualSection: n
Version: 1.0
TclPart: tcllib
TclDescription: Parser generator tools
Keywords:
 - graph walking
 - lemon
 - normalization
 - page
 - parser generator
 - text processing
 - tree walking
Copyright:
 - Copyright (c) 2007 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

page\_util\_norm\_lemon - page AST normalization, LEMON

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [page::util::norm\_lemon]{.lit} [0.2]{.optlit}
[package]{.cmd} [require]{.sub} [snit]{.lit}
[::page::util::norm::lemon]{.cmd} [tree]{.arg}
:::

# Description

This package provides a single utility command which takes an AST for a lemon  grammar and normalizes it in various ways. The result is called a *Normalized Lemon Grammar Tree*.

*Note* that this package can only be used from within a plugin managed by the package **page::pluginmgr**.

# API

**::page::util::norm::lemon** *tree*
: This command assumes the *tree* object contains for a lemon grammar. It normalizes this tree in place. The result is called a *Normalized Lemon Grammar Tree*.

    The exact operations performed are left undocumented for the moment.


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *page* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Page Parser Generator

# Copyright

```
Copyright (c) 2007 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
