---
CommandName: Tk_ConfigureWindow
title: Tk_ConfigureWindow
ManualSection: 3
Version: 4.0
TclPart: Tk
TclDescription: Tk Library Procedures
Keywords:
 - parent
 - window
Copyright:
 - Copyright (c) 1990-1993 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

Tk\_GetOtherWindow, Tk\_MakeContainer, Tk\_MakeWindow, Tk\_UseWindow - window utility functions

# Synopsis

::: {.synopsis} :::
**#include <tk.h>**
[Tk\_Window]{.ret} [Tk\_GetOtherWindow]{.ccmd} [tkwin]{.cargs}
[Tk\_MakeContainer]{.ccmd} [tkwin]{.cargs}
[Tk\_MakeWindow]{.ccmd} [tkwin, parent]{.cargs}
[int]{.ret} [Tk\_UseWindow]{.ccmd} [interp, tkwin, string]{.cargs}
:::

# Arguments

::: {.arguments} :::

[\*]{.carg .interp type="Tcl_Interp"}
: Interpreter associated with the application.

[tkwin]{.carg .in type="Tk_Window"}
: Token for window.

[parent]{.carg .in type="Window"}
: Parent window.

[\*string]{.carg .in type="const char"}
: String identifying an X window to use for *tkwin*; must be an integer value.

:::

# Description

If both the container and embedded window are in the same process, **Tk\_GetOtherWindow** will return either one, given the other. If winPtr is a container, the return value is the token for the embedded window, and vice versa. If the "other" window isn't in this process, NULL is returned.

**Tk\_MakeContainer** is called to indicate that a particular window will be a container for an embedded application. This changes certain aspects of the window's behavior, such as whether it will receive events anymore.

**Tk\_MakeWindow** creates an actual window system window object based on the current attributes of the specified TkWindow. It returns the handle to the new window, or None on failure.

**Tk\_UseWindow** causes a Tk window to use a given X window as its parent window, rather than the root window for the screen. It is invoked by an embedded application to specify the window in which it is embedded.

The return value is normally [TCL\_OK][catch]. If an error occurs (such as string not being a valid window spec), then the return value is [TCL\_ERROR][catch] and an error message is left in the interp's result if interp is non-NULL.


[catch]: ../tcl/catch.md
