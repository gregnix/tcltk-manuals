---
CommandName: Tk_HandleEvent
title: Tk_HandleEvent
ManualSection: 3
Version: unknown
TclPart: Tk
TclDescription: Tk Library Procedures
Keywords:
 - callback
 - event
 - handler
 - window
Copyright:
 - Copyright (c) 1990-1992 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

Tk\_HandleEvent - invoke event handlers for window system events

# Synopsis

::: {.synopsis} :::
**#include <tk.h>**
[Tk\_HandleEvent]{.ccmd} [eventPtr]{.cargs}
:::

# Arguments

::: {.arguments} :::

[\*eventPtr]{.carg .in type="XEvent"}
: Pointer to X event to dispatch to relevant handler(s). It is important that all unused fields of the structure be set to zero.

:::

# Description

**Tk\_HandleEvent** is a lower-level procedure that deals with window events.  It is called by [Tcl\_ServiceEvent][Notifier] (and indirectly by [Tcl\_DoOneEvent][DoOneEvent]), and in a few other cases within Tk. It makes callbacks to any window event handlers (created by calls to [Tk\_CreateEventHandler][EventHndlr]) that match *eventPtr* and then returns.  In some cases it may be useful for an application to bypass the Tk event queue and call **Tk\_HandleEvent** directly instead of calling [Tcl\_QueueEvent][Notifier] followed by [Tcl\_ServiceEvent][Notifier].

This procedure may be invoked recursively.  For example, it is possible to invoke **Tk\_HandleEvent** recursively from a handler called by **Tk\_HandleEvent**.  This sort of operation is useful in some modal situations, such as when a notifier has been popped up and an application wishes to wait for the user to click a button in the notifier before doing anything else.


[DoOneEvent]: ../tcl-c/DoOneEvent.md
[EventHndlr]: EventHndlr.md
[Notifier]: ../tcl-c/Notifier.md
