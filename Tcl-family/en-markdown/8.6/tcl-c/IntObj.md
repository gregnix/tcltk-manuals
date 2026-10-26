---
CommandName: Tcl_IntObj
title: Tcl_IntObj
ManualSection: 3
Version: 8.5
TclPart: Tcl
TclDescription: Tcl Library Procedures
Links:
 - Tcl_NewObj
 - Tcl_DecrRefCount
 - Tcl_IncrRefCount
 - Tcl_GetObjResult
Keywords:
 - integer
 - integer value
 - integer type
 - internal representation
 - value
 - value type
 - string representation
Copyright:
 - Copyright (c) 1996-1997 Sun Microsystems, Inc.
---

# Name

Tcl\_NewIntObj, Tcl\_NewLongObj, Tcl\_NewWideIntObj, Tcl\_SetIntObj, Tcl\_SetLongObj, Tcl\_SetWideIntObj, Tcl\_GetIntFromObj, Tcl\_GetLongFromObj, Tcl\_GetWideIntFromObj, Tcl\_NewBignumObj, Tcl\_SetBignumObj, Tcl\_GetBignumFromObj, Tcl\_TakeBignumFromObj - manipulate Tcl values as integers

# Synopsis

::: {.synopsis} :::
**#include <tcl.h>**
[Tcl\_Obj \*]{.ret} [Tcl\_NewIntObj]{.ccmd} [intValue]{.cargs}
[Tcl\_Obj \*]{.ret} [Tcl\_NewLongObj]{.ccmd} [longValue]{.cargs}
[Tcl\_Obj \*]{.ret} [Tcl\_NewWideIntObj]{.ccmd} [wideValue]{.cargs}
[Tcl\_SetIntObj]{.ccmd} [objPtr, intValue]{.cargs}
[Tcl\_SetLongObj]{.ccmd} [objPtr, longValue]{.cargs}
[Tcl\_SetWideIntObj]{.ccmd} [objPtr, wideValue]{.cargs}
[int]{.ret} [Tcl\_GetIntFromObj]{.ccmd} [interp, objPtr, intPtr]{.cargs}
[int]{.ret} [Tcl\_GetLongFromObj]{.ccmd} [interp, objPtr, longPtr]{.cargs}
[int]{.ret} [Tcl\_GetWideIntFromObj]{.ccmd} [interp, objPtr, widePtr]{.cargs}
**#include <tclTomMath.h>**
[Tcl\_Obj \*]{.ret} [Tcl\_NewBignumObj]{.ccmd} [bigValue]{.cargs}
[Tcl\_SetBignumObj]{.ccmd} [objPtr, bigValue]{.cargs}
[int]{.ret} [Tcl\_GetBignumFromObj]{.ccmd} [interp, objPtr, bigValue]{.cargs}
[int]{.ret} [Tcl\_TakeBignumFromObj]{.ccmd} [interp, objPtr, bigValue]{.cargs}
[int]{.ret} [Tcl\_InitBignumFromDouble]{.ccmd} [interp, doubleValue, bigValue]{.cargs}
:::

# Arguments

::: {.arguments} :::

[intValue]{.carg .in type="int"}
: Integer value used to initialize or set a Tcl value.

[longValue]{.carg .in type="long"}
: Long integer value used to initialize or set a Tcl value.

[wideValue]{.carg .in type="Tcl_WideInt"}
: Wide integer value used to initialize or set a Tcl value.

[\*objPtr]{.carg .in/out type="Tcl_Obj"}
: For **Tcl\_SetIntObj**, **Tcl\_SetLongObj**, **Tcl\_SetWideIntObj**, and **Tcl\_SetBignumObj**, this points to the value in which to store an integral value.  For **Tcl\_GetIntFromObj**, **Tcl\_GetLongFromObj**, **Tcl\_GetWideIntFromObj**, **Tcl\_GetBignumFromObj**, and **Tcl\_TakeBignumFromObj**, this refers to the value from which to retrieve an integral value.

