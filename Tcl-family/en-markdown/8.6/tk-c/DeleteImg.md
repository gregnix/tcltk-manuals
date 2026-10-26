---
CommandName: Tk_DeleteImage
title: Tk_DeleteImage
ManualSection: 3
Version: 4.0
TclPart: Tk
TclDescription: Tk Library Procedures
Keywords:
 - delete image
 - image manager
Copyright:
 - Copyright (c) 1995-1996 Sun Microsystems, Inc.
---

# Name

Tk\_DeleteImage - Destroy an image.

# Synopsis

::: {.synopsis} :::
**#include <tk.h>**
[Tk\_DeleteImage]{.ccmd} [interp, name]{.cargs}
:::

# Arguments

::: {.arguments} :::

[\*interp]{.carg .in type="Tcl_Interp"}
: Interpreter for which the image was created.

[\*name]{.carg .in type="const char"}
: Name of the image.

:::

# Description

**Tk\_DeleteImage** deletes the image given by *interp* and *name*, if there is one.  All instances of that image will redisplay as empty regions.  If the given image does not exist then the procedure has no effect.
