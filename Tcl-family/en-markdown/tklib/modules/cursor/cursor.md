---
CommandName: cursor
ManualSection: n
Version: 0.3.1
TclPart: tklib
TclDescription: Tk cursor routines
Links:
 - Tk_GetCursor(3)
 - cursors(n)
 - options(n)
Keywords:
 - cursor
Copyright:
 - Copyright (c) Jeffrey Hobbs <jeff@hobbs.org>
---

# Name

cursor - Procedures to handle CURSOR data

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tk]{.lit} 
[package]{.cmd} [require]{.sub} [cursor]{.lit} [0.3.1]{.optlit} 
[::cursor::propagate]{.cmd} [widget]{.arg} [cursor]{.arg} 
[::cursor::restore]{.cmd} [widget]{.arg} [cursor]{.optarg} 
[::cursor::display]{.cmd} [parent]{.optarg} 
:::

# Description

The **cursor** package provides commands to handle Tk cursors.

# Commands

The following commands are available:

**::cursor::propagate** *widget* *cursor*
: Sets the cursor for the specified *widget* and all its descendants to *cursor*.

**::cursor::restore** *widget* ?*cursor*?
: Restore the original or previously set cursor for the specified *widget* and all its descendants.  If *cursor* is specified, that will be used if on any widget that did not have a preset cursor (set by a previous call to **::cursor::propagate**).

**::cursor::display** ?*parent*?
: Pops up a dialog with a listbox containing all the cursor names. Selecting a cursor name will display it in that dialog.  This is simply for viewing any available cursors on the platform.


# Bugs, ideas, feedback

This document, and the package it describes, will undoubtedly contain bugs and other problems. Please report such in the category *cursor* of the [Tklib Trackers](http://core.tcl-lang.org/tklib/reportlist). Please also report any ideas for enhancements you may have for either package and/or documentation.

# Copyright

```
Copyright (c) Jeffrey Hobbs <jeff@hobbs.org>
```
