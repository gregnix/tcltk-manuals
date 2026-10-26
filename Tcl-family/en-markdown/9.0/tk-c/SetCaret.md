---
CommandName: Tk_SetCaretPos
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

Tk_SetCaretPos - set the display caret location

# Synopsis

::: {.synopsis} :::
[#include]{.cmd} [\<tk.h>]{.lit}

int
[Tk_SetCaretPos]{.cmd}([tkwin]{.arg}, [x]{.arg}, [y]{.arg}, [height]{.arg})
:::

# Arguments

Tk_Window *tkwin* (in)
: Token for window.

int *x* (in)
: Window-relative x coordinate.

int *y* (in)
: Window-relative y coordinate.

int *h* (in)
: Height of the caret in the window.


# Description

**Tk_SetCaretPos** sets the caret location for the display of the specified Tk_Window *tkwin*.  The caret is the per-display cursor location used for indicating global focus (e.g. to comply with Microsoft Accessibility guidelines), as well as for location of the over-the-spot XIM (X Input Methods) or Windows IME windows.
