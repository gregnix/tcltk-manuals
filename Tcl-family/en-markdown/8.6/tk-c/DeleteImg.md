---
CommandName: Tk_DeleteImage
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

Tk_DeleteImage - Destroy an image.

# Synopsis

::: {.synopsis} :::
[#include]{.cmd} [\<tk.h>]{.lit}

[Tk_DeleteImage]{.cmd}([interp]{.arg}, [name]{.arg})
:::

# Arguments

Tcl_Interp *\*interp* (in)
: Interpreter for which the image was created.

const char *\*name* (in)
: Name of the image.


# Description

**Tk_DeleteImage** deletes the image given by *interp* and *name*, if there is one.  All instances of that image will redisplay as empty regions.  If the given image does not exist then the procedure has no effect.
