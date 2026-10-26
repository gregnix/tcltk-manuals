---
CommandName: Tk_GetPixmap
title: Tk_GetPixmap
ManualSection: 3
Version: 4.0
TclPart: Tk
TclDescription: Tk Library Procedures
Keywords:
 - pixmap
 - resource identifier
Copyright:
 - Copyright (c) 1990 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

Tk\_GetPixmap, Tk\_FreePixmap - allocate and free pixmaps

# Synopsis

::: {.synopsis} :::
**#include <tk.h>**
[Pixmap]{.ret} [Tk\_GetPixmap]{.ccmd} [display, d, width, height, depth]{.cargs}
[Tk\_FreePixmap]{.ccmd} [display, pixmap]{.cargs}
:::

# Arguments

::: {.arguments} :::

[\*display]{.carg .in type="Display"}
: X display for the pixmap.

[d]{.carg .in type="Drawable"}
: Pixmap or window where the new pixmap will be used for drawing.

[width]{.carg .in type="int"}
: Width of pixmap.

[height]{.carg .in type="int"}
: Height of pixmap.

[depth]{.carg .in type="int"}
: Number of bits per pixel in pixmap.

[pixmap]{.carg .in type="Pixmap"}
: Pixmap to destroy.

:::

# Description

These procedures are identical to the Xlib procedures **XCreatePixmap** and **XFreePixmap**, except that they have extra code to manage X resource identifiers so that identifiers for deleted pixmaps can be reused in the future. It is important for Tk applications to use these procedures rather than **XCreatePixmap** and **XFreePixmap**;  otherwise long-running applications may run out of resource identifiers.

**Tk\_GetPixmap** creates a pixmap suitable for drawing in *d*, with dimensions given by *width*, *height*, and *depth*, and returns its identifier. **Tk\_FreePixmap** destroys the pixmap given by *pixmap* and makes its resource identifier available for reuse.
