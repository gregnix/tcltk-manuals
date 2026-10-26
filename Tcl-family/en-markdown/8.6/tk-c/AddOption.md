---
CommandName: Tk_AddOption
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
 - All rights reserved.
---

# Name

Tk_AddOption - Add an option to the option database

# Synopsis

::: {.synopsis} :::
[#include]{.cmd} [\<tk.h>]{.lit}

void
[Tk_AddOption]{.cmd}([tkwin]{.arg}, [name]{.arg}, [value]{.arg}, [priority]{.arg})
:::

# Arguments

Tk_Window *tkwin* (in)
: Token for window.

const char *\*name* (in)
: Multi-element name of option.

const char *\*value* (in)
: Value of option.

int *priority* (in)
: Overall priority level to use for option.


# Description

This procedure is invoked to add an option to the database associated with *tkwin*'s main window.  *Name* contains the option being specified and consists of names and/or classes separated by asterisks or dots, in the usual X format. *Value* contains the text string to associate with *name*; this value will be returned in calls to **Tk_GetOption**. *Priority* specifies the priority of the value; when options are queried using **Tk_GetOption**, the value with the highest priority is returned.  *Priority* must be between 0 and **TK_MAX_PRIO** (100). Some common priority values are:

**TK_WIDGET_DEFAULT_PRIO** (20)
: Used for default values hard-coded into widgets.

**TK_STARTUP_FILE_PRIO** (40)
: Used for options specified in application-specific startup files.

**TK_USER_DEFAULT_PRIO** (60)
: Used for options specified in user-specific defaults files, such as **.Xdefaults**, resource databases loaded into the X server, or user-specific startup files.

**TK_INTERACTIVE_PRIO** (80)
: Used for options specified interactively after the application starts running.
