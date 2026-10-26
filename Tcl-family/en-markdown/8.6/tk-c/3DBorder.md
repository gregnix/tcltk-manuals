---
CommandName: Tk_Alloc3DBorderFromObj
title: Tk_Alloc3DBorderFromObj
ManualSection: 3
Version: 8.1
TclPart: Tk
TclDescription: Tk Library Procedures
Keywords:
 - 3D
 - background
 - border
 - color
 - depressed
 - illumination
 - value
 - polygon
 - raised
 - shadow
 - three-dimensional effect
Copyright:
 - Copyright (c) 1990-1993 The Regents of the University of California.
 - Copyright (c) 1994-1998 Sun Microsystems, Inc.
---

# Name

Tk\_Alloc3DBorderFromObj, Tk\_Get3DBorder, Tk\_Get3DBorderFromObj, Tk\_Draw3DRectangle, Tk\_Fill3DRectangle, Tk\_Draw3DPolygon, Tk\_Fill3DPolygon, Tk\_3DVerticalBevel, Tk\_3DHorizontalBevel, Tk\_SetBackgroundFromBorder, Tk\_NameOf3DBorder, Tk\_3DBorderColor, Tk\_3DBorderGC, Tk\_Free3DBorderFromObj, Tk\_Free3DBorder - draw borders with three-dimensional appearance

# Synopsis

::: {.synopsis} :::
**#include <tk.h>**

[Tk\_3DBorder]{.ret} [Tk\_Alloc3DBorderFromObj]{.ccmd} [interp, tkwin, objPtr]{.cargs}
[Tk\_3DBorder]{.ret} [Tk\_Get3DBorder]{.ccmd} [interp, tkwin, colorName]{.cargs}
[Tk\_3DBorder]{.ret} [Tk\_Get3DBorderFromObj]{.ccmd} [tkwin, objPtr]{.cargs}
[Tk\_Draw3DRectangle]{.ccmd} [tkwin, drawable, border, x, y, width, height, borderWidth, relief]{.cargs}
[Tk\_Fill3DRectangle]{.ccmd} [tkwin, drawable, border, x, y, width, height, borderWidth, relief]{.cargs}
[Tk\_Draw3DPolygon]{.ccmd} [tkwin, drawable, border, pointPtr, numPoints, polyBorderWidth, leftRelief]{.cargs}
[Tk\_Fill3DPolygon]{.ccmd} [tkwin, drawable, border, pointPtr, numPoints, polyBorderWidth, leftRelief]{.cargs}
[Tk\_3DVerticalBevel]{.ccmd} [tkwin, drawable, border, x, y, width, height, leftBevel, relief]{.cargs}
[Tk\_3DHorizontalBevel]{.ccmd} [tkwin, drawable, border, x, y, width, height, leftIn, rightIn, topBevel, relief]{.cargs}
[Tk\_SetBackgroundFromBorder]{.ccmd} [tkwin, border]{.cargs}
[const char \*]{.ret} [Tk\_NameOf3DBorder]{.ccmd} [border]{.cargs}
[XColor \*]{.ret} [Tk\_3DBorderColor]{.ccmd} [border]{.cargs}
[GC \*]{.ret} [Tk\_3DBorderGC]{.ccmd} [tkwin, border, which]{.cargs}
[Tk\_Free3DBorderFromObj]{.ccmd} [tkwin, objPtr]{.cargs}
[Tk\_Free3DBorder]{.ccmd} [border]{.cargs}
:::

# Arguments

::: {.arguments} :::

[\*interp]{.carg .in type="Tcl_Interp"}
: Interpreter to use for error reporting.

[tkwin]{.carg .in type="Tk_Window"}
: Token for window (for all procedures except **Tk\_Get3DBorder**, must be the window for which the border was allocated).

[\*objPtr]{.carg .in type="Tcl_Obj"}
: Pointer to value whose value describes color corresponding to background (flat areas).  Illuminated edges will be brighter than this and shadowed edges will be darker than this.

[\*colorName]{.carg .in type="const char"}
: Same as *objPtr* except value is supplied as a string rather than a value.

[drawable]{.carg .in type="Drawable"}
: X token for window or pixmap;  indicates where graphics are to be drawn. Must either be the X window for *tkwin* or a pixmap with the same screen and depth as *tkwin*.

[border]{.carg .in type="Tk_3DBorder"}
: Token for border previously allocated in call to **Tk\_Get3DBorder**.

[x]{.carg .in type="int"}
: X-coordinate of upper-left corner of rectangle describing border or bevel, in pixels.

[y]{.carg .in type="int"}
: Y-coordinate of upper-left corner of rectangle describing border or bevel, in pixels.

[width]{.carg .in type="int"}
: Width of rectangle describing border or bevel, in pixels.

[height]{.carg .in type="int"}
: Height of rectangle describing border or bevel, in pixels.

[borderWidth]{.carg .in type="int"}
: Width of border in pixels. Positive means border is inside rectangle given by *x*, *y*, *width*, *height*, negative means border is outside rectangle.

