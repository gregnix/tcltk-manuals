---
CommandName: term::interact::pager
title: term::interact::pager
ManualSection: n
Version: 0.2
TclPart: tcllib
TclDescription: Terminal control
Keywords:
 - control
 - pager
 - terminal
 - text display
Copyright:
 - Copyright (c) 2006 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

term::interact::pager - Terminal widget, paging

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [term::interact::pager]{.lit} [0.2]{.optlit}
[term::interact::pager]{.cmd} [object]{.arg} [text]{.arg} [options...]{.optarg}
[object]{.ins} [interact]{.sub}
[object]{.ins} [done]{.sub}
[object]{.ins} [clear]{.sub}
[object]{.ins} [text]{.sub} [text]{.arg}
[object]{.ins} [configure]{.sub}
[object]{.ins} [configure]{.sub} [option]{.arg}
[object]{.ins} [configure]{.sub} [option]{.arg} [value...]{.arg}
[object]{.ins} [cget]{.sub} [option]{.arg}
:::

# Description

This package provides a class for the creation of a simple paging text display.

# Class API

The package exports a single command, the class command, enabling the creation of pager instances. Its API is:

**term::interact::pager** *object* *text* ?*options*...?
: This command creates a new pager object with the name *object*, initializes it, and returns the fully qualified name of the object command as its result.

    The argument is the text to show, possibly followed by configuration options and their values. The options are explained in the section [Configuration].


# Object API

The objects created by the class command provide the methods listed below:

*object* **interact**
: Show the pager in the screen at the configured location and start interacting with it. This opens its own event loop for the processing of incoming characters. The method returns when the interaction has completed. See section [Interaction] for a description of the possible interaction.

*object* **done**
: This method can be used by user supplied actions to terminate the interaction with the object.

*object* **clear**
: This method can be used by user supplied actions to remove the pager from the terminal.

*object* **text** *text*
: This method can be used to change the text shown by the pager. The pager will reset the dispay to show the first line of the text at the top.

*object* **configure**
: see below ...

*object* **configure** *option*
: see below ...

*object* **configure** *option* *value*...
: see below ...

*object* **cget** *option*
: Standard methods to retrieve and configure the options of the pager.


# Configuration

A pager instance recognizes the following options:

**-in** chan
: Specifies the channel to read character sequences from. Defaults to **stdin**.

**-out** chan
: Specifies the channel to write the pager contents to. Defaults to **stdout**.

**-column** int
: Specifies the column of the terminal where the left margin of the pager display should appear. Defaults to 0, i.e. the left-most column.

**-line** int
: Specifies the line of the terminal where the top margin of the pager display should appear. Defaults to 0, i.e. the top-most line.

**-height** int
: Specifies the number of lines of text to show at most in the display. Defaults to 25.

**-actions** dict
: Specifies a dictionary containing additional actions, using character sequences as keys. Note that these sequences cannot override the hardwired sequences described in section [Interaction].


# Interaction

A pager object recognizes the control sequences listed below and acts as described. The user can supply more control sequences to act on via the configuration, but is not able to overide these defaults.

Cursor Up
: The text is scrolled down a single line, making one more line visible at the top. The pager will not react if the first line of the text is already shown.

Cursor Down
: The text is scrolled up a single line, making one more line visible at the bottom. The pager will not react if the last line of the text is already shown.

Page Up
: The text is scrolled down a page. The pager will not react if the first line of the text is already shown.

Page Down
: The text is scrolled up a page. The pager will not react if the last line of the text is already shown.

Enter/Return
: The interaction with the object is terminated.


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
