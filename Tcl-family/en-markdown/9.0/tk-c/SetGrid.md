---
CommandName: Tk_SetGrid
title: Tk_SetGrid
ManualSection: 3
Version: 4.0
TclPart: Tk
TclDescription: Tk Library Procedures
Keywords:
 - grid
 - window
 - window manager
Copyright:
 - Copyright (c) 1990-1994 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

Tk\_SetGrid, Tk\_UnsetGrid - control the grid for interactive resizing

# Synopsis

::: {.synopsis} :::
**#include <tk.h>**
[Tk\_SetGrid]{.ccmd} [tkwin, reqWidth, reqHeight, widthInc, heightInc]{.cargs}
[Tk\_UnsetGrid]{.ccmd} [tkwin]{.cargs}
:::

# Arguments

::: {.arguments} :::

[tkwin]{.carg .in type="Tk_Window"}
: Token for window.

[reqWidth]{.carg .in type="int"}
: Width in grid units that corresponds to the pixel dimension *tkwin* has requested via [Tk\_GeometryRequest][GeomReq].

[reqHeight]{.carg .in type="int"}
: Height in grid units that corresponds to the pixel dimension *tkwin* has requested via [Tk\_GeometryRequest][GeomReq].

[widthInc]{.carg .in type="int"}
: Width of one grid unit, in pixels.

[heightInc]{.carg .in type="int"}
: Height of one grid unit, in pixels.

:::

# Description

**Tk\_SetGrid** turns on gridded geometry management for *tkwin*'s toplevel window and specifies the geometry of the grid. **Tk\_SetGrid** is typically invoked by a widget when its **setGrid** option is true. It restricts interactive resizing of *tkwin*'s toplevel window so that the space allocated to the toplevel is equal to its requested size plus or minus even multiples of *widthInc* and *heightInc*. Furthermore, the *reqWidth* and *reqHeight* values are passed to the window manager so that it can report the window's size in grid units during interactive resizes. If *tkwin*'s configuration changes (e.g., the size of a grid unit changes) then the widget should invoke **Tk\_SetGrid** again with the new information.

**Tk\_UnsetGrid** cancels gridded geometry management for *tkwin*'s toplevel window.

For each toplevel window there can be at most one internal window with gridding enabled. If **Tk\_SetGrid** or **Tk\_UnsetGrid** is invoked when some other window is already controlling gridding for *tkwin*'s toplevel, the calls for the new window have no effect.

See the [wm] manual entry for additional information on gridded geometry management.


[GeomReq]: GeomReq.md
[wm]: ../tk/wm.md
