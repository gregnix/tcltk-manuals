---
CommandName: term::ansi::code
title: term::ansi::code
ManualSection: n
Version: 0.2
TclPart: tcllib
TclDescription: Terminal control
Keywords:
 - control
 - declare
 - define
 - terminal
Copyright:
 - Copyright (c) 2006 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

term::ansi::code - Helper for control sequences

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [term::ansi::code]{.lit} [0.2]{.optlit}
[::term::ansi::code::esc]{.cmd} [str]{.arg}
[::term::ansi::code::escb]{.cmd} [str]{.arg}
[::term::ansi::code::define]{.cmd} [name]{.arg} [escape]{.arg} [code]{.arg}
[::term::ansi::code::const]{.cmd} [name]{.arg} [code]{.arg}
:::

# Description

This package provides commands enabling the definition of control sequences in an easy manner.

**::term::ansi::code::esc** *str*
: This command returns the argument string, prefixed with the ANSI escape character, "\\033."

**::term::ansi::code::escb** *str*
: This command returns the argument string, prefixed with a common ANSI escape sequence, "\\033\[".

**::term::ansi::code::define** *name* *escape* *code*
: This command defines a procedure *name* which returns the control sequence *code*, beginning with the specified escape sequence, either **esc**, or **escb**.

**::term::ansi::code::const** *name* *code*
: This command defines a procedure *name* which returns the control sequence *code*.


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *term* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Terminal control

# Copyright

```
Copyright (c) 2006 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
