---
CommandName: Tk_GetColormap
title: Tk_GetColormap
ManualSection: 3
Version: 4.0
TclPart: Tk
TclDescription: Tk Library Procedures
Keywords:
 - colormap
 - visual
Copyright:
 - Copyright (c) 1994 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

Tk\_GetColormap, Tk\_PreserveColormap, Tk\_FreeColormap - allocate and free colormaps

# Synopsis

::: {.synopsis} :::
**#include <tk.h>**
Colormap Tk\_GetColormap(interp, tkwin, string)
Tk\_PreserveColormap(display, colormap)
Tk\_FreeColormap(display, colormap)
:::

# Arguments

::: {.arguments} :::

[\*interp]{.carg .in type="Tcl_Interp"}
: Interpreter to use for error reporting.

[tkwin]{.carg .in type="Tk_Window"}
: Token for window in which colormap will be used.

[\*string]{.carg .in type="const char"}
: Selects a colormap:  either **new** or the name of a window with the same screen and visual as *tkwin*.

[\*display]{.carg .in type="Display"}
: Display for which *colormap* was allocated.

[colormap]{.carg .in type="Colormap"}
: Colormap to free or preserve;  must have been returned by a previous call to **Tk\_GetColormap** or [Tk\_GetVisual][GetVisual].

:::

# Description

These procedures are used to manage colormaps. **Tk\_GetColormap** returns a colormap suitable for use in *tkwin*. If its *string* argument is **new** then a new colormap is created;  otherwise *string* must be the name of another window with the same screen and visual as *tkwin*, and the colormap from that window is returned. If *string* does not make sense, or if it refers to a window on a different screen from *tkwin* or with a different visual than *tkwin*, then **Tk\_GetColormap** returns **None** and leaves an error message in *interp*'s result.

**Tk\_PreserveColormap** increases the internal reference count for a colormap previously returned by **Tk\_GetColormap**, which allows the colormap to be stored in several locations without knowing which order they will be released.

**Tk\_FreeColormap** should be called when a colormap returned by **Tk\_GetColormap** is no longer needed. Tk maintains a reference count for each colormap returned by **Tk\_GetColormap**, so there should eventually be one call to **Tk\_FreeColormap** for each call to **Tk\_GetColormap** and each call to **Tk\_PreserveColormap**. When a colormap's reference count becomes zero, Tk releases the X colormap.

[Tk\_GetVisual][GetVisual] and **Tk\_GetColormap** work together, in that a new colormap created by [Tk\_GetVisual][GetVisual] may later be returned by **Tk\_GetColormap**. The reference counting mechanism for colormaps includes both procedures, so callers of [Tk\_GetVisual][GetVisual] must also call **Tk\_FreeColormap** to release the colormap. If **Tk\_GetColormap** is called with a *string* value of **new** then the resulting colormap will never be returned by [Tk\_GetVisual][GetVisual];  however, it can be used in other windows by calling **Tk\_GetColormap** with the original window's name as *string*.


[GetVisual]: GetVisual.md
