---
CommandName: Tcl_SetErrno
ManualSection: 3
Version: 8.3
TclPart: Tcl
TclDescription: Tcl Library Procedures
Keywords:
 - errno
 - error code
 - global variables
Copyright:
 - Copyright (c) 1996 Sun Microsystems, Inc.
---

# Name

Tcl_SetErrno, Tcl_GetErrno, Tcl_ErrnoId, Tcl_ErrnoMsg, Tcl_WinConvertError - manipulate errno to store and retrieve error codes

# Synopsis

::: {.synopsis} :::
[#include]{.cmd} [\<tcl.h>]{.lit}

void
[Tcl_SetErrno]{.cmd}([errorCode]{.arg})

int
[Tcl_GetErrno]{.cmd}()

const char \*
[Tcl_ErrnoId]{.cmd}()

const char \*
[Tcl_ErrnoMsg]{.cmd}([errorCode]{.arg})

void
[Tcl_WinConvertError]{.cmd}([winErrorCode]{.arg})
:::

# Arguments

int *errorCode* (in)
: A POSIX error code such as **ENOENT**.

DWORD *winErrorCode* (in)
: A Windows or Winsock error code such as **ERROR_FILE_NOT_FOUND**.


# Description

**Tcl_SetErrno** and **Tcl_GetErrno** provide portable access to the **errno** variable, which is used to record a POSIX error code after system calls and other operations such as **Tcl_Gets**. These procedures are necessary because global variable accesses cannot be made across module boundaries on some platforms.

**Tcl_SetErrno** sets the **errno** variable to the value of the *errorCode* argument C procedures that wish to return error information to their callers via **errno** should call **Tcl_SetErrno** rather than setting **errno** directly.

**Tcl_GetErrno** returns the current value of **errno**. Procedures wishing to access **errno** should call this procedure instead of accessing **errno** directly.

**Tcl_ErrnoId** and **Tcl_ErrnoMsg** return string representations of **errno** values.  **Tcl_ErrnoId** returns a machine-readable textual identifier such as "EACCES" that corresponds to the current value of **errno**. **Tcl_ErrnoMsg** returns a human-readable string such as "permission denied" that corresponds to the value of its *errorCode* argument.  The *errorCode* argument is typically the value returned by **Tcl_GetErrno**. The strings returned by these functions are statically allocated and the caller must not free or modify them.

**Tcl_WinConvertError** (Windows only) maps the passed Windows or Winsock error code to a POSIX error and stores it in **errno**.
