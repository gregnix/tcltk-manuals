---
CommandName: Itcl_CreateObject
title: Itcl_CreateObject
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

Itcl\_CreateObject, Itcl\_DeleteObject, Itcl\_FindObject, Itcl\_IsObject, Itcl\_IsObjectIsa - Manipulate an class instance.

# Synopsis

::: {.synopsis} :::
**#include <itclInt.h>**

[void]{.ret} [Itcl\_PreserveData]{.ccmd} [cdata]{.cargs}

[void]{.ret} [Itcl\_ReleaseData]{.ccmd} [cdata]{.cargs}

[void]{.ret} [Itcl\_EventuallyFree]{.ccmd} [cdata, fproc]{.cargs}
:::

# Arguments

::: {.arguments} :::

[\*fproc]{.carg .in type="Tcl_FreeProc"}
: Address of function to call when the block is to be freed.

[\*clientData]{.carg .in type="void"}
: Arbitrary one-word value.

:::

# Description
