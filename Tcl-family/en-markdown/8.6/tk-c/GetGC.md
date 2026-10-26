---
CommandName: Tk_GetGC
title: Tk_GetGC
ManualSection: 3
Version: unknown
TclPart: Tk
TclDescription: Tk Library Procedures
Keywords:
 - graphics context
Copyright:
 - Copyright (c) 1990 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

Tk\_GetGC, Tk\_FreeGC - maintain database of read-only graphics contexts

# Synopsis

::: {.synopsis} :::
**#include <tk.h>**
[GC]{.ret} [Tk\_GetGC]{.ccmd} [tkwin, valueMask, valuePtr]{.cargs}
[Tk\_FreeGC]{.cmd} [display, gc]{.sub}
:::

# Arguments

::: {.arguments} :::

[tkwin]{.carg .in type="Tk_Window"}
: Token for window in which the graphics context will be used.

[valueMask]{.carg .in type="unsigned long"}
: Mask of bits (such as **GCForeground** or **GCStipple**) indicating which fields of *\*valuePtr* are valid.

[\*valuePtr]{.carg .in type="XGCValues"}
: Pointer to structure describing the desired values for the graphics context.

[\*display]{.carg .in type="Display"}
: Display for which *gc* was allocated.

[gc]{.carg .in type="GC"}
: X identifier for graphics context that is no longer needed. Must have been allocated by **Tk\_GetGC**.

:::

# Description

**Tk\_GetGC** and **Tk\_FreeGC** manage a collection of graphics contexts being used by an application.  The procedures allow graphics contexts to be shared, thereby avoiding the server overhead that would be incurred if a separate GC were created for each use.  **Tk\_GetGC** takes arguments describing the desired graphics context and returns an X identifier for a GC that fits the description.  The graphics context that is returned will have default values in all of the fields not specified explicitly by *valueMask* and *valuePtr*.

**Tk\_GetGC** maintains a database of all the graphics contexts it has created.  Whenever possible, a call to **Tk\_GetGC** will return an existing graphics context rather than creating a new one.  This approach can substantially reduce server overhead, so **Tk\_GetGC** should generally be used in preference to the Xlib procedure **XCreateGC**, which creates a new graphics context on each call.

Since the return values of **Tk\_GetGC** are shared, callers should never modify the graphics contexts returned by **Tk\_GetGC**. If a graphics context must be modified dynamically, then it should be created by calling **XCreateGC** instead of **Tk\_GetGC**.

When a graphics context is no longer needed, **Tk\_FreeGC** should be called to release it. There should be exactly one call to **Tk\_FreeGC** for each call to **Tk\_GetGC**. When a graphics context is no longer in use anywhere (i.e. it has been freed as many times as it has been gotten) **Tk\_FreeGC** will release it to the X server and delete it from the database.
