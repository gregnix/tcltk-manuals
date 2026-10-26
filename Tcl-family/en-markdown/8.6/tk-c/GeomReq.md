---
CommandName: Tk_GeometryRequest
title: Tk_GeometryRequest
ManualSection: 3
Version: 8.4
TclPart: Tk
TclDescription: Tk Library Procedures
Keywords:
 - geometry
 - request
Copyright:
 - Copyright (c) 1990-1994 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

Tk\_GeometryRequest, Tk\_SetMinimumRequestSize, Tk\_SetInternalBorder, Tk\_SetInternalBorderEx - specify desired geometry or internal border for a window

# Synopsis

::: {.synopsis} :::
**#include <tk.h>**
[Tk\_GeometryRequest]{.ccmd} [tkwin, reqWidth, reqHeight]{.cargs}
[Tk\_SetMinimumRequestSize]{.ccmd} [tkwin, minWidth, minHeight]{.cargs}
[Tk\_SetInternalBorder]{.ccmd} [tkwin, width]{.cargs}
[Tk\_SetInternalBorderEx]{.ccmd} [tkwin, left, right, top, bottom]{.cargs}
:::

# Arguments

::: {.arguments} :::

[tkwin]{.carg .in type="Tk_Window"}
: Window for which geometry is being requested.

[reqWidth]{.carg .in type="int"}
: Desired width for *tkwin*, in pixel units.

[reqHeight]{.carg .in type="int"}
: Desired height for *tkwin*, in pixel units.

[minWidth]{.carg .in type="int"}
: Desired minimum requested width for *tkwin*, in pixel units.

[minHeight]{.carg .in type="int"}
: Desired minimum requested height for *tkwin*, in pixel units.

[width]{.carg .in type="int"}
: Space to leave for internal border for *tkwin*, in pixel units.

[left]{.carg .in type="int"}
: Space to leave for left side of internal border for *tkwin*, in pixel units.

[right]{.carg .in type="int"}
: Space to leave for right side of internal border for *tkwin*, in pixel units.

[top]{.carg .in type="int"}
: Space to leave for top side of internal border for *tkwin*, in pixel units.

[bottom]{.carg .in type="int"}
: Space to leave for bottom side of internal border for *tkwin*, in pixel units.

:::

# Description

**Tk\_GeometryRequest** is called by widget code to indicate its preference for the dimensions of a particular window.  The arguments to **Tk\_GeometryRequest** are made available to the geometry manager for the window, which then decides on the actual geometry for the window.  Although geometry managers generally try to satisfy requests made to **Tk\_GeometryRequest**, there is no guarantee that this will always be possible.  Widget code should not assume that a geometry request will be satisfied until it receives a **ConfigureNotify** event indicating that the geometry change has occurred.  Widget code should never call procedures like [Tk\_ResizeWindow][ConfigWind] directly.  Instead, it should invoke **Tk\_GeometryRequest** and leave the final geometry decisions to the geometry manager.

If *tkwin* is a top-level window, then the geometry information will be passed to the window manager using the standard ICCCM protocol.

**Tk\_SetInternalBorder** is called by widget code to indicate that the widget has an internal border.  This means that the widget draws a decorative border inside the window instead of using the standard X borders, which are external to the window's area.  For example, internal borders are used to draw 3-D effects.  *Width* specifies the width of the border in pixels.  Geometry managers will use this information to avoid placing any children of *tkwin* overlapping the outermost *width* pixels of *tkwin*'s area.

**Tk\_SetInternalBorderEx** works like **Tk\_SetInternalBorder** but lets you specify different widths for different sides of the window.

**Tk\_SetMinimumRequestSize** is called by widget code to indicate that a geometry manager should request at least this size for the widget.  This allows a widget to have some control over its size when a propagating geometry manager is used inside it.

The information specified in calls to **Tk\_GeometryRequest**, **Tk\_SetMinimumRequestSize**, **Tk\_SetInternalBorder** and **Tk\_SetInternalBorderEx** can be retrieved using the macros [Tk\_ReqWidth][WindowId], [Tk\_ReqHeight][WindowId], [Tk\_MinReqWidth][WindowId], [Tk\_MinReqHeight][WindowId], [Tk\_MinReqWidth][WindowId], [Tk\_InternalBorderLeft][WindowId], [Tk\_InternalBorderRight][WindowId], [Tk\_InternalBorderTop][WindowId] and [Tk\_InternalBorderBottom][WindowId]. See the [Tk\_WindowId][WindowId] manual entry for details.


[ConfigWind]: ConfigWind.md
[WindowId]: WindowId.md
