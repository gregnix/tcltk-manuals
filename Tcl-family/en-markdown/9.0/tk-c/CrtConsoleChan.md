---
CommandName: Tk_InitConsoleChannels
title: Tk_InitConsoleChannels
ManualSection: 3
Version: 8.5
TclPart: Tk
TclDescription: Tk Library Procedures
Links:
 - console(n)
Keywords:
 - standard channels
 - console
Copyright:
 - Copyright (c) 2007 ActiveState Software Inc.
---

# Name

Tk\_InitConsoleChannels - Install the console channels as standard channels

# Synopsis

::: {.synopsis} :::
**#include <tk.h>**
[Tk\_InitConsoleChannels]{.ccmd} [interp]{.cargs}
:::

# Arguments

::: {.arguments} :::

[\*interp]{.carg .in type="Tcl_Interp"}
: Interpreter in which the console channels are created.

:::

# Description

**Tk\_InitConsoleChannels** is invoked to create a set of console channels and install them as the standard channels. All I/O on these channels will be discarded until **Tk\_CreateConsoleWindow** is called to attach the console to a text widget.

This function is for use by shell applications based on Tk, like [wish], on platforms which have no standard channels in graphical mode, like Win32.

The *interp* argument is the interpreter in which to create and install the console channels.

**NOTE:** If this function is used it has to be called before the first call to [Tcl\_RegisterChannel][OpenFileChnl], directly, or indirectly through other channel functions. Because otherwise the standard channels will be already initialized to the system defaults, which will be nonsensical for the case **Tk\_InitConsoleChannels** is for.


[OpenFileChnl]: ../tcl-c/OpenFileChnl.md
[wish]: ../tk/wish.md
