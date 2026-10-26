---
CommandName: Tk_GetHISTANCE
title: Tk_GetHISTANCE
ManualSection: 3
Version: unknown
TclPart: Tk
TclDescription: Tk Library Procedures
Keywords:
 - identifier
 - instance
Copyright:
 - Copyright (c) 1998-2000 Scriptics Corporation.
---

# Name

Tk\_GetHINSTANCE - retrieve the global application instance handle

# Synopsis

::: {.synopsis} :::
**#include <tkPlatDecls.h>**
[HINSTANCE]{.ret} [Tk\_GetHINSTANCE]{.ccmd} []{.cargs}
:::

# Description

**Tk\_GetHINSTANCE** returns the Windows application instance handle for the Tk application.  This function is only available on Windows platforms.
