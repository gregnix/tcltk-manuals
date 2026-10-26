---
CommandName: Tcl_Alloc
title: Tcl_Alloc
ManualSection: 3
Version: 7.5
TclPart: Tcl
TclDescription: Tcl Library Procedures
Keywords:
 - alloc
 - allocation
 - free
 - malloc
 - memory
 - realloc
 - TCL_MEM_DEBUG
Copyright:
 - Copyright (c) 1995-1996 Sun Microsystems, Inc.
---

# Name

Tcl\_Alloc, Tcl\_Free, Tcl\_Realloc, Tcl\_AttemptAlloc, Tcl\_AttemptRealloc, Tcl\_GetMemoryInfo, ckalloc, ckfree, ckrealloc, attemptckalloc, attemptckrealloc - allocate or free heap memory

# Synopsis

::: {.synopsis} :::
**#include <tcl.h>**
[char \*]{.ret} [Tcl\_Alloc]{.ccmd} [size]{.cargs}
[void]{.ret} [Tcl\_Free]{.ccmd} [ptr]{.cargs}
[char \*]{.ret} [Tcl\_Realloc]{.ccmd} [ptr, size]{.cargs}
[char \*]{.ret} [Tcl\_AttemptAlloc]{.ccmd} [size]{.cargs}
[char \*]{.ret} [Tcl\_AttemptRealloc]{.ccmd} [ptr, size]{.cargs}
[void]{.ret} [Tcl\_GetMemoryInfo]{.ccmd} [dsPtr]{.cargs}
[char \*]{.ret} [ckalloc]{.ccmd} [size]{.cargs}
[void]{.ret} [ckfree]{.ccmd} [ptr]{.cargs}
[char \*]{.ret} [ckrealloc]{.ccmd} [ptr, size]{.cargs}
[char \*]{.ret} [attemptckalloc]{.ccmd} [size]{.cargs}
[char \*]{.ret} [attemptckrealloc]{.ccmd} [ptr, size]{.cargs}
:::

# Arguments

::: {.arguments} :::

[size]{.carg .in type="unsigned int"}
: Size in bytes of the memory block to allocate.

[\*ptr]{.carg .in type="char"}
: Pointer to memory block to free or realloc.

[\*dsPtr]{.carg .in type="Tcl_DString"}
: Initialized DString pointer.

:::

# Description

These procedures provide a platform and compiler independent interface for memory allocation.  Programs that need to transfer ownership of memory blocks between Tcl and other modules should use these routines rather than the native **malloc()** and **free()** routines provided by the C run-time library.

**Tcl\_Alloc** returns a pointer to a block of at least *size* bytes suitably aligned for any use.

**Tcl\_Free** makes the space referred to by *ptr* available for further allocation.

**Tcl\_Realloc** changes the size of the block pointed to by *ptr* to *size* bytes and returns a pointer to the new block. The contents will be unchanged up to the lesser of the new and old sizes.  The returned location may be different from *ptr*.  If *ptr* is NULL, this is equivalent to calling **Tcl\_Alloc** with just the *size* argument.

**Tcl\_AttemptAlloc** and **Tcl\_AttemptRealloc** are identical in function to **Tcl\_Alloc** and **Tcl\_Realloc**, except that **Tcl\_AttemptAlloc** and **Tcl\_AttemptRealloc** will not cause the Tcl interpreter to **panic** if the memory allocation fails.  If the allocation fails, these functions will return NULL.  Note that on some platforms, but not all, attempting to allocate a zero-sized block of memory will also cause these functions to return NULL.

The procedures **ckalloc**, **ckfree**, **ckrealloc**, **attemptckalloc**, and **attemptckrealloc** are implemented as macros.  Normally, they are synonyms for the corresponding procedures documented on this page.  When Tcl and all modules calling Tcl are compiled with [TCL\_MEM\_DEBUG][TCL_MEM_DEBUG] defined, however, these macros are redefined to be special debugging versions of these procedures.  To support Tcl's memory debugging within a module, use the macros rather than direct calls to **Tcl\_Alloc**, etc.  **Tcl\_GetMemoryInfo** appends a list-of-lists of memory stats to the provided DString. This function cannot be used in stub-enabled extensions, and it is only available if Tcl is compiled with the threaded memory allocator.


[TCL_MEM_DEBUG]: TCL_MEM_DEBUG.md
