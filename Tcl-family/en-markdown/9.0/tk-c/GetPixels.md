---
CommandName: Tk_GetPixelsFromObj
title: Tk_GetPixelsFromObj
ManualSection: 3
Version: 8.1
TclPart: Tk
TclDescription: Tk Library Procedures
Keywords:
 - centimeters
 - convert
 - inches
 - millimeters
 - pixels
 - points
 - screen units
Copyright:
 - Copyright (c) 1990 The Regents of the University of California.
 - Copyright (c) 1994-1998 Sun Microsystems, Inc.
---

# Name

Tk\_GetPixelsFromObj, Tk\_GetPixels, Tk\_GetMMFromObj, Tk\_GetScreenMM, Tk\_GetDoublePixelsFromObj - translate between strings and screen units

# Synopsis

::: {.synopsis} :::
**#include <tk.h>**
[int]{.ret} [Tk\_GetPixelsFromObj]{.ccmd} [interp, tkwin, objPtr, intPtr]{.cargs}
[int]{.ret} [Tk\_GetDoublePixelsFromObj]{.ccmd} [interp, tkwin, objPtr, doublePtr]{.cargs}
[int]{.ret} [Tk\_GetPixels]{.ccmd} [interp, tkwin, string, intPtr]{.cargs}
[int]{.ret} [Tk\_GetMMFromObj]{.ccmd} [interp, tkwin, objPtr, doublePtr]{.cargs}
[int]{.ret} [Tk\_GetScreenMM]{.ccmd} [interp, tkwin, string, doublePtr]{.cargs}
:::

# Arguments

::: {.arguments} :::

[\*interp]{.carg .in type="Tcl_Interp"}
: Interpreter to use for error reporting.

[tkwin]{.carg .in type="Tk_Window"}
: Window whose screen geometry determines the conversion between absolute units and pixels.

[\*objPtr]{.carg .in/out type="Tcl_Obj"}
: String value specifies a distance on the screen; internal rep will be modified to cache converted distance.

[\*string]{.carg .in type="const char"}
: Same as *objPtr* except specification of distance is passed as a string.

[\*intPtr]{.carg .out type="int"}
: Pointer to location in which to store converted distance in pixels.

[\*doublePtr]{.carg .out type="double"}
: Pointer to location in which to store converted distance in millimeters.

:::

# Description

These procedures take as argument a specification of distance on the screen (*objPtr* or *string*) and compute the corresponding distance either in integer pixels or floating-point millimeters. In either case, *objPtr* or *string* specifies a screen distance as a floating-point number followed by one of the following characters that indicates units:

<none>
: The number specifies a distance in pixels.

**c**
: The number specifies a distance in centimeters on the screen.

**i**
: The number specifies a distance in inches on the screen.

**m**
: The number specifies a distance in millimeters on the screen.

**p**
: The number specifies a distance in printer's points (1/72 inch) on the screen.


**Tk\_GetPixelsFromObj** converts the value of *objPtr* to the nearest even number of pixels and stores that value at *\*intPtr*. It returns [TCL\_OK][catch] under normal circumstances. If an error occurs (e.g. *objPtr* contains a number followed by a character that is not one of the ones above) then [TCL\_ERROR][catch] is returned and an error message is left in *interp*'s result if *interp* is not NULL. **Tk\_GetPixelsFromObj** caches information about the return value in *objPtr*, which speeds up future calls to **Tk\_GetPixelsFromObj** with the same *objPtr*.

**Tk\_GetDoublePixelsFromObj** is identical to **Tk\_GetPixelsFromObj** except it returns a double not rounded to the nearest integer.

**Tk\_GetPixels** is identical to **Tk\_GetPixelsFromObj** except that the screen distance is specified with a string instead of an object.  This prevents **Tk\_GetPixels** from caching the return value, so **Tk\_GetPixels** is less efficient than **Tk\_GetPixelsFromObj**.

**Tk\_GetMMFromObj** and **Tk\_GetScreenMM** are similar to **Tk\_GetPixelsFromObj** and **Tk\_GetPixels** (respectively) except that they convert the screen distance to millimeters and store a double-precision floating-point result at *\*doublePtr*.


[catch]: ../tcl/catch.md
