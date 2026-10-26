---
CommandName: HWND
title: HWND
ManualSection: 3
Version: 8.0
TclPart: Tk
TclDescription: Tk Library Procedures
Keywords:
 - identifier
 - window
Copyright:
 - Copyright (c) 1998-2000 Scriptics Corporation.
---

# Name

Tk\_GetHWND, Tk\_AttachHWND - manage interactions between the Windows handle and an X window

# Synopsis

::: {.synopsis} :::
**#include <tkPlatDecls.h>**
[HWND]{.ret} [Tk\_GetHWND]{.ccmd} [window]{.cargs}
[Window]{.ret} [Tk\_AttachHWND]{.ccmd} [tkwin, hwnd]{.cargs}
:::

# Arguments

::: {.arguments} :::

[window]{.carg .in type="Window"}
: X token for window.

[tkwin]{.carg .in type="Tk_Window"}
: Tk window for window.

[hwnd]{.carg .in type="HWND"}
: Windows HWND for window.

:::

# Description

**Tk\_GetHWND** returns the Windows HWND identifier for X Windows window given by *window*.

**Tk\_AttachHWND** binds the Windows HWND identifier to the specified Tk\_Window given by *tkwin*. It returns an X Windows window that encapsulates the HWND.
