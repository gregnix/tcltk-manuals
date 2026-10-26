---
CommandName: Geometry
title: Geometry
ManualSection: 3
Version: 8.5
TclPart: Tk
TclDescription: Tk Themed Widget
Links:
 - Tk_GetReliefFromObj(3)
 - Tk_GetPixelsFromObj(3)
 - Tk_GetAnchorFromObj(3)
Keywords:
 - geometry
 - padding
 - margins
 - box
 - region
 - sticky
 - relief
Copyright:
 - Copyright (c) 2004 Joe English
---

# Name

Ttk\_MakeBox, Ttk\_PadBox, Ttk\_ExpandBox, Ttk\_PackBox, Ttk\_StickBox, Ttk\_PlaceBox, Ttk\_BoxContains, Ttk\_MakePadding, Ttk\_UniformPadding, Ttk\_AddPadding, Ttk\_RelievePadding, Ttk\_GetPaddingFromObj, Ttk\_GetBorderFromObj, Ttk\_GetStickyFromObj - Tk themed geometry utilities

# Synopsis

::: {.synopsis} :::
**#include <tkTheme.h>**

[Ttk\_Box]{.ret} [Ttk\_MakeBox]{.ccmd} [int x, int y, int width, int height]{.cargs}

[Ttk\_Box]{.ret} [Ttk\_PadBox]{.ccmd} [Ttk\_Box parcel, Ttk\_Padding padding]{.cargs}

[Ttk\_Box]{.ret} [Ttk\_ExpandBox]{.ccmd} [Ttk\_Box parcel, Ttk\_Padding padding]{.cargs}

[Ttk\_Box]{.ret} [Ttk\_PackBox]{.ccmd} [Ttk\_Box \*cavity, int width, int height, Ttk\_Side side]{.cargs}

[Ttk\_Box]{.ret} [Ttk\_StickBox]{.ccmd} [Ttk\_Box parcel, int width, int height, unsigned sticky]{.cargs}

[Ttk\_Box]{.ret} [Ttk\_PlaceBox]{.ccmd} [Ttk\_Box \*cavity, int width, int height, Ttk\_Side side, unsigned sticky]{.cargs}

[Ttk\_Box]{.ret} [Ttk\_AnchorBox]{.ccmd} [Ttk\_Box parcel, int width, int height, Tk\_Anchor anchor]{.cargs}

[Ttk\_Padding]{.ret} [Ttk\_MakePadding]{.ccmd} [short left, short top, short right, short bottom]{.cargs}

[Ttk\_Padding]{.ret} [Ttk\_UniformPadding]{.ccmd} [short border]{.cargs}

