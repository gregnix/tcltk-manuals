---
CommandName: Tk_GetUserInactiveTime
ManualSection: 3
Version: 8.5
TclPart: Tk
TclDescription: Tk Library Procedures
Keywords:
 - idle
 - inactive
Copyright:
 - Copyright (c) 1998-2000 Scriptics Corporation.
 - All rights reserved.
---

# Name

Tk_GetUserInactiveTime, Tk_ResetUserInactiveTime - discover user inactivity time

# Synopsis

::: {.synopsis} :::
[#include]{.cmd} [\<tk.h>]{.lit}

long
[Tk_GetUserInactiveTime]{.cmd}([display]{.arg})

[Tk_ResetUserInactiveTime]{.cmd}([display]{.arg})
:::

# Arguments

Display *\*display* (in)
: The display on which the user inactivity timer is to be queried or reset.


# Description

**Tk_GetUserInactiveTime** returns the number of milliseconds that have passed since the last user interaction (usually via keyboard or mouse) with the respective display. On systems and displays that do not support querying the user inactivity time, **-1** is returned. **Tk_ResetUserInactiveTime** resets the user inactivity timer of the given display to zero.  On windowing systems that do not support multiple displays *display* can be passed as **NULL**.
