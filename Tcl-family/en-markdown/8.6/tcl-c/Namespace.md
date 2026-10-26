---
CommandName: Tcl_Namespace
ManualSection: 3
Version: 8.5
TclPart: Tcl
TclDescription: Tcl Library Procedures
Links:
 - Tcl_CreateCommand(3)
 - Tcl_ListObjAppendList(3)
 - Tcl_SetVar(3)
Keywords:
 - namespace
 - command
Copyright:
 - Copyright (c) 2003 Donal K. Fellows
---

# Name

Tcl_AppendExportList, Tcl_CreateNamespace, Tcl_DeleteNamespace, Tcl_Export, Tcl_FindCommand, Tcl_FindNamespace, Tcl_ForgetImport, Tcl_GetCurrentNamespace, Tcl_GetGlobalNamespace, Tcl_GetNamespaceUnknownHandler, Tcl_Import, Tcl_SetNamespaceUnknownHandler - manipulate namespaces

# Synopsis

::: {.synopsis} :::
[#include]{.cmd} [\<tcl.h>]{.lit}

Tcl_Namespace \*
[Tcl_CreateNamespace]{.cmd}([interp]{.arg}, [name]{.arg}, [clientData]{.arg}, [deleteProc]{.arg})

[Tcl_DeleteNamespace]{.cmd}([nsPtr]{.arg})

int
[Tcl_AppendExportList]{.cmd}([interp]{.arg}, [nsPtr]{.arg}, [objPtr]{.arg})

int
[Tcl_Export]{.cmd}([interp]{.arg}, [nsPtr]{.arg}, [pattern]{.arg}, [resetListFirst]{.arg})

int
[Tcl_Import]{.cmd}([interp]{.arg}, [nsPtr]{.arg}, [pattern]{.arg}, [allowOverwrite]{.arg})

int
[Tcl_ForgetImport]{.cmd}([interp]{.arg}, [nsPtr]{.arg}, [pattern]{.arg})

Tcl_Namespace \*
[Tcl_GetCurrentNamespace]{.cmd}([interp]{.arg})

Tcl_Namespace \*
[Tcl_GetGlobalNamespace]{.cmd}([interp]{.arg})

Tcl_Namespace \*
[Tcl_FindNamespace]{.cmd}([interp]{.arg}, [name]{.arg}, [contextNsPtr]{.arg}, [flags]{.arg})

Tcl_Command
[Tcl_FindCommand]{.cmd}([interp]{.arg}, [name]{.arg}, [contextNsPtr]{.arg}, [flags]{.arg})

Tcl_Obj \*
[Tcl_GetNamespaceUnknownHandler]{.cmd}([interp]{.arg}, [nsPtr]{.arg})

int
[Tcl_SetNamespaceUnknownHandler]{.cmd}([interp]{.arg}, [nsPtr]{.arg}, [handlerPtr]{.arg})
:::

# Arguments

Tcl_Interp *\*interp* (in/out)
: The interpreter in which the namespace exists and where name lookups are performed. Also where error result messages are written.

const char *\*name* (in)
: The name of the namespace or command to be created or accessed.

ClientData *clientData* (in)
: A context pointer by the creator of the namespace.  Not interpreted by Tcl at all.

Tcl_NamespaceDeleteProc *\*deleteProc* (in)
: A pointer to function to call when the namespace is deleted, or NULL if no such callback is to be performed.

Tcl_Namespace *\*nsPtr* (in)
: The namespace to be manipulated, or NULL (for other than **Tcl_DeleteNamespace**) to manipulate the current namespace.

Tcl_Obj *\*objPtr* (out)
: A reference to an unshared value to which the function output will be written.

const char *\*pattern* (in)
: The glob-style pattern (see **Tcl_StringMatch**) that describes the commands to be imported or exported.

int *resetListFirst* (in)
: Whether the list of export patterns should be reset before adding the current pattern to it.

int *allowOverwrite* (in)
: Whether new commands created by this import action can overwrite existing commands.

Tcl_Namespace *\*contextNsPtr* (in)
: The location in the namespace hierarchy where the search for a namespace or command should be conducted relative to when the search term is not rooted at the global namespace.  NULL indicates the current namespace.

int *flags* (in)
: OR-ed combination of bits controlling how the search is to be performed.  The following flags are supported: **TCL_GLOBAL_ONLY** (indicates that the search is always to be conducted relative to the global namespace), **TCL_NAMESPACE_ONLY** (just for **Tcl_FindCommand**; indicates that the search is always to be conducted relative to the context namespace), and **TCL_LEAVE_ERR_MSG** (indicates that an error message should be left in the interpreter if the search fails.)

Tcl_Obj *\*handlerPtr* (in)
: A script fragment to be installed as the unknown command handler for the namespace, or NULL to reset the handler to its default.


# Description

Namespaces are hierarchic naming contexts that can contain commands and variables.  They also maintain a list of patterns that describes what commands are exported, and can import commands that have been exported by other namespaces.  Namespaces can also be manipulated through the Tcl command **namespace**.

The *Tcl_Namespace* structure encapsulates a namespace, and is guaranteed to have the following fields in it: *name* (the local name of the namespace, with no namespace separator characters in it, with empty denoting the global namespace), *fullName* (the fully specified name of the namespace), *clientData*, *deleteProc* (the values specified in the call to **Tcl_CreateNamespace**), and *parentPtr* (a pointer to the containing namespace, or NULL for the global namespace.)

**Tcl_CreateNamespace** creates a new namespace.  The *deleteProc* will have the following type signature:

```
typedef void Tcl_NamespaceDeleteProc(
        ClientData clientData);
```

**Tcl_DeleteNamespace** deletes a namespace, calling the *deleteProc* defined for the namespace (if any).

**Tcl_AppendExportList** retrieves the export patterns for a namespace given namespace and appends them (as list items) to *objPtr*.

**Tcl_Export** sets and appends to the export patterns for a namespace.  Patterns are appended unless the *resetListFirst* flag is true.

**Tcl_Import** imports commands matching a pattern into a namespace.  Note that the pattern must include the name of the namespace to import from.  This function returns TCL_ERROR if an attempt to import a command over an existing command is made, unless the *allowOverwrite* flag has been set.

**Tcl_ForgetImport** removes imports matching a pattern.

**Tcl_GetCurrentNamespace** returns the current namespace for an interpreter.

**Tcl_GetGlobalNamespace** returns the global namespace for an interpreter.

**Tcl_FindNamespace** searches for a namespace named *name* within the context of the namespace *contextNsPtr*.  If the namespace cannot be found, NULL is returned.

**Tcl_FindCommand** searches for a command named *name* within the context of the namespace *contextNsPtr*.  If the command cannot be found, NULL is returned.

**Tcl_GetNamespaceUnknownHandler** returns the unknown command handler for the namespace, or NULL if none is set.

**Tcl_SetNamespaceUnknownHandler** sets the unknown command handler for the namespace. If *handlerPtr* is NULL, then the handler is reset to its default.
