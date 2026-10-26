---
CommandName: Tk_CanvasPs
title: Tk_CanvasPs
ManualSection: 3
Version: 4.0
TclPart: Tk
TclDescription: Tk Library Procedures
Keywords:
 - bitmap
 - canvas
 - color
 - font
 - path
 - Postscript
 - stipple
Copyright:
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

Tk\_CanvasPsY, Tk\_CanvasPsBitmap, Tk\_CanvasPsColor, Tk\_CanvasPsFont, Tk\_CanvasPsPath, Tk\_CanvasPsStipple - utility procedures for generating Postscript for canvases

# Synopsis

::: {.synopsis} :::
**#include <tk.h>**
[double]{.ret} [Tk\_CanvasPsY]{.ccmd} [canvas, canvasY]{.cargs}
[int]{.ret} [Tk\_CanvasPsBitmap]{.ccmd} [interp, canvas, bitmap, x, y, width, height]{.cargs}
[int]{.ret} [Tk\_CanvasPsColor]{.ccmd} [interp, canvas, colorPtr]{.cargs}
[int]{.ret} [Tk\_CanvasPsFont]{.ccmd} [interp, canvas, tkFont]{.cargs}
[Tk\_CanvasPsPath]{.ccmd} [interp, canvas, coordPtr, numPoints]{.cargs}
[int]{.ret} [Tk\_CanvasPsStipple]{.ccmd} [interp, canvas, bitmap]{.cargs}
:::

# Arguments

::: {.arguments} :::

[canvas]{.carg .in type="Tk_Canvas"}
: A token that identifies a canvas widget for which Postscript is being generated.

[canvasY]{.carg .in type="double"}
: Y-coordinate in the space of the canvas.

[\*interp]{.carg .in/out type="Tcl_Interp"}
: A Tcl interpreter;  Postscript is appended to its result, or the result may be replaced with an error message.

[bitmap]{.carg .in type="Pixmap"}
: Bitmap to use for generating Postscript.

[x]{.carg .in type="int"}
: X-coordinate within *bitmap* of left edge of region to output.

[y]{.carg .in type="int"}
: Y-coordinate within *bitmap* of top edge of region to output.

[width]{.carg .in type="int"}
: Width of region of bitmap to output, in pixels.

[height]{.carg .in type="int"}
: Height of region of bitmap to output, in pixels.

[\*colorPtr]{.carg .in type="XColor"}
: Information about color value to set in Postscript.

[tkFont]{.carg .in type="Tk_Font"}
: Font for which Postscript is to be generated.

[\*coordPtr]{.carg .in type="double"}
: Pointer to an array of coordinates for one or more points specified in canvas coordinates. The order of values in *coordPtr* is x1, y1, x2, y2, x3, y3, and so on.

[numPoints]{.carg .in type="int"}
: Number of points at *coordPtr*.

:::

# Description

These procedures are called by canvas type managers to carry out common functions related to generating Postscript. Most of the procedures take a *canvas* argument, which refers to a canvas widget for which Postscript is being generated.

**Tk\_CanvasPsY** takes as argument a y-coordinate in the space of a canvas and returns the value that should be used for that point in the Postscript currently being generated for *canvas*. Y coordinates require transformation because Postscript uses an origin at the lower-left corner whereas X uses an origin at the upper-left corner. Canvas x coordinates can be used directly in Postscript without transformation.

**Tk\_CanvasPsBitmap** generates Postscript to describe a region of a bitmap. The Postscript is generated in proper image data format for Postscript, i.e., as data between angle brackets, one bit per pixel. The Postscript is appended to the result of interpreter *interp* and [TCL\_OK][catch] is returned unless an error occurs, in which case [TCL\_ERROR][catch] is returned and the interpreter result is overwritten with an error message.

**Tk\_CanvasPsColor** generates Postscript to set the current color to correspond to its *colorPtr* argument, taking into account any color map specified in the **postscript** command. It appends the Postscript to the interpreter *interp*'s result and returns [TCL\_OK][catch] unless an error occurs, in which case [TCL\_ERROR][catch] is returned and the interpreter's result is overwritten with an error message.

**Tk\_CanvasPsFont** generates Postscript that sets the current font to match *tkFont* as closely as possible. **Tk\_CanvasPsFont** takes into account any font map specified in the **postscript** command, and it does the best it can at mapping X fonts to Postscript fonts. It appends the Postscript to interpreter *interp*'s result and returns [TCL\_OK][catch] unless an error occurs, in which case [TCL\_ERROR][catch] is returned and the interpreter's result is overwritten with an error message.

**Tk\_CanvasPsPath** generates Postscript to set the current path to the set of points given by *coordPtr* and *numPoints*. It appends the resulting Postscript to the result of interpreter *interp*.

**Tk\_CanvasPsStipple** generates Postscript that will fill the current path in stippled fashion. It uses *bitmap* as the stipple pattern and the current Postscript color;  ones in the stipple bitmap are drawn in the current color, and zeroes are not drawn at all. The Postscript is appended to interpreter *interp*'s result and [TCL\_OK][catch] is returned, unless an error occurs, in which case [TCL\_ERROR][catch] is returned and the interpreter's result is overwritten with an error message.


[catch]: ../tcl/catch.md
