---
CommandName: Tk_ClearSelection
ManualSection: 3
Version: 4.0
TclPart: Tk
TclDescription: Tk Library Procedures
Keywords:
 - clear
 - selection
Copyright:
 - Copyright (c) 1992-1994 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

Tk_ClearSelection - Deselect a selection

# Synopsis

::: {.synopsis} :::
[#include]{.cmd} [\<tk.h>]{.lit}

[Tk_ClearSelection]{.cmd}([tkwin]{.arg}, [selection]{.arg})
:::

# Arguments

Tk_Window *tkwin* (in)
: The selection will be cleared from the display containing this window.

Atom *selection* (in)
: The name of selection to be cleared.


# Description

**Tk_ClearSelection** cancels the selection specified by the atom *selection* for the display containing *tkwin*. The selection need not be in *tkwin* itself or even in *tkwin*'s application. If there is a window anywhere on *tkwin*'s display that owns *selection*, the window will be notified and the selection will be cleared. If there is no owner for *selection* on the display, then the procedure has no effect.
