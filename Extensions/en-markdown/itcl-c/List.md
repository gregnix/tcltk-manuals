---
CommandName: Itcl_InitList
ManualSection: 3
Version: 3.0
TclPart: itcl
TclDescription: "[incr\\ Tcl] Library Procedures"
Keywords:
 - list
Copyright:
 - Copyright (c) 1993-1998 Lucent Technologies, Inc.
---

# Name

Itcl_InitList, Itcl_DeleteList, Itcl_CreateListElem, Itcl_DeleteListElem, Itcl_InsertList, Itcl_InsertListElem, Itcl_AppendList, Itcl_AppendListElem, Itcl_SetListValue - Manipulate an Itcl list object.

# Synopsis

::: {.synopsis} :::
[#include]{.cmd} [\<itcl.h>]{.lit}

void
[Itcl_InitList]{.cmd}([list]{.arg})

void
[Itcl_DeleteList]{.cmd}([list]{.arg})

Itcl_ListElem \*
[Itcl_CreateListElem]{.cmd}([list]{.arg})

Itcl_ListElem \*
[Itcl_DeleteListElem]{.cmd}([elem]{.arg})

Itcl_ListElem \*
[Itcl_InsertList]{.cmd}([list]{.arg}, [clientData]{.arg})

Itcl_ListElem \*
[Itcl_InsertListElem]{.cmd}([elem]{.arg}, [clientData]{.arg})

Itcl_ListElem \*
[Itcl_AppendList]{.cmd}([list]{.arg}, [clientData]{.arg})

Itcl_ListElem \*
[Itcl_AppendListElem]{.cmd}([elem]{.arg}, [clientData]{.arg})

void
[Itcl_SetListValue]{.cmd}([elem]{.arg}, [clientData]{.arg})
:::

# Arguments

Itcl_List *\*list* (in)
: List info structure.

Itcl_ListElem *\*elem* (in)
: List element info structure.

void *\*clientData* (in)
: Arbitrary one-word value to save in the list.


# Description
