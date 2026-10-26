---
CommandName: Tk_SetCaretPos
title: Tk_SetCaretPos
ManualSection: 3
Version: 8.4
TclPart: Tk
TclDescription: Tk Library Procedures
Keywords:
 - caret
 - cursor
Copyright:
 - Copyright (c) 2002 ActiveState Corporation.
---

# Name

Tk\_SetCaretPos - set the display caret location

# Synopsis

::: {.synopsis} :::
**#include <tk.h>**
[int]{.ret} [Tk\_SetCaretPos]{.ccmd} [tkwin, x, y, height]{.cargs}
:::

# Arguments

::: {.arguments} :::

[tkwin]{.carg .in type="Tk_Window"}
: Token for window.

[x]{.carg .in type="int"}
: Window-relative x coordinate.

[y]{.carg .in type="int"}
: Window-relative y coordinate.

[h]{.carg .in type="int"}
: Height of the caret in the window.

:::

# Description

**Tk\_SetCaretPos** sets the caret location for the display of the specified Tk\_Window *tkwin*.  The caret is the per-display cursor location used for indicating global focus (e.g. to comply with Microsoft Accessibility guidelines), as well as for location of the over-the-spot XIM (X Input Methods) or Windows IME windows.
