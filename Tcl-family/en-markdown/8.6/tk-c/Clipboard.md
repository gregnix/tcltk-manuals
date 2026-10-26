---
CommandName: Tk_ClipboardClear
title: Tk_ClipboardClear
ManualSection: 3
Version: 4.0
TclPart: Tk
TclDescription: Tk Library Procedures
Keywords:
 - append
 - clipboard
 - clear
 - format
 - type
Copyright:
 - Copyright (c) 1994 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

Tk\_ClipboardClear, Tk\_ClipboardAppend - Manage the clipboard

# Synopsis

::: {.synopsis} :::
**#include <tk.h>**
[int]{.ret} [Tk\_ClipboardClear]{.ccmd} [interp, tkwin]{.cargs}
[int]{.ret} [Tk\_ClipboardAppend]{.ccmd} [interp, tkwin, target, format, buffer]{.cargs}
:::

# Arguments

::: {.arguments} :::

[\*interp]{.carg .in type="Tcl_Interp"}
: Interpreter to use for reporting errors.

[tkwin]{.carg .in type="Tk_Window"}
: Window that determines which display's clipboard to manipulate.

[target]{.carg .in type="Atom"}
: Conversion type for this clipboard item;  has same meaning as *target* argument to [Tk\_CreateSelHandler][CrtSelHdlr].

[format]{.carg .in type="Atom"}
: Representation to use when data is retrieved;  has same meaning as *format* argument to [Tk\_CreateSelHandler][CrtSelHdlr].

[\*buffer]{.carg .in type="const char"}
: Null terminated string containing the data to be appended to the clipboard.

:::

# Description

These two procedures manage the clipboard for Tk. The clipboard is typically managed by calling **Tk\_ClipboardClear** once, then calling **Tk\_ClipboardAppend** to add data for any number of targets.

**Tk\_ClipboardClear** claims the CLIPBOARD selection and frees any data items previously stored on the clipboard in this application. It normally returns [TCL\_OK][catch], but if an error occurs it returns [TCL\_ERROR][catch] and leaves an error message in interpreter *interp*'s result. **Tk\_ClipboardClear** must be called before a sequence of **Tk\_ClipboardAppend** calls can be issued.

**Tk\_ClipboardAppend** appends a buffer of data to the clipboard. The first buffer for a given *target* determines the *format* for that *target*. Any successive appends for that *target* must have the same format or an error will be returned. **Tk\_ClipboardAppend** returns [TCL\_OK][catch] if the buffer is successfully copied onto the clipboard.  If the clipboard is not currently owned by the application, either because **Tk\_ClipboardClear** has not been called or because ownership of the clipboard has changed since the last call to **Tk\_ClipboardClear**, **Tk\_ClipboardAppend** returns [TCL\_ERROR][catch] and leaves an error message in the result of interpreter *interp*.

In order to guarantee atomicity, no event handling should occur between **Tk\_ClipboardClear** and the following **Tk\_ClipboardAppend** calls (otherwise someone could retrieve a partially completed clipboard or claim ownership away from this application).

**Tk\_ClipboardClear** may invoke callbacks, including arbitrary Tcl scripts, as a result of losing the CLIPBOARD selection, so any calling function should take care to be re-entrant at the point **Tk\_ClipboardClear** is invoked.


[catch]: ../tcl/catch.md
[CrtSelHdlr]: CrtSelHdlr.md
