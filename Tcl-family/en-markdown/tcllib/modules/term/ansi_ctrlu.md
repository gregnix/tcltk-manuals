---
CommandName: term::ansi::ctrl::unix
title: term::ansi::ctrl::unix
ManualSection: n
Version: 0.1.2
TclPart: tcllib
TclDescription: Terminal control
Keywords:
 - ansi
 - columns
 - control
 - cooked
 - input mode
 - lines
 - raw
 - rows
 - terminal
Copyright:
 - Copyright (c) 2006-2011 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

term::ansi::ctrl::unix - Control operations and queries

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [term::ansi::ctrl::unix]{.lit} [0.1.2]{.optlit}
[::term::ansi::ctrl::unix::import]{.cmd} [ns]{.optarg} [arg...]{.optarg}
[::term::ansi::ctrl::unix::raw]{.cmd}
[::term::ansi::ctrl::unix::cooked]{.cmd}
[::term::ansi::ctrl::unix::columns]{.cmd}
[::term::ansi::ctrl::unix::rows]{.cmd}
:::

# Description

*WARNING*: This package is unix-specific and depends on the availability of two unix system commands for terminal control, i.e. **stty** and **tput**, both of which have to be found in the **$PATH**. If any of these two commands is missing the loading of the package will fail.

The package provides commands to switch the standard input of the current process between *raw* and *cooked* input modes, and to query the size of terminals, i.e. the available number of columns and lines.

# API

## Introspection

**::term::ansi::ctrl::unix::import** ?*ns*? ?*arg*...?
: This command imports some or all attribute commands into the namespace *ns*. This is by default the namespace *ctrl*. Note that this is relative namespace name, placing the imported command into a child of the current namespace. By default all commands are imported, this can howver be restricted by listing the names of the wanted commands after the namespace argument.


## Operations

**::term::ansi::ctrl::unix::raw**
: This command switches the standard input of the current process to *raw* input mode. This means that from then on all characters typed by the user are immediately reported to the application instead of waiting in the OS buffer until the Enter/Return key is received.

**::term::ansi::ctrl::unix::cooked**
: This command switches the standard input of the current process to *cooked* input mode. This means that from then on all characters typed by the user are kept in OS buffers for editing until the Enter/Return key is received.

**::term::ansi::ctrl::unix::columns**
: This command queries the terminal connected to the standard input for the number of columns available for display.

**::term::ansi::ctrl::unix::rows**
: This command queries the terminal connected to the standard input for the number of rows (aka lines) available for display.


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *term* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Terminal control

# Copyright

```
Copyright (c) 2006-2011 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
