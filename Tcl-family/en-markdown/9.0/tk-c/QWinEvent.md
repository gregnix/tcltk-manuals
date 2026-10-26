---
CommandName: Tk_QueueWindowEvent
title: Tk_QueueWindowEvent
ManualSection: 3
Version: 7.5
TclPart: Tk
TclDescription: Tk Library Procedures
Keywords:
 - callback
 - clock
 - handler
 - modal timeout
 - events
Copyright:
 - Copyright (c) 1995-1996 Sun Microsystems, Inc.
---

# Name

Tk\_CollapseMotionEvents, Tk\_QueueWindowEvent - Add a window event to the Tcl event queue

# Synopsis

::: {.synopsis} :::
**#include <tk.h>**
[int]{.ret} [Tk\_CollapseMotionEvents]{.ccmd} [display, collapse]{.cargs}
[Tk\_QueueWindowEvent]{.ccmd} [eventPtr, position]{.cargs}
:::

# Arguments

::: {.arguments} :::

[\*display]{.carg .in type="Display"}
: Display for which to control motion event collapsing.

[collapse]{.carg .in type="int"}
: Indicates whether motion events should be collapsed or not.

[\*eventPtr]{.carg .in type="XEvent"}
: An event to add to the event queue. It is important that all unused fields of the structure be set to zero.

[position]{.carg .in type="Tcl_QueuePosition"}
: Where to add the new event in the queue:  **TCL\_QUEUE\_TAIL**, **TCL\_QUEUE\_HEAD**, or **TCL\_QUEUE\_MARK**.

:::

# Description

**Tk\_QueueWindowEvent** places a window event on Tcl's internal event queue for eventual servicing.  It creates a Tcl\_Event structure, copies the event into that structure, and calls [Tcl\_QueueEvent][Notifier] to add the event to the queue.  When the event is eventually removed from the queue it is processed just like all window events.

When multiple motion events are received for the same window in rapid succession, they are collapsed by default.  This behavior can be controlled with **Tk\_CollapseMotionEvents**.  **Tk\_CollapseMotionEvents** always returns the previous value for collapse behavior on the *display*.

The *position* argument to **Tk\_QueueWindowEvent** has the same significance as for [Tcl\_QueueEvent][Notifier];  see the documentation for [Tcl\_QueueEvent][Notifier] for details.


[Notifier]: ../tcl-c/Notifier.md
