---
CommandName: Tk_HWNDToWindow
ManualSection: 3
Version: unknown
TclPart: Tk
TclDescription: Tk Library Procedures
Keywords:
 - Windows window id
Copyright:
 - Copyright (c) 1998-2000 Scriptics Corporation.
 - All rights reserved.
---

# Name

Tk_HWNDToWindow - Find Tk's window information for a Windows window

# Synopsis

::: {.synopsis} :::
[#include]{.cmd} [\<tkPlatDecls.h>]{.lit}

Tk_Window
[Tk_HWNDToWindow]{.cmd}([hwnd]{.arg})
:::

# Arguments

HWND *hwnd* (in)
: Windows handle for the window.


# Description

Given a Windows HWND window identifier, this procedure returns the corresponding Tk_Window handle. If there is no Tk_Window corresponding to *hwnd* then NULL is returned.
