---
CommandName: Tk_WindowId
title: Tk_WindowId
ManualSection: 3
Version: 8.4
TclPart: Tk
TclDescription: Tk Library Procedures
Keywords:
 - attributes
 - colormap
 - depth
 - display
 - height
 - geometry manager
 - identifier
 - mapped
 - requested size
 - screen
 - top-level
 - visual
 - width
 - window
 - x
 - y
Copyright:
 - Copyright (c) 1990-1993 The Regents of the University of California.
 - Copyright (c) 1994-1997 Sun Microsystems, Inc.
---

# Name

Tk\_WindowId, Tk\_Parent, Tk\_Display, Tk\_DisplayName, Tk\_ScreenNumber, Tk\_Screen, Tk\_X, Tk\_Y, Tk\_Width, Tk\_Height, Tk\_Changes, Tk\_Attributes, Tk\_IsContainer, Tk\_IsEmbedded, Tk\_IsMapped, Tk\_IsTopLevel, Tk\_ReqWidth, Tk\_ReqHeight, Tk\_MinReqWidth, Tk\_MinReqHeight, Tk\_InternalBorderLeft, Tk\_InternalBorderRight, Tk\_InternalBorderTop, Tk\_InternalBorderBottom, Tk\_Visual, Tk\_Depth, Tk\_Colormap, Tk\_Interp  - retrieve information from Tk's local data structure

# Synopsis

::: {.synopsis} :::
**#include <tk.h>**
[Window]{.ret} [Tk\_WindowId]{.ccmd} [tkwin]{.cargs}
[Tk\_Window]{.ret} [Tk\_Parent]{.ccmd} [tkwin]{.cargs}
[Display \*]{.ret} [Tk\_Display]{.ccmd} [tkwin]{.cargs}
[const char \*]{.ret} [Tk\_DisplayName]{.ccmd} [tkwin]{.cargs}
[int]{.ret} [Tk\_ScreenNumber]{.ccmd} [tkwin]{.cargs}
[Screen \*]{.ret} [Tk\_Screen]{.ccmd} [tkwin]{.cargs}
[int]{.ret} [Tk\_X]{.ccmd} [tkwin]{.cargs}
[int]{.ret} [Tk\_Y]{.ccmd} [tkwin]{.cargs}
[int]{.ret} [Tk\_Width]{.ccmd} [tkwin]{.cargs}
[int]{.ret} [Tk\_Height]{.ccmd} [tkwin]{.cargs}
[XWindowChanges \*]{.ret} [Tk\_Changes]{.ccmd} [tkwin]{.cargs}
[XSetWindowAttributes \*]{.ret} [Tk\_Attributes]{.ccmd} [tkwin]{.cargs}
[int]{.ret} [Tk\_IsContainer]{.ccmd} [tkwin]{.cargs}
[int]{.ret} [Tk\_IsEmbedded]{.ccmd} [tkwin]{.cargs}
[int]{.ret} [Tk\_IsMapped]{.ccmd} [tkwin]{.cargs}
[int]{.ret} [Tk\_IsTopLevel]{.ccmd} [tkwin]{.cargs}
[int]{.ret} [Tk\_ReqWidth]{.ccmd} [tkwin]{.cargs}
[int]{.ret} [Tk\_ReqHeight]{.ccmd} [tkwin]{.cargs}
[int]{.ret} [Tk\_MinReqWidth]{.ccmd} [tkwin]{.cargs}
[int]{.ret} [Tk\_MinReqHeight]{.ccmd} [tkwin]{.cargs}
[int]{.ret} [Tk\_InternalBorderLeft]{.ccmd} [tkwin]{.cargs}
[int]{.ret} [Tk\_InternalBorderRight]{.ccmd} [tkwin]{.cargs}
[int]{.ret} [Tk\_InternalBorderTop]{.ccmd} [tkwin]{.cargs}
[int]{.ret} [Tk\_InternalBorderBottom]{.ccmd} [tkwin]{.cargs}
[Visual \*]{.ret} [Tk\_Visual]{.ccmd} [tkwin]{.cargs}
[int]{.ret} [Tk\_Depth]{.ccmd} [tkwin]{.cargs}
[Colormap]{.ret} [Tk\_Colormap]{.ccmd} [tkwin]{.cargs}
[Tcl\_Interp \*]{.ret} [Tk\_Interp]{.ccmd} [tkwin]{.cargs}
:::

