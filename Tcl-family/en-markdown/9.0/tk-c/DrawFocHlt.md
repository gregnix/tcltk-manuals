---
CommandName: Tk_DrawFocusHighlight
ManualSection: 3
Version: 4.0
TclPart: Tk
TclDescription: Tk Library Procedures
Keywords:
 - focus
 - traversal highlight
Copyright:
 - Copyright (c) 1995-1996 Sun Microsystems, Inc.
---

# Name

Tk_DrawFocusHighlight - draw the traversal highlight ring for a widget

# Synopsis

::: {.synopsis} :::
[#include]{.cmd} [\<tk.h>]{.lit}

[Tk_DrawFocusHighlight]{.cmd}([tkwin]{.arg}, [gc]{.arg}, [width]{.arg}, [drawable]{.arg})
:::

# Arguments

Tk_Window *tkwin* (in)
: Window for which the highlight is being drawn.  Used to retrieve the window's dimensions, among other things.

GC *gc* (in)
: Graphics context to use for drawing the highlight.

int *width* (in)
: Width of the highlight ring, in pixels.

Drawable *drawable* (in)
: Drawable in which to draw the highlight;  usually an offscreen pixmap for double buffering.


# Description

**Tk_DrawFocusHighlight** is a utility procedure that draws the traversal highlight ring for a widget. It is typically invoked by widgets during redisplay.
