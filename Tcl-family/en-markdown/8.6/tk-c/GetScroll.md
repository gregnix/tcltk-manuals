---
CommandName: Tk_GetScrollInfo
title: Tk_GetScrollInfo
ManualSection: 3
Version: 8.0
TclPart: Tk
TclDescription: Tk Library Procedures
Keywords:
 - parse
 - scrollbar
 - scrolling command
 - xview
 - yview
Copyright:
 - Copyright (c) 1994 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

Tk\_GetScrollInfoObj, Tk\_GetScrollInfo - parse arguments for scrolling commands

# Synopsis

::: {.synopsis} :::
**#include <tk.h>**
int Tk\_GetScrollInfoObj(interp, objc, objv, fractionPtr, stepsPtr)
int Tk\_GetScrollInfo(interp, argc, argv, fractionPtr, stepsPtr)
:::

# Arguments

::: {.arguments} :::

[\*interp]{.carg .in type="Tcl_Interp"}
: Interpreter to use for error reporting.

[objc]{.carg .in type="int"}
: Number of [Tcl\_Obj][Object]'s in *objv* array.

[objv]{.carg .in type="Tcl_Obj *const *"}
: Argument objects.  These represent the entire widget command, of which the first word is typically the widget name and the second word is typically **xview** or **yview**.

[argc]{.carg .in type="int"}
: Number of strings in *argv* array.

[argv]{.carg .in type="const char **"}
: Argument strings.  These represent the entire widget command, of which the first word is typically the widget name and the second word is typically **xview** or **yview**.

[\*fractionPtr]{.carg .out type="double"}
: Filled in with fraction from **moveto** option, if any.

[\*stepsPtr]{.carg .out type="int"}
: Filled in with line or page count from **scroll** option, if any. The value may be negative.

:::

# Description

**Tk\_GetScrollInfoObj** parses the arguments expected by widget scrolling commands such as **xview** and **yview**. It receives the entire list of words that make up a widget command and parses the words starting with *objv*\[2\]. The words starting with *objv*\[2\] must have one of the following forms:

```
moveto fraction
scroll number units
scroll number pages
```

Any of the **moveto**, **scroll**, **units**, and **pages** keywords may be abbreviated. If *objv* has the **moveto** form, **TK\_SCROLL\_MOVETO** is returned as result and *\*fractionPtr* is filled in with the *fraction* argument to the command, which must be a proper real value. If *objv* has the **scroll** form, **TK\_SCROLL\_UNITS** or **TK\_SCROLL\_PAGES** is returned and *\*stepsPtr* is filled in with the *number* value, which must be a proper integer. If an error occurs in parsing the arguments, **TK\_SCROLL\_ERROR** is returned and an error message is left in interpreter *interp*'s result.

**Tk\_GetScrollInfo** is identical in function to **Tk\_GetScrollInfoObj**.  However, **Tk\_GetScrollInfo** accepts string arguments, making it more appropriate for use with legacy widgets.


[Object]: ../tcl-c/Object.md
