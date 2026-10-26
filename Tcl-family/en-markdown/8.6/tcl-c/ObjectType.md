---
CommandName: Tcl_ObjType
title: Tcl_ObjType
ManualSection: 3
Version: 8.0
TclPart: Tcl
TclDescription: Tcl Library Procedures
Links:
 - Tcl_NewObj(3)
 - Tcl_DecrRefCount(3)
 - Tcl_IncrRefCount(3)
Keywords:
 - internal representation
 - value
 - value type
 - string representation
 - type conversion
Copyright:
 - Copyright (c) 1996-1997 Sun Microsystems, Inc.
---

# Name

Tcl\_RegisterObjType, Tcl\_GetObjType, Tcl\_AppendAllObjTypes, Tcl\_ConvertToType  - manipulate Tcl value types

# Synopsis

::: {.synopsis} :::
**#include <tcl.h>**
[Tcl\_RegisterObjType]{.ccmd} [typePtr]{.cargs}
[const Tcl\_ObjType \*]{.ret} [Tcl\_GetObjType]{.ccmd} [typeName]{.cargs}
[int]{.ret} [Tcl\_AppendAllObjTypes]{.ccmd} [interp, objPtr]{.cargs}
[int]{.ret} [Tcl\_ConvertToType]{.ccmd} [interp, objPtr, typePtr]{.cargs}
:::

# Arguments

::: {.arguments} :::

[\*typePtr]{.carg .in type="const Tcl_ObjType"}
: Points to the structure containing information about the Tcl value type. This storage must live forever, typically by being statically allocated.

[\*typeName]{.carg .in type="const char"}
: The name of a Tcl value type that **Tcl\_GetObjType** should look up.

[\*interp]{.carg .in type="Tcl_Interp"}
: Interpreter to use for error reporting.

[\*objPtr]{.carg .in type="Tcl_Obj"}
: For **Tcl\_AppendAllObjTypes**, this points to the value onto which it appends the name of each value type as a list element. For **Tcl\_ConvertToType**, this points to a value that must have been the result of a previous call to [Tcl\_NewObj][Object].

:::

# Description

The procedures in this man page manage Tcl value types (sometimes referred to as object types or **Tcl\_ObjType**s for historical reasons). They are used to register new value types, look up types, and force conversions from one type to another.

**Tcl\_RegisterObjType** registers a new Tcl value type in the table of all value types that **Tcl\_GetObjType** can look up by name.  There are other value types supported by Tcl as well, which Tcl chooses not to register.  Extensions can likewise choose to register the value types they create or not. The argument *typePtr* points to a Tcl\_ObjType structure that describes the new type by giving its name and by supplying pointers to four procedures that implement the type. If the type table already contains a type with the same name as in *typePtr*, it is replaced with the new type. The Tcl\_ObjType structure is described in the section [The Tcl\_ObjType structure] below.

**Tcl\_GetObjType** returns a pointer to the registered Tcl\_ObjType with name *typeName*. It returns NULL if no type with that name is registered.

**Tcl\_AppendAllObjTypes** appends the name of each registered value type as a list element onto the Tcl value referenced by *objPtr*. The return value is [TCL\_OK][catch] unless there was an error converting *objPtr* to a list value; in that case [TCL\_ERROR][catch] is returned.

**Tcl\_ConvertToType** converts a value from one type to another if possible. It creates a new internal representation for *objPtr* appropriate for the target type *typePtr* and sets its *typePtr* member as determined by calling the *typePtr->setFromAnyProc* routine. Any internal representation for *objPtr*'s old type is freed. If an error occurs during conversion, it returns [TCL\_ERROR][catch] and leaves an error message in the result value for *interp* unless *interp* is NULL. Otherwise, it returns [TCL\_OK][catch]. Passing a NULL *interp* allows this procedure to be used as a test whether the conversion can be done (and in fact was done).

In many cases, the *typePtr->setFromAnyProc* routine will set *objPtr->typePtr* to the argument value *typePtr*, but that is no longer guaranteed.  The *setFromAnyProc* is free to set the internal representation for *objPtr* to make use of another related Tcl\_ObjType, if it sees fit.

# The Tcl\_ObjType structure

Extension writers can define new value types by defining four procedures and initializing a Tcl\_ObjType structure to describe the type. Extension writers may also pass a pointer to their Tcl\_ObjType structure to **Tcl\_RegisterObjType** if they wish to permit other extensions to look up their Tcl\_ObjType by name with the **Tcl\_GetObjType** routine. The **Tcl\_ObjType** structure is defined as follows:

```
typedef struct Tcl_ObjType {
    const char *name;
    Tcl_FreeInternalRepProc *freeIntRepProc;
    Tcl_DupInternalRepProc *dupIntRepProc;
    Tcl_UpdateStringProc *updateStringProc;
    Tcl_SetFromAnyProc *setFromAnyProc;
} Tcl_ObjType;
```

## The name field

