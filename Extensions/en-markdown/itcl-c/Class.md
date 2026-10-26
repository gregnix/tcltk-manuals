---
CommandName: Itcl_CreateClass
ManualSection: 3
Version: 3.0
TclPart: itcl
TclDescription: "[incr\\ Tcl] Library Procedures"
Keywords:
 - class
 - find
Copyright:
 - Copyright (c) 1993-1998 Lucent Technologies, Inc.
---

# Name

Itcl_CreateClass, Itcl_DeleteClass, Itcl_FindClass, Itcl_IsClass, Itcl_IsClassNamespace - Manipulate classes.

# Synopsis

::: {.synopsis} :::
[#include]{.cmd} [\<itclInt.h>]{.lit}

int
[Itcl_CreateClass]{.cmd}([interp]{.arg}, [path]{.arg}, [info]{.arg}, [rPtr]{.arg})

int
[Itcl_DeleteClass]{.cmd}([interp]{.arg}, [cdefnPtr]{.arg})

ItclClass \*
[Itcl_FindClass]{.cmd}([interp]{.arg}, [path]{.arg}, [autoload]{.arg})

int
[Itcl_IsClass]{.cmd}([cmd]{.arg})

int
[Itcl_IsClassNamespace]{.cmd}([namesp]{.arg})
:::

# Arguments

Tcl_Interp *\*interp* (in)
: Interpreter to modify.

const char *\*path* (in)
: Path of the class.

ItclObjectInfo *\*info* (in)
: TODO.

ItclClass *\*\*rPtr* (in/out)
: The address of the pointer to modify.

ItclClass *\*cdefnPtr* (in)
: Pointer to class info struct.

int *autoload* (in)
: Flag value for if the class should be autoloaded

Tcl_Command *cmd* (in)
: Command to check.

Tcl_Namespace *\*namesp* (in)
: Namespace to check.


# Description
