---
CommandName: Tk_MainLoop
title: Tk_MainLoop
ManualSection: 3
Version: unknown
TclPart: Tk
TclDescription: Tk Library Procedures
Keywords:
 - application
 - event
 - main loop
Copyright:
 - Copyright (c) 1990-1992 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

Tk\_MainLoop - loop for events until all windows are deleted

# Synopsis

::: {.synopsis} :::
**#include <tk.h>**
[Tk\_MainLoop]{.ccmd} []{.cargs}
:::

# Description

**Tk\_MainLoop** is a procedure that loops repeatedly calling [Tcl\_DoOneEvent][DoOneEvent].  It returns only when there are no applications left in this process (i.e. no main windows exist anymore).  Most windowing applications will call **Tk\_MainLoop** after initialization; the main execution of the application will consist entirely of callbacks invoked via [Tcl\_DoOneEvent][DoOneEvent].


[DoOneEvent]: ../tcl-c/DoOneEvent.md
