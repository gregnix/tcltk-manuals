---
CommandName: Itcl_RegisterC
ManualSection: 3
Version: 3.0
TclPart: itcl
TclDescription: "[incr\\ Tcl] Library Procedures"
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

Itcl_RegisterC, Itcl_RegisterObjC, Itcl_RegisterObjC2, Itcl_FindC, Itcl_FindC2 - Associate a symbolic name with a C procedure.

# Synopsis

::: {.synopsis} :::
[#include]{.cmd} [\<itcl.h>]{.lit}

int
[Itcl_RegisterC]{.cmd}([interp]{.arg}, [cmdName]{.arg}, [argProc]{.arg}, [clientData]{.arg}, [deleteProc]{.arg})

int
[Itcl_RegisterObjC]{.cmd}([interp]{.arg}, [cmdName]{.arg}, [objProc]{.arg}, [clientData]{.arg}, [deleteProc]{.arg})

int
[Itcl_RegisterObjC2]{.cmd}([interp]{.arg}, [cmdName]{.arg}, [objProc2]{.arg}, [clientData]{.arg}, [deleteProc]{.arg})

int
[Itcl_FindC]{.cmd}([interp]{.arg}, [cmdName]{.arg}, [argProcPtr]{.arg}, [objProcPtr]{.arg}, [cDataPtr]{.arg})

int
[Itcl_FindC2]{.cmd}([interp]{.arg}, [cmdName]{.arg}, [objProc2Ptr]{.arg}, [cDataPtr]{.arg})
:::

# Arguments

Tcl_Interp *\*interp* (in)
: Interpreter in which to create new command.

const char *\*cmdName* (in)
: Name of command.

Tcl_CmdProc *\*argProc* (in)
: Implementation of new command:  *argProc* will be called whenever

Tcl_CmdProc *\*\*argProcPtr* (in/out)
: The Tcl_CmdProc \* to receive the pointer. Can be NULL.

Tcl_ObjCmdProc *\*objProc* (in)
: Implementation of the new command: *objProc* will be called whenever

Tcl_ObjCmdProc2 *\*objProc2* (in)
: Implementation of the new command: *objProc2* will be called whenever

Tcl_ObjCmdProc *\*\*objProcPtr* (in/out)
: The Tcl_ObjCmdProc \* to receive the pointer.

Tcl_ObjCmdProc2 *\*\*objProc2Ptr* (in/out)
: The Tcl_ObjCmdProc2 \* to receive the pointer.

void *\*clientData* (in)
: Arbitrary one-word value to pass to *proc* and *deleteProc*.

void *\*\*cDataPtr* (in/out)
: The void \* to receive the pointer.

Tcl_CmdDeleteProc *\*deleteProc* (in)
: Procedure to call before *cmdName* is deleted from the interpreter; allows for command-specific cleanup.  If NULL, then no procedure is called before the command is deleted.


# Description

Used to associate a symbolic name with an (argc,argv) C procedure that handles a Tcl command.  Procedures that are registered in this manner can be referenced in the body of an \[incr Tcl\] class definition to specify C procedures to acting as methods/procs. Usually invoked in an initialization routine for an extension, called out in Tcl_AppInit() at the start of an application.

Each symbolic procedure can have an arbitrary client data value associated with it.  This value is passed into the command handler whenever it is invoked.

A symbolic procedure name can be used only once for a given style (arg/obj) handler.  If the name is defined with an arg-style handler, it can be redefined with an obj-style handler; or if the name is defined with an obj-style handler, it can be redefined with an arg-style handler.  In either case, any previous client data is discarded and the new client data is remembered.  However, if a name is redefined to a different handler of the same style, this procedure returns an error.

Returns TCL_OK on success, or TCL_ERROR (along with an error message in interp->result) if anything goes wrong.

C procedures can be integrated into an **\[incr**\\ **Tcl\]** class definition to implement methods, procs, and the "config" code for public variables.  Any body that starts with "**@**" is treated as the symbolic name for a C procedure.

Symbolic names are established by registering procedures via **Itcl_RegisterObjC()** or **Itcl_RegisterObjC2()** or **Itcl_RegisterC()**.  This is usually done in the **Tcl_AppInit()** procedure, which is automatically called when the interpreter starts up. In the following example, the procedure \\ffCMy_FooObjCmd() is registered with the symbolic name "foo".  This procedure can be referenced in the **body** command as "\\ffC@foo".

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

C procedures are implemented just like ordinary Tcl commands. See the **CrtCommand** man page for details.  Within the procedure, class data members can be accessed like ordinary variables using **Tcl_SetVar()**, **Tcl_GetVar()**, **Tcl_TraceVar()**, etc.  Class methods and procs can be executed like ordinary commands using **Tcl_Eval()**.  **\[incr**\\ **Tcl\]** makes this possible by automatically setting up the context before executing the C procedure.

This scheme provides a natural migration path for code development. Classes can be developed quickly using Tcl code to implement the bodies.  An entire application can be built and tested.  When necessary, individual bodies can be implemented with C code to improve performance.

See the Archetype class in **\[incr**\\ **Tk\]** for an example of how this C linking method is used.
