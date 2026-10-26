---
CommandName: Tcl_GetIndexFromObj
title: Tcl_GetIndexFromObj
ManualSection: 3
Version: 8.1
TclPart: Tcl
TclDescription: Tcl Library Procedures
Links:
 - prefix(n)
 - Tcl_WrongNumArgs(3)
Keywords:
 - index
 - option
 - value
 - table lookup
Copyright:
 - Copyright (c) 1997 Sun Microsystems, Inc.
---

# Name

Tcl\_GetIndexFromObj, Tcl\_GetIndexFromObjStruct - lookup string in table of keywords

# Synopsis

::: {.synopsis} :::
**#include <tcl.h>**
int Tcl\_GetIndexFromObj(interp, objPtr, tablePtr, msg, flags,
int Tcl\_GetIndexFromObjStruct(interp, objPtr, structTablePtr, offset,
:::

indexPtr)

msg, flags, indexPtr)

# Arguments

::: {.arguments} :::

[\*interp]{.carg .in type="Tcl_Interp"}
: Interpreter to use for error reporting; if NULL, then no message is provided on errors.

[\*objPtr]{.carg .in/out type="Tcl_Obj"}
: The string value of this value is used to search through *tablePtr*. The internal representation is modified to hold the index of the matching table entry.

[\*tablePtr]{.carg .in type="const char *const"}
: An array of null-terminated strings.  The end of the array is marked by a NULL string pointer. Note that references to the *tablePtr* may be retained in the internal representation of *objPtr*, so this should represent the address of a statically-allocated array.

[\*structTablePtr]{.carg .in type="const void"}
: An array of arbitrary type, typically some **struct** type. The first member of the structure must be a null-terminated string. The size of the structure is given by *offset*. Note that references to the *structTablePtr* may be retained in the internal representation of *objPtr*, so this should represent the address of a statically-allocated array of structures.

[offset]{.carg .in type="int"}
: The offset to add to structTablePtr to get to the next entry. The end of the array is marked by a NULL string pointer.

[\*msg]{.carg .in type="const char"}
: Null-terminated string describing what is being looked up, such as **option**.  This string is included in error messages.

[flags]{.carg .in type="int"}
: OR-ed combination of bits providing additional information for operation.  The only bit that is currently defined is **TCL\_EXACT**.

[\*indexPtr]{.carg .out type="int"}
: The index of the string in *tablePtr* that matches the value of *objPtr* is returned here.

:::

# Description

These procedures provide an efficient way for looking up keywords, switch names, option names, and similar things where the literal value of a Tcl value must be chosen from a predefined set. **Tcl\_GetIndexFromObj** compares *objPtr* against each of the strings in *tablePtr* to find a match.  A match occurs if *objPtr*'s string value is identical to one of the strings in *tablePtr*, or if it is a non-empty unique abbreviation for exactly one of the strings in *tablePtr* and the **TCL\_EXACT** flag was not specified; in either case the index of the matching entry is stored at *\*indexPtr* and [TCL\_OK][catch] is returned.

If there is no matching entry, [TCL\_ERROR][catch] is returned and an error message is left in *interp*'s result if *interp* is not NULL.  *Msg* is included in the error message to indicate what was being looked up.  For example, if *msg* is **option** the error message will have a form like "**bad option "firt": must be first, second, or third**".

If **Tcl\_GetIndexFromObj** completes successfully it modifies the internal representation of *objPtr* to hold the address of the table and the index of the matching entry.  If **Tcl\_GetIndexFromObj** is invoked again with the same *objPtr* and *tablePtr* arguments (e.g. during a reinvocation of a Tcl command), it returns the matching index immediately without having to redo the lookup operation.  Note: **Tcl\_GetIndexFromObj** assumes that the entries in *tablePtr* are static: they must not change between invocations.  If the value of *objPtr* is the empty string, **Tcl\_GetIndexFromObj** will treat it as a non-matching value and return [TCL\_ERROR][catch].

**Tcl\_GetIndexFromObjStruct** works just like **Tcl\_GetIndexFromObj**, except that instead of treating *tablePtr* as an array of string pointers, it treats it as a pointer to the first string in a series of strings that have *offset* bytes between them (i.e. that there is a pointer to the first array of characters at *tablePtr*, a pointer to the second array of characters at *tablePtr*+*offset* bytes, etc.) This is particularly useful when processing things like **Tk\_ConfigurationSpec**, whose string keys are in the same place in each of several array elements.


[catch]: ../tcl/catch.md
