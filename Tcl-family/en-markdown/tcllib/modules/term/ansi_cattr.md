---
CommandName: term::ansi::code::attr
ManualSection: n
Version: 0.2
TclPart: tcllib
TclDescription: Terminal control
Keywords:
 - ansi
 - attribute control
 - color control
 - control
 - terminal
Copyright:
 - Copyright (c) 2006 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

term::ansi::code::attr - ANSI attribute sequences

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [term::ansi::code]{.lit} [0.2]{.optlit} 
[package]{.cmd} [require]{.sub} [term::ansi::code::attr]{.lit} [0.2]{.optlit} 
[::term::ansi::code::attr::names]{.cmd} 
[::term::ansi::code::attr::import]{.cmd} [ns]{.optarg} [arg]{.optdot} 
[::term::ansi::code::attr::fgblack]{.cmd} 
[::term::ansi::code::attr::fgred]{.cmd} 
[::term::ansi::code::attr::fggreen]{.cmd} 
[::term::ansi::code::attr::fgyellow]{.cmd} 
[::term::ansi::code::attr::fgblue]{.cmd} 
[::term::ansi::code::attr::fgmagenta]{.cmd} 
[::term::ansi::code::attr::fgcyan]{.cmd} 
[::term::ansi::code::attr::fgwhite]{.cmd} 
[::term::ansi::code::attr::fgdefault]{.cmd} 
[::term::ansi::code::attr::bgblack]{.cmd} 
[::term::ansi::code::attr::bgred]{.cmd} 
[::term::ansi::code::attr::bggreen]{.cmd} 
[::term::ansi::code::attr::bgyellow]{.cmd} 
[::term::ansi::code::attr::bgblue]{.cmd} 
[::term::ansi::code::attr::bgmagenta]{.cmd} 
[::term::ansi::code::attr::bgcyan]{.cmd} 
[::term::ansi::code::attr::bgwhite]{.cmd} 
[::term::ansi::code::attr::bgdefault]{.cmd} 
[::term::ansi::code::attr::bold]{.cmd} 
[::term::ansi::code::attr::dim]{.cmd} 
[::term::ansi::code::attr::italic]{.cmd} 
[::term::ansi::code::attr::underline]{.cmd} 
[::term::ansi::code::attr::blink]{.cmd} 
[::term::ansi::code::attr::revers]{.cmd} 
[::term::ansi::code::attr::hidden]{.cmd} 
[::term::ansi::code::attr::strike]{.cmd} 
[::term::ansi::code::attr::nobold]{.cmd} 
[::term::ansi::code::attr::noitalic]{.cmd} 
[::term::ansi::code::attr::nounderline]{.cmd} 
[::term::ansi::code::attr::noblink]{.cmd} 
[::term::ansi::code::attr::norevers]{.cmd} 
[::term::ansi::code::attr::nohidden]{.cmd} 
[::term::ansi::code::attr::nostrike]{.cmd} 
[::term::ansi::code::attr::reset]{.cmd} 
:::

# Description

This package provides symbolic names for the ANSI attribute control codes. For each control code a single command is provided which returns this code as its result. None of the commands of this package write to a channel; that is handled by higher level packages, like **term::ansi::send**.

# Api

## Introspection

**::term::ansi::code::attr::names**
: This command is for introspection. It returns as its result a list containing the names of all attribute commands.

**::term::ansi::code::attr::import** ?*ns*? ?*arg*...?
: This command imports some or all attribute commands into the namespace *ns*. This is by default the namespace *attr*. Note that this is relative namespace name, placing the imported command into a child of the current namespace. By default all commands are imported, this can howver be restricted by listing the names of the wanted commands after the namespace argument.


## Attributes

**::term::ansi::code::attr::fgblack**
: Set text color to *Black*.

**::term::ansi::code::attr::fgred**
: Set text color to *Red*.

**::term::ansi::code::attr::fggreen**
: Set text color to *Green*.

**::term::ansi::code::attr::fgyellow**
: Set text color to *Yellow*.

**::term::ansi::code::attr::fgblue**
: Set text color to *Blue*.

**::term::ansi::code::attr::fgmagenta**
: Set text color to *Magenta*.

**::term::ansi::code::attr::fgcyan**
: Set text color to *Cyan*.

**::term::ansi::code::attr::fgwhite**
: Set text color to *White*.

**::term::ansi::code::attr::fgdefault**
: Set default text color (*Black*).

**::term::ansi::code::attr::bgblack**
: Set background to *Black*.

**::term::ansi::code::attr::bgred**
: Set background to *Red*.

**::term::ansi::code::attr::bggreen**
: Set background to *Green*.

**::term::ansi::code::attr::bgyellow**
: Set background to *Yellow*.

**::term::ansi::code::attr::bgblue**
: Set background to *Blue*.

**::term::ansi::code::attr::bgmagenta**
: Set background to *Magenta*.

**::term::ansi::code::attr::bgcyan**
: Set background to *Cyan*.

**::term::ansi::code::attr::bgwhite**
: Set background to *White*.

**::term::ansi::code::attr::bgdefault**
: Set default background (Transparent).

**::term::ansi::code::attr::bold**
: Bold on.

**::term::ansi::code::attr::dim**
: Dim on.

**::term::ansi::code::attr::italic**
: Italics on.

**::term::ansi::code::attr::underline**
: Underscore on.

**::term::ansi::code::attr::blink**
: Blink on.

**::term::ansi::code::attr::revers**
: Reverse on.

**::term::ansi::code::attr::hidden**
: Hidden on.

**::term::ansi::code::attr::strike**
: Strike-through on.

**::term::ansi::code::attr::nobold**
: Bold off.

**::term::ansi::code::attr::noitalic**
: Italics off.

**::term::ansi::code::attr::nounderline**
: Underscore off.

**::term::ansi::code::attr::noblink**
: Blink off.

**::term::ansi::code::attr::norevers**
: Reverse off.

**::term::ansi::code::attr::nohidden**
: Hidden off.

**::term::ansi::code::attr::nostrike**
: Strike-through off.

**::term::ansi::code::attr::reset**
: Reset all attributes to their default values.


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
