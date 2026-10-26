---
CommandName: Tk_OwnSelection
title: Tk_OwnSelection
ManualSection: 3
Version: 4.0
TclPart: Tk
TclDescription: Tk Library Procedures
Keywords:
 - own
 - selection owner
Copyright:
 - Copyright (c) 1990-1994 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

Tk\_OwnSelection - make a window the owner of the primary selection

# Synopsis

::: {.synopsis} :::
**#include <tk.h>**
[Tk\_OwnSelection]{.ccmd} [tkwin, selection, proc, clientData]{.cargs}
:::

# Arguments

::: {.arguments} :::

[tkwin]{.carg .in type="Tk_Window"}
: Window that is to become new selection owner.

[selection]{.carg .in type="Atom"}
: The name of the selection to be owned, such as XA\_PRIMARY.

[\*proc]{.carg .in type="Tk_LostSelProc"}
: Procedure to invoke when *tkwin* loses selection ownership later.

[clientData]{.carg .in type="ClientData"}
: Arbitrary one-word value to pass to *proc*.

:::

# Description

**Tk\_OwnSelection** arranges for *tkwin* to become the new owner of the selection specified by the atom *selection*.  After this call completes, future requests for the selection will be directed to handlers created for *tkwin* using [Tk\_CreateSelHandler][CrtSelHdlr].  When *tkwin* eventually loses the selection ownership, *proc* will be invoked so that the window can clean itself up (e.g. by unhighlighting the selection).  *Proc* should have arguments and result that match the type **Tk\_LostSelProc**:

```
typedef void Tk_LostSelProc(
        ClientData clientData);
```

The *clientData* parameter to *proc* is a copy of the *clientData* argument given to **Tk\_OwnSelection**, and is usually a pointer to a data structure containing application-specific information about *tkwin*.


[CrtSelHdlr]: CrtSelHdlr.md
