---
CommandName: Tk_GetAnchorFromObj
title: Tk_GetAnchorFromObj
ManualSection: 3
Version: 8.1
TclPart: Tk
TclDescription: Tk Library Procedures
Keywords:
 - anchor position
Copyright:
 - Copyright (c) 1990 The Regents of the University of California.
 - Copyright (c) 1994-1998 Sun Microsystems, Inc.
---

# Name

Tk\_GetAnchorFromObj, Tk\_GetAnchor, Tk\_NameOfAnchor - translate between strings and anchor positions

# Synopsis

::: {.synopsis} :::
**#include <tk.h>**
int Tk\_GetAnchorFromObj(interp, objPtr, anchorPtr)
int Tk\_GetAnchor(interp, string, anchorPtr)
const char \* Tk\_NameOfAnchor(anchor)
:::

# Arguments

::: {.arguments} :::

[\*interp]{.carg .in type="Tcl_Interp"}
: Interpreter to use for error reporting, or NULL.

[\*objPtr]{.carg .in/out type="Tcl_Obj"}
: String value contains name of anchor point: "**n**", "**ne**", "**e**", "**se**", "**s**", "**sw**", "**w**", "**nw**", or "**center**"; internal rep will be modified to cache corresponding Tk\_Anchor. In the case of "**center**" on input, a non-empty abbreviation of it may also be used on input.

[\*string]{.carg .in type="const char"}
: Same as *objPtr* except description of anchor point is passed as a string.

[\*anchorPtr]{.carg .out type="int"}
: Pointer to location in which to store anchor position corresponding to *objPtr* or *string*.

[anchor]{.carg .in type="Tk_Anchor"}
: Anchor position, e.g. **TCL\_ANCHOR\_CENTER**.

:::

# Description

**Tk\_GetAnchorFromObj** places in *\*anchorPtr* an anchor position (enumerated type **Tk\_Anchor**) corresponding to *objPtr*'s value.  The result will be one of **TK\_ANCHOR\_N**, **TK\_ANCHOR\_NE**, **TK\_ANCHOR\_E**, **TK\_ANCHOR\_SE**, **TK\_ANCHOR\_S**, **TK\_ANCHOR\_SW**, **TK\_ANCHOR\_W**, **TK\_ANCHOR\_NW**, or **TK\_ANCHOR\_CENTER**. Anchor positions are typically used for indicating a point on an object that will be used to position the object, e.g. **TK\_ANCHOR\_N** means position the top center point of the object at a particular place.

Under normal circumstances the return value is [TCL\_OK][catch] and *interp* is unused. If *string* does not contain a valid anchor position or an abbreviation of one of these names, [TCL\_ERROR][catch] is returned, *\*anchorPtr* is unmodified, and an error message is stored in *interp*'s result if *interp* is not NULL. **Tk\_GetAnchorFromObj** caches information about the return value in *objPtr*, which speeds up future calls to **Tk\_GetAnchorFromObj** with the same *objPtr*.

**Tk\_GetAnchor** is identical to **Tk\_GetAnchorFromObj** except that the description of the anchor is specified with a string instead of an object.  This prevents **Tk\_GetAnchor** from caching the return value, so **Tk\_GetAnchor** is less efficient than **Tk\_GetAnchorFromObj**.

**Tk\_NameOfAnchor** is the logical inverse of **Tk\_GetAnchor**. Given an anchor position such as **TK\_ANCHOR\_N** it returns a statically-allocated string corresponding to *anchor*. If *anchor* is not a legal anchor value, then "unknown anchor position" is returned.


[catch]: ../tcl/catch.md
