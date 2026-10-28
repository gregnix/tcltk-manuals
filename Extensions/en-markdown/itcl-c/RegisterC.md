---
CommandName: Itcl_RegisterC
title: Itcl_RegisterC
ManualSection: 3
Version: 3.0
TclPart: itcl
TclDescription: "[incr Tcl] Library Procedures"
Links:
 - Tcl_CreateCommand
 - Tcl_CreateObjCommand
Keywords:
 - class
 - object
Copyright:
 - Copyright (c) 1993-1998 Lucent Technologies, Inc.
---

# Name

Itcl\_RegisterC, Itcl\_RegisterObjC, Itcl\_RegisterObjC2, Itcl\_FindC, Itcl\_FindC2 - Associate a symbolic name with a C procedure.

# Synopsis

::: {.synopsis} :::
**#include <itcl.h>**

[int]{.ret} [Itcl\_RegisterC]{.ccmd} [interp, cmdName, argProc, clientData, deleteProc]{.cargs}

[int]{.ret} [Itcl\_RegisterObjC]{.ccmd} [interp, cmdName, objProc, clientData, deleteProc]{.cargs}

[int]{.ret} [Itcl\_RegisterObjC2]{.ccmd} [interp, cmdName, objProc2, clientData, deleteProc]{.cargs}

[int]{.ret} [Itcl\_FindC]{.ccmd} [interp, cmdName, argProcPtr, objProcPtr, cDataPtr]{.cargs}

[int]{.ret} [Itcl\_FindC2]{.ccmd} [interp, cmdName, objProc2Ptr, cDataPtr]{.cargs}
:::

# Arguments

::: {.arguments} :::

[\*interp]{.carg .in type="Tcl_Interp"}
: Interpreter in which to create new command.

[\*cmdName]{.carg .in type="const char"}
: Name of command.

[\*argProc]{.carg .in type="Tcl_CmdProc"}
: Implementation of new command:  *argProc* will be called whenever

[\*\*argProcPtr]{.carg .in/out type="Tcl_CmdProc"}
: The Tcl\_CmdProc \* to receive the pointer. Can be NULL.

[\*objProc]{.carg .in type="Tcl_ObjCmdProc"}
: Implementation of the new command: *objProc* will be called whenever

[\*objProc2]{.carg .in type="Tcl_ObjCmdProc2"}
: Implementation of the new command: *objProc2* will be called whenever

[\*\*objProcPtr]{.carg .in/out type="Tcl_ObjCmdProc"}
: The Tcl\_ObjCmdProc \* to receive the pointer.

[\*\*objProc2Ptr]{.carg .in/out type="Tcl_ObjCmdProc2"}
: The Tcl\_ObjCmdProc2 \* to receive the pointer.

[\*clientData]{.carg .in type="void"}
: Arbitrary one-word value to pass to *proc* and *deleteProc*.

[\*\*cDataPtr]{.carg .in/out type="void"}
: The void \* to receive the pointer.

[\*deleteProc]{.carg .in type="Tcl_CmdDeleteProc"}
: Procedure to call before *cmdName* is deleted from the interpreter; allows for command-specific cleanup.  If NULL, then no procedure is called before the command is deleted.

:::

# Description

Used to associate a symbolic name with an (argc,argv) C procedure that handles a Tcl command.  Procedures that are registered in this manner can be referenced in the body of an \[incr Tcl\] class definition to specify C procedures to acting as methods/procs. Usually invoked in an initialization routine for an extension, called out in Tcl\_AppInit() at the start of an application.

Each symbolic procedure can have an arbitrary client data value associated with it.  This value is passed into the command handler whenever it is invoked.

A symbolic procedure name can be used only once for a given style (arg/obj) handler.  If the name is defined with an arg-style handler, it can be redefined with an obj-style handler; or if the name is defined with an obj-style handler, it can be redefined with an arg-style handler.  In either case, any previous client data is discarded and the new client data is remembered.  However, if a name is redefined to a different handler of the same style, this procedure returns an error.

Returns TCL\_OK on success, or TCL\_ERROR (along with an error message in interp->result) if anything goes wrong.

C procedures can be integrated into an **\[incr Tcl\]** class definition to implement methods, procs, and the "config" code for public variables.  Any body that starts with "**@**" is treated as the symbolic name for a C procedure.

Symbolic names are established by registering procedures via **Itcl\_RegisterObjC()** or **Itcl\_RegisterObjC2()** or **Itcl\_RegisterC()**.  This is usually done in the **Tcl\_AppInit()** procedure, which is automatically called when the interpreter starts up. In the following example, the procedure **My\_FooObjCmd()** is registered with the symbolic name "foo".  This procedure can be referenced in the **body** command as "**@foo**".

```
int
Tcl_AppInit(interp)
    Tcl_Interp *interp;     /* Interpreter for application. */
{
    if (Itcl_Init(interp) == TCL_ERROR) {
        return TCL_ERROR;
    }

    if (Itcl_RegisterObjC(interp, "foo", My_FooObjCmd) != TCL_OK) {
        return TCL_ERROR;
    }
}
```

C procedures are implemented just like ordinary Tcl commands. See the **CrtCommand** man page for details.  Within the procedure, class data members can be accessed like ordinary variables using **Tcl\_SetVar()**, **Tcl\_GetVar()**, **Tcl\_TraceVar()**, etc.  Class methods and procs can be executed like ordinary commands using **Tcl\_Eval()**.  **\[incr Tcl\]** makes this possible by automatically setting up the context before executing the C procedure.

This scheme provides a natural migration path for code development. Classes can be developed quickly using Tcl code to implement the bodies.  An entire application can be built and tested.  When necessary, individual bodies can be implemented with C code to improve performance.

See the Archetype class in **\[incr Tk\]** for an example of how this C linking method is used.
