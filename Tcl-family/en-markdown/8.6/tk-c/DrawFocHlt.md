---
CommandName: Tk_DrawFocusHighlight
title: Tk_DrawFocusHighlight
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

Tk\_DrawFocusHighlight - draw the traversal highlight ring for a widget

# Synopsis

::: {.synopsis} :::
**#include <tk.h>**
Tk\_DrawFocusHighlight(tkwin, gc, width, drawable)
:::

# Arguments

::: {.arguments} :::

[tkwin]{.carg .in type="Tk_Window"}
: Window for which the highlight is being drawn.  Used to retrieve the window's dimensions, among other things.

[gc]{.carg .in type="GC"}
: Graphics context to use for drawing the highlight.

[width]{.carg .in type="int"}
: Width of the highlight ring, in pixels.

[drawable]{.carg .in type="Drawable"}
: Drawable in which to draw the highlight;  usually an offscreen pixmap for double buffering.

:::

# Description

**Tk\_DrawFocusHighlight** is a utility procedure that draws the traversal highlight ring for a widget. It is typically invoked by widgets during redisplay.
