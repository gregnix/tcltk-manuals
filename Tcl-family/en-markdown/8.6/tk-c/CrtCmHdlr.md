---
CommandName: Tk_CreateClientMessageHandler
title: Tk_CreateClientMessageHandler
ManualSection: 3
Version: 8.4
TclPart: Tk
TclDescription: Tk Library Procedures
Keywords:
 - bind
 - callback
 - event
 - handler
Copyright:
 - Copyright (c) 2000 Ajuba Solutions.
---

# Name

Tk\_CreateClientMessageHandler, Tk\_DeleteClientMessageHandler - associate procedure callback with ClientMessage type X events

# Synopsis

::: {.synopsis} :::
**#include <tk.h>**
[Tk\_CreateClientMessageHandler]{.ccmd} [proc]{.cargs}
[Tk\_DeleteClientMessageHandler]{.ccmd} [proc]{.cargs}
:::

# Arguments

::: {.arguments} :::

[\*proc]{.carg .in type="Tk_ClientMessageProc"}
: Procedure to invoke whenever a ClientMessage X event occurs on any display.

:::

# Description

**Tk\_CreateClientMessageHandler** arranges for *proc* to be invoked in the future whenever a ClientMessage X event occurs that is not handled by **WM\_PROTOCOL**.  **Tk\_CreateClientMessageHandler** is intended for use by applications which need to watch X ClientMessage events, such as drag and drop applications.

The callback to *proc* will be made by [Tk\_HandleEvent][HandleEvent]; this mechanism only works in programs that dispatch events through [Tk\_HandleEvent][HandleEvent] (or through other Tk procedures that call [Tk\_HandleEvent][HandleEvent], such as [Tcl\_DoOneEvent][DoOneEvent] or [Tk\_MainLoop][MainLoop]).

*Proc* should have arguments and result that match the type **Tk\_ClientMessageProc**:

```
typedef int Tk_ClientMessageProc(
        Tk_Window tkwin,
        XEvent *eventPtr);
```

The *tkwin* parameter to *proc* is the Tk window which is associated with this event.  *EventPtr* is a pointer to the X event.

Whenever an X ClientMessage event is processed by [Tk\_HandleEvent][HandleEvent], the *proc* is called if it was not handled as a **WM\_PROTOCOL**. The return value from *proc* is normally 0. A non-zero return value indicates that the event is not to be handled further; that is, *proc* has done all processing that is to be allowed for the event.

If there are multiple ClientMessage event handlers, each one is called for each event, in the order in which they were established.

**Tk\_DeleteClientMessageHandler** may be called to delete a previously-created ClientMessage event handler: it deletes each handler it finds that matches the *proc* argument.  If no such handler exists, then **Tk\_DeleteClientMessageHandler** returns without doing anything. Although Tk supports it, it's probably a bad idea to have more than one callback with the same *proc* argument.


[DoOneEvent]: ../tcl-c/DoOneEvent.md
[HandleEvent]: HandleEvent.md
[MainLoop]: MainLoop.md
