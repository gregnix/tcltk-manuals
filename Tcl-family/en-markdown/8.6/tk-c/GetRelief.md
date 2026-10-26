---
CommandName: Tk_GetReliefFromObj
title: Tk_GetReliefFromObj
ManualSection: 3
Version: 8.1
TclPart: Tk
TclDescription: Tk Library Procedures
Keywords:
 - name
 - relief
 - string
Copyright:
 - Copyright (c) 1990 The Regents of the University of California.
 - Copyright (c) 1994-1998 Sun Microsystems, Inc.
---

# Name

Tk\_GetReliefFromObj, Tk\_GetRelief, Tk\_NameOfRelief - translate between strings and relief values

# Synopsis

::: {.synopsis} :::
**#include <tk.h>**
[int]{.ret} [Tk\_GetReliefFromObj]{.ccmd} [interp, objPtr, reliefPtr]{.cargs}
[int]{.ret} [Tk\_GetRelief]{.ccmd} [interp, name, reliefPtr]{.cargs}
[const char \*]{.ret} [Tk\_NameOfRelief]{.ccmd} [relief]{.cargs}
:::

# Arguments

::: {.arguments} :::

[\*interp]{.carg .in type="Tcl_Interp"}
: Interpreter to use for error reporting.

[\*objPtr]{.carg .in/out type="Tcl_Obj"}
: String value contains name of relief, one of "**flat**", "**groove**", "**raised**", "**ridge**", "**solid**", or "**sunken**" (or any unique abbreviation thereof on input); the internal rep will be modified to cache corresponding relief value.

[\*name]{.carg .in type="const char"}
: Same as *objPtr* except description of relief is passed as a string.

[\*reliefPtr]{.carg .out type="int"}
: Pointer to location in which to store relief value corresponding to *objPtr* or *name*.

[relief]{.carg .in type="int"}
: Relief value (one of **TK\_RELIEF\_FLAT**, **TK\_RELIEF\_RAISED**, **TK\_RELIEF\_SUNKEN**, **TK\_RELIEF\_GROOVE**, **TK\_RELIEF\_SOLID**, or **TK\_RELIEF\_RIDGE**).

:::

# Description

**Tk\_GetReliefFromObj** places in *\*reliefPtr* the relief value corresponding to the value of *objPtr*.  This value will be one of **TK\_RELIEF\_FLAT**, **TK\_RELIEF\_RAISED**, **TK\_RELIEF\_SUNKEN**, **TK\_RELIEF\_GROOVE**, **TK\_RELIEF\_SOLID**, or **TK\_RELIEF\_RIDGE**. Under normal circumstances the return value is [TCL\_OK][catch] and *interp* is unused. If *objPtr* does not contain one of the valid relief names or an abbreviation of one of them, then [TCL\_ERROR][catch] is returned, *\*reliefPtr* is unmodified, and an error message is stored in *interp*'s result if *interp* is not NULL. **Tk\_GetReliefFromObj** caches information about the return value in *objPtr*, which speeds up future calls to **Tk\_GetReliefFromObj** with the same *objPtr*.

**Tk\_GetRelief** is identical to **Tk\_GetReliefFromObj** except that the description of the relief is specified with a string instead of an object.  This prevents **Tk\_GetRelief** from caching the return value, so **Tk\_GetRelief** is less efficient than **Tk\_GetReliefFromObj**.

**Tk\_NameOfRelief** is the logical inverse of **Tk\_GetRelief**. Given a relief value it returns the corresponding string (**flat**, **raised**, **sunken**, **groove**, **solid**, or **ridge**). If *relief* is not a legal relief value, then "unknown relief" is returned.


[catch]: ../tcl/catch.md
