---
CommandName: Itcl_PreserveData
title: Itcl_PreserveData
ManualSection: 3
Version: 3.0
TclPart: itcl
TclDescription: "[incr Tcl] Library Procedures"
Keywords:
 - free
 - memory
Copyright:
 - Copyright (c) 1993-1998 Lucent Technologies, Inc.
---

# Name

Itcl\_Alloc, Itcl\_Free, Itcl\_PreserveData, Itcl\_ReleaseData, Itcl\_EventuallyFree - Manipulate an Itcl list object.

# Synopsis

::: {.synopsis} :::
**#include <itcl.h>**

[void \*]{.ret} [Itcl\_Alloc]{.ccmd} [size]{.cargs}

[void]{.ret} [Itcl\_PreserveData]{.ccmd} [ptr]{.cargs}

[void]{.ret} [Itcl\_ReleaseData]{.ccmd} [ptr]{.cargs}

[void]{.ret} [Itcl\_EventuallyFree]{.ccmd} [ptr, fproc]{.cargs}

[void]{.ret} [Itcl\_Free]{.ccmd} [ptr]{.cargs}
:::

# Arguments

::: {.arguments} :::

[size]{.carg .in type="size_t"}
: Number of bytes to allocate.

[\*ptr]{.carg .in type="void"}
: Pointer value allocated by **Itcl\_Alloc**.

[\*fproc]{.carg .in type="Tcl_FreeProc"}
: Address of function to call when the block is to be freed.

:::

# Description

These procedures are used to allocate and release memory, especially blocks of memory that will be used by multiple independent modules. They are similar in function to the routines in the public Tcl interface, **Tcl\_Alloc**, **Tcl\_Free**, **Tcl\_Preserve**, **Tcl\_Release**, and **Tcl\_EventuallyFree**. The Tcl routines suffer from issues with performance scaling as the number of blocks managed grows large. The facilities of Itcl encounter these performance scaling issues and require an alternative that does not suffer from them.

**Itcl\_Alloc** returns an untyped pointer to an allocated block of memory of at least *size* bytes. All *size* bytes are initialized to zero.

A module calls **Itcl\_PreserveData** on a pointer *ptr* allocated by **Itcl\_Alloc** to prevent deallocation of that memory while the module remains interested in it.

A module calls **Itcl\_ReleaseData** on a pointer *ptr* previously preserved by **Itcl\_PreserveData** to indicate the module no longer has an interest in the block of memory, and will not be disturbed by its deallocation.

**Itcl\_EventuallyFree** is called on a pointer *ptr* allocated by **Itcl\_Alloc** to register a deallocation routine *fproc* to be called when the number of calls to **Itcl\_ReleaseData** on *ptr* matches the number of calls to **Itcl\_PreserveData** on *ptr*. This condition indicates all modules have ended their interest in the block of memory and a call to *fproc* with argument *ptr* will deallocate the memory that no module needs anymore.

**Itcl\_Free** is a deallocation routine for a *ptr* value allocated by **Itcl\_Alloc**. It may be called on any *ptr* with no history of an **Itcl\_PreserveData** call unmatched by an **Itcl\_ReleaseData** call. It is best used as an *fproc* argument to **Itcl\_EventuallyFree** or as a routine called from within such an *fproc* routine. It can also be used to deallocate a *ptr* value when it can be assured that value has never been passed to **Itcl\_PreserveData** or **Itcl\_EventuallyFree**.