The *name* member describes the name of the type, e.g. **int**. When a type is registered, this is the name used by callers of **Tcl\_GetObjType** to lookup the type.  For unregistered types, the *name* field is primarily of value for debugging. The remaining four members are pointers to procedures called by the generic Tcl value code:

## The setFromAnyProc field

The *setFromAnyProc* member contains the address of a function called to create a valid internal representation from a value's string representation.

```
typedef int Tcl_SetFromAnyProc(
        Tcl_Interp *interp,
        Tcl_Obj *objPtr);
```

If an internal representation cannot be created from the string, it returns [TCL\_ERROR][catch] and puts a message describing the error in the result value for *interp* unless *interp* is NULL. If *setFromAnyProc* is successful, it stores the new internal representation, sets *objPtr*'s *typePtr* member to point to the **Tcl\_ObjType** struct corresponding to the new internal representation, and returns [TCL\_OK][catch]. Before setting the new internal representation, the *setFromAnyProc* must free any internal representation of *objPtr*'s old type; it does this by calling the old type's *freeIntRepProc* if it is not NULL.

As an example, the *setFromAnyProc* for the built-in Tcl list type gets an up-to-date string representation for *objPtr* by calling [Tcl\_GetStringFromObj][StringObj]. It parses the string to verify it is in a valid list format and to obtain each element value in the list, and, if this succeeds, stores the list elements in *objPtr*'s internal representation and sets *objPtr*'s *typePtr* member to point to the list type's Tcl\_ObjType structure.

Do not release *objPtr*'s old internal representation unless you replace it with a new one or reset the *typePtr* member to NULL.

The *setFromAnyProc* member may be set to NULL, if the routines making use of the internal representation have no need to derive that internal representation from an arbitrary string value.  However, in this case, passing a pointer to the type to **Tcl\_ConvertToType** will lead to a panic, so to avoid this possibility, the type should *not* be registered.

## The updateStringProc field

The *updateStringProc* member contains the address of a function called to create a valid string representation from a value's internal representation.

```
typedef void Tcl_UpdateStringProc(
        Tcl_Obj *objPtr);
```

*objPtr*'s *bytes* member is always NULL when it is called. It must always set *bytes* non-NULL before returning. We require the string representation's byte array to have a null after the last byte, at offset *length*, and to have no null bytes before that; this allows string representations to be treated as conventional null character-terminated C strings. These restrictions are easily met by using Tcl's internal UTF encoding for the string representation, same as one would do for other Tcl routines accepting string values as arguments. Storage for the byte array must be allocated in the heap by [Tcl\_Alloc][Alloc] or [ckalloc][Alloc].  Note that *updateStringProc*s must allocate enough storage for the string's bytes and the terminating null byte.

The *updateStringProc* for Tcl's built-in double type, for example, calls [Tcl\_PrintDouble][PrintDbl] to write to a buffer of size TCL\_DOUBLE\_SPACE, then allocates and copies the string representation to just enough space to hold it.  A pointer to the allocated space is stored in the *bytes* member.

The *updateStringProc* member may be set to NULL, if the routines making use of the internal representation are written so that the string representation is never invalidated.  Failure to meet this obligation will lead to panics or crashes when [Tcl\_GetStringFromObj][StringObj] or other similar routines ask for the string representation.

## The dupIntRepProc field

The *dupIntRepProc* member contains the address of a function called to copy an internal representation from one value to another.

```
typedef void Tcl_DupInternalRepProc(
        Tcl_Obj *srcPtr,
        Tcl_Obj *dupPtr);
```

*dupPtr*'s internal representation is made a copy of *srcPtr*'s internal representation. Before the call, *srcPtr*'s internal representation is valid and *dupPtr*'s is not. *srcPtr*'s value type determines what copying its internal representation means.

For example, the *dupIntRepProc* for the Tcl integer type simply copies an integer. The built-in list type's *dupIntRepProc* uses a far more sophisticated scheme to continue sharing storage as much as it reasonably can.

## The freeIntRepProc field

The *freeIntRepProc* member contains the address of a function that is called when a value is freed.

```
typedef void Tcl_FreeInternalRepProc(
        Tcl_Obj *objPtr);
```

The *freeIntRepProc* function can deallocate the storage for the value's internal representation and do other type-specific processing necessary when a value is freed.

For example, the list type's *freeIntRepProc* respects the storage sharing scheme established by the *dupIntRepProc* so that it only frees storage when the last value sharing it is being freed.

The *freeIntRepProc* member can be set to NULL to indicate that the internal representation does not require freeing. The *freeIntRepProc* implementation must not access the *bytes* member of the value, since Tcl makes its own internal uses of that field during value deletion.  The defined tasks for the *freeIntRepProc* have no need to consult the *bytes* member.


[Alloc]: Alloc.md
[catch]: ../tcl/catch.md
[Object]: Object.md
[PrintDbl]: PrintDbl.md
[StringObj]: StringObj.md