[relief]{.carg .in type="int"}
: Indicates 3-D position of interior of value relative to exterior; should be **TK\_RELIEF\_RAISED**, **TK\_RELIEF\_SUNKEN**, **TK\_RELIEF\_GROOVE**, **TK\_RELIEF\_SOLID**, or **TK\_RELIEF\_RIDGE** (may also be **TK\_RELIEF\_FLAT** for **Tk\_Fill3DRectangle**).

[\*pointPtr]{.carg .in type="XPoint"}
: Pointer to array of points describing the set of vertices in a polygon. The polygon need not be closed (it will be closed automatically if it is not).

[numPoints]{.carg .in type="int"}
: Number of points at *\*pointPtr*.

[polyBorderWidth]{.carg .in type="int"}
: Width of border in pixels.  If positive, border is drawn to left of trajectory given by *pointPtr*;  if negative, border is drawn to right of trajectory.  If *leftRelief* is **TK\_RELIEF\_GROOVE** or **TK\_RELIEF\_RIDGE** then the border is centered on the trajectory.

[leftRelief]{.carg .in type="int"}
: Height of left side of polygon's path relative to right.  **TK\_RELIEF\_RAISED** means left side should appear higher and **TK\_RELIEF\_SUNKEN** means right side should appear higher; **TK\_RELIEF\_GROOVE** and **TK\_RELIEF\_RIDGE** mean the obvious things. For **Tk\_Fill3DPolygon**, **TK\_RELIEF\_FLAT** may also be specified to indicate no difference in height.

[leftBevel]{.carg .in type="int"}
: Non-zero means this bevel forms the left side of the value;  zero means it forms the right side.

[leftIn]{.carg .in type="int"}
: Non-zero means that the left edge of the horizontal bevel angles in, so that the bottom of the edge is farther to the right than the top. Zero means the edge angles out, so that the bottom is farther to the left than the top.

[rightIn]{.carg .in type="int"}
: Non-zero means that the right edge of the horizontal bevel angles in, so that the bottom of the edge is farther to the left than the top. Zero means the edge angles out, so that the bottom is farther to the right than the top.

[topBevel]{.carg .in type="int"}
: Non-zero means this bevel forms the top side of the value;  zero means it forms the bottom side.

[which]{.carg .in type="int"}
: Specifies which of the border's graphics contexts is desired. Must be **TK\_3D\_FLAT\_GC**, **TK\_3D\_LIGHT\_GC**, or **TK\_3D\_DARK\_GC**.

:::

# Description

These procedures provide facilities for drawing window borders in a way that produces a three-dimensional appearance. **Tk\_Alloc3DBorderFromObj** allocates colors and Pixmaps needed to draw a border in the window given by the *tkwin* argument.  The value of *objPtr* is a standard Tk color name that determines the border colors. The color indicated by *objPtr* will not actually be used in the border;  it indicates the background color for the window (i.e. a color for flat surfaces). The illuminated portions of the border will appear brighter than indicated by *objPtr*, and the shadowed portions of the border will appear darker than *objPtr*.

**Tk\_Alloc3DBorderFromObj** returns a token that may be used in later calls to **Tk\_Draw3DRectangle**.  If an error occurs in allocating information for the border (e.g. a bogus color name was given) then NULL is returned and an error message is left as the result of interpreter *interp*. If it returns successfully, **Tk\_Alloc3DBorderFromObj** caches information about the return value in *objPtr*, which speeds up future calls to **Tk\_Alloc3DBorderFromObj** with the same *objPtr* and *tkwin*.

**Tk\_Get3DBorder** is identical to **Tk\_Alloc3DBorderFromObj** except that the color is specified with a string instead of a value.  This prevents **Tk\_Get3DBorder** from caching the return value, so **Tk\_Get3DBorder** is less efficient than **Tk\_Alloc3DBorderFromObj**.

**Tk\_Get3DBorderFromObj** returns the token for an existing border, given the window and color name used to create the border. **Tk\_Get3DBorderFromObj** does not actually create the border; it must already have been created with a previous call to **Tk\_Alloc3DBorderFromObj** or **Tk\_Get3DBorder**.  The return value is cached in *objPtr*, which speeds up future calls to **Tk\_Get3DBorderFromObj** with the same *objPtr* and *tkwin*.

Once a border structure has been created, **Tk\_Draw3DRectangle** may be invoked to draw the border. The *tkwin* argument specifies the window for which the border was allocated, and *drawable* specifies a window or pixmap in which the border is to be drawn. *Drawable* need not refer to the same window as *tkwin*, but it must refer to a compatible pixmap or window:  one associated with the same screen and with the same depth as *tkwin*. The *x*, *y*, *width*, and *height* arguments define the bounding box of the border region within *drawable* (usually *x* and *y* are zero and *width* and *height* are the dimensions of the window), and *borderWidth* specifies the number of pixels actually occupied by the border.  The *relief* argument indicates which of several three-dimensional effects is desired: **TK\_RELIEF\_RAISED** means that the interior of the rectangle should appear raised relative to the exterior of the rectangle, and **TK\_RELIEF\_SUNKEN** means that the interior should appear depressed. **TK\_RELIEF\_GROOVE** and **TK\_RELIEF\_RIDGE** mean that there should appear to be a groove or ridge around the exterior of the rectangle.

