---
CommandName: Itcl_InitStack
title: Itcl_InitStack
ManualSection: 3
Version: 3.0
TclPart: itcl
TclDescription: "[incr Tcl] Library Procedures"
Keywords:
 - stack
Copyright:
 - Copyright (c) 1993-1998 Lucent Technologies, Inc.
---

# Name

Itcl\_InitStack, Itcl\_DeleteStack, Itcl\_PushStack, Itcl\_PopStack, Itcl\_PeekStack, Itcl\_GetStackValue, Itcl\_GetStackSize - Manipulate an Itcl stack object.

# Synopsis

::: {.synopsis} :::
**#include <itcl.h>**

[int]{.ret} [Itcl\_InitStack]{.ccmd} [stack]{.cargs}

[int]{.ret} [Itcl\_DeleteStack]{.ccmd} [stack]{.cargs}

[int]{.ret} [Itcl\_PushStack]{.ccmd} [cdata, stack]{.cargs}

[void \*]{.ret} [Itcl\_PopStack]{.ccmd} [stack]{.cargs}

[void \*]{.ret} [Itcl\_PeekStack]{.ccmd} [stack]{.cargs}

[void \*]{.ret} [Itcl\_GetStackValue]{.ccmd} [stack, pos]{.cargs}

[int]{.ret} [Itcl\_GetStackSize]{.ccmd} [stack]{.cargs}
:::

# Arguments

::: {.arguments} :::

[\*stack]{.carg .in type="Itcl_Stack"}
: Stack info structure.

[pos]{.carg .in type="int"}
: position in stack order from the top.

[\*clientData]{.carg .in type="void"}
: Arbitrary one-word value to save in the stack.

:::

# Description

**Itcl\_InitStack** initializes a stack structure and **Itcl\_DeleteStack** deletes it. **Itcl\_PushStack** pushes the *cdata* value onto the stack. **Itcl\_PopStack** removes and returns the top most *cdata* value. **Itcl\_PeekStack** returns the top most value, but does not remove it. **Itcl\_GetStackValue** gets a value at some index within the stack.  Index "0" is the first value pushed onto the stack. **Itcl\_GetStackSize** returns the count of entries on the stack.
