---
CommandName: Tk_Name
title: Tk_Name
ManualSection: 3
Version: unknown
TclPart: Tk
TclDescription: Tk Library Procedures
Keywords:
 - name
 - path name
 - token
 - window
Copyright:
 - Copyright (c) 1990 The Regents of the University of California.
 - Copyright (c) 1994-1997 Sun Microsystems, Inc.
---

# Name

Tk\_Name, Tk\_PathName, Tk\_NameToWindow - convert between names and window tokens

# Synopsis

::: {.synopsis} :::
**#include <tk.h>**
[Tk\_Uid]{.ret} [Tk\_Name]{.ccmd} [tkwin]{.cargs}
[char \*]{.ret} [Tk\_PathName]{.ccmd} [tkwin]{.cargs}
[Tk\_Window]{.ret} [Tk\_NameToWindow]{.ccmd} [interp, pathName, tkwin]{.cargs}
:::

# Arguments

::: {.arguments} :::

[tkwin]{.carg .in type="Tk_Window"}
: Token for window.

[\*interp]{.carg .out type="Tcl_Interp"}
: Interpreter to use for error reporting (can be NULL).

[\*pathName]{.carg .in type="const char"}
: Character string containing path name of window.

:::

# Description

Each window managed by Tk has two names, a short name that identifies a window among children of the same parent, and a path name that identifies the window uniquely among all the windows belonging to the same main window.  The path name is used more often in Tk than the short name;  many commands, like [bind], expect path names as arguments.

The **Tk\_Name** macro returns a window's short name, which is the same as the *name* argument passed to [Tk\_CreateWindow][CrtWindow] when the window was created.  The value is returned as a [Tk\_Uid][GetUid], which may be used just like a string pointer but also has the properties of a unique identifier (see the manual entry for [Tk\_GetUid][GetUid] for details).

The **Tk\_PathName** macro returns a hierarchical name for *tkwin*. Path names have a structure similar to file names in Unix but with dots between elements instead of slashes:  the main window for an application has the path name "."; its children have names like ".a" and ".b"; their children have names like ".a.aa" and ".b.bb"; and so on.  A window is considered to be a child of another window for naming purposes if the second window was named as the first window's *parent* when the first window was created. This is not always the same as the X window hierarchy.  For example, a pop-up is created as a child of the root window, but its logical parent will usually be a window within the application.

The procedure **Tk\_NameToWindow** returns the token for a window given its path name (the *pathName* argument) and another window belonging to the same main window (*tkwin*).  It normally returns a token for the named window, but if no such window exists **Tk\_NameToWindow** leaves an error message in interpreter *interp*'s result and returns NULL.  The *tkwin* argument to **Tk\_NameToWindow** is needed because path names are only unique within a single application hierarchy.  If, for example, a single process has opened two main windows, each will have a separate naming hierarchy and the same path name might appear in each of the hierarchies.  Normally *tkwin* is the main window of the desired hierarchy, but this need not be the case:  any window in the desired hierarchy may be used.


[bind]: ../tk/bind.md
[CrtWindow]: CrtWindow.md
[GetUid]: GetUid.md
