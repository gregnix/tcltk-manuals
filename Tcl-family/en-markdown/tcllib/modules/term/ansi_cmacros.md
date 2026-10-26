---
CommandName: term::ansi::code::macros
ManualSection: n
Version: 0.2
TclPart: tcllib
TclDescription: Terminal control
Keywords:
 - ansi
 - control
 - frame
 - menu
 - terminal
Copyright:
 - Copyright (c) 2006 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

term::ansi::code::macros - Macro sequences

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [textutil::repeat]{.lit} 
[package]{.cmd} [require]{.sub} [textutil::tabify]{.lit} 
[package]{.cmd} [require]{.sub} [term::ansi::code::macros]{.lit} [0.2]{.optlit} 
[::term::ansi::code::macros::names]{.cmd} 
[::term::ansi::code::macros::import]{.cmd} [ns]{.optarg} [arg]{.optdot} 
[::term::ansi::code::macros::menu]{.cmd} [menu]{.arg} 
[::term::ansi::code::macros::frame]{.cmd} [string]{.arg} 
:::

# Description

This package provides higher level control sequences for more complex shapes.

# Api

## Introspection

**::term::ansi::code::macros::names**
: This command is for introspection. It returns as its result a list containing the names of all attribute commands.

**::term::ansi::code::macros::import** ?*ns*? ?*arg*...?
: This command imports some or all attribute commands into the namespace *ns*. This is by default the namespace *macros*. Note that this is relative namespace name, placing the imported command into a child of the current namespace. By default all commands are imported, this can howver be restricted by listing the names of the wanted commands after the namespace argument.


## Sequences

**::term::ansi::code::macros::menu** *menu*
: The description of a menu is converted into a formatted rectangular block of text, with the menu command characters highlighted using bold red text.  The result is returned as the result of the command. The description, *menu*, is a dictionary mapping from menu label to command character.

**::term::ansi::code::macros::frame** *string*
: The paragraph of text contained in the string is padded with spaces at the right margin, after normalizing internal tabs, and then put into a frame made of box-graphics. The result is returned as the result of the command.


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
