---
CommandName: Tk_GetCapStyle
title: Tk_GetCapStyle
ManualSection: 3
Version: unknown
TclPart: Tk
TclDescription: Tk Library Procedures
Keywords:
 - butt
 - cap style
 - projecting
 - round
Copyright:
 - Copyright (c) 1990 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

Tk\_GetCapStyle, Tk\_NameOfCapStyle - translate between strings and cap styles

# Synopsis

::: {.synopsis} :::
**#include <tk.h>**
int Tk\_GetCapStyle(interp, string, capPtr)
const char \* Tk\_NameOfCapStyle(cap)
:::

# Arguments

::: {.arguments} :::

[\*interp]{.carg .in type="Tcl_Interp"}
: Interpreter to use for error reporting.

[\*string]{.carg .in type="const char"}
: String containing name of cap style - one of "**butt**", "**projecting**", or "**round**" - or a unique abbreviation of one.

[\*capPtr]{.carg .out type="int"}
: Pointer to location in which to store X cap style corresponding to *string*.

[cap]{.carg .in type="int"}
: Cap style: one of **CapButt**, **CapProjecting**, or **CapRound**.

:::

# Description

**Tk\_GetCapStyle** places in *\*capPtr* the X cap style corresponding to *string*. This will be one of the values **CapButt**, **CapProjecting**, or **CapRound**. Cap styles are typically used in X graphics contexts to indicate how the end-points of lines should be capped. See the X documentation for information on what each style implies.

Under normal circumstances the return value is [TCL\_OK][catch] and *interp* is unused. If *string* does not contain a valid cap style or an abbreviation of one of these names, then an error message is stored in interpreter *interp*'s result, [TCL\_ERROR][catch] is returned, and *\*capPtr* is unmodified.

**Tk\_NameOfCapStyle** is the logical inverse of **Tk\_GetCapStyle**. Given a cap style such as **CapButt** it returns a statically-allocated string corresponding to *cap*. If *cap* is not a legal cap style, then "unknown cap style" is returned.


[catch]: ../tcl/catch.md
