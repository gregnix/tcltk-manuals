---
CommandName: Tk_Init
title: Tk_Init
ManualSection: 3
Version: 8.0
TclPart: Tk
TclDescription: Tk Library Procedures
Keywords:
 - safe
 - application
 - initialization
 - load
 - main window
Copyright:
 - Copyright (c) 1995-1996 Sun Microsystems, Inc.
---

# Name

Tk\_Init, Tk\_SafeInit - add Tk to an interpreter and make a new Tk application.

# Synopsis

::: {.synopsis} :::
**#include <tk.h>**
[int]{.ret} [Tk\_Init]{.ccmd} [interp]{.cargs}
[int]{.ret} [Tk\_SafeInit]{.ccmd} [interp]{.cargs}
:::

# Arguments

::: {.arguments} :::

[\*interp]{.carg .in type="Tcl_Interp"}
: Interpreter in which to load Tk.  Tk should not already be loaded in this interpreter.

:::

# Description

**Tk\_Init** is the package initialization procedure for Tk. It is normally invoked by the [Tcl\_AppInit][AppInit] procedure for an application or by the [load] command. **Tk\_Init** adds all of Tk's commands to *interp* and creates a new Tk application, including its main window. If the initialization is successful **Tk\_Init** returns [TCL\_OK][catch];  if there is an error it returns [TCL\_ERROR][catch]. **Tk\_Init** also leaves a result or error message in interpreter *interp*'s result.

If there is a variable [argv][tclvars] in *interp*, **Tk\_Init** treats the contents of this variable as a list of options for the new Tk application. The options may have any of the forms documented for the [wish] application (in fact, [wish] uses Tk\_Init to process its command-line arguments).

**Tk\_SafeInit** is identical to **Tk\_Init** except that it removes all Tk commands that are considered unsafe.  Those commands and the reasons for their exclusion are:

[bell]
: Continuous ringing of the bell is a nuisance.

[clipboard]
: A malicious script could replace the contents of the clipboard with the string "**rm -r \***" and lead to surprises when the contents of the clipboard are pasted.

[grab]
: Grab can be used to block the user from using any other applications.

[menu]
: Menus can be used to cover the entire screen and to steal input from the user.

[selection]
: See clipboard.

[send]
: Send can be used to cause unsafe interpreters to execute commands.

[tk]
: The tk command recreates the send command, which is unsafe.

[tkwait]
: Tkwait can block the containing process forever

[toplevel]
: Toplevels can be used to cover the entire screen and to steal input from the user.

[wm]
: If toplevels are ever allowed, wm can be used to remove decorations, move windows around, etc.


[AppInit]: ../tcl-c/AppInit.md
[bell]: ../tk/bell.md
[catch]: ../tcl/catch.md
[clipboard]: ../tk/clipboard.md
[grab]: ../tk/grab.md
[load]: ../tcl/load.md
[menu]: ../tk/menu.md
[selection]: ../tk/selection.md
[send]: ../tk/send.md
[tclvars]: ../tcl/tclvars.md
[tk]: ../tk/tk.md
[tkwait]: ../tk/tkwait.md
[toplevel]: ../tk/toplevel.md
[wish]: ../tk/wish.md
[wm]: ../tk/wm.md
