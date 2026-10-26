---
CommandName: Tk_GetJoinStyle
title: Tk_GetJoinStyle
ManualSection: 3
Version: unknown
TclPart: Tk
TclDescription: Tk Library Procedures
Keywords:
 - bevel
 - join style
 - miter
 - round
Copyright:
 - Copyright (c) 1990 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

Tk\_GetJoinStyle, Tk\_NameOfJoinStyle - translate between strings and join styles

# Synopsis

::: {.synopsis} :::
**#include <tk.h>**
[int]{.ret} [Tk\_GetJoinStyle]{.ccmd} [interp, string, joinPtr]{.cargs}
[const char \*]{.ret} [Tk\_NameOfJoinStyle]{.ccmd} [join]{.cargs}
:::

# Arguments

::: {.arguments} :::

[\*interp]{.carg .in type="Tcl_Interp"}
: Interpreter to use for error reporting.

[\*string]{.carg .in type="const char"}
: String containing name of join style - one of "**bevel**", "**miter**", or "**round**" - or a unique abbreviation of one.

[\*joinPtr]{.carg .out type="int"}
: Pointer to location in which to store X join style corresponding to *string*.

[join]{.carg .in type="int"}
: Join style: one of **JoinBevel**, **JoinMiter**, **JoinRound**.

:::

# Description

**Tk\_GetJoinStyle** places in *\*joinPtr* the X join style corresponding to *string*, which will be one of **JoinBevel**, **JoinMiter**, or **JoinRound**. Join styles are typically used in X graphics contexts to indicate how adjacent line segments should be joined together. See the X documentation for information on what each style implies.

Under normal circumstances the return value is [TCL\_OK][catch] and *interp* is unused. If *string* does not contain a valid join style or an abbreviation of one of these names, then an error message is stored in interpreter *interp*'s result, [TCL\_ERROR][catch] is returned, and *\*joinPtr* is unmodified.

**Tk\_NameOfJoinStyle** is the logical inverse of **Tk\_GetJoinStyle**. Given a join style such as **JoinBevel** it returns a statically-allocated string corresponding to *join*. If *join* is not a legal join style, then "unknown join style" is returned.


[catch]: ../tcl/catch.md