[\*interp]{.carg .in/out type="Tcl_Interp"}
: When non-NULL, an error message is left here when integral value retrieval fails.

[\*intPtr]{.carg .out type="int"}
: Points to place to store the integer value retrieved from *objPtr*.

[\*longPtr]{.carg .out type="long"}
: Points to place to store the long integer value retrieved from *objPtr*.

[\*widePtr]{.carg .out type="Tcl_WideInt"}
: Points to place to store the wide integer value retrieved from *objPtr*.

[\*bigValue]{.carg .in/out type="mp_int"}
: Points to a multi-precision integer structure declared by the LibTomMath library.

[doubleValue]{.carg .in type="double"}
: Double value from which the integer part is determined and used to initialize a multi-precision integer value.

:::

# Description

These procedures are used to create, modify, and read Tcl values that hold integral values.

The different routines exist to accommodate different integral types in C with which values might be exchanged.  The C integral types for which Tcl provides value exchange routines are **int**, **long int**, **Tcl\_WideInt**, and **mp\_int**.  The **int** and **long int** types are provided by the C language standard.  The **Tcl\_WideInt** type is a typedef defined to be whatever signed integral type covers at least the 64-bit integer range (-9223372036854775808 to 9223372036854775807).  Depending on the platform and the C compiler, the actual type might be **long int**, **long long int**, **\_\_int64**, or something else. The **mp\_int** type is a multiple-precision integer type defined by the LibTomMath multiple-precision integer library.

The **Tcl\_NewIntObj**, **Tcl\_NewLongObj**, **Tcl\_NewWideIntObj**, and **Tcl\_NewBignumObj** routines each create and return a new Tcl value initialized to the integral value of the argument.  The returned Tcl value is unshared.

The **Tcl\_SetIntObj**, **Tcl\_SetLongObj**, **Tcl\_SetWideIntObj**, and **Tcl\_SetBignumObj** routines each set the value of an existing Tcl value pointed to by *objPtr* to the integral value provided by the other argument.  The *objPtr* argument must point to an unshared Tcl value.  Any attempt to set the value of a shared Tcl value violates Tcl's copy-on-write policy.  Any existing string representation or internal representation in the unshared Tcl value will be freed as a consequence of setting the new value.

The **Tcl\_GetIntFromObj**, **Tcl\_GetLongFromObj**, **Tcl\_GetWideIntFromObj**, **Tcl\_GetBignumFromObj**, and **Tcl\_TakeBignumFromObj** routines attempt to retrieve an integral value of the appropriate type from the Tcl value *objPtr*.  If the attempt succeeds, then [TCL\_OK][catch] is returned, and the value is written to the storage provided by the caller.  The attempt might fail if *objPtr* does not hold an integral value, or if the value exceeds the range of the target type.  If the attempt fails, then [TCL\_ERROR][catch] is returned, and if *interp* is non-NULL, an error message is left in *interp*.  The **Tcl\_ObjType** of *objPtr* may be changed to make subsequent calls to the same routine more efficient. Unlike the other functions, **Tcl\_TakeBignumFromObj** may set the content of the Tcl value *objPtr* to an empty string in the process of retrieving the multiple-precision integer value.

The choice between **Tcl\_GetBignumFromObj** and **Tcl\_TakeBignumFromObj** is governed by how the caller will continue to use *objPtr*.  If after the **mp\_int** value is retrieved from *objPtr*, the caller will make no more use of *objPtr*, then using **Tcl\_TakeBignumFromObj** permits Tcl to detect when an unshared *objPtr* permits the value to be moved instead of copied, which should be more efficient. If anything later in the caller requires *objPtr* to continue to hold the same value, then **Tcl\_GetBignumFromObj** must be chosen.

The **Tcl\_InitBignumFromDouble** routine is a utility procedure that extracts the integer part of *doubleValue* and stores that integer value in the **mp\_int** value *bigValue*.


[catch]: ../tcl/catch.md
