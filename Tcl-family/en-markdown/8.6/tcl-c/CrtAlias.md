---
CommandName: Tcl_CreateAlias
title: Tcl_CreateAlias
ManualSection: 3
Version: 7.6
TclPart: Tcl
TclDescription: Tcl Library Procedures
Links:
 - interp
Keywords:
 - alias
 - command
 - exposed commands
 - hidden commands
 - interpreter
 - invoke
 - parent
 - child
Copyright:
 - Copyright (c) 1995-1996 Sun Microsystems, Inc.
---

# Name

Tcl\_IsSafe, Tcl\_MakeSafe, Tcl\_CreateChild, Tcl\_CreateSlave, Tcl\_GetChild, Tcl\_GetSlave, Tcl\_GetParent, Tcl\_GetMaster, Tcl\_GetInterpPath, Tcl\_CreateAlias, Tcl\_CreateAliasObj, Tcl\_GetAlias, Tcl\_GetAliasObj, Tcl\_ExposeCommand, Tcl\_HideCommand - manage multiple Tcl interpreters, aliases and hidden commands

# Synopsis

::: {.synopsis} :::
**#include <tcl.h>**
[int]{.ret} [Tcl\_IsSafe]{.ccmd} [interp]{.cargs}
[int]{.ret} [Tcl\_MakeSafe]{.ccmd} [interp]{.cargs}
[Tcl\_Interp \*]{.ret} [Tcl\_CreateChild]{.ccmd version="TIP 581"} [interp, name, isSafe]{.cargs}
[Tcl\_Interp \*]{.ret} [Tcl\_CreateSlave]{.ccmd} [interp, name, isSafe]{.cargs}
[Tcl\_Interp \*]{.ret} [Tcl\_GetChild]{.ccmd version="TIP 581"} [interp, name]{.cargs}
[Tcl\_Interp \*]{.ret} [Tcl\_GetSlave]{.ccmd} [interp, name]{.cargs}
[Tcl\_Interp \*]{.ret} [Tcl\_GetParent]{.ccmd version="TIP 581"} [interp]{.cargs}
[Tcl\_Interp \*]{.ret} [Tcl\_GetMaster]{.ccmd} [interp]{.cargs}
[int]{.ret} [Tcl\_GetInterpPath]{.ccmd} [interp, childInterp]{.cargs}
int Tcl\_CreateAlias(childInterp, childCmd, targetInterp, targetCmd,
int Tcl\_CreateAliasObj(childInterp, childCmd, targetInterp, targetCmd,
int Tcl\_GetAlias(interp, childCmd, targetInterpPtr, targetCmdPtr,
int Tcl\_GetAliasObj(interp, childCmd, targetInterpPtr, targetCmdPtr,
[int]{.ret} [Tcl\_ExposeCommand]{.ccmd} [interp, hiddenCmdName, cmdName]{.cargs}
[int]{.ret} [Tcl\_HideCommand]{.ccmd} [interp, cmdName, hiddenCmdName]{.cargs}
:::

argc, argv)

objc, objv)

argcPtr, argvPtr)

objcPtr, objvPtr)

# Arguments

::: {.arguments} :::

[\*interp]{.carg .in type="Tcl_Interp"}
: Interpreter in which to execute the specified command.

[\*name]{.carg .in type="const char"}
: Name of child interpreter to create or manipulate.

[isSafe]{.carg .in type="int"}
: If non-zero, a "safe" child that is suitable for running untrusted code is created, otherwise a trusted child is created.

[\*childInterp]{.carg .in type="Tcl_Interp"}
: Interpreter to use for creating the source command for an alias (see below).

[\*childCmd]{.carg .in type="const char"}
: Name of source command for alias.

[\*targetInterp]{.carg .in type="Tcl_Interp"}
: Interpreter that contains the target command for an alias.

[\*targetCmd]{.carg .in type="const char"}
: Name of target command for alias in *targetInterp*.

[argc]{.carg .in type="int"}
: Count of additional arguments to pass to the alias command.

[\*argv]{.carg .in type="const char *const"}
: Vector of strings, the additional arguments to pass to the alias command. This storage is owned by the caller.

[objc]{.carg .in type="int"}
: Count of additional value arguments to pass to the aliased command.

[\*\*objv]{.carg .in type="Tcl_Obj"}
: Vector of [Tcl\_Obj][Object] structures, the additional value arguments to pass to the aliased command. This storage is owned by the caller.

[\*\*targetInterpPtr]{.carg .in type="Tcl_Interp"}
: Pointer to location to store the address of the interpreter where a target command is defined for an alias.

[\*\*targetCmdPtr]{.carg .out type="const char"}
: Pointer to location to store the address of the name of the target command for an alias.

[\*argcPtr]{.carg .out type="int"}
: Pointer to location to store count of additional arguments to be passed to the alias. The location is in storage owned by the caller.

[\*\*\*argvPtr]{.carg .out type="const char"}
: Pointer to location to store a vector of strings, the additional arguments to pass to an alias. The location is in storage owned by the caller, the vector of strings is owned by the called function.

[\*objcPtr]{.carg .out type="int"}
: Pointer to location to store count of additional value arguments to be passed to the alias. The location is in storage owned by the caller.

[\*\*\*objvPtr]{.carg .out type="Tcl_Obj"}
: Pointer to location to store a vector of [Tcl\_Obj][Object] structures, the additional arguments to pass to an alias command. The location is in storage owned by the caller, the vector of [Tcl\_Obj][Object] structures is owned by the called function.

[\*cmdName]{.carg .in type="const char"}
: Name of an exposed command to hide or create.

[\*hiddenCmdName]{.carg .in type="const char"}
: Name under which a hidden command is stored and with which it can be exposed or invoked.

