---
CommandName: Tk_AllocColorFromObj
title: Tk_AllocColorFromObj
ManualSection: 3
Version: 8.1
TclPart: Tk
TclDescription: Tk Library Procedures
Keywords:
 - color
 - intensity
 - value
 - pixel value
Copyright:
 - Copyright (c) 1990-1991 The Regents of the University of California.
 - Copyright (c) 1994-1998 Sun Microsystems, Inc.
---

# Name

Tk\_AllocColorFromObj, Tk\_GetColor, Tk\_GetColorFromObj, Tk\_GetColorByValue, Tk\_NameOfColor, Tk\_FreeColorFromObj, Tk\_FreeColor - maintain database of colors

# Synopsis

::: {.synopsis} :::
**#include <tk.h>**
[XColor \*]{.ret} [Tk\_AllocColorFromObj]{.ccmd} [interp, tkwin, objPtr]{.cargs}
[XColor \*]{.ret} [Tk\_GetColor]{.ccmd} [interp, tkwin, name]{.cargs}
[XColor \*]{.ret} [Tk\_GetColorFromObj]{.ccmd} [tkwin, objPtr]{.cargs}
[XColor \*]{.ret} [Tk\_GetColorByValue]{.ccmd} [tkwin, prefPtr]{.cargs}
[const char \*]{.ret} [Tk\_NameOfColor]{.ccmd} [colorPtr]{.cargs}
[GC]{.ret} [Tk\_GCForColor]{.ccmd} [colorPtr, drawable]{.cargs}
[Tk\_FreeColorFromObj]{.ccmd} [tkwin, objPtr]{.cargs}
[Tk\_FreeColor]{.ccmd} [colorPtr]{.cargs}
:::

# Arguments

::: {.arguments} :::

[\*interp]{.carg .in type="Tcl_Interp"}
: Interpreter to use for error reporting.

[tkwin]{.carg .in type="Tk_Window"}
: Token for window in which color will be used.

[\*objPtr]{.carg .in/out type="Tcl_Obj"}
: String value describes desired color; internal rep will be modified to cache pointer to corresponding (XColor \*).

[\*name]{.carg .in type="const char"}
: Same as *objPtr* except description of color is passed as a string and resulting (XColor \*) is not cached.

[\*prefPtr]{.carg .in type="XColor"}
: Indicates red, green, and blue intensities of desired color.

[\*colorPtr]{.carg .in type="XColor"}
: Pointer to X color information.  Must have been allocated by previous call to **Tk\_AllocColorFromObj**, **Tk\_GetColor** or **Tk\_GetColorByValue**, except when passed to **Tk\_NameOfColor**.

[drawable]{.carg .in type="Drawable"}
: Drawable in which the result graphics context will be used.  Must have same screen and depth as the window for which the color was allocated.

:::

# Description

These procedures manage the colors being used by a Tk application. They allow colors to be shared whenever possible, so that colormap space is preserved, and they pick closest available colors when colormap space is exhausted.

Given a textual description of a color, **Tk\_AllocColorFromObj** locates a pixel value that may be used to render the color in a particular window.  The desired color is specified with a value whose string value must have one of the following forms:

*colorname*
: Any of the valid textual names for a color defined in the server's color database file, such as **red** or **PeachPuff**.

**#***RGB*
: see below ...

**#***RRGGBB*
: see below ...

**#***RRRGGGBBB*
: see below ...

**#***RRRRGGGGBBBB*
: A numeric specification of the red, green, and blue intensities to use to display the color.  Each *R*, *G*, or *B* represents a single hexadecimal digit.  The four forms permit colors to be specified with 4-bit, 8-bit, 12-bit or 16-bit values. When fewer than 16 bits are provided for each color, they represent the most significant bits of the color, while the lower unfilled bits will be repeatedly replicated from the available higher bits. For example, #3a7 is the same as #3333aaaa7777.


**Tk\_AllocColorFromObj** returns a pointer to an XColor structure;  the structure indicates the exact intensities of the allocated color (which may differ slightly from those requested, depending on the limitations of the screen) and a pixel value that may be used to draw with the color in *tkwin*. If an error occurs in **Tk\_AllocColorFromObj** (such as an unknown color name) then NULL is returned and an error message is stored in *interp*'s result if *interp* is not NULL. If the colormap for *tkwin* is full, **Tk\_AllocColorFromObj** will use the closest existing color in the colormap. **Tk\_AllocColorFromObj** caches information about the return value in *objPtr*, which speeds up future calls to procedures such as **Tk\_AllocColorFromObj** and **Tk\_GetColorFromObj**.

**Tk\_GetColor** is identical to **Tk\_AllocColorFromObj** except that the description of the color is specified with a string instead of a value.  This prevents **Tk\_GetColor** from caching the return value, so **Tk\_GetColor** is less efficient than **Tk\_AllocColorFromObj**.

**Tk\_GetColorFromObj** returns the token for an existing color, given the window and description used to create the color. **Tk\_GetColorFromObj** does not actually create the color; the color must already have been created with a previous call to **Tk\_AllocColorFromObj** or **Tk\_GetColor**.  The return value is cached in *objPtr*, which speeds up future calls to **Tk\_GetColorFromObj** with the same *objPtr* and *tkwin*.

**Tk\_GetColorByValue** is similar to **Tk\_GetColor** except that the desired color is indicated with the *red*, *green*, and *blue* fields of the structure pointed to by *colorPtr*.

This package maintains a database of all the colors currently in use. If the same color is requested multiple times from **Tk\_GetColor** or **Tk\_AllocColorFromObj** (e.g. by different windows), or if the same intensities are requested multiple times from **Tk\_GetColorByValue**, then existing pixel values will be re-used.  Re-using an existing pixel avoids any interaction with the window server, which makes the allocation much more efficient.  These procedures also provide a portable interface that works across all platforms.  For this reason, you should generally use **Tk\_AllocColorFromObj**, **Tk\_GetColor**, or **Tk\_GetColorByValue** instead of lower level procedures like **XAllocColor**.

Since different calls to this package may return the same shared pixel value, callers should never change the color of a pixel returned by the procedures. If you need to change a color value dynamically, you should use **XAllocColorCells** to allocate the pixel value for the color.

The procedure **Tk\_NameOfColor** is roughly the inverse of **Tk\_GetColor**.  If its *colorPtr* argument was created by **Tk\_AllocColorFromObj** or **Tk\_GetColor** then the return value is the string that was used to create the color.  If *colorPtr* was created by a call to **Tk\_GetColorByValue**, or by any other mechanism, then the return value is a string that could be passed to **Tk\_GetColor** to return the same color.  Note:  the string returned by **Tk\_NameOfColor** is only guaranteed to persist until the next call to **Tk\_NameOfColor**.

**Tk\_GCForColor** returns a graphics context whose **foreground** field is the pixel allocated for *colorPtr* and whose other fields all have default values. This provides an easy way to do basic drawing with a color. The graphics context is cached with the color and will exist only as long as *colorPtr* exists;  it is freed when the last reference to *colorPtr* is freed by calling **Tk\_FreeColor**.

When a color is no longer needed **Tk\_FreeColorFromObj** or **Tk\_FreeColor** should be called to release it. For **Tk\_FreeColorFromObj** the color to release is specified with the same information used to create it; for **Tk\_FreeColor** the color to release is specified with a pointer to its XColor structure. There should be exactly one call to **Tk\_FreeColorFromObj** or **Tk\_FreeColor** for each call to **Tk\_AllocColorFromObj**, **Tk\_GetColor**, or **Tk\_GetColorByValue**.
