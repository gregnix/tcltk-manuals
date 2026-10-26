---
CommandName: Tk_GetHISTANCE
ManualSection: 3
Version: unknown
TclPart: Tk
TclDescription: Tk Library Procedures
Keywords:
 - identifier
 - instance
Copyright:
 - Copyright (c) 1998-2000 Scriptics Corporation.
 - All rights reserved.
---

# Name

Tk_GetHINSTANCE - retrieve the global application instance handle

# Synopsis

::: {.synopsis} :::
[#include]{.cmd} [\<tkPlatDecls.h>]{.lit}

HINSTANCE
[Tk_GetHINSTANCE]{.cmd}()
:::

# Description

**Tk_GetHINSTANCE** returns the Windows application instance handle for the Tk application.  This function is only available on Windows platforms.
