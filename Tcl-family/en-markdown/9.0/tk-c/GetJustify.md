---
CommandName: Tk_GetJustifyFromObj
title: Tk_GetJustifyFromObj
ManualSection: 3
Version: 8.1
TclPart: Tk
TclDescription: Tk Library Procedures
Keywords:
 - center
 - fill
 - justification
 - string
Copyright:
 - Copyright (c) 1990-1994 The Regents of the University of California.
 - Copyright (c) 1994-1998 Sun Microsystems, Inc.
---

# Name

Tk\_GetJustifyFromObj, Tk\_GetJustify, Tk\_NameOfJustify - translate between strings and justification styles

# Synopsis

::: {.synopsis} :::
**#include <tk.h>**
[int]{.ret} [Tk\_GetJustifyFromObj]{.ccmd} [interp, objPtr, justifyPtr]{.cargs}
[int]{.ret} [Tk\_GetJustify]{.ccmd} [interp, string, justifyPtr]{.cargs}
[const char \*]{.ret} [Tk\_NameOfJustify]{.ccmd} [justify]{.cargs}
:::

# Arguments

::: {.arguments} :::

[\*interp]{.carg .in type="Tcl_Interp"}
: Interpreter to use for error reporting, or NULL.

[\*objPtr]{.carg .in/out type="Tcl_Obj"}
: String value contains name of justification style - one of "**left**", "**right**", or "**center**" - or a unique abbreviation of one. The internal rep will be modified to cache corresponding justify value.

[\*string]{.carg .in type="const char"}
: Same as *objPtr* except description of justification style is passed as a string.

[\*justifyPtr]{.carg .out type="int"}
: Pointer to location in which to store justify value corresponding to *objPtr* or *string*.

[justify]{.carg .in type="Tk_Justify"}
: Justification style (one of the values listed below).

:::

# Description

**Tk\_GetJustifyFromObj** places in *\*justifyPtr* the justify value corresponding to *objPtr*'s value. This value will be one of the following:

**TK\_JUSTIFY\_LEFT**
: Means that the text on each line should start at the left edge of the line;  as a result, the right edges of lines may be ragged.

**TK\_JUSTIFY\_RIGHT**
: Means that the text on each line should end at the right edge of the line;  as a result, the left edges of lines may be ragged.

**TK\_JUSTIFY\_CENTER**
: Means that the text on each line should be centered;  as a result, both the left and right edges of lines may be ragged.


Under normal circumstances the return value is [TCL\_OK][catch] and *interp* is unused. If *objPtr* does not contain a valid justification style or an abbreviation of one of these names, [TCL\_ERROR][catch] is returned, *\*justifyPtr* is unmodified, and an error message is stored in *interp*'s result if *interp* is not NULL. **Tk\_GetJustifyFromObj** caches information about the return value in *objPtr*, which speeds up future calls to **Tk\_GetJustifyFromObj** with the same *objPtr*.

**Tk\_GetJustify** is identical to **Tk\_GetJustifyFromObj** except that the description of the justification is specified with a string instead of an object.  This prevents **Tk\_GetJustify** from caching the return value, so **Tk\_GetJustify** is less efficient than **Tk\_GetJustifyFromObj**.

**Tk\_NameOfJustify** is the logical inverse of **Tk\_GetJustify**. Given a justify value it returns a statically-allocated string corresponding to *justify*. If *justify* is not a legal justify value, then "unknown justification style" is returned.


[catch]: ../tcl/catch.md