# Arguments

::: {.arguments} :::

[tkwin]{.carg .in type="Tk_Window"}
: Token for window.

:::

# Description

**Tk\_WindowId** and the other names listed above are all macros that return fields from Tk's local data structure for *tkwin*.  None of these macros requires any interaction with the server;  it is safe to assume that all are fast.

**Tk\_WindowId** returns the X identifier for *tkwin*, or **NULL** if no X window has been created for *tkwin* yet.

**Tk\_Parent** returns Tk's token for the logical parent of *tkwin*.  The parent is the token that was specified when *tkwin* was created, or NULL for main windows.

**Tk\_Interp** returns the Tcl interpreter associated with a *tkwin* or NULL if there is an error.

**Tk\_Display** returns a pointer to the Xlib display structure corresponding to *tkwin*.  **Tk\_DisplayName** returns an ASCII string identifying *tkwin*'s display.  **Tk\_ScreenNumber** returns the index of *tkwin*'s screen among all the screens of *tkwin*'s display.  **Tk\_Screen** returns a pointer to the Xlib structure corresponding to *tkwin*'s screen.

**Tk\_X**, **Tk\_Y**, **Tk\_Width**, and **Tk\_Height** return information about *tkwin's* location within its parent and its size.  The location information refers to the upper-left pixel in the window, or its border if there is one. The width and height information refers to the interior size of the window, not including any border.  **Tk\_Changes** returns a pointer to a structure containing all of the above information plus a few other fields.  **Tk\_Attributes** returns a pointer to an XSetWindowAttributes structure describing all of the attributes of the *tkwin*'s window, such as background pixmap, event mask, and so on (Tk keeps track of all this information as it is changed by the application).  Note: it is essential that applications use Tk procedures like [Tk\_ResizeWindow][ConfigWind] instead of X procedures like **XResizeWindow**, so that Tk can keep its data structures up-to-date.

**Tk\_IsContainer** returns a non-zero value if *tkwin* is a container, and that some other application may be embedding itself inside *tkwin*.

**Tk\_IsEmbedded** returns a non-zero value if *tkwin* is not a free-standing window, but rather is embedded in some other application.

**Tk\_IsMapped** returns a non-zero value if *tkwin* is mapped and zero if *tkwin* is not mapped.

**Tk\_IsTopLevel** returns a non-zero value if *tkwin* is a top-level window (its X parent is the root window of the screen) and zero if *tkwin* is not a top-level window.

**Tk\_ReqWidth** and **Tk\_ReqHeight** return information about the window's requested size.  These values correspond to the last call to [Tk\_GeometryRequest][GeomReq] for *tkwin*.

**Tk\_MinReqWidth** and **Tk\_MinReqHeight** return information about the window's minimum requested size.  These values correspond to the last call to [Tk\_SetMinimumRequestSize][GeomReq] for *tkwin*.

**Tk\_InternalBorderLeft**, **Tk\_InternalBorderRight**, **Tk\_InternalBorderTop** and **Tk\_InternalBorderBottom** return the width of one side of the internal border that has been requested for *tkwin*, or 0 if no internal border was requested.  The return value is simply the last value passed to [Tk\_SetInternalBorder][GeomReq] or [Tk\_SetInternalBorderEx][GeomReq] for *tkwin*.

**Tk\_Visual**, **Tk\_Depth**, and **Tk\_Colormap** return information about the visual characteristics of a window. **Tk\_Visual** returns the visual type for the window, **Tk\_Depth** returns the number of bits per pixel, and **Tk\_Colormap** returns the current colormap for the window.  The visual characteristics are normally set from the defaults for the window's screen, but they may be overridden by calling [Tk\_SetWindowVisual][SetVisual].


[ConfigWind]: ConfigWind.md
[GeomReq]: GeomReq.md
[SetVisual]: SetVisual.md
