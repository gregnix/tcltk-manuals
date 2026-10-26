---
CommandName: Tk_IdToWindow
title: Tk_IdToWindow
ManualSection: 3
Version: 4.0
TclPart: Tk
TclDescription: Tk Library Procedures
Keywords:
 - X window id
Copyright:
 - Copyright (c) 1995-1996 Sun Microsystems, Inc.
---

# Name

Tk\_IdToWindow - Find Tk's window information for an X window

# Synopsis

::: {.synopsis} :::
**#include <tk.h>**
[Tk\_Window]{.ret} [Tk\_IdToWindow]{.ccmd} [display, window]{.cargs}
:::

# Arguments

::: {.arguments} :::

[\*display]{.carg .in type="Display"}
: X display containing the window.

[window]{.carg .in type="Window"}
: X id for window.

:::

# Description

Given an X window identifier and the X display it corresponds to, this procedure returns the corresponding Tk\_Window handle. If there is no Tk\_Window corresponding to *window* then NULL is returned.
