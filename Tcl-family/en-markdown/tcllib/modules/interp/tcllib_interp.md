---
CommandName: interp
ManualSection: n
Version: 0.1.3
TclPart: tcllib
TclDescription: Interpreter utilities
Keywords:
 - alias
 - empty interpreter
 - interpreter
 - method
 - snit
Copyright:
 - Copyright (c) 2006 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

interp - Interp creation and aliasing

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [interp]{.lit} [0.1.3]{.optlit} 
[::interp::createEmpty]{.cmd} [path]{.optarg} 
[::interp::snitLink]{.cmd} [path]{.arg} [methodlist]{.arg} 
[::interp::snitDictLink]{.cmd} [path]{.arg} [methoddict]{.arg} 
:::

# Description

This package provides a number of commands for the convenient creation of Tcl interpreters for highly restricted execution.

# Api

**::interp::createEmpty** ?*path*?
: This commands creates an empty Tcl interpreter and returns it name. Empty means that the new interpreter has neither namespaces, nor any commands. It is useful only for the creation of aliases. If a *path* is specified then it is taken as the name of the new interpreter.

**::interp::snitLink** *path* *methodlist*
: This command assumes that it was called from within a method of a snit object, and that the command **mymethod** is available. It extends the interpreter specified by *path* with aliases for all methods found in the *methodlist*, with the alias directing execution to the same-named method of the snit object invoking this command. Each element of *methodlist* is actually interpreted as a command prefix, with the first word of each prefix the name of the method to link to. The result of the command is the empty string.

**::interp::snitDictLink** *path* *methoddict*
: This command behaves like **::interp::snitLink**, except that it takes a dictionary mapping from commands to methods as its input, and not a list of methods. Like for **::interp::snitLink** the method references are actually command prefixes. This command allows the creation of more complex command-method mappings than **::interp::snitLink**. The result of the command is the empty string.


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *interp* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Programming tools

# Copyright

```
Copyright (c) 2006 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
