---
CommandName: Tk_GetOption
title: Tk_GetOption
ManualSection: 3
Version: unknown
TclPart: Tk
TclDescription: Tk Library Procedures
Keywords:
 - class
 - name
 - option
 - retrieve
Copyright:
 - Copyright (c) 1990 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

Tk\_GetOption - retrieve an option from the option database

# Synopsis

::: {.synopsis} :::
**#include <tk.h>**
[Tk\_Uid]{.ret} [Tk\_GetOption]{.ccmd} [tkwin, name, class]{.cargs}
:::

# Arguments

::: {.arguments} :::

[tkwin]{.carg .in type="Tk_Window"}
: Token for window.

[\*name]{.carg .in type="const char"}
: Name of desired option.

[\*class]{.carg .in type="const char"}
: Class of desired option.  Null means there is no class for this option;  do lookup based on name only.

:::

# Description

This procedure is invoked to retrieve an option from the database associated with *tkwin*'s main window.  If there is an option for *tkwin* that matches the given *name* or *class*, then it is returned in the form of a [Tk\_Uid][GetUid].  If multiple options match *name* and *class*, then the highest-priority one is returned.  If no option matches, then NULL is returned.

**Tk\_GetOption** caches options related to *tkwin* so that successive calls for the same *tkwin* will execute much more quickly than successive calls for different windows.


[GetUid]: GetUid.md
