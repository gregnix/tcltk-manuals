---
CommandName: Tk_GetRootCoords
title: Tk_GetRootCoords
ManualSection: 3
Version: unknown
TclPart: Tk
TclDescription: Tk Library Procedures
Keywords:
 - coordinates
 - root window
Copyright:
 - Copyright (c) 1990 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

Tk\_GetRootCoords - Compute root-window coordinates of window

# Synopsis

::: {.synopsis} :::
**#include <tk.h>**
[Tk\_GetRootCoords]{.ccmd} [tkwin, xPtr, yPtr]{.cargs}
:::

# Arguments

::: {.arguments} :::

[tkwin]{.carg .in type="Tk_Window"}
: Token for window.

[\*xPtr]{.carg .out type="int"}
: Pointer to location in which to store root-window x-coordinate corresponding to left edge of *tkwin*'s border.

[\*yPtr]{.carg .out type="int"}
: Pointer to location in which to store root-window y-coordinate corresponding to top edge of *tkwin*'s border.

:::

# Description

This procedure scans through the structural information maintained by Tk to compute the root-window coordinates corresponding to the upper-left corner of *tkwin*'s border.  If *tkwin* has no border, then **Tk\_GetRootCoords** returns the root-window coordinates corresponding to location (0,0) in *tkwin*. **Tk\_GetRootCoords** is relatively efficient, since it does not have to communicate with the X server.
