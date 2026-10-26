---
CommandName: Tcl_BooleanObj
title: Tcl_BooleanObj
ManualSection: 3
Version: 8.5
TclPart: Tcl
TclDescription: Tcl Library Procedures
Links:
 - Tcl_NewObj
 - Tcl_IsShared
 - Tcl_GetBoolean
Keywords:
 - boolean
 - value
Copyright:
 - Copyright (c) 1996-1997 Sun Microsystems, Inc.
---

# Name

Tcl\_NewBooleanObj, Tcl\_SetBooleanObj, Tcl\_GetBooleanFromObj - store/retrieve boolean value in a [Tcl\_Obj][Object]

# Synopsis

::: {.synopsis} :::
**#include <tcl.h>**
[Tcl\_Obj \*]{.ret} [Tcl\_NewBooleanObj]{.ccmd} [intValue]{.cargs}
[Tcl\_SetBooleanObj]{.ccmd} [objPtr, intValue]{.cargs}
[int]{.ret} [Tcl\_GetBooleanFromObj]{.ccmd} [interp, objPtr, intPtr]{.cargs}
:::

# Arguments

::: {.arguments} :::

[intValue]{.carg .in type="int"}
: Integer value to be stored as a boolean value in a [Tcl\_Obj][Object].

[\*objPtr]{.carg .in/out type="Tcl_Obj"}
: Points to the [Tcl\_Obj][Object] in which to store, or from which to retrieve a boolean value.

[\*interp]{.carg .in/out type="Tcl_Interp"}
: If a boolean value cannot be retrieved, an error message is left in the interpreter's result value unless *interp* is NULL.

[\*intPtr]{.carg .out type="int"}
: Points to place where **Tcl\_GetBooleanFromObj** stores the boolean value (0 or 1) obtained from *objPtr*.

:::

# Description

These procedures are used to pass boolean values to and from Tcl as [Tcl\_Obj][Object]'s.  When storing a boolean value into a [Tcl\_Obj][Object], any non-zero integer value in *intValue* is taken to be the boolean value **1**, and the integer value **0** is taken to be the boolean value **0**.

**Tcl\_NewBooleanObj** creates a new [Tcl\_Obj][Object], stores the boolean value *intValue* in it, and returns a pointer to the new [Tcl\_Obj][Object]. The new [Tcl\_Obj][Object] has reference count of zero.

**Tcl\_SetBooleanObj** accepts *objPtr*, a pointer to an existing [Tcl\_Obj][Object], and stores in the [Tcl\_Obj][Object] *\*objPtr* the boolean value *intValue*.  This is a write operation on *\*objPtr*, so *objPtr* must be unshared.  Attempts to write to a shared [Tcl\_Obj][Object] will panic.  A successful write of *intValue* into *\*objPtr* implies the freeing of any former value stored in *\*objPtr*.

**Tcl\_GetBooleanFromObj** attempts to retrieve a boolean value from the value stored in *\*objPtr*. If *objPtr* holds a string value recognized by [Tcl\_GetBoolean][GetInt], then the recognized boolean value is written at the address given by *intPtr*. If *objPtr* holds any value recognized as a number by Tcl, then if that value is zero a 0 is written at the address given by *intPtr* and if that value is non-zero a 1 is written at the address given by *intPtr*. In all cases where a value is written at the address given by *intPtr*, **Tcl\_GetBooleanFromObj** returns [TCL\_OK][catch]. If the value of *objPtr* does not meet any of the conditions above, then [TCL\_ERROR][catch] is returned and an error message is left in the interpreter's result unless *interp* is NULL. **Tcl\_GetBooleanFromObj** may also make changes to the internal fields of *\*objPtr* so that future calls to **Tcl\_GetBooleanFromObj** on the same *objPtr* can be performed more efficiently.

Note that the routines **Tcl\_GetBooleanFromObj** and [Tcl\_GetBoolean][GetInt] are not functional equivalents. The set of values for which **Tcl\_GetBooleanFromObj** will return [TCL\_OK][catch] is strictly larger than the set of values for which [Tcl\_GetBoolean][GetInt] will do the same. For example, the value "5" passed to **Tcl\_GetBooleanFromObj** will lead to a [TCL\_OK][catch] return (and the boolean value 1), while the same value passed to [Tcl\_GetBoolean][GetInt] will lead to a [TCL\_ERROR][catch] return.


[catch]: ../tcl/catch.md
[GetInt]: GetInt.md
[Object]: Object.md
