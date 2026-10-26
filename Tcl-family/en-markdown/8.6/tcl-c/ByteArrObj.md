---
CommandName: Tcl_ByteArrayObj
title: Tcl_ByteArrayObj
ManualSection: 3
Version: 8.1
TclPart: Tcl
TclDescription: Tcl Library Procedures
Links:
 - Tcl_GetStringFromObj
 - Tcl_NewObj
 - Tcl_IncrRefCount
 - Tcl_DecrRefCount
Keywords:
 - value
 - binary data
 - byte array
 - utf
 - unicode
 - internationalization
Copyright:
 - Copyright (c) 1997 Sun Microsystems, Inc.
---

# Name

Tcl\_NewByteArrayObj, Tcl\_SetByteArrayObj, Tcl\_GetByteArrayFromObj, Tcl\_SetByteArrayLength - manipulate Tcl values as a arrays of bytes

# Synopsis

::: {.synopsis} :::
**#include <tcl.h>**
[Tcl\_Obj \*]{.ret} [Tcl\_NewByteArrayObj]{.ccmd} [bytes, length]{.cargs}
[void]{.ret} [Tcl\_SetByteArrayObj]{.ccmd} [objPtr, bytes, length]{.cargs}
[unsigned char \*]{.ret} [Tcl\_GetByteArrayFromObj]{.ccmd} [objPtr, lengthPtr]{.cargs}
[unsigned char \*]{.ret} [Tcl\_SetByteArrayLength]{.ccmd} [objPtr, length]{.cargs}
:::

# Arguments

::: {.arguments} :::

[\*bytes]{.carg .in type="const unsigned char"}
: The array of bytes used to initialize or set a byte-array value. May be NULL even if *length* is non-zero.

[length]{.carg .in type="int"}
: The length of the array of bytes.  It must be >= 0.

[\*objPtr]{.carg .in/out type="Tcl_Obj"}
: For **Tcl\_SetByteArrayObj**, this points to the value to be converted to byte-array type.  For **Tcl\_GetByteArrayFromObj** and **Tcl\_SetByteArrayLength**, this points to the value from which to get the byte-array value; if *objPtr* does not already point to a byte-array value, it will be converted to one.

[\*lengthPtr]{.carg .out type="int"}
: If non-NULL, filled with the length of the array of bytes in the value.

:::

# Description

These procedures are used to create, modify, and read Tcl byte-array values from C code.  Byte-array values are typically used to hold the results of binary IO operations or data structures created with the [binary] command.  In Tcl, an array of bytes is not equivalent to a string.  Conceptually, a string is an array of Unicode characters, while a byte-array is an array of 8-bit quantities with no implicit meaning. Accessor functions are provided to get the string representation of a byte-array or to convert an arbitrary value to a byte-array.  Obtaining the string representation of a byte-array value (by calling [Tcl\_GetStringFromObj][StringObj]) produces a properly formed UTF-8 sequence with a one-to-one mapping between the bytes in the internal representation and the UTF-8 characters in the string representation.

**Tcl\_NewByteArrayObj** and **Tcl\_SetByteArrayObj** will create a new value of byte-array type or modify an existing value to have a byte-array type.  Both of these procedures set the value's type to be byte-array and set the value's internal representation to a copy of the array of bytes given by *bytes*. **Tcl\_NewByteArrayObj** returns a pointer to a newly allocated value with a reference count of zero. **Tcl\_SetByteArrayObj** invalidates any old string representation and, if the value is not already a byte-array value, frees any old internal representation. If *bytes* is NULL then the new byte array contains arbitrary values.

**Tcl\_GetByteArrayFromObj** converts a Tcl value to byte-array type and returns a pointer to the value's new internal representation as an array of bytes.  The length of this array is stored in *lengthPtr* if *lengthPtr* is non-NULL.  The storage for the array of bytes is owned by the value and should not be freed.  The contents of the array may be modified by the caller only if the value is not shared and the caller invalidates the string representation.

**Tcl\_SetByteArrayLength** converts the Tcl value to byte-array type and changes the length of the value's internal representation as an array of bytes.  If *length* is greater than the space currently allocated for the array, the array is reallocated to the new length; the newly allocated bytes at the end of the array have arbitrary values.  If *length* is less than the space currently allocated for the array, the length of array is reduced to the new length.  The return value is a pointer to the value's new array of bytes.


[binary]: ../tcl/binary.md
[StringObj]: StringObj.md
