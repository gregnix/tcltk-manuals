---
CommandName: tie
title: tie
ManualSection: n
Version: 1.3
TclPart: tcllib
TclDescription: Tcl Data Structures
Keywords:
 - array
 - database
 - file
 - metakit
 - persistence
 - tie
 - untie
Copyright:
 - Copyright (c) 2008-2021 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

tie - Array persistence, standard data sources

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [tie::std::log]{.lit} [1.2]{.optlit}
[package]{.cmd} [require]{.sub} [tie::std::array]{.lit} [1.2]{.optlit}
[package]{.cmd} [require]{.sub} [tie::std::rarray]{.lit} [1.2]{.optlit}
[package]{.cmd} [require]{.sub} [tie::std::file]{.lit} [1.2]{.optlit}
[package]{.cmd} [require]{.sub} [tie::std::growfile]{.lit} [1.2]{.optlit}
[package]{.cmd} [require]{.sub} [tie::std::dsource]{.lit} [1.2]{.optlit}
:::

# Description

The packages listed as requirements for this document are internal packages providing the standard data sources of package **tie**, as described in section *STANDARD DATA SOURCE TYPES* of **tie**'s documentation.

They are automatically loaded and registered by **tie** when it itself is requested, and as such there is no need to request them on their own, although it is possible to do so.

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *tie* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Programming tools

# Copyright

```
Copyright (c) 2008-2021 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
