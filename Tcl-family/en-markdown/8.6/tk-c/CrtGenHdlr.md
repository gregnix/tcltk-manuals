---
CommandName: Tk_CreateGenericHandler
title: Tk_CreateGenericHandler
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
 - Copyright (c) 1992-1994 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

Tk\_CreateGenericHandler, Tk\_DeleteGenericHandler - associate procedure callback with all X events

# Synopsis

::: {.synopsis} :::
**#include <tk.h>**
[Tk\_CreateGenericHandler]{.ccmd} [proc, clientData]{.cargs}
[Tk\_DeleteGenericHandler]{.ccmd} [proc, clientData]{.cargs}
:::

# Arguments

::: {.arguments} :::

[\*proc]{.carg .in type="Tk_GenericProc"}
: Procedure to invoke whenever any X event occurs on any display.

[clientData]{.carg .in type="ClientData"}
: Arbitrary one-word value to pass to *proc*.

:::

# Description

**Tk\_CreateGenericHandler** arranges for *proc* to be invoked in the future whenever any X event occurs.  This mechanism is *not* intended for dispatching X events on windows managed by Tk (you should use [Tk\_CreateEventHandler][EventHndlr] for this purpose). **Tk\_CreateGenericHandler** is intended for other purposes, such as tracing X events, monitoring events on windows not owned by Tk, accessing X-related libraries that were not originally designed for use with Tk, and so on.

The callback to *proc* will be made by [Tk\_HandleEvent][HandleEvent]; this mechanism only works in programs that dispatch events through [Tk\_HandleEvent][HandleEvent] (or through other Tk procedures that call [Tk\_HandleEvent][HandleEvent], such as [Tcl\_DoOneEvent][DoOneEvent] or [Tk\_MainLoop][MainLoop]).

*Proc* should have arguments and result that match the type **Tk\_GenericProc**:

```
typedef int Tk_GenericProc(
        ClientData clientData,
        XEvent *eventPtr);
```

The *clientData* parameter to *proc* is a copy of the *clientData* argument given to **Tk\_CreateGenericHandler** when the callback was created.  Typically, *clientData* points to a data structure containing application-specific information about how to handle events. *EventPtr* is a pointer to the X event.

Whenever an X event is processed by [Tk\_HandleEvent][HandleEvent], *proc* is called.  The return value from *proc* is normally 0. A non-zero return value indicates that the event is not to be handled further; that is, *proc* has done all processing that is to be allowed for the event.

If there are multiple generic event handlers, each one is called for each event, in the order in which they were established.

**Tk\_DeleteGenericHandler** may be called to delete a previously-created generic event handler:  it deletes each handler it finds that matches the *proc* and *clientData* arguments.  If no such handler exists, then **Tk\_DeleteGenericHandler** returns without doing anything.  Although Tk supports it, it's probably a bad idea to have more than one callback with the same *proc* and *clientData* arguments.

Establishing a generic event handler does nothing to ensure that the process will actually receive the X events that the handler wants to process. For example, it is the caller's responsibility to invoke **XSelectInput** to select the desired events, if that is necessary.


[DoOneEvent]: ../tcl-c/DoOneEvent.md
[EventHndlr]: EventHndlr.md
[HandleEvent]: HandleEvent.md
[MainLoop]: MainLoop.md
