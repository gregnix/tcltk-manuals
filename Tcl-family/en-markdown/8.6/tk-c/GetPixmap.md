---
CommandName: Tk_GetPixmap
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

Tk_GetPixmap, Tk_FreePixmap - allocate and free pixmaps

# Synopsis

::: {.synopsis} :::
[#include]{.cmd} [\<tk.h>]{.lit}

Pixmap
[Tk_GetPixmap]{.cmd}([display]{.arg}, [d]{.arg}, [width]{.arg}, [height]{.arg}, [depth]{.arg})

[Tk_FreePixmap]{.cmd}([display]{.arg}, [pixmap]{.arg})
:::

# Arguments

Display *\*display* (in)
: X display for the pixmap.

Drawable *d* (in)
: Pixmap or window where the new pixmap will be used for drawing.

int *width* (in)
: Width of pixmap.

int *height* (in)
: Height of pixmap.

int *depth* (in)
: Number of bits per pixel in pixmap.

Pixmap *pixmap* (in)
: Pixmap to destroy.


# Description

These procedures are identical to the Xlib procedures **XCreatePixmap** and **XFreePixmap**, except that they have extra code to manage X resource identifiers so that identifiers for deleted pixmaps can be reused in the future. It is important for Tk applications to use these procedures rather than **XCreatePixmap** and **XFreePixmap**;  otherwise long-running applications may run out of resource identifiers.

**Tk_GetPixmap** creates a pixmap suitable for drawing in *d*, with dimensions given by *width*, *height*, and *depth*, and returns its identifier. **Tk_FreePixmap** destroys the pixmap given by *pixmap* and makes its resource identifier available for reuse.
