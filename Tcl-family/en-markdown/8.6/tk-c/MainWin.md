---
CommandName: Tk_MainWindow
title: Tk_MainWindow
ManualSection: 3
Version: 7.0
TclPart: Tk
TclDescription: Tk Library Procedures
Keywords:
 - application
 - main window
Copyright:
 - Copyright (c) 1990 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

Tk\_MainWindow, Tk\_GetNumMainWindows - functions for querying main window information

# Synopsis

::: {.synopsis} :::
**#include <tk.h>**
[Tk\_Window]{.ret} [Tk\_MainWindow]{.ccmd} [interp]{.cargs}
[int]{.ret} [Tk\_GetNumMainWindows]{.ccmd} []{.cargs}
:::

# Arguments

::: {.arguments} :::

[\*interp]{.carg .in/out type="Tcl_Interp"}
: Interpreter associated with the application.

:::

# Description

A main window is a special kind of toplevel window used as the outermost window in an application.

If *interp* is associated with a Tk application then **Tk\_MainWindow** returns the application's main window. If there is no Tk application associated with *interp* then **Tk\_MainWindow** returns NULL and leaves an error message in interpreter *interp*'s result.

**Tk\_GetNumMainWindows** returns a count of the number of main windows currently open in the current thread.
