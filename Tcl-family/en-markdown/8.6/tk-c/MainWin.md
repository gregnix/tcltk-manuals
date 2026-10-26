---
CommandName: Tk_MainWindow
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

Tk_MainWindow, Tk_GetNumMainWindows - functions for querying main window information

# Synopsis

::: {.synopsis} :::
[#include]{.cmd} [\<tk.h>]{.lit}

Tk_Window
[Tk_MainWindow]{.cmd}([interp]{.arg})

int
[Tk_GetNumMainWindows]{.cmd}()
:::

# Arguments

Tcl_Interp *\*interp* (in/out)
: Interpreter associated with the application.


# Description

A main window is a special kind of toplevel window used as the outermost window in an application.

If *interp* is associated with a Tk application then **Tk_MainWindow** returns the application's main window. If there is no Tk application associated with *interp* then **Tk_MainWindow** returns NULL and leaves an error message in interpreter *interp*'s result.

**Tk_GetNumMainWindows** returns a count of the number of main windows currently open in the current thread.
