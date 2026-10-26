---
CommandName: Tk_Main
title: Tk_Main
ManualSection: 3
Version: 4.0
TclPart: Tk
TclDescription: Tk Library Procedures
Links:
 - Tcl_DoOneEvent(3)
Keywords:
 - application-specific initialization
 - command-line arguments
 - main program
Copyright:
 - Copyright (c) 1994 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

Tk\_Main - main program for Tk-based applications

# Synopsis

::: {.synopsis} :::
**#include <tk.h>**
[Tk\_Main]{.ccmd} [argc, argv, appInitProc]{.cargs}
:::

# Arguments

::: {.arguments} :::

[argc]{.carg .in type="int"}
: Number of elements in *argv*.

[\*argv\[\]]{.carg .in type="char"}
: Array of strings containing command-line arguments. On Windows, when using -DUNICODE, the parameter type changes to wchar\_t \*.

[\*appInitProc]{.carg .in type="Tcl_AppInitProc"}
: Address of an application-specific initialization procedure. The value for this argument is usually [Tcl\_AppInit][AppInit].

:::

# Description

**Tk\_Main** acts as the main program for most Tk-based applications. Starting with Tk 4.0 it is not called **main** anymore because it is part of the Tk library and having a function **main** in a library (particularly a shared library) causes problems on many systems. Having **main** in the Tk library would also make it hard to use Tk in C++ programs, since C++ programs must have special C++ **main** functions.

Normally each application contains a small **main** function that does nothing but invoke **Tk\_Main**. **Tk\_Main** then does all the work of creating and running a [wish]-like application.

When it is has finished its own initialization, but before it processes commands, **Tk\_Main** calls the procedure given by the *appInitProc* argument.  This procedure provides a "hook" for the application to perform its own initialization, such as defining application-specific commands.  The procedure must have an interface that matches the type **Tcl\_AppInitProc**:

```
typedef int Tcl_AppInitProc(
        Tcl_Interp *interp);
```

*AppInitProc* is almost always a pointer to [Tcl\_AppInit][AppInit]; for more details on this procedure, see the documentation for [Tcl\_AppInit][AppInit].

**Tk\_Main** functions much the same as [Tcl\_Main][Tcl_Main].  In particular, **Tk\_Main** supports both an interactive mode and a startup script mode, with the file name and encoding of a startup script under the control of the [Tcl\_SetStartupScript][Tcl_Main] and [Tcl\_GetStartupScript][Tcl_Main] routines. However it calls [Tk\_MainLoop][MainLoop] after processing any supplied script, and in interactive uses events registered with [Tcl\_CreateFileHandler][CrtFileHdlr] to process user input.


[AppInit]: ../tcl-c/AppInit.md
[CrtFileHdlr]: ../tcl-c/CrtFileHdlr.md
[MainLoop]: MainLoop.md
[Tcl_Main]: ../tcl-c/Tcl_Main.md
[wish]: ../tk/wish.md
