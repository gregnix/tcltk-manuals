---
CommandName: Itcl_InitStack
ManualSection: 3
Version: 3.0
TclPart: itcl
TclDescription: "[incr\\ Tcl] Library Procedures"
Keywords:
 - stack
Copyright:
 - Copyright (c) 1993-1998 Lucent Technologies, Inc.
---

# Name

Itcl_InitStack, Itcl_DeleteStack, Itcl_PushStack, Itcl_PopStack, Itcl_PeekStack, Itcl_GetStackValue, Itcl_GetStackSize - Manipulate an Itcl stack object.

# Synopsis

::: {.synopsis} :::
[#include]{.cmd} [\<itcl.h>]{.lit}

int
[Itcl_InitStack]{.cmd}([stack]{.arg})

int
[Itcl_DeleteStack]{.cmd}([stack]{.arg})

int
[Itcl_PushStack]{.cmd}([cdata]{.arg}, [stack]{.arg})

void \*
[Itcl_PopStack]{.cmd}([stack]{.arg})

void \*
[Itcl_PeekStack]{.cmd}([stack]{.arg})

void \*
[Itcl_GetStackValue]{.cmd}([stack]{.arg}, [pos]{.arg})

int
[Itcl_GetStackSize]{.cmd}([stack]{.arg})
:::

# Arguments

Itcl_Stack *\*stack* (in)
: Stack info structure.

int *pos* (in)
: position in stack order from the top.

void *\*clientData* (in)
: Arbitrary one-word value to save in the stack.


# Description

**Itcl_InitStack** initializes a stack structure and **Itcl_DeleteStack** deletes it. **Itcl_PushStack** pushes the *cdata* value onto the stack. **Itcl_PopStack** removes and returns the top most *cdata* value. **Itcl_PeekStack** returns the top most value, but does not remove it. **Itcl_GetStackValue** gets a value at some index within the stack.  Index "0" is the first value pushed onto the stack. **Itcl_GetStackSize** returns the count of entries on the stack.