Ttk\_Padding Ttk\_AddPadding(Ttk\_Padding padding1, Ttk\_Padding padding2;

[Ttk\_Padding]{.ret} [Ttk\_RelievePadding]{.ccmd} [Ttk\_Padding padding, int relief]{.cargs}

[int]{.ret} [Ttk\_BoxContains]{.ccmd} [Ttk\_Box box, int x, int y]{.cargs}

[int]{.ret} [Ttk\_GetPaddingFromObj]{.ccmd} [Tcl\_Interp \*interp, Tk\_Window tkwin, Tcl\_Obj \*objPtr, Ttk\_Padding \*padding\_rtn]{.cargs}

[int]{.ret} [Ttk\_GetBorderFromObj]{.ccmd} [Tcl\_Interp \*interp, Tcl\_Obj \*objPtr, Ttk\_Padding \*padding\_rtn]{.cargs}

[int]{.ret} [Ttk\_GetStickyFromObj]{.ccmd} [Tcl\_Interp \*interp, Tcl\_Obj \*objPtr, int \*sticky\_rtn]{.cargs}
:::

# Arguments

::: {.arguments} :::

[anchor]{.carg .in type="Tk_Anchor"}
: One of the symbolic constants **TK\_ANCHOR\_N**, **TK\_ANCHOR\_NE**, etc.  See *[Tk\_GetAnchorFromObj][GetAnchor](3)*.

[cavity]{.carg .in/out type="Ttk_Box *"}
: A rectangular region from which a parcel is allocated.

[border]{.carg .in type="short"}
: Extra padding (in pixels) to add uniformly to each side of a region.

[bottom]{.carg .in type="short"}
: Extra padding (in pixels) to add to the bottom of a region.

[box]{.carg .in type="Ttk_Box"}
: Specifies a rectangular region.

[box\_rtn]{.carg .out type="Ttk_Box *"}
: A rectangular region.

[height]{.carg .in type="int"}
: The height in pixels of a region.

[interp]{.carg .in type="Tcl_Interp *"}
: Used to store error messages.

[left]{.carg .in type="int"}
: Extra padding (in pixels) to add to the left side of a region.

[objPtr]{.carg .in type="Tcl_Obj *"}
: String value contains a symbolic name to be converted to an enumerated value or bitmask. Internal rep may be be modified to cache corresponding value.

[padding]{.carg .in type="Ttk_Padding"}
: Extra padding to add on the inside of a region.

[padding\_rtn]{.carg .out type="Ttk_Padding *"}
: Padding present in the inside of a region.

[parcel]{.carg .in type="Ttk_Box"}
: A rectangular region, allocated from a cavity.

[relief]{.carg .in type="int"}
: One of the standard Tk relief options (**TK\_RELIEF\_RAISED**, **TK\_RELIEF\_SUNKEN**, etc.). See [Tk\_GetReliefFromObj][GetRelief].

[right]{.carg .in type="short"}
: Extra padding (in pixels) to add to the right side of a region.

[side]{.carg .in type="Ttk_Side"}
: One of **TTK\_SIDE\_LEFT**, **TTK\_SIDE\_TOP**, **TTK\_SIDE\_RIGHT**, or **TTK\_SIDE\_BOTTOM**.

[sticky]{.carg .in type="unsigned"}
: A bitmask containing one or more of the bits **TTK\_STICK\_W** (west, or left), **TTK\_STICK\_E** (east, or right), **TTK\_STICK\_N** (north, or top), and **TTK\_STICK\_S** (south, or bottom). **TTK\_FILL\_X** is defined as a synonym for (**TTK\_STICK\_W**|**TTK\_STICK\_E**), **TTK\_FILL\_Y** is a synonym for (**TTK\_STICK\_N**|**TTK\_STICK\_S**), and  **TTK\_FILL\_BOTH** is a synonym for (**TTK\_FILL\_X**|**TTK\_FILL\_Y**). See also: *grid(n)*.

[tkwin]{.carg .in type="Tk_Window"}
: Window whose screen geometry determines the conversion between absolute units and pixels.

[top]{.carg .in type="short"}
: Extra padding at the top of a region.

[width]{.carg .in type="int"}
: The width in pixels of a region.

[x]{.carg .in type="int"}
: X coordinate of upper-left corner of region.

[y]{.carg .in type="int"}
: Y coordinate of upper-left corner of region.

:::

# Boxes

The **Ttk\_Box** structure represents a rectangular region of a window:

```
typedef struct {
    int x;
    int y;
    int width;
    int height;
} Ttk_Box;
```

All coordinates are relative to the window.

**Ttk\_MakeBox** is a convenience routine that constructs a **Ttk\_Box** structure representing a region *width* pixels wide, *height* pixels tall, at the specified *x, y* coordinates.

**Ttk\_PadBox** returns a new box located inside the specified *parcel*, shrunken according to the left, top, right, and bottom margins specified by *padding*.

**Ttk\_ExpandBox** is the inverse of **Ttk\_PadBox**: it returns a new box surrounding the specified *parcel*, expanded  according to the left, top, right, and bottom margins specified by *padding*.

**Ttk\_PackBox** allocates a parcel *width* by *height* pixels wide on the specified *side* of the *cavity*, and shrinks the *cavity* accordingly.

**Ttk\_StickBox** places a box with the requested *width* and *height* inside the *parcel* according to the *sticky* bits.

**Ttk\_PlaceBox** combines **Ttk\_PackBox** and **Ttk\_StickBox**: it allocates a parcel on the specified *side* of the *cavity*, places a box of the requested size inside the parcel according to *sticky*, and shrinks the *cavity*.

**Ttk\_AnchorBox** places a box with the requested *width* and *height* inside the *parcel* according to the specified *anchor* option.

**Ttk\_BoxContains** tests if the specified *x, y* coordinate lies within the rectangular region *box*.

# Paddding

The **Ttk\_Padding** structure is used to represent borders, internal padding, and external margins:

```
typedef struct {
    short left;
    short top;
    short right;
    short bottom;
} Ttk_Padding;
```

**Ttk\_MakePadding** is a convenience routine that constructs a **Ttk\_Padding** structure with the specified left, top, right, and bottom components.

**Ttk\_UniformPadding** constructs a **Ttk\_Padding** structure with all components equal to the specified *border*.

**Ttk\_AddPadding** adds two **Ttk\_Padding**s together and returns a combined padding containing the sum of the individual padding components.

**Ttk\_RelievePadding** adds an extra 2 pixels of padding to *padding* according to the specified *relief*. If *relief* is **TK\_RELIEF\_SUNKEN**, adds two pixels at the top and left so the inner region is shifted down and to the left. If it is **TK\_RELIEF\_RAISED**, adds two pixels at the bottom and right so the inner region is shifted up and to the right. Otherwise, adds 1 pixel on all sides. This is typically used in element geometry procedures to simulate a "pressed-in" look for pushbuttons.

# Conversion routines

**Ttk\_GetPaddingFromObj** converts the string in *objPtr* to a **Ttk\_Padding** structure. The string representation is a list of up to four length specifications "*left top right bottom*". If fewer than four elements are specified, *bottom* defaults to *top*, *right* defaults to *left*, and *top* defaults to *left*. See **[Tk\_GetPixelsFromObj][GetPixels](3)** for the syntax of length specifications.

**Ttk\_GetBorderFromObj** is the same as **Ttk\_GetPaddingFromObj** except that the lengths are specified as integers (i.e., resolution-dependent values like *3m* are not allowed).

**Ttk\_GetStickyFromObj** converts the string in *objPtr* to a *sticky* bitmask.  The string contains zero or more of the characters **n**, **s**, **e**, or **w**.


[GetAnchor]: GetAnchor.md
[GetPixels]: GetPixels.md
[GetRelief]: GetRelief.md
