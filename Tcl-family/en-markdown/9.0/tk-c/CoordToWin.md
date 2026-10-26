---
CommandName: Tk_CoordsToWindow
ManualSection: 3
Version: unknown
TclPart: Tk
TclDescription: Tk Library Procedures
Keywords:
 - containing
 - coordinates
 - root window
Copyright:
 - Copyright (c) 1990-1993 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

Tk_CoordsToWindow - Find window containing a point

# Synopsis

::: {.synopsis} :::
[#include]{.cmd} [\<tk.h>]{.lit}

Tk_Window
[Tk_CoordsToWindow]{.cmd}([rootX]{.arg}, [rootY]{.arg}, [tkwin]{.arg})
:::

# Arguments

int *rootX* (in)
: X-coordinate (in root window coordinates).

int *rootY* (in)
: Y-coordinate (in root window coordinates).

Tk_Window *tkwin* (in)
: Token for window that identifies application.


# Description

**Tk_CoordsToWindow** locates the window that contains a given point. The point is specified in root coordinates with *rootX* and *rootY* (if a virtual-root window manager is in use then *rootX* and *rootY* are in the coordinate system of the virtual root window). The return value from the procedure is a token for the window that contains the given point. If the point is not in any window, or if the containing window is not in the same application as *tkwin*, then NULL is returned.

The containing window is decided using the same rules that determine which window contains the mouse cursor:  if a parent and a child both contain the point then the child gets preference, and if two siblings both contain the point then the highest one in the stacking order (i.e. the one that's visible on the screen) gets preference.
