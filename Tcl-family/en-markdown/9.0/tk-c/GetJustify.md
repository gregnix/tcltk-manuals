---
CommandName: Tk_GetJustifyFromObj
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

Tk_GetJustifyFromObj, Tk_GetJustify, Tk_NameOfJustify - translate between strings and justification styles

# Synopsis

::: {.synopsis} :::
[#include]{.cmd} [\<tk.h>]{.lit}

int
[Tk_GetJustifyFromObj]{.cmd}([interp]{.arg}, [objPtr]{.arg}, [justifyPtr]{.arg})

int
[Tk_GetJustify]{.cmd}([interp]{.arg}, [string]{.arg}, [justifyPtr]{.arg})

const char \*
[Tk_NameOfJustify]{.cmd}([justify]{.arg})
:::

# Arguments

Tcl_Interp *\*interp* (in)
: Interpreter to use for error reporting, or NULL.

Tcl_Obj *\*objPtr* (in/out)
: String value contains name of justification style - one of "**left**", "**right**", or "**center**" - or a unique abbreviation of one. The internal rep will be modified to cache corresponding justify value.

const char *\*string* (in)
: Same as *objPtr* except description of justification style is passed as a string.

int *\*justifyPtr* (out)
: Pointer to location in which to store justify value corresponding to *objPtr* or *string*.

Tk_Justify *justify* (in)
: Justification style (one of the values listed below).


# Description

**Tk_GetJustifyFromObj** places in *\*justifyPtr* the justify value corresponding to *objPtr*'s value. This value will be one of the following:

**TK_JUSTIFY_LEFT**
: Means that the text on each line should start at the left edge of the line;  as a result, the right edges of lines may be ragged.

**TK_JUSTIFY_RIGHT**
: Means that the text on each line should end at the right edge of the line;  as a result, the left edges of lines may be ragged.

**TK_JUSTIFY_CENTER**
: Means that the text on each line should be centered;  as a result, both the left and right edges of lines may be ragged. Under normal circumstances the return value is **TCL_OK** and *interp* is unused. If *objPtr* does not contain a valid justification style or an abbreviation of one of these names, **TCL_ERROR** is returned, *\*justifyPtr* is unmodified, and an error message is stored in *interp*'s result if *interp* is not NULL. **Tk_GetJustifyFromObj** caches information about the return value in *objPtr*, which speeds up future calls to **Tk_GetJustifyFromObj** with the same *objPtr*. **Tk_GetJustify** is identical to **Tk_GetJustifyFromObj** except that the description of the justification is specified with a string instead of an object.  This prevents **Tk_GetJustify** from caching the return value, so **Tk_GetJustify** is less efficient than **Tk_GetJustifyFromObj**. **Tk_NameOfJustify** is the logical inverse of **Tk_GetJustify**. Given a justify value it returns a statically-allocated string corresponding to *justify*. If *justify* is not a legal justify value, then "unknown justification style" is returned.
