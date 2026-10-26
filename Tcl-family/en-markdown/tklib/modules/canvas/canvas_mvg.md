---
CommandName: canvas::mvg
title: canvas::mvg
ManualSection: n
Version: 1.0.1
TclPart: tklib
TclDescription: Variations on a canvas
Keywords:
 - canvas
 - graphics
 - imagemagick
 - magick vector graphics
 - mvg
 - print screen
 - serialization
 - vector graphics
Copyright:
 - Copyright (c) 2010 Wolf-Dieter Busch (http://wiki.tcl-lang.org/15505)
 - Copyright (c) 2010 Documentation, Andreas Kupries
---

# Name

canvas::mvg - Canvas to ImageMagick MVG vector format

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit}
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.5]{.lit}
[package]{.cmd} [require]{.sub} [canvas::mvg]{.lit} [1]{.optlit}
[::canvas::mvg]{.cmd} [pathName]{.arg}
:::

# Description

This package provides a command to convert a canvas' contents to ImageMagick's MVG vector format.

# API

**::canvas::mvg** *pathName*
: Dump the contents of the canvas *pathName*. The result is a string in ImageMagick's MVG vector format.


# Bugs, ideas, feedback

This document, and the package it describes, will undoubtedly contain bugs and other problems. Please report such in the category *canvas* of the [Tklib Trackers](http://core.tcl-lang.org/tklib/reportlist). Please also report any ideas for enhancements you may have for either package and/or documentation.

# Copyright

```
Copyright (c) 2010 Wolf-Dieter Busch (http://wiki.tcl-lang.org/15505)
Copyright (c) 2010 Documentation, Andreas Kupries
```
