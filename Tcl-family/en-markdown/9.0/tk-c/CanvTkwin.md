---
CommandName: Tk_CanvasTkwin
title: Tk_CanvasTkwin
ManualSection: 3
Version: 4.1
TclPart: Tk
TclDescription: Tk Library Procedures
Keywords:
 - canvas
 - focus
 - item type
 - redisplay
 - selection
 - type manager
Copyright:
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

Tk\_CanvasTkwin, Tk\_CanvasGetCoord, Tk\_CanvasDrawableCoords, Tk\_CanvasSetStippleOrigin, Tk\_CanvasWindowCoords, Tk\_CanvasEventuallyRedraw, Tk\_CanvasTagsOption - utility procedures for canvas type managers

# Synopsis

::: {.synopsis} :::
**#include <tk.h>**
[Tk\_Window]{.ret} [Tk\_CanvasTkwin]{.ccmd} [canvas]{.cargs}
[int]{.ret} [Tk\_CanvasGetCoord]{.ccmd} [interp, canvas, string, doublePtr]{.cargs}
[Tk\_CanvasDrawableCoords]{.ccmd} [canvas, x, y, drawableXPtr, drawableYPtr]{.cargs}
[Tk\_CanvasSetStippleOrigin]{.ccmd} [canvas, gc]{.cargs}
[Tk\_CanvasWindowCoords]{.ccmd} [canvas, x, y, screenXPtr, screenYPtr]{.cargs}
[Tk\_CanvasEventuallyRedraw]{.ccmd} [canvas, x1, y1, x2, y2]{.cargs}
:::

Tk\_OptionParseProc \***Tk\_CanvasTagsParseProc**;

Tk\_OptionPrintProc \***Tk\_CanvasTagsPrintProc**;

# Arguments

::: {.arguments} :::

[canvas]{.carg .in type="Tk_Canvas"}
: A token that identifies a canvas widget.

[\*interp]{.carg .in/out type="Tcl_Interp"}
: Interpreter to use for error reporting.

[\*string]{.carg .in type="const char"}
: Textual description of a canvas coordinate.

[\*doublePtr]{.carg .out type="double"}
: Points to place to store a converted coordinate.

[x]{.carg .in type="double"}
: An x coordinate in the space of the canvas.

[y]{.carg .in type="double"}
: A y coordinate in the space of the canvas.

[\*drawableXPtr]{.carg .out type="short"}
: Pointer to a location in which to store an x coordinate in the space of the drawable currently being used to redisplay the canvas.

[\*drawableYPtr]{.carg .out type="short"}
: Pointer to a location in which to store a y coordinate in the space of the drawable currently being used to redisplay the canvas.

[gc]{.carg .out type="GC"}
: Graphics context to modify.

[\*screenXPtr]{.carg .out type="short"}
: Points to a location in which to store the screen coordinate in the canvas window that corresponds to *x*.

[\*screenYPtr]{.carg .out type="short"}
: Points to a location in which to store the screen coordinate in the canvas window that corresponds to *y*.

[x1]{.carg .in type="int"}
: Left edge of the region that needs redisplay.  Only pixels at or to the right of this coordinate need to be redisplayed.

[y1]{.carg .in type="int"}
: Top edge of the region that needs redisplay.  Only pixels at or below this coordinate need to be redisplayed.

[x2]{.carg .in type="int"}
: Right edge of the region that needs redisplay.  Only pixels to the left of this coordinate need to be redisplayed.

[y2]{.carg .in type="int"}
: Bottom edge of the region that needs redisplay.  Only pixels above this coordinate need to be redisplayed.

:::

# Description

These procedures are called by canvas type managers to perform various utility functions.

**Tk\_CanvasTkwin** returns the Tk\_Window associated with a particular canvas.

**Tk\_CanvasGetCoord** translates a string specification of a coordinate (such as **2p** or **1.6c**) into a double-precision canvas coordinate. If *string* is a valid coordinate description then **Tk\_CanvasGetCoord** stores the corresponding canvas coordinate at \**doublePtr* and returns **[TCL\_OK][catch]**. Otherwise it stores an error message in the interpreter result and returns **[TCL\_ERROR][catch]**.

**Tk\_CanvasDrawableCoords** is called by type managers during redisplay to compute where to draw things. Given *x* and *y* coordinates in the space of the canvas, **Tk\_CanvasDrawableCoords** computes the corresponding pixel in the drawable that is currently being used for redisplay; it returns those coordinates in \**drawableXPtr* and \**drawableYPtr*. This procedure should not be invoked except during redisplay.

**Tk\_CanvasSetStippleOrigin** is also used during redisplay. It sets the stipple origin in *gc* so that stipples drawn with *gc* in the current offscreen pixmap will line up with stipples drawn with origin (0,0) in the canvas's actual window. **Tk\_CanvasSetStippleOrigin** is needed in order to guarantee that stipple patterns line up properly when the canvas is redisplayed in small pieces. Redisplays are carried out in double-buffered fashion where a piece of the canvas is redrawn in an offscreen pixmap and then copied back onto the screen. In this approach the stipple origins in graphics contexts need to be adjusted during each redisplay to compensate for the position of the off-screen pixmap relative to the window. If an item is being drawn with stipples, its type manager typically calls **Tk\_CanvasSetStippleOrigin** just before using *gc* to draw something;  after it is finished drawing, the type manager calls **XSetTSOrigin** to restore the origin in *gc* back to (0,0) (the restore is needed because graphics contexts are shared, so they cannot be modified permanently).

**Tk\_CanvasWindowCoords** is similar to **Tk\_CanvasDrawableCoords** except that it returns coordinates in the canvas's window on the screen, instead of coordinates in an off-screen pixmap.

**Tk\_CanvasEventuallyRedraw** may be invoked by a type manager to inform Tk that a portion of a canvas needs to be redrawn. The *x1*, *y1*, *x2*, and *y2* arguments specify the region that needs to be redrawn, in canvas coordinates. Type managers rarely need to invoke **Tk\_CanvasEventuallyRedraw**, since Tk can normally figure out when an item has changed and make the redisplay request on its behalf (this happens, for example whenever Tk calls a *configureProc* or *scaleProc*). The only time that a type manager needs to call **Tk\_CanvasEventuallyRedraw** is if an item has changed on its own without being invoked through one of the procedures in its Tk\_ItemType; this could happen, for example, in an image item if the image is modified using image commands.

**Tk\_CanvasTagsParseProc** and **Tk\_CanvasTagsPrintProc** are procedures that handle the **-tags** option for canvas items. The code of a canvas type manager will not call these procedures directly, but will use their addresses to create a **Tk\_CustomOption** structure for the **-tags** option.   The code typically looks like this:

```
static const Tk_CustomOption tagsOption = {Tk_CanvasTagsParseProc,
    Tk_CanvasTagsPrintProc, NULL
};

static const Tk_ConfigSpec configSpecs[] = {
    ...
    {TK_CONFIG_CUSTOM, "-tags", NULL, NULL,
        NULL, 0, TK_CONFIG_NULL_OK, &tagsOption},
    ...
};
```


[catch]: ../tcl/catch.md
