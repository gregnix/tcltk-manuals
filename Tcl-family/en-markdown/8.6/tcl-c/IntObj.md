---
CommandName: Tcl_IntObj
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

Tcl_NewIntObj, Tcl_NewLongObj, Tcl_NewWideIntObj, Tcl_SetIntObj, Tcl_SetLongObj, Tcl_SetWideIntObj, Tcl_GetIntFromObj, Tcl_GetLongFromObj, Tcl_GetWideIntFromObj, Tcl_NewBignumObj, Tcl_SetBignumObj, Tcl_GetBignumFromObj, Tcl_TakeBignumFromObj - manipulate Tcl values as integers

# Synopsis

::: {.synopsis} :::
[#include]{.cmd} [\<tcl.h>]{.lit}

Tcl_Obj \*
[Tcl_NewIntObj]{.cmd}([intValue]{.arg})

Tcl_Obj \*
[Tcl_NewLongObj]{.cmd}([longValue]{.arg})

Tcl_Obj \*
[Tcl_NewWideIntObj]{.cmd}([wideValue]{.arg})

[Tcl_SetIntObj]{.cmd}([objPtr]{.arg}, [intValue]{.arg})

[Tcl_SetLongObj]{.cmd}([objPtr]{.arg}, [longValue]{.arg})

[Tcl_SetWideIntObj]{.cmd}([objPtr]{.arg}, [wideValue]{.arg})

int
[Tcl_GetIntFromObj]{.cmd}([interp]{.arg}, [objPtr]{.arg}, [intPtr]{.arg})

int
[Tcl_GetLongFromObj]{.cmd}([interp]{.arg}, [objPtr]{.arg}, [longPtr]{.arg})

int
[Tcl_GetWideIntFromObj]{.cmd}([interp]{.arg}, [objPtr]{.arg}, [widePtr]{.arg})

[#include]{.cmd} [\<tclTomMath.h>]{.lit}

Tcl_Obj \*
[Tcl_NewBignumObj]{.cmd}([bigValue]{.arg})

[Tcl_SetBignumObj]{.cmd}([objPtr]{.arg}, [bigValue]{.arg})

int
[Tcl_GetBignumFromObj]{.cmd}([interp]{.arg}, [objPtr]{.arg}, [bigValue]{.arg})

int
[Tcl_TakeBignumFromObj]{.cmd}([interp]{.arg}, [objPtr]{.arg}, [bigValue]{.arg})

int
[Tcl_InitBignumFromDouble]{.cmd}([interp]{.arg}, [doubleValue]{.arg}, [bigValue]{.arg})
:::

# Arguments

int *intValue* (in)
: Integer value used to initialize or set a Tcl value.

long *longValue* (in)
: Long integer value used to initialize or set a Tcl value.

Tcl_WideInt *wideValue* (in)
: Wide integer value used to initialize or set a Tcl value.

Tcl_Obj *\*objPtr* (in/out)
: For **Tcl_SetIntObj**, **Tcl_SetLongObj**, **Tcl_SetWideIntObj**, and **Tcl_SetBignumObj**, this points to the value in which to store an integral value.  For **Tcl_GetIntFromObj**, **Tcl_GetLongFromObj**, **Tcl_GetWideIntFromObj**, **Tcl_GetBignumFromObj**, and **Tcl_TakeBignumFromObj**, this refers to the value from which to retrieve an integral value.

Tcl_Interp *\*interp* (in/out)
: When non-NULL, an error message is left here when integral value retrieval fails.

int *\*intPtr* (out)
: Points to place to store the integer value retrieved from *objPtr*.

long *\*longPtr* (out)
: Points to place to store the long integer value retrieved from *objPtr*.

Tcl_WideInt *\*widePtr* (out)
: Points to place to store the wide integer value retrieved from *objPtr*.

mp_int *\*bigValue* (in/out)
: Points to a multi-precision integer structure declared by the LibTomMath library.

double *doubleValue* (in)
: Double value from which the integer part is determined and used to initialize a multi-precision integer value.


# Description

These procedures are used to create, modify, and read Tcl values that hold integral values.

The different routines exist to accommodate different integral types in C with which values might be exchanged.  The C integral types for which Tcl provides value exchange routines are **int**, **long int**, **Tcl_WideInt**, and **mp_int**.  The **int** and **long int** types are provided by the C language standard.  The **Tcl_WideInt** type is a typedef defined to be whatever signed integral type covers at least the 64-bit integer range (-9223372036854775808 to 9223372036854775807).  Depending on the platform and the C compiler, the actual type might be **long int**, **long long int**, **\__int64**, or something else. The **mp_int** type is a multiple-precision integer type defined by the LibTomMath multiple-precision integer library.

The **Tcl_NewIntObj**, **Tcl_NewLongObj**, **Tcl_NewWideIntObj**, and **Tcl_NewBignumObj** routines each create and return a new Tcl value initialized to the integral value of the argument.  The returned Tcl value is unshared.

The **Tcl_SetIntObj**, **Tcl_SetLongObj**, **Tcl_SetWideIntObj**, and **Tcl_SetBignumObj** routines each set the value of an existing Tcl value pointed to by *objPtr* to the integral value provided by the other argument.  The *objPtr* argument must point to an unshared Tcl value.  Any attempt to set the value of a shared Tcl value violates Tcl's copy-on-write policy.  Any existing string representation or internal representation in the unshared Tcl value will be freed as a consequence of setting the new value.

The **Tcl_GetIntFromObj**, **Tcl_GetLongFromObj**, **Tcl_GetWideIntFromObj**, **Tcl_GetBignumFromObj**, and **Tcl_TakeBignumFromObj** routines attempt to retrieve an integral value of the appropriate type from the Tcl value *objPtr*.  If the attempt succeeds, then **TCL_OK** is returned, and the value is written to the storage provided by the caller.  The attempt might fail if *objPtr* does not hold an integral value, or if the value exceeds the range of the target type.  If the attempt fails, then **TCL_ERROR** is returned, and if *interp* is non-NULL, an error message is left in *interp*.  The **Tcl_ObjType** of *objPtr* may be changed to make subsequent calls to the same routine more efficient. Unlike the other functions, **Tcl_TakeBignumFromObj** may set the content of the Tcl value *objPtr* to an empty string in the process of retrieving the multiple-precision integer value.

The choice between **Tcl_GetBignumFromObj** and **Tcl_TakeBignumFromObj** is governed by how the caller will continue to use *objPtr*.  If after the **mp_int** value is retrieved from *objPtr*, the caller will make no more use of *objPtr*, then using **Tcl_TakeBignumFromObj** permits Tcl to detect when an unshared *objPtr* permits the value to be moved instead of copied, which should be more efficient. If anything later in the caller requires *objPtr* to continue to hold the same value, then **Tcl_GetBignumFromObj** must be chosen.

The **Tcl_InitBignumFromDouble** routine is a utility procedure that extracts the integer part of *doubleValue* and stores that integer value in the **mp_int** value *bigValue*.
