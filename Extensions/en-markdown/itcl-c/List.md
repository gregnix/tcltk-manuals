---
CommandName: Itcl_InitList
title: Itcl_InitList
ManualSection: 3
Version: 3.0
TclPart: itcl
TclDescription: "[incr Tcl] Library Procedures"
Keywords:
 - list
Copyright:
 - Copyright (c) 1993-1998 Lucent Technologies, Inc.
---

# Name

Itcl\_InitList, Itcl\_DeleteList, Itcl\_CreateListElem, Itcl\_DeleteListElem, Itcl\_InsertList, Itcl\_InsertListElem, Itcl\_AppendList, Itcl\_AppendListElem, Itcl\_SetListValue - Manipulate an Itcl list object.

# Synopsis

::: {.synopsis} :::
**#include <itcl.h>**

[void]{.ret} [Itcl\_InitList]{.ccmd} [list]{.cargs}

[void]{.ret} [Itcl\_DeleteList]{.ccmd} [list]{.cargs}

[Itcl\_ListElem \*]{.ret} [Itcl\_CreateListElem]{.ccmd} [list]{.cargs}

[Itcl\_ListElem \*]{.ret} [Itcl\_DeleteListElem]{.ccmd} [elem]{.cargs}

[Itcl\_ListElem \*]{.ret} [Itcl\_InsertList]{.ccmd} [list, clientData]{.cargs}

[Itcl\_ListElem \*]{.ret} [Itcl\_InsertListElem]{.ccmd} [elem, clientData]{.cargs}

[Itcl\_ListElem \*]{.ret} [Itcl\_AppendList]{.ccmd} [list, clientData]{.cargs}

[Itcl\_ListElem \*]{.ret} [Itcl\_AppendListElem]{.ccmd} [elem, clientData]{.cargs}

[void]{.ret} [Itcl\_SetListValue]{.ccmd} [elem, clientData]{.cargs}
:::

# Arguments

::: {.arguments} :::

[\*list]{.carg .in type="Itcl_List"}
: List info structure.

[\*elem]{.carg .in type="Itcl_ListElem"}
: List element info structure.

[\*clientData]{.carg .in type="void"}
: Arbitrary one-word value to save in the list.

:::

# Description
