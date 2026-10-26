---
CommandName: Tk_GetVRootGeometry
title: Tk_GetVRootGeometry
ManualSection: 3
Version: 4.0
TclPart: Tk
TclDescription: Tk Library Procedures
Keywords:
 - geometry
 - height
 - location
 - virtual root
 - width
 - window manager
Copyright:
 - Copyright (c) 1990 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

Tk\_GetVRootGeometry - Get location and size of virtual root for window

# Synopsis

::: {.synopsis} :::
**#include <tk.h>**
[Tk\_GetVRootGeometry]{.ccmd} [tkwin, xPtr, yPtr, widthPtr, heightPtr]{.cargs}
:::

# Arguments

::: {.arguments} :::

[tkwin]{.carg .in type="Tk_Window"}
: Token for window whose virtual root is to be queried.

[xPtr]{.carg .out type="int"}
: Points to word in which to store x-offset of virtual root.

[yPtr]{.carg .out type="int"}
: Points to word in which to store y-offset of virtual root.

[widthPtr]{.carg .out type="int"}
: Points to word in which to store width of virtual root.

[heightPtr]{.carg .out type="int"}
: Points to word in which to store height of virtual root.

:::

# Description

**Tk\_GetVRootGeometry** returns geometry information about the virtual root window associated with *tkwin*.  The "associated" virtual root is the one in which *tkwin*'s nearest top-level ancestor (or *tkwin* itself if it is a top-level window) has been reparented by the window manager.  This window is identified by a **\_\_SWM\_ROOT** or **\_\_WM\_ROOT** property placed on the top-level window by the window manager. If *tkwin* is not associated with a virtual root (e.g. because the window manager does not use virtual roots) then \**xPtr* and \**yPtr* will be set to 0 and \**widthPtr* and \**heightPtr* will be set to the dimensions of the screen containing *tkwin*.
