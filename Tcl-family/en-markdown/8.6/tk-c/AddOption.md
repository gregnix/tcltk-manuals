---
CommandName: Tk_AddOption
title: Tk_AddOption
ManualSection: 3
Version: unknown
TclPart: Tk
TclDescription: Tk Library Procedures
Keywords:
 - class
 - name
 - option
 - add
Copyright:
 - Copyright (c) 1998-2000 by Scriptics Corporation.
---

# Name

Tk\_AddOption - Add an option to the option database

# Synopsis

::: {.synopsis} :::
**#include <tk.h>**
[void]{.ret} [Tk\_AddOption]{.ccmd} [tkwin, name, value, priority]{.cargs}
:::

# Arguments

::: {.arguments} :::

[tkwin]{.carg .in type="Tk_Window"}
: Token for window.

[\*name]{.carg .in type="const char"}
: Multi-element name of option.

[\*value]{.carg .in type="const char"}
: Value of option.

[priority]{.carg .in type="int"}
: Overall priority level to use for option.

:::

# Description

This procedure is invoked to add an option to the database associated with *tkwin*'s main window.  *Name* contains the option being specified and consists of names and/or classes separated by asterisks or dots, in the usual X format. *Value* contains the text string to associate with *name*; this value will be returned in calls to [Tk\_GetOption][GetOption]. *Priority* specifies the priority of the value; when options are queried using [Tk\_GetOption][GetOption], the value with the highest priority is returned.  *Priority* must be between 0 and **TK\_MAX\_PRIO** (100). Some common priority values are:

**TK\_WIDGET\_DEFAULT\_PRIO** (20)
: Used for default values hard-coded into widgets.

**TK\_STARTUP\_FILE\_PRIO** (40)
: Used for options specified in application-specific startup files.

**TK\_USER\_DEFAULT\_PRIO** (60)
: Used for options specified in user-specific defaults files, such as **.Xdefaults**, resource databases loaded into the X server, or user-specific startup files.

**TK\_INTERACTIVE\_PRIO** (80)
: Used for options specified interactively after the application starts running.


[GetOption]: GetOption.md
