---
CommandName: Tk_SetWindowVisual
title: Tk_SetWindowVisual
ManualSection: 3
Version: 4.0
TclPart: Tk
TclDescription: Tk Library Procedures
Keywords:
 - colormap
 - depth
 - visual
Copyright:
 - Copyright (c) 1992 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

Tk\_SetWindowVisual - change visual characteristics of window

# Synopsis

::: {.synopsis} :::
**#include <tk.h>**
[int]{.ret} [Tk\_SetWindowVisual]{.ccmd} [tkwin, visual, depth, colormap]{.cargs}
:::

# Arguments

::: {.arguments} :::

[tkwin]{.carg .in type="Tk_Window"}
: Token for window.

[\*visual]{.carg .in type="Visual"}
: New visual type to use for *tkwin*.

[depth]{.carg .in type="int"}
: Number of bits per pixel desired for *tkwin*.

[colormap]{.carg .in type="Colormap"}
: New colormap for *tkwin*, which must be compatible with *visual* and *depth*.

:::

# Description

When Tk creates a new window it assigns it the default visual characteristics (visual, depth, and colormap) for its screen. **Tk\_SetWindowVisual** may be called to change them. **Tk\_SetWindowVisual** must be called before the window has actually been created in X (e.g. before [Tk\_MapWindow][MapWindow] or [Tk\_MakeWindowExist][CrtWindow] has been invoked for the window). The safest thing is to call **Tk\_SetWindowVisual** immediately after calling [Tk\_CreateWindow][CrtWindow]. If *tkwin* has already been created before **Tk\_SetWindowVisual** is called then it returns 0 and does not make any changes;  otherwise it returns 1 to signify that the operation completed successfully.

Note that **Tk\_SetWindowVisual** should not be called if you just want to change a window's colormap without changing its visual or depth; call [Tk\_SetWindowColormap][ConfigWind] instead.


[ConfigWind]: ConfigWind.md
[CrtWindow]: CrtWindow.md
[MapWindow]: MapWindow.md
