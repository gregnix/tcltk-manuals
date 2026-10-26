---
CommandName: Tk_IdToWindow
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

Tk_IdToWindow - Find Tk's window information for an X window

# Synopsis

::: {.synopsis} :::
[#include]{.cmd} [\<tk.h>]{.lit}

Tk_Window
[Tk_IdToWindow]{.cmd}([display]{.arg}, [window]{.arg})
:::

# Arguments

Display *\*display* (in)
: X display containing the window.

Window *window* (in)
: X id for window.


# Description

Given an X window identifier and the X display it corresponds to, this procedure returns the corresponding Tk_Window handle. If there is no Tk_Window corresponding to *window* then NULL is returned.
