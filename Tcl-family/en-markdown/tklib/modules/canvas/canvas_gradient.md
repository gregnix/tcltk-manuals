---
CommandName: canvas::gradient
title: canvas::gradient
ManualSection: n
Version: 0.2
TclPart: tklib
TclDescription: Variations on a canvas
Keywords:
 - background
 - canvas
 - color gradient
 - gradients
 - image
 - widget background
Copyright:
 - Copyright (c) 2013 Jarek Lewandowski, MaxJarek
 - Copyright (c) Origin http://wiki.tcl-lang.org/6100
 - Copyright (c) Origin http://wiki.tcl-lang.org/37242
 - Copyright (c) Origin http://wiki.tcl-lang.org/9079
---

# Name

canvas::gradient - Canvas with a gradient background

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit}
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.5]{.lit}
[package]{.cmd} [require]{.sub} [canvas::gradient]{.lit} [0.2]{.optlit}
[::canvas::gradient]{.cmd} [pathName]{.arg} ?options?...
:::

# Description

This package provides a command to set background gradients on canvases.

*NOTE!* This package reserves the canvas tag **canvas::gradient** for its use.

# API

**::canvas::gradient** *pathName* ?options?...
: Creates a background gradient on the canvas *pathName*. An existing gradient is replaced by the new definition.

    The set of available options is decribed below, in section [Options].


## Options

**-direction** *direction*
: The value for this option specifies the *direction* of the gradient. If not specified the system defaults to **x**, a horizontal gradient. The package supports five directions:

    **x**
    : for a horizontal gradient (default). Color changes along the x-axis, with the start color at the left.

    **y**
    : for a vertical gradient. Color changes along the y-axis, with the start color at the top.

    **d1**
    : for a diagonal gradient from left+top to bottom+right. Color changes along the diagonal. with the start color at left+top.

    **d2**
    : for a diagonal gradient from left+bottom to top+right. Color changes along the diagonal. with the start color at left+bottom.

    **r**
    : for a radial gradient around the center of the viewport Color changes from the center outward, with the start color at the center.


**-color1** *color*
: The value for this option specifies the starting color of the gradient. If not specified it defaults to **red**.

**-color2** *color*
: The value for this option specifies the ending color of the gradient. If not specified it defaults to **green**.

**-type** *type*
: The value for this option specifies how the gradient is calculated. The package currently supports on ly one method, which is the default, naturally:

    **linear**
    : for linear interpolation between the start and end colors (default).



# Example

```
	package require canvas::gradient
	canvas .c
	canvas::gradient .c -direction x -color1 yellow -color2 blue
	pack .c -fill both -expand 1
```

# Bugs, ideas, feedback

This document, and the package it describes, will undoubtedly contain bugs and other problems. Please report such in the category *canvas* of the [Tklib Trackers](http://core.tcl-lang.org/tklib/reportlist). Please also report any ideas for enhancements you may have for either package and/or documentation.

# Copyright

```
Copyright (c) 2013 Jarek Lewandowski, MaxJarek
Copyright (c) Origin http://wiki.tcl-lang.org/6100
Copyright (c) Origin http://wiki.tcl-lang.org/37242
Copyright (c) Origin http://wiki.tcl-lang.org/9079
```
