---
CommandName: Tk_CreateEventHandler
title: Tk_CreateEventHandler
ManualSection: 3
Version: unknown
TclPart: Tk
TclDescription: Tk Library Procedures
Keywords:
 - bind
 - callback
 - event
 - handler
Copyright:
 - Copyright (c) 1990 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

Tk\_CreateEventHandler, Tk\_DeleteEventHandler - associate procedure callback with an X event

# Synopsis

::: {.synopsis} :::
**#include <tk.h>**
[Tk\_CreateEventHandler]{.ccmd} [tkwin, mask, proc, clientData]{.cargs}
[Tk\_DeleteEventHandler]{.ccmd} [tkwin, mask, proc, clientData]{.cargs}
:::

# Arguments

::: {.arguments} :::

[tkwin]{.carg .in type="Tk_Window"}
: Token for window in which events may occur.

[mask]{.carg .in type="unsigned long"}
: Bit-mask of events (such as **ButtonPressMask**) for which *proc* should be called.

[\*proc]{.carg .in type="Tk_EventProc"}
: Procedure to invoke whenever an event in *mask* occurs in the window given by *tkwin*.

[clientData]{.carg .in type="ClientData"}
: Arbitrary one-word value to pass to *proc*.

:::

# Description

**Tk\_CreateEventHandler** arranges for *proc* to be invoked in the future whenever one of the event types specified by *mask* occurs in the window specified by *tkwin*. The callback to *proc* will be made by [Tk\_HandleEvent][HandleEvent]; this mechanism only works in programs that dispatch events through [Tk\_HandleEvent][HandleEvent] (or through other Tk procedures that call [Tk\_HandleEvent][HandleEvent], such as [Tcl\_DoOneEvent][DoOneEvent] or [Tk\_MainLoop][MainLoop]).

*Proc* should have arguments and result that match the type **Tk\_EventProc**:

```
typedef void Tk_EventProc(
        ClientData clientData,
        XEvent *eventPtr);
```

The *clientData* parameter to *proc* is a copy of the *clientData* argument given to **Tk\_CreateEventHandler** when the callback was created.  Typically, *clientData* points to a data structure containing application-specific information about the window in which the event occurred.  *EventPtr* is a pointer to the X event, which will be one of the ones specified in the *mask* argument to **Tk\_CreateEventHandler**.

**Tk\_DeleteEventHandler** may be called to delete a previously-created event handler:  it deletes the first handler it finds that is associated with *tkwin* and matches the *mask*, *proc*, and *clientData* arguments.  If no such handler exists, then [Tk\_HandleEvent][HandleEvent] returns without doing anything.  Although Tk supports it, it's probably a bad idea to have more than one callback with the same *mask*, *proc*, and *clientData* arguments. When a window is deleted all of its handlers will be deleted automatically;  in this case there is no need to call **Tk\_DeleteEventHandler**.

If multiple handlers are declared for the same type of X event on the same window, then the handlers will be invoked in the order they were created.


[DoOneEvent]: ../tcl-c/DoOneEvent.md
[HandleEvent]: HandleEvent.md
[MainLoop]: MainLoop.md
