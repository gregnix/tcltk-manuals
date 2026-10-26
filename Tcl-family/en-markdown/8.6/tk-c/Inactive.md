---
CommandName: Tk_GetUserInactiveTime
title: Tk_GetUserInactiveTime
ManualSection: 3
Version: 8.5
TclPart: Tk
TclDescription: Tk Library Procedures
Keywords:
 - idle
 - inactive
Copyright:
 - Copyright (c) 1998-2000 by Scriptics Corporation.
---

# Name

Tk\_GetUserInactiveTime, Tk\_ResetUserInactiveTime - discover user inactivity time

# Synopsis

::: {.synopsis} :::
**#include <tk.h>**
long Tk\_GetUserInactiveTime(display)
[Tk\_ResetUserInactiveTime(display)]{.cmd}
:::

# Arguments

::: {.arguments} :::

[\*display]{.carg .in type="Display"}
: The display on which the user inactivity timer is to be queried or reset.

:::

# Description

**Tk\_GetUserInactiveTime** returns the number of milliseconds that have passed since the last user interaction (usually via keyboard or mouse) with the respective display. On systems and displays that do not support querying the user inactivity time, **-1** is returned. **Tk\_ResetUserInactiveTime** resets the user inactivity timer of the given display to zero.  On windowing systems that do not support multiple displays *display* can be passed as **NULL**.
