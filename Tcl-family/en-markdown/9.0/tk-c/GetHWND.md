---
CommandName: HWND
ManualSection: 3
Version: 8.0
TclPart: Tk
TclDescription: Tk Library Procedures
Keywords:
 - identifier
 - window
Copyright:
 - Copyright (c) 1998-2000 Scriptics Corporation.
 - All rights reserved.
---

# Name

Tk_GetHWND, Tk_AttachHWND - manage interactions between the Windows handle and an X window

# Synopsis

::: {.synopsis} :::
[#include]{.cmd} [\<tkPlatDecls.h>]{.lit}

HWND
[Tk_GetHWND]{.cmd}([window]{.arg})

Window
[Tk_AttachHWND]{.cmd}([tkwin]{.arg}, [hwnd]{.arg})
:::

# Arguments

Window *window* (in)
: X token for window.

Tk_Window *tkwin* (in)
: Tk window for window.

HWND *hwnd* (in)
: Windows HWND for window.


# Description

**Tk_GetHWND** returns the Windows HWND identifier for X Windows window given by *window*.

**Tk_AttachHWND** binds the Windows HWND identifier to the specified Tk_Window given by *tkwin*. It returns an X Windows window that encapsulates the HWND.
