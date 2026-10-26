---
CommandName: Tk_MoveToplevelWindow
title: Tk_MoveToplevelWindow
ManualSection: 3
Version: unknown
TclPart: Tk
TclDescription: Tk Library Procedures
Keywords:
 - position
 - top-level window
 - window manager
Copyright:
 - Copyright (c) 1990-1993 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

Tk\_MoveToplevelWindow - Adjust the position of a top-level window

# Synopsis

::: {.synopsis} :::
**#include <tk.h>**
Tk\_MoveToplevelWindow(tkwin, x, y)
:::

# Arguments

::: {.arguments} :::

[tkwin]{.carg .in type="Tk_Window"}
: Token for top-level window to move.

[x]{.carg .in type="int"}
: New x-coordinate for the top-left pixel of *tkwin*'s border, or the top-left pixel of the decorative border supplied for *tkwin* by the window manager, if there is one.

[y]{.carg .in type="int"}
: New y-coordinate for the top-left pixel of *tkwin*'s border, or the top-left pixel of the decorative border supplied for *tkwin* by the window manager, if there is one.

:::

# Description

In general, a window should never set its own position;  this should be done only by the geometry manger that is responsible for the window. For top-level windows the window manager is effectively the geometry manager;  Tk provides interface code between the application and the window manager to convey the application's desires to the geometry manager.  The desired size for a top-level window is conveyed using the usual [Tk\_GeometryRequest][GeomReq] mechanism.  The procedure **Tk\_MoveToplevelWindow** may be used by an application to request a particular position for a top-level window;  this procedure is similar in function to the [wm geometry][wm] Tcl command except that negative offsets cannot be specified.  It is invoked by widgets such as menus that want to appear at a particular place on the screen.

When **Tk\_MoveToplevelWindow** is called it does not immediately pass on the new desired location to the window manager;  it defers this action until all other outstanding work has been completed, using the [Tcl\_DoWhenIdle][DoWhenIdle] mechanism.


[DoWhenIdle]: ../tcl-c/DoWhenIdle.md
[GeomReq]: GeomReq.md
[wm]: ../tk/wm.md
