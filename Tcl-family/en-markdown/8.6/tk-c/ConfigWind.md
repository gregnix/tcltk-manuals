---
CommandName: Tk_ConfigureWindow
title: Tk_ConfigureWindow
ManualSection: 3
Version: 4.0
TclPart: Tk
TclDescription: Tk Library Procedures
Links:
 - Tk_MoveToplevelWindow
 - Tk_RestackWindow
Keywords:
 - attributes
 - border
 - color
 - configure
 - height
 - pixel
 - pixmap
 - width
 - window
 - x
 - y
Copyright:
 - Copyright (c) 1990-1993 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

Tk\_ConfigureWindow, Tk\_MoveWindow, Tk\_ResizeWindow, Tk\_MoveResizeWindow, Tk\_SetWindowBorderWidth, Tk\_ChangeWindowAttributes, Tk\_SetWindowBackground, Tk\_SetWindowBackgroundPixmap, Tk\_SetWindowBorder, Tk\_SetWindowBorderPixmap, Tk\_SetWindowColormap, Tk\_DefineCursor, Tk\_UndefineCursor - change window configuration or attributes

# Synopsis

::: {.synopsis} :::
**#include <tk.h>**
[Tk\_ConfigureWindow]{.ccmd} [tkwin, valueMask, valuePtr]{.cargs}
[Tk\_MoveWindow]{.ccmd} [tkwin, x, y]{.cargs}
[Tk\_ResizeWindow]{.ccmd} [tkwin, width, height]{.cargs}
[Tk\_MoveResizeWindow]{.ccmd} [tkwin, x,  y, width, height]{.cargs}
[Tk\_SetWindowBorderWidth]{.ccmd} [tkwin, borderWidth]{.cargs}
[Tk\_ChangeWindowAttributes]{.ccmd} [tkwin, valueMask, attsPtr]{.cargs}
[Tk\_SetWindowBackground]{.ccmd} [tkwin, pixel]{.cargs}
[Tk\_SetWindowBackgroundPixmap]{.ccmd} [tkwin, pixmap]{.cargs}
[Tk\_SetWindowBorder]{.ccmd} [tkwin, pixel]{.cargs}
[Tk\_SetWindowBorderPixmap]{.ccmd} [tkwin, pixmap]{.cargs}
[Tk\_SetWindowColormap]{.ccmd} [tkwin, colormap]{.cargs}
[Tk\_DefineCursor]{.ccmd} [tkwin, cursor]{.cargs}
[Tk\_UndefineCursor]{.ccmd} [tkwin]{.cargs}
:::

# Arguments

::: {.arguments} :::

[tkwin]{.carg .in type="Tk_Window"}
: Token for window.

[valueMask]{.carg .in type="unsigned int"}
: OR-ed mask of values like **CWX** or **CWBorderPixel**, indicating which fields of *\*valuePtr* or *\*attsPtr* to use.

[\*valuePtr]{.carg .in type="XWindowChanges"}
: Points to a structure containing new values for the configuration parameters selected by *valueMask*.  Fields not selected by *valueMask* are ignored.

[x]{.carg .in type="int"}
: New x-coordinate for *tkwin*'s top left pixel (including border, if any) within tkwin's parent.

[y]{.carg .in type="int"}
: New y-coordinate for *tkwin*'s top left pixel (including border, if any) within tkwin's parent.

[width]{.carg .in type="int"}
: New width for *tkwin* (interior, not including border).

[height]{.carg .in type="int"}
: New height for *tkwin* (interior, not including border).

[borderWidth]{.carg .in type="int"}
: New width for *tkwin*'s border.

[\*attsPtr]{.carg .in type="XSetWindowAttributes"}
: Points to a structure containing new values for the attributes given by the *valueMask* argument.  Attributes not selected by *valueMask* are ignored.

[pixel]{.carg .in type="unsigned long"}
: New background or border color for window.

[pixmap]{.carg .in type="Pixmap"}
: New pixmap to use for background or border of *tkwin*.  WARNING: cannot necessarily be deleted immediately, as for Xlib calls.  See note below.

[colormap]{.carg .in type="Colormap"}
: New colormap to use for *tkwin*.

[cursor]{.carg .in type="Tk_Cursor"}
: New cursor to use for *tkwin*.  If **None** is specified, then *tkwin* will not have its own cursor;  it will use the cursor of its parent.

:::

# Description

These procedures are analogous to the X library procedures with similar names, such as **XConfigureWindow**.  Each one of the above procedures calls the corresponding X procedure and also saves the configuration information in Tk's local structure for the window.  This allows the information to be retrieved quickly by the application (using macros such as [Tk\_X][WindowId] and [Tk\_Height][WindowId]) without having to contact the X server.  In addition, if no X window has actually been created for *tkwin* yet, these procedures do not issue X operations or cause event handlers to be invoked;  they save the information in Tk's local structure for the window;  when the window is created later, the saved information will be used to configure the window.

See the X library documentation for details on what these procedures do and how they use their arguments.

In the procedures **Tk\_ConfigureWindow**, **Tk\_MoveWindow**, **Tk\_ResizeWindow**, **Tk\_MoveResizeWindow**, and **Tk\_SetWindowBorderWidth**, if *tkwin* is an internal window then event handlers interested in configure events are invoked immediately, before the procedure returns.  If *tkwin* is a top-level window then the event handlers will be invoked later, after X has seen the request and returned an event for it.

Applications using Tk should never call procedures like **XConfigureWindow** directly;  they should always use the corresponding Tk procedures.

The size and location of a window should only be modified by the appropriate geometry manager for that window and never by a window itself (but see [Tk\_MoveToplevelWindow][MoveToplev] for moving a top-level window).

You may not use **Tk\_ConfigureWindow** to change the stacking order of a window (*valueMask* may not contain the **CWSibling** or **CWStackMode** bits). To change the stacking order, use the procedure [Tk\_RestackWindow][Restack].

The procedure **Tk\_SetWindowColormap** will automatically add *tkwin* to the **TK\_COLORMAP\_WINDOWS** property of its nearest top-level ancestor if the new colormap is different from that of *tkwin*'s parent and *tkwin* is not already in the **TK\_COLORMAP\_WINDOWS** property.

# Bugs

**Tk\_SetWindowBackgroundPixmap** and **Tk\_SetWindowBorderPixmap** differ slightly from their Xlib counterparts in that the *pixmap* argument may not necessarily be deleted immediately after calling one of these procedures.  This is because *tkwin*'s window may not exist yet at the time of the call, in which case *pixmap* is merely saved and used later when *tkwin*'s window is actually created.  If you wish to delete *pixmap*, then call [Tk\_MakeWindowExist][CrtWindow] first to be sure that *tkwin*'s window exists and *pixmap* has been passed to the X server.

A similar problem occurs for the *cursor* argument passed to **Tk\_DefineCursor**.  The solution is the same as for pixmaps above: call [Tk\_MakeWindowExist][CrtWindow] before freeing the cursor.


[CrtWindow]: CrtWindow.md
[MoveToplev]: MoveToplev.md
[Restack]: Restack.md
[WindowId]: WindowId.md