**Tk\_Fill3DRectangle** is somewhat like **Tk\_Draw3DRectangle** except that it first fills the rectangular area with the background color (one corresponding to the color used to create *border*).  Then it calls **Tk\_Draw3DRectangle** to draw a border just inside the outer edge of the rectangular area.  The argument *relief* indicates the desired effect (**TK\_RELIEF\_FLAT** means no border should be drawn; all that happens is to fill the rectangle with the background color).

The procedure **Tk\_Draw3DPolygon** may be used to draw more complex shapes with a three-dimensional appearance.  The *pointPtr* and *numPoints* arguments define a trajectory, *polyBorderWidth* indicates how wide the border should be (and on which side of the trajectory to draw it), and *leftRelief* indicates which side of the trajectory should appear raised.  **Tk\_Draw3DPolygon** draws a border around the given trajectory using the colors from *border* to produce a three-dimensional appearance.  If the trajectory is non-self-intersecting, the appearance will be a raised or sunken polygon shape.  The trajectory may be self-intersecting, although it's not clear how useful this is.

**Tk\_Fill3DPolygon** is to **Tk\_Draw3DPolygon** what **Tk\_Fill3DRectangle** is to **Tk\_Draw3DRectangle**:  it fills the polygonal area with the background color from *border*, then calls **Tk\_Draw3DPolygon** to draw a border around the area (unless *leftRelief* is **TK\_RELIEF\_FLAT**; in this case no border is drawn).

The procedures **Tk\_3DVerticalBevel** and **Tk\_3DHorizontalBevel** provide lower-level drawing primitives that are used by procedures such as **Tk\_Draw3DRectangle**. These procedures are also useful in their own right for drawing rectilinear border shapes. **Tk\_3DVerticalBevel** draws a vertical beveled edge, such as the left or right side of a rectangle, and **Tk\_3DHorizontalBevel** draws a horizontal beveled edge, such as the top or bottom of a rectangle. Each procedure takes *x*, *y*, *width*, and *height* arguments that describe the rectangular area of the beveled edge (e.g., *width* is the border width for **Tk\_3DVerticalBevel**). The *leftBorder* and *topBorder* arguments indicate the position of the border relative to the "inside" of the value, and *relief* indicates the relief of the inside of the value relative to the outside. **Tk\_3DVerticalBevel** just draws a rectangular region. **Tk\_3DHorizontalBevel** draws a trapezoidal region to generate mitered corners;  it should be called after **Tk\_3DVerticalBevel** (otherwise **Tk\_3DVerticalBevel** will overwrite the mitering in the corner). The *leftIn* and *rightIn* arguments to **Tk\_3DHorizontalBevel** describe the mitering at the corners;  a value of 1 means that the bottom edge of the trapezoid will be shorter than the top, 0 means it will be longer. For example, to draw a rectangular border the top bevel should be drawn with 1 for both *leftIn* and *rightIn*, and the bottom bevel should be drawn with 0 for both arguments.

The procedure **Tk\_SetBackgroundFromBorder** will modify the background pixel and/or pixmap of *tkwin* to produce a result compatible with *border*.  For color displays, the resulting background will just be the color specified when *border* was created;  for monochrome displays, the resulting background will be a light stipple pattern, in order to distinguish the background from the illuminated portion of the border.

Given a token for a border, the procedure **Tk\_NameOf3DBorder** will return the color name that was used to create the border.

The procedure **Tk\_3DBorderColor** returns the XColor structure that will be used for flat surfaces drawn for its *border* argument by procedures like **Tk\_Fill3DRectangle**. The return value corresponds to the color name that was used to create the border. The XColor, and its associated pixel value, will remain allocated as long as *border* exists.

The procedure **Tk\_3DBorderGC** returns one of the X graphics contexts that are used to draw the border. The argument *which* selects which one of the three possible GC's: **TK\_3D\_FLAT\_GC** returns the context used for flat surfaces, **TK\_3D\_LIGHT\_GC** returns the context for light shadows, and **TK\_3D\_DARK\_GC** returns the context for dark shadows.

When a border is no longer needed, **Tk\_Free3DBorderFromObj** or **Tk\_Free3DBorder** should be called to release the resources associated with it. For **Tk\_Free3DBorderFromObj** the border to release is specified with the window and color name used to create the border; for **Tk\_Free3DBorder** the border to release is specified with the Tk\_3DBorder token for the border. There should be exactly one call to **Tk\_Free3DBorderFromObj** or **Tk\_Free3DBorder** for each call to **Tk\_Alloc3DBorderFromObj** or **Tk\_Get3DBorder**.
