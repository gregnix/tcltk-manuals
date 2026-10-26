---
CommandName: Tk_MapWindow
title: Tk_MapWindow
ManualSection: 3
Version: unknown
TclPart: Tk
TclDescription: Tk Library Procedures
Keywords:
 - map
 - unmap
 - window
Copyright:
 - Copyright (c) 1990 The Regents of the University of California.
 - Copyright (c) 1994-1997 Sun Microsystems, Inc.
---

# Name

Tk\_MapWindow, Tk\_UnmapWindow - map or unmap a window

# Synopsis

::: {.synopsis} :::
**#include <tk.h>**
[Tk\_Window]{.ret} [Tk\_MapWindow]{.ccmd} [tkwin]{.cargs}
[Tk\_UnmapWindow]{.ccmd} [tkwin]{.cargs}
:::

# Arguments

::: {.arguments} :::

[tkwin]{.carg .in type="Tk_Window"}
: Token for window.

:::

# Description

These procedures may be used to map and unmap windows managed by Tk.  **Tk\_MapWindow** maps the window given by *tkwin*, and also creates an X window corresponding to *tkwin* if it does not already exist.  See the [Tk\_CreateWindow][CrtWindow] manual entry for information on deferred window creation. **Tk\_UnmapWindow** unmaps *tkwin*'s window from the screen.

If *tkwin* is a child window (i.e. [Tk\_CreateWindow][CrtWindow] was used to create a child window), then event handlers interested in map and unmap events are invoked immediately.  If *tkwin* is not an internal window, then the event handlers will be invoked later, after X has seen the request and returned an event for it.

These procedures should be used in place of the X procedures **XMapWindow** and **XUnmapWindow**, since they update Tk's local data structure for *tkwin*.  Applications using Tk should not invoke **XMapWindow** and **XUnmapWindow** directly.


[CrtWindow]: CrtWindow.md
