---
CommandName: Tk_CreateErrorHandler
title: Tk_CreateErrorHandler
ManualSection: 3
Version: unknown
TclPart: Tk
TclDescription: Tk Library Procedures
Keywords:
 - callback
 - error
 - event
 - handler
Copyright:
 - Copyright (c) 1990 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

Tk\_CreateErrorHandler, Tk\_DeleteErrorHandler - handle X protocol errors

# Synopsis

::: {.synopsis} :::
**#include <tk.h>**
[Tk\_ErrorHandler]{.ret} [Tk\_CreateErrorHandler]{.ccmd} [display, error, request, minor, proc, clientData]{.cargs}
[Tk\_DeleteErrorHandler]{.ccmd} [handler]{.cargs}
:::

# Arguments

::: {.arguments} :::

[\*display]{.carg .in type="Display"}
: Display whose errors are to be handled.

[error]{.carg .in type="int"}
: Match only error events with this value in the *error\_code* field.  If -1, then match any *error\_code* value.

[request]{.carg .in type="int"}
: Match only error events with this value in the *request\_code* field.  If -1, then match any *request\_code* value.

[minor]{.carg .in type="int"}
: Match only error events with this value in the *minor\_code* field.  If -1, then match any *minor\_code* value.

[\*proc]{.carg .in type="Tk_ErrorProc"}
: Procedure to invoke whenever an error event is received for *display* and matches *error*, *request*, and *minor*. NULL means ignore any matching errors.

[clientData]{.carg .in type="ClientData"}
: Arbitrary one-word value to pass to *proc*.

[handler]{.carg .in type="Tk_ErrorHandler"}
: Token for error handler to delete (return value from a previous call to **Tk\_CreateErrorHandler**).

:::

# Description

**Tk\_CreateErrorHandler** arranges for a particular procedure (*proc*) to be called whenever certain protocol errors occur on a particular display (*display*).  Protocol errors occur when the X protocol is used incorrectly, such as attempting to map a window that does not exist.  See the Xlib documentation for **XSetErrorHandler** for more information on the kinds of errors that can occur. For *proc* to be invoked to handle a particular error, five things must occur:

1. The error must pertain to *display*.

2. Either the *error* argument to **Tk\_CreateErrorHandler** must have been -1, or the *error* argument must match the *error\_code* field from the error event.

3. Either the *request* argument to **Tk\_CreateErrorHandler** must have been -1, or the *request* argument must match the *request\_code* field from the error event.

4. Either the *minor* argument to **Tk\_CreateErrorHandler** must have been -1, or the *minor* argument must match the *minor\_code* field from the error event.

5. The protocol request to which the error pertains must have been made when the handler was active (see below for more information).


*Proc* should have arguments and result that match the following type:

```
typedef int Tk_ErrorProc(
        ClientData clientData,
        XErrorEvent *errEventPtr);
```

The *clientData* parameter to *proc* is a copy of the *clientData* argument given to **Tcl\_CreateErrorHandler** when the callback was created.  Typically, *clientData* points to a data structure containing application-specific information that is needed to deal with the error.  *ErrEventPtr* is a pointer to the X error event. The procedure *proc* should return an integer value.  If it returns 0 it means that *proc* handled the error completely and there is no need to take any other action for the error.  If it returns non-zero it means *proc* was unable to handle the error.

If a value of NULL is specified for *proc*, all matching errors will be ignored:  this will produce the same result as if a procedure had been specified that always returns 0.

If more than more than one handler matches a particular error, then they are invoked in turn.  The handlers will be invoked in reverse order of creation:  most recently declared handler first. If any handler returns 0, then subsequent (older) handlers will not be invoked.  If no handler returns 0, then Tk invokes X's default error handler, which prints an error message and aborts the program.  If you wish to have a default handler that deals with errors that no other handler can deal with, then declare it first.

The X documentation states that "the error handler should not call any functions (directly or indirectly) on the display that will generate protocol requests or that will look for input events." This restriction applies to handlers declared by **Tk\_CreateErrorHandler**; disobey it at your own risk.

**Tk\_DeleteErrorHandler** may be called to delete a previously-created error handler.  The *handler* argument identifies the error handler, and should be a value returned by a previous call to [Tk\_CreateEventHandler][EventHndlr].

A particular error handler applies to errors resulting from protocol requests generated between the call to **Tk\_CreateErrorHandler** and the call to **Tk\_DeleteErrorHandler**.  However, the actual callback to *proc* may not occur until after the **Tk\_DeleteErrorHandler** call, due to buffering in the client and server. If an error event pertains to a protocol request made just before calling **Tk\_DeleteErrorHandler**, then the error event may not have been processed before the **Tk\_DeleteErrorHandler** call.  When this situation arises, Tk will save information about the handler and invoke the handler's *proc* later when the error event finally arrives. If an application wishes to delete an error handler and know for certain that all relevant errors have been processed, it should first call **Tk\_DeleteErrorHandler** and then call **XSync**;  this will flush out any buffered requests and errors, but will result in a performance penalty because it requires communication to and from the X server.  After the **XSync** call Tk is guaranteed not to call any error handlers deleted before the **XSync** call.

For the Tk error handling mechanism to work properly, it is essential that application code never calls **XSetErrorHandler** directly; applications should use only **Tk\_CreateErrorHandler**.


[EventHndlr]: EventHndlr.md
