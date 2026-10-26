---
CommandName: Tk_StrictMotif
title: Tk_StrictMotif
ManualSection: 3
Version: 4.0
TclPart: Tk
TclDescription: Tk Library Procedures
Keywords:
 - Motif compliance
 - tk_strictMotif variable
Copyright:
 - Copyright (c) 1995-1996 Sun Microsystems, Inc.
---

# Name

Tk\_StrictMotif - Return value of tk\_strictMotif variable

# Synopsis

::: {.synopsis} :::
**#include <tk.h>**
[int]{.ret} [Tk\_StrictMotif]{.ccmd} [tkwin]{.cargs}
:::

# Arguments

::: {.arguments} :::

[tkwin]{.carg .in type="Tk_Window"}
: Token for window.

:::

# Description

This procedure returns the current value of the [tk\_strictMotif][tkvars] variable in the interpreter associated with *tkwin*'s application. The value is returned as an integer that is either 0 or 1. 1 means that strict Motif compliance has been requested, so anything that is not part of the Motif specification should be avoided. 0 means that "Motif-like" is good enough, and extra features are welcome.

This procedure uses a link to the Tcl variable to provide much faster access to the variable's value than could be had by calling [Tcl\_GetVar][SetVar].


[SetVar]: ../tcl-c/SetVar.md
[tkvars]: ../tk/tkvars.md
