---
CommandName: Tcl_Init
title: Tcl_Init
ManualSection: 3
Version: 8.0
TclPart: Tcl
TclDescription: Tcl Library Procedures
Links:
 - Tcl_AppInit
 - Tcl_Main
Keywords:
 - application
 - initialization
 - interpreter
Copyright:
 - Copyright (c) 1998-2000 Scriptics Corporation.
---

# Name

Tcl\_Init - find and source initialization script

# Synopsis

::: {.synopsis} :::
**#include <tcl.h>**
[int]{.ret} [Tcl\_Init]{.ccmd} [interp]{.cargs}
:::

# Arguments

::: {.arguments} :::

[\*interp]{.carg .in type="Tcl_Interp"}
: Interpreter to initialize.

:::

# Description

**Tcl\_Init** is a helper procedure that finds and [source]s the **init.tcl** script, which should exist somewhere on the Tcl library path.

**Tcl\_Init** is typically called from [Tcl\_AppInit][AppInit] procedures.


[AppInit]: AppInit.md
[source]: ../tcl/source.md