:::

# Description

These procedures are intended for access to the multiple interpreter facility from inside C programs. They enable managing multiple interpreters in a hierarchical relationship, and the management of aliases, commands that when invoked in one interpreter execute a command in another interpreter. The return value for those procedures that return an **int** is either [TCL\_OK][catch] or [TCL\_ERROR][catch]. If [TCL\_ERROR][catch] is returned then the interpreter's result contains an error message.

**Tcl\_CreateSlave** creates a new interpreter as a child of *interp*. It also creates a child command named *childName* in *interp* which allows *interp* to manipulate the new child. If *isSafe* is zero, the command creates a trusted child in which Tcl code has access to all the Tcl commands. If it is **1**, the command creates a "safe" child in which Tcl code has access only to set of Tcl commands defined as "Safe Tcl"; see the manual entry for the Tcl **interp** command for details. If the creation of the new child interpreter failed, **NULL** is returned.

[**Tcl\_CreateChild** is a synonym for **Tcl\_CreateSlave**.]{version="TIP 581"}

**Tcl\_IsSafe** returns **1** if *interp* is "safe" (was created with the **TCL\_SAFE\_INTERPRETER** flag specified), **0** otherwise.

**Tcl\_MakeSafe** marks *interp* as "safe", so that future calls to **Tcl\_IsSafe** will return 1.  It also removes all known potentially-unsafe core functionality (both commands and variables) from *interp*.  However, it cannot know what parts of an extension or application are safe and does not make any attempt to remove those parts, so safety is not guaranteed after calling **Tcl\_MakeSafe**. Callers will want to take care with their use of **Tcl\_MakeSafe** to avoid false claims of safety.  For many situations, **Tcl\_CreateSlave** may be a better choice, since it creates interpreters in a known-safe state.

**Tcl\_GetSlave** returns a pointer to a child interpreter of *interp*. The child interpreter is identified by *childName*. If no such child interpreter exists, **NULL** is returned.

[**Tcl\_GetChild** is a synonym for **Tcl\_GetSlave**.]{version="TIP 581"}

**Tcl\_GetMaster** returns a pointer to the master interpreter of *interp*. If *interp* has no master (it is a top-level interpreter) then **NULL** is returned.

[**Tcl\_GetParent** is a synonym for **Tcl\_GetMaster**.]{version="TIP 581"}

**Tcl\_GetInterpPath** stores in the result of *interp* the relative path between *interp* and *childInterp*; *childInterp* must be a child of *interp*. If the computation of the relative path succeeds, [TCL\_OK][catch] is returned, else [TCL\_ERROR][catch] is returned and an error message is stored as the result of *interp*.

**Tcl\_CreateAlias** creates a command named *childCmd* in *childInterp* that when invoked, will cause the command *targetCmd* to be invoked in *targetInterp*. The arguments specified by the strings contained in *argv* are always prepended to any arguments supplied in the invocation of *childCmd* and passed to *targetCmd*. This operation returns [TCL\_OK][catch] if it succeeds, or [TCL\_ERROR][catch] if it fails; in that case, an error message is left in the value result of *childInterp*. Note that there are no restrictions on the ancestry relationship (as created by **Tcl\_CreateSlave**) between *childInterp* and *targetInterp*. Any two interpreters can be used, without any restrictions on how they are related.

**Tcl\_CreateAliasObj** is similar to **Tcl\_CreateAlias** except that it takes a vector of values to pass as additional arguments instead of a vector of strings.

**Tcl\_GetAliasObj** returns information in the form of a pointer to a vector of [Tcl\_Obj][Object] structures about an alias *aliasName* in *interp*. Any of the result fields can be **NULL**, in which case the corresponding datum is not returned. If a result field is non-**NULL**, the address indicated is set to the corresponding datum. For example, if *targetCmdPtr* is non-**NULL** it is set to a pointer to the string containing the name of the target command.

**Tcl\_GetAlias** is similar to **Tcl\_GetAliasObj** except that it returns a pointer to a vector of string instead of a vector of [Tcl\_Obj][Object] structures. **Tcl\_GetAlias** is deprecated.

**Tcl\_ExposeCommand** moves the command named *hiddenCmdName* from the set of hidden commands to the set of exposed commands, putting it under the name *cmdName*. *HiddenCmdName* must be the name of an existing hidden command, or the operation will return [TCL\_ERROR][catch] and leave an error message as the result of *interp*. If an exposed command named *cmdName* already exists, the operation returns [TCL\_ERROR][catch] and leaves an error message as the result of *interp*. If the operation succeeds, it returns [TCL\_OK][catch]. After executing this command, attempts to use *cmdName* in any script evaluation mechanism will again succeed.

**Tcl\_HideCommand** moves the command named *cmdName* from the set of exposed commands to the set of hidden commands, under the name *hiddenCmdName*. *CmdName* must be the name of an existing exposed command, or the operation will return [TCL\_ERROR][catch] and leave an error message as the result of *interp*. Currently both *cmdName* and *hiddenCmdName* must not contain namespace qualifiers, or the operation will return [TCL\_ERROR][catch] and leave an error message as the result of *interp*. The *CmdName* will be looked up in the global namespace, and not relative to the current namespace, even if the current namespace is not the global one. If a hidden command whose name is *hiddenCmdName* already exists, the operation also returns [TCL\_ERROR][catch] and an error message is left as the result of *interp*. If the operation succeeds, it returns [TCL\_OK][catch]. After executing this command, attempts to use *cmdName* in any script evaluation mechanism will fail.

For a description of the Tcl interface to multiple interpreters, see *interp(n)*.


[catch]: ../tcl/catch.md
[Object]: Object.md
