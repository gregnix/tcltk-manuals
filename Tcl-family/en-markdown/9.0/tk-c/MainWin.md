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
[Tk\_SetMainMenubar]{.ccmd} [interp, tkwin, menuName]{.cargs}
[Tk\_SetWindowMenubar]{.ccmd} [interp, tkwin, oldMenuName, menuName]{.cargs}
[int]{.ret} [Tk\_GetNumMainWindows]{.ccmd} []{.cargs}
:::

# Arguments

::: {.arguments} :::

[\*interp]{.carg .in/out type="Tcl_Interp"}
: Interpreter associated with the application.

[tkwin]{.carg .in type="Tk_Window"}
: Token for main window.

[char]{.carg .*menuName type="const"}
: The name of the new menubar that the toplevel needs to be set to. NULL means that their is no menu now.

[char]{.carg .*oldMenuName type="const"}
: The name of the menubar previously set in this toplevel. NULL means no menu was set previously.

:::

# Description

A main window is a special kind of toplevel window used as the outermost window in an application.

If *interp* is associated with a Tk application then **Tk\_MainWindow** returns the application's main window. If there is no Tk application associated with *interp* then **Tk\_MainWindow** returns NULL and leaves an error message in interpreter *interp*'s result.

**Tk\_GetNumMainWindows** returns a count of the number of main windows currently open in the current thread. **Tk\_SetMainMenubar** Called when a toplevel widget is brought to front. On the Macintosh, sets up the menubar that goes across the top of the main monitor. On other platforms, nothing is necessary. **Tk\_SetWindowMenubar** associates a menu with a window. The old menu clones for the menubar are thrown away, and a handler is set up to allocate the new ones.
