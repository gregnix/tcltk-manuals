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

[Tk_SetMainMenubar]{.cmd}([interp]{.arg}, [tkwin]{.arg}, [menuName]{.arg})

[Tk_SetWindowMenubar]{.cmd}([interp]{.arg}, [tkwin]{.arg}, [oldMenuName]{.arg}, [menuName]{.arg})

int
[Tk_GetNumMainWindows]{.cmd}()
:::

# Arguments

Tcl_Interp *\*interp* (in/out)
: Interpreter associated with the application.

Tk_Window *tkwin* (in)
: Token for main window.

const *char*
: The name of the new menubar that the toplevel needs to be set to. NULL means that their is no menu now.

const *char*
: The name of the menubar previously set in this toplevel. NULL means no menu was set previously.


# Description

A main window is a special kind of toplevel window used as the outermost window in an application.

If *interp* is associated with a Tk application then **Tk_MainWindow** returns the application's main window. If there is no Tk application associated with *interp* then **Tk_MainWindow** returns NULL and leaves an error message in interpreter *interp*'s result.

**Tk_GetNumMainWindows** returns a count of the number of main windows currently open in the current thread. **Tk_SetMainMenubar** Called when a toplevel widget is brought to front. On the Macintosh, sets up the menubar that goes across the top of the main monitor. On other platforms, nothing is necessary. **Tk_SetWindowMenubar** associates a menu with a window. The old menu clones for the menubar are thrown away, and a handler is set up to allocate the new ones.
