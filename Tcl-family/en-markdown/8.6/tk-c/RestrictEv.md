---
CommandName: Tk_RestrictEvents
title: Tk_RestrictEvents
ManualSection: 3
Version: unknown
TclPart: Tk
TclDescription: Tk Library Procedures
Keywords:
 - delay
 - event
 - filter
 - restriction
Copyright:
 - Copyright (c) 1990 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

Tk\_RestrictEvents - filter and selectively delay X events

# Synopsis

::: {.synopsis} :::
**#include <tk.h>**
[Tk\_RestrictProc \*]{.ret} [Tk\_RestrictEvents]{.ccmd} [proc, arg, prevArgPtr]{.cargs}
:::

# Arguments

::: {.arguments} :::

[\*proc]{.carg .in type="Tk_RestrictProc"}
: Predicate procedure to call to filter incoming X events. NULL means do not restrict events at all.

[arg]{.carg .in type="ClientData"}
: Arbitrary argument to pass to *proc*.

[\*prevArgPtr]{.carg .out type="ClientData"}
: Pointer to place to save argument to previous restrict procedure.

:::

# Description

This procedure is useful in certain situations where applications are only prepared to receive certain X events.  After **Tk\_RestrictEvents** is called, [Tcl\_DoOneEvent][DoOneEvent] (and hence [Tk\_MainLoop][MainLoop]) will filter X input events through *proc*.  *Proc* indicates whether a given event is to be processed immediately, deferred until some later time (e.g. when the event restriction is lifted), or discarded. *Proc* is a procedure with arguments and result that match the type **Tk\_RestrictProc**:

```
typedef Tk_RestrictAction Tk_RestrictProc(
        ClientData arg,
        XEvent *eventPtr);
```

The *arg* argument is a copy of the *arg* passed to **Tk\_RestrictEvents**; it may be used to provide *proc* with information it needs to filter events.  The *eventPtr* points to an event under consideration.  *Proc* returns a restrict action (enumerated type **Tk\_RestrictAction**) that indicates what [Tcl\_DoOneEvent][DoOneEvent] should do with the event.  If the return value is **TK\_PROCESS\_EVENT**, then the event will be handled immediately. If the return value is **TK\_DEFER\_EVENT**, then the event will be left on the event queue for later processing.  If the return value is **TK\_DISCARD\_EVENT**, then the event will be removed from the event queue and discarded without being processed.

**Tk\_RestrictEvents** uses its return value and *prevArgPtr* to return information about the current event restriction procedure (a NULL return value means there are currently no restrictions). These values may be used to restore the previous restriction state when there is no longer any need for the current restriction.

There are very few places where **Tk\_RestrictEvents** is needed. In most cases, the best way to restrict events is by changing the bindings with the [bind] Tcl command or by calling [Tk\_CreateEventHandler][EventHndlr] and [Tk\_DeleteEventHandler][EventHndlr] from C. The main place where **Tk\_RestrictEvents** must be used is when performing synchronous actions (for example, if you need to wait for a particular event to occur on a particular window but you do not want to invoke any handlers for any other events).  The "obvious" solution in these situations is to call **XNextEvent** or **XWindowEvent**, but these procedures cannot be used because Tk keeps its own event queue that is separate from the X event queue.  Instead, call **Tk\_RestrictEvents** to set up a filter, then call [Tcl\_DoOneEvent][DoOneEvent] to retrieve the desired event(s).


[bind]: ../tk/bind.md
[DoOneEvent]: ../tcl-c/DoOneEvent.md
[EventHndlr]: EventHndlr.md
[MainLoop]: MainLoop.md
