---
CommandName: Tk_MapWindow
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

Tk_MapWindow, Tk_UnmapWindow - map or unmap a window

# Synopsis

::: {.synopsis} :::
[#include]{.cmd} [\<tk.h>]{.lit}

Tk_Window
[Tk_MapWindow]{.cmd}([tkwin]{.arg})

[Tk_UnmapWindow]{.cmd}([tkwin]{.arg})
:::

# Arguments

Tk_Window *tkwin* (in)
: Token for window.


# Description

These procedures may be used to map and unmap windows managed by Tk.  **Tk_MapWindow** maps the window given by *tkwin*, and also creates an X window corresponding to *tkwin* if it does not already exist.  See the **Tk_CreateWindow** manual entry for information on deferred window creation. **Tk_UnmapWindow** unmaps *tkwin*'s window from the screen.

If *tkwin* is a child window (i.e. **Tk_CreateWindow** was used to create a child window), then event handlers interested in map and unmap events are invoked immediately.  If *tkwin* is not an internal window, then the event handlers will be invoked later, after X has seen the request and returned an event for it.

These procedures should be used in place of the X procedures **XMapWindow** and **XUnmapWindow**, since they update Tk's local data structure for *tkwin*.  Applications using Tk should not invoke **XMapWindow** and **XUnmapWindow** directly.
