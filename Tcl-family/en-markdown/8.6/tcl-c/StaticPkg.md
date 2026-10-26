---
CommandName: Tcl_StaticPackage
title: Tcl_StaticPackage
ManualSection: 3
Version: 7.5
TclPart: Tcl
TclDescription: Tcl Library Procedures
Keywords:
 - initialization procedure
 - package
 - static linking
Links:
 - load(n)
 - package(n)
 - Tcl_PkgRequire(3)
Copyright:
 - Copyright (c) 1995-1996 Sun Microsystems, Inc.
---

# Name

Tcl\_StaticPackage - make a statically linked package available via the 'load' command

# Synopsis

::: {.synopsis} :::
**#include <tcl.h>**
[Tcl\_StaticPackage]{.ccmd} [interp, prefix, initProc, safeInitProc]{.cargs}
:::

# Arguments

::: {.arguments} :::

[\*interp]{.carg .in type="Tcl_Interp"}
: If not NULL, points to an interpreter into which the package has already been loaded (i.e., the caller has already invoked the appropriate initialization procedure).  NULL means the package has not yet been incorporated into any interpreter.

[\*prefix]{.carg .in type="const char"}
: Prefix for library initialization function;  should be properly capitalized (first letter upper-case, all others lower-case).

[\*initProc]{.carg .in type="Tcl_PackageInitProc"}
: Procedure to invoke to incorporate this package into a trusted interpreter.

[\*safeInitProc]{.carg .in type="Tcl_PackageInitProc"}
: Procedure to call to incorporate this package into a safe interpreter (one that will execute untrusted scripts).  NULL means the package cannot be used in safe interpreters.

:::

# Description

This procedure may be invoked to announce that a package has been linked statically with a Tcl application and, optionally, that it has already been loaded into an interpreter. Once **Tcl\_StaticPackage** has been invoked for a package, it may be loaded into interpreters using the [load] command. **Tcl\_StaticPackage** is normally invoked only by the [Tcl\_AppInit][AppInit] procedure for the application, not by packages for themselves (**Tcl\_StaticPackage** should only be invoked for statically loaded packages, and code in the package itself should not need to know whether the package is dynamically or statically loaded).

When the [load] command is used later to load the package into an interpreter, one of *initProc* and *safeInitProc* will be invoked, depending on whether the target interpreter is safe or not. *initProc* and *safeInitProc* must both match the following prototype:

```
typedef int Tcl_PackageInitProc(
        Tcl_Interp *interp);
```

The *interp* argument identifies the interpreter in which the package is to be loaded.  The initialization procedure must return [TCL\_OK][catch] or [TCL\_ERROR][catch] to indicate whether or not it completed successfully; in the event of an error it should set the interpreter's result to point to an error message.  The result or error from the initialization procedure will be returned as the result of the [load] command that caused the initialization procedure to be invoked.


[AppInit]: AppInit.md
[catch]: ../tcl/catch.md
[load]: ../tcl/load.md
