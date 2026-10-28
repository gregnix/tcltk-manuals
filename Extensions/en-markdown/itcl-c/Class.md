---
CommandName: Itcl_CreateClass
title: Itcl_CreateClass
ManualSection: 3
Version: 3.0
TclPart: itcl
TclDescription: "[incr Tcl] Library Procedures"
Keywords:
 - class
 - find
Copyright:
 - Copyright (c) 1993-1998 Lucent Technologies, Inc.
---

# Name

Itcl\_CreateClass, Itcl\_DeleteClass, Itcl\_FindClass, Itcl\_IsClass, Itcl\_IsClassNamespace - Manipulate classes.

# Synopsis

::: {.synopsis} :::
**#include <itclInt.h>**

[int]{.ret} [Itcl\_CreateClass]{.ccmd} [interp, path, info, rPtr]{.cargs}

[int]{.ret} [Itcl\_DeleteClass]{.ccmd} [interp, cdefnPtr]{.cargs}

[ItclClass \*]{.ret} [Itcl\_FindClass]{.ccmd} [interp, path, autoload]{.cargs}

[int]{.ret} [Itcl\_IsClass]{.ccmd} [cmd]{.cargs}

[int]{.ret} [Itcl\_IsClassNamespace]{.ccmd} [namesp]{.cargs}
:::

# Arguments

::: {.arguments} :::

[\*interp]{.carg .in type="Tcl_Interp"}
: Interpreter to modify.

[\*path]{.carg .in type="const char"}
: Path of the class.

[\*info]{.carg .in type="ItclObjectInfo"}
: TODO.

[\*\*rPtr]{.carg .in/out type="ItclClass"}
: The address of the pointer to modify.

[\*cdefnPtr]{.carg .in type="ItclClass"}
: Pointer to class info struct.

[autoload]{.carg .in type="int"}
: Flag value for if the class should be autoloaded

[cmd]{.carg .in type="Tcl_Command"}
: Command to check.

[\*namesp]{.carg .in type="Tcl_Namespace"}
: Namespace to check.

:::

# Description
