---
CommandName: page_intro
title: page_intro
ManualSection: n
Version: 1.0
TclPart: tcllib
TclDescription: Parser generator tools
Keywords:
 - page
 - parser generator
 - text processing
Copyright:
 - Copyright (c) 2007 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

page\_intro - page introduction

# Description

*page* (short for *parser generator*) stands for a set of related packages which help in the construction of parser generators, and other utilities doing text processing.

They are mainly geared towards supporting the Tcllib application **page**, with the package **page::pluginmgr** in a central role as the plugin management for the application. The other packages are performing low-level text processing and utility tasks geared towards parser generation and mainly accessed by **page** through plugins.

The packages implementing the plugins are not documented as regular packages, as they cannot be loaded into a general interpreter, like tclsh, without extensive preparation of the interpreter. Preparation which is done for them by the plugin manager.

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
