---
CommandName: Tk_ClearSelection
title: Tk_ClearSelection
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

Tk\_ClearSelection - Deselect a selection

# Synopsis

::: {.synopsis} :::
**#include <tk.h>**
[Tk\_ClearSelection]{.ccmd} [tkwin, selection]{.cargs}
:::

# Arguments

::: {.arguments} :::

[tkwin]{.carg .in type="Tk_Window"}
: The selection will be cleared from the display containing this window.

[selection]{.carg .in type="Atom"}
: The name of selection to be cleared.

:::

# Description

**Tk\_ClearSelection** cancels the selection specified by the atom *selection* for the display containing *tkwin*. The selection need not be in *tkwin* itself or even in *tkwin*'s application. If there is a window anywhere on *tkwin*'s display that owns *selection*, the window will be notified and the selection will be cleared. If there is no owner for *selection* on the display, then the procedure has no effect.
