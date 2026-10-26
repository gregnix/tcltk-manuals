---
CommandName: Tk_SetClass
title: Tk_SetClass
ManualSection: 3
Version: unknown
TclPart: Tk
TclDescription: Tk Library Procedures
Keywords:
 - class
 - unique identifier
 - window
 - window manager
Copyright:
 - Copyright (c) 1990 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

Tk\_SetClass, Tk\_Class - set or retrieve a window's class

# Synopsis

::: {.synopsis} :::
**#include <tk.h>**
[Tk\_SetClass]{.ccmd} [tkwin, class]{.cargs}
[Tk\_Uid]{.ret} [Tk\_Class]{.ccmd} [tkwin]{.cargs}
:::

# Arguments

::: {.arguments} :::

[tkwin]{.carg .in type="Tk_Window"}
: Token for window.

[\*class]{.carg .in type="char"}
: New class name for window.

:::

# Description

**Tk\_SetClass** is called to associate a class with a particular window.  The *class* string identifies the type of the window;  all windows with the same general class of behavior (button, menu, etc.) should have the same class.  By convention all class names start with a capital letter, and there exists a Tcl command with the same name as each class (except all in lower-case) which can be used to create and manipulate windows of that class. A window's class string is initialized to NULL when the window is created.

For main windows, Tk automatically propagates the name and class to the WM\_CLASS property used by window managers.  This happens either when a main window is actually created (e.g. in [Tk\_MakeWindowExist][CrtWindow]), or when **Tk\_SetClass** is called, whichever occurs later.  If a main window has not been assigned a class then Tk will not set the WM\_CLASS property for the window.

**Tk\_Class** is a macro that returns the current value of *tkwin*'s class.  The value is returned as a [Tk\_Uid][GetUid], which may be used just like a string pointer but also has the properties of a unique identifier (see the manual entry for [Tk\_GetUid][GetUid] for details). If *tkwin* has not yet been given a class, then **Tk\_Class** will return NULL.


[CrtWindow]: CrtWindow.md
[GetUid]: GetUid.md
