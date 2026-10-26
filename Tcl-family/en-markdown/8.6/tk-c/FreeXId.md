---
CommandName: Tk_FreeXId
title: Tk_FreeXId
ManualSection: 3
Version: 4.0
TclPart: Tk
TclDescription: Tk Library Procedures
Keywords:
 - resource identifier
Copyright:
 - Copyright (c) 1990 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

Tk\_FreeXId - make X resource identifier available for reuse

# Synopsis

::: {.synopsis} :::
**#include <tk.h>**
Tk\_FreeXId(display, id)
:::

# Arguments

::: {.arguments} :::

[\*display]{.carg .in type="Display"}
: Display for which *id* was allocated.

[id]{.carg .in type="XID"}
: Identifier of X resource (window, font, pixmap, cursor, graphics context, or colormap) that is no longer in use.

:::

# Description

The default allocator for resource identifiers provided by Xlib is very simple-minded and does not allow resource identifiers to be re-used. If a long-running application reaches the end of the resource id space, it will generate an X protocol error and crash. Tk replaces the default id allocator with its own allocator, which allows identifiers to be reused. In order for this to work, **Tk\_FreeXId** must be called to tell the allocator about resources that have been freed. Tk automatically calls **Tk\_FreeXId** whenever it frees a resource, so if you use procedures like [Tk\_GetFont][GetFont], [Tk\_GetGC][GetGC], and [Tk\_GetPixmap][GetPixmap] then you need not call **Tk\_FreeXId**. However, if you allocate resources directly from Xlib, for example by calling **XCreatePixmap**, then you should call **Tk\_FreeXId** when you call the corresponding Xlib free procedure, such as **XFreePixmap**. If you do not call **Tk\_FreeXId** then the resource identifier will be lost, which could cause problems if the application runs long enough to lose all of the available identifiers.


[GetFont]: GetFont.md
[GetGC]: GetGC.md
[GetPixmap]: GetPixmap.md
