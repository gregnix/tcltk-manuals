---
CommandName: pkg_dtplite
title: pkg_dtplite
ManualSection: n
Version: 1.3.2
TclPart: tcllib
TclDescription: Documentation toolbox
Links:
 - docidx introduction
 - doctoc introduction
 - doctools introduction
Keywords:
 - HTML
 - TMML
 - conversion
 - docidx
 - doctoc
 - doctools
 - manpage
 - markup
 - nroff
Copyright:
 - Copyright (c) 2004-2013 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

pkg\_dtplite - Lightweight DocTools Markup Processor

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [dtplite]{.lit} [1.3.2]{.optlit}
[dtplite::print-via]{.cmd} [cmd]{.arg}
[dtplite::do]{.cmd} [arguments]{.arg}
:::

# Description

The package provided by this document, **dtplite**, is the foundation for the **dtplite** application. It is a light wrapper around the various **doctools** packages.

# Commands

**dtplite::print-via** *cmd*
: Redirect print operations of the package to the specified *cmd*.

    The result of the command is the empty string.

**dtplite::do** *arguments*
: The main command it takes a *single list* of *arguments*, processes them, and performs the specified action.

    The result of the command is the empty string.

    The details of the syntax inside of the *arguments* list are explained in section *COMMAND LINE* of the documentation for the **dtplite** application.


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *doctools* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Documentation tools

# Copyright

```
Copyright (c) 2004-2013 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
