---
CommandName: canvas::snap
ManualSection: n
Version: 1.0.1
TclPart: tklib
TclDescription: Variations on a canvas
Keywords:
 - canvas
 - image
 - photo
 - print screen
 - snapshot
Copyright:
 - Copyright (c) 2004 George Petasis (http://wiki.tcl-lang.org/1404)
 - Copyright (c) 2010 Documentation, Andreas Kupries
---

# Name

canvas::snap - Canvas snapshot to Tk photo image

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} 
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.5]{.lit} 
[package]{.cmd} [require]{.sub} [canvas::snap]{.lit} [1.0.1]{.optlit} 
[package]{.cmd} [require]{.sub} [img::window]{.lit} 
[::canvas::snap]{.cmd} [pathName]{.arg} 
:::

# Description

This package provides a command to take snapshots of arbitrary canvases.

# Api

**::canvas::snap** *pathName*
: Takes a snapshot of the canvas *pathName*. The result is the name of a new Tk photo image containing the snapshot. *Note* that this command has a side-effect. To avoid having white rectangles where other windows may overlap the canvas this command forces the toplevel window the canvas is in to the top of the stacking order.


# Bugs, ideas, feedback

This document, and the package it describes, will undoubtedly contain bugs and other problems. Please report such in the category *canvas* of the [Tklib Trackers](http://core.tcl-lang.org/tklib/reportlist). Please also report any ideas for enhancements you may have for either package and/or documentation.

# Copyright

```
Copyright (c) 2004 George Petasis (http://wiki.tcl-lang.org/1404)
Copyright (c) 2010 Documentation, Andreas Kupries
```
