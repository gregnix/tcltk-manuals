---
CommandName: Tk_HWNDToWindow
title: Tk_HWNDToWindow
ManualSection: 3
Version: unknown
TclPart: Tk
TclDescription: Tk Library Procedures
Keywords:
 - Windows window id
Copyright:
 - Copyright (c) 1998-2000 by Scriptics Corporation.
---

# Name

Tk\_HWNDToWindow - Find Tk's window information for a Windows window

# Synopsis

::: {.synopsis} :::
**#include <tkPlatDecls.h>**
[Tk\_Window]{.ret} [Tk\_HWNDToWindow]{.ccmd} [hwnd]{.cargs}
:::

# Arguments

::: {.arguments} :::

[hwnd]{.carg .in type="HWND"}
: Windows handle for the window.

:::

# Description

Given a Windows HWND window identifier, this procedure returns the corresponding Tk\_Window handle. If there is no Tk\_Window corresponding to *hwnd* then NULL is returned.
