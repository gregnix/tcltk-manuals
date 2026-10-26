---
CommandName: Tk_StrictMotif
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

Tk_StrictMotif - Return value of tk_strictMotif variable

# Synopsis

::: {.synopsis} :::
[#include]{.cmd} [\<tk.h>]{.lit}

int
[Tk_StrictMotif]{.cmd}([tkwin]{.arg})
:::

# Arguments

Tk_Window *tkwin* (in)
: Token for window.


# Description

This procedure returns the current value of the **tk_strictMotif** variable in the interpreter associated with *tkwin*'s application. The value is returned as an integer that is either 0 or 1. 1 means that strict Motif compliance has been requested, so anything that is not part of the Motif specification should be avoided. 0 means that "Motif-like" is good enough, and extra features are welcome.

This procedure uses a link to the Tcl variable to provide much faster access to the variable's value than could be had by calling **Tcl_GetVar**.
