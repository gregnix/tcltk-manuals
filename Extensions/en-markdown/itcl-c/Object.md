---
CommandName: Itcl_CreateObject
ManualSection: 3
Version: 3.0
TclPart: itcl
TclDescription: "[incr\\ Tcl] Library Procedures"
Keywords:
 - free
 - memory
Copyright:
 - Copyright (c) 1993-1998 Lucent Technologies, Inc.
---

# Name

Itcl_CreateObject, Itcl_DeleteObject, Itcl_FindObject, Itcl_IsObject, Itcl_IsObjectIsa - Manipulate an class instance.

# Synopsis

::: {.synopsis} :::
[#include]{.cmd} [\<itclInt.h>]{.lit}

void
[Itcl_PreserveData]{.cmd}([cdata]{.arg})

void
[Itcl_ReleaseData]{.cmd}([cdata]{.arg})

void
[Itcl_EventuallyFree]{.cmd}([cdata]{.arg}, [fproc]{.arg})
:::

# Arguments

Tcl_FreeProc *\*fproc* (in)
: Address of function to call when the block is to be freed.

void *\*clientData* (in)
: Arbitrary one-word value.


# Description
