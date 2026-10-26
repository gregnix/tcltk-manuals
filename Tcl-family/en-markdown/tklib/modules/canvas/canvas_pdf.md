---
CommandName: canvas::pdf
ManualSection: n
Version: 1
TclPart: tklib
TclDescription: Variations on a canvas
Keywords:
 - canvas
 - graphics
 - imagemagick
 - pdf
 - portable document format
 - print screen
 - serialization
 - vector graphics
Copyright:
 - Copyright (c) 2014 Andreas Kupries, Arjen Markus
 - Copyright (c) 2014 Documentation, Andreas Kupries
---

# Name

canvas::pdf - Canvas to PDF

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} 
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.5]{.lit} 
[package]{.cmd} [require]{.sub} [canvas::pdf]{.lit} [1]{.optlit} 
[package]{.cmd} [require]{.sub} [pdf4tcl]{.lit} 
[::canvas::pdf]{.cmd} [pathName]{.arg} 
:::

# Description

This package provides a command to convert a canvas' contents to Adobe's PDF vector format.

# Api

**::canvas::pdf** *pathName*
: Dump the contents of the canvas *pathName*. The result is a string in Adobe's PDF.


# Bugs, ideas, feedback

This document, and the package it describes, will undoubtedly contain bugs and other problems. Please report such in the category *canvas* of the [Tklib Trackers](http://core.tcl-lang.org/tklib/reportlist). Please also report any ideas for enhancements you may have for either package and/or documentation.

# Copyright

```
Copyright (c) 2014 Andreas Kupries, Arjen Markus
Copyright (c) 2014 Documentation, Andreas Kupries
```
