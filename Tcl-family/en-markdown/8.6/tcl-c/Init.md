---
CommandName: Tcl_Init
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
 - All rights reserved.
---

# Name

Tcl_Init - find and source initialization script

# Synopsis

::: {.synopsis} :::
[#include]{.cmd} [\<tcl.h>]{.lit}

int
[Tcl_Init]{.cmd}([interp]{.arg})
:::

# Arguments

Tcl_Interp *\*interp* (in)
: Interpreter to initialize.


# Description

**Tcl_Init** is a helper procedure that finds and **source**s the **init.tcl** script, which should exist somewhere on the Tcl library path.

**Tcl_Init** is typically called from **Tcl_AppInit** procedures.
