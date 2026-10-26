---
CommandName: Tk_GetVisual
title: Tk_GetVisual
ManualSection: 3
Version: 4.0
TclPart: Tk
TclDescription: Tk Library Procedures
Keywords:
 - colormap
 - screen
 - visual
Copyright:
 - Copyright (c) 1994 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

Tk\_GetVisual - translate from string to visual

# Synopsis

::: {.synopsis} :::
**#include <tk.h>**
Visual \* Tk\_GetVisual(interp, tkwin, string, depthPtr, colormapPtr)
:::

# Arguments

::: {.arguments} :::

[\*interp]{.carg .in type="Tcl_Interp"}
: Interpreter to use for error reporting.

[tkwin]{.carg .in type="Tk_Window"}
: Token for window in which the visual will be used.

[\*string]{.carg .in type="const char"}
: String that identifies the desired visual.  See below for valid formats.

[\*depthPtr]{.carg .out type="int"}
: Depth of returned visual gets stored here.

[\*colormapPtr]{.carg .out type="Colormap"}
: If non-NULL then a suitable colormap for visual is found and its identifier is stored here.

:::

# Description

**Tk\_GetVisual** takes a string description of a visual and finds a suitable X Visual for use in *tkwin*, if there is one. It returns a pointer to the X Visual structure for the visual and stores the number of bits per pixel for it at *\*depthPtr*. If *string* is unrecognizable or if no suitable visual could be found, then NULL is returned and **Tk\_GetVisual** leaves an error message in interpreter *interp*'s result. If *colormap* is non-NULL then **Tk\_GetVisual** also locates an appropriate colormap for use with the result visual and stores its X identifier at *\*colormapPtr*.

The *string* argument specifies the desired visual in one of the following ways:

*class depth*
: The string consists of a class name followed by an integer depth, with any amount of white space (including none) in between. *class* selects what sort of visual is desired and must be one of **directcolor**, **grayscale**, **greyscale**, **pseudocolor**, **staticcolor**, **staticgray**, **staticgrey**, or **truecolor**, or a unique abbreviation. *depth* specifies how many bits per pixel are needed for the visual. If possible, **Tk\_GetVisual** will return a visual with this depth; if there is no visual of the desired depth then **Tk\_GetVisual** looks first for a visual with greater depth, then one with less depth.

**default**
: Use the default visual for *tkwin*'s screen.

*pathName*
: Use the visual for the window given by *pathName*. *pathName* must be the name of a window on the same screen as *tkwin*.

*number*
: Use the visual whose X identifier is *number*.

**best** ?*depth*?
: Choose the "best possible" visual, using the following rules, in decreasing order of priority:

    (a)
    : a visual that has exactly the desired depth is best, followed by a visual with greater depth than requested (but as little extra as possible), followed by a visual with less depth than requested (but as great a depth as possible);

    (b)
    : if no *depth* is specified, then the deepest available visual is chosen;

    (c)
    : **pseudocolor** is better than **truecolor** or **directcolor**, which are better than **staticcolor**, which is better than **staticgray** or **grayscale**;

    (d)
    : the default visual for the screen is better than any other visual.



# Credits

The idea for **Tk\_GetVisual**, and the first implementation, came from Paul Mackerras.
