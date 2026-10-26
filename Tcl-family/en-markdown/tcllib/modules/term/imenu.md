---
CommandName: term::interact::menu
title: term::interact::menu
ManualSection: n
Version: 0.2
TclPart: tcllib
TclDescription: Terminal control
Keywords:
 - control
 - menu
 - terminal
 - text display
Copyright:
 - Copyright (c) 2006 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

term::interact::menu - Terminal widget, menu

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [term::interact::menu]{.lit} [0.2]{.optlit}
[term::interact::menu]{.cmd} [object]{.arg} [dict]{.arg} [options...]{.optarg}
[object]{.ins} [interact]{.sub}
[object]{.ins} [done]{.sub}
[object]{.ins} [clear]{.sub}
[object]{.ins} [configure]{.sub}
[object]{.ins} [configure]{.sub} [option]{.arg}
[object]{.ins} [configure]{.sub} [option]{.arg} [value...]{.arg}
[object]{.ins} [cget]{.sub} [option]{.arg}
:::

# Description

This package provides a class for the creation of a simple menu control.

# Class API

The package exports a single command, the class command, enabling the creation of menu instances. Its API is:

**term::interact::menu** *object* *dict* ?*options*...?
: This command creates a new menu object with the name *object*, initializes it, and returns the fully qualified name of the object command as its result.

    The argument is the menu to show, possibly followed by configuration options and their values. The options are explained in the section [Configuration]. The menu is a dictionary maping labels to symbolic action codes.


# Object API

The objects created by the class command provide the methods listed below:

*object* **interact**
: Shows the menu in the screen at the configured location and starts interacting with it. This opens its own event loop for the processing of incoming characters. The method returns when the interaction has completed. See section [Interaction] for a description of the possible interaction.

    The method returns the symbolic action of the menu item selected by the user at the end of the interaction.

*object* **done**
: This method can be used by user supplied actions to terminate the interaction with the object.

*object* **clear**
: This method can be used by user supplied actions to remove the menu from the terminal.

*object* **configure**
: see below ...

*object* **configure** *option*
: see below ...

*object* **configure** *option* *value*...
: see below ...

*object* **cget** *option*
: Standard methods to retrieve and configure the options of the menu.


# Configuration

A menu instance recognizes the following options:

**-in** chan
: Specifies the channel to read character sequences from. Defaults to **stdin**.

**-out** chan
: Specifies the channel to write the menu contents to. Defaults to **stdout**.

**-column** int
: Specifies the column of the terminal where the left margin of the menu display should appear. Defaults to 0, i.e. the left-most column.

**-line** int
: Specifies the line of the terminal where the top margin of the menu display should appear. Defaults to 0, i.e. the top-most line.

**-height** int
: Specifies the number of lines of text to show at most in the display. Defaults to 25.

**-actions** dict
: Specifies a dictionary containing additional actions, using character sequences as keys. Note that these sequences cannot override the hardwired sequences described in section [Interaction].

**-hilitleft** int
: see below ...

**-hilitright** int
: By default the entire selected menu entry is highlighted in revers output. However, when present these two options restrict revers dispay to the specified sub-range of the entry.

**-framed** bool
: By default the menu is shown using only header and footer out of characters box graphics. If this flag is set the menu is fully enclosed in a box.


# Interaction

A menu object recognizes the control sequences listed below and acts as described. The user can supply more control sequences to act on via the configuration, but is not able to overide these defaults.

Cursor Up
: The selection is moved up one entry, except if the first entry of the menu is already selected.

Cursor Down
: The selection is moved down one entry, except if the last entry of the menu is already selected.

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
