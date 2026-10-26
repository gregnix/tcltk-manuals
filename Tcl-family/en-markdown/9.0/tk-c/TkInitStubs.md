---
CommandName: Tk_InitStubs
title: Tk_InitStubs
ManualSection: 3
Version: 8.4
TclPart: Tk
TclDescription: Tk Library Procedures
Links:
 - Tcl_InitStubs
Keywords:
 - stubs
Copyright:
 - Copyright (c) 1999 Scriptics Corporation
---

# Name

Tk\_InitStubs - initialize the Tk stubs mechanism

# Synopsis

::: {.synopsis} :::
**#include <tk.h>**
[const char \*]{.ret} [Tk\_InitStubs]{.ccmd} [interp, version, exact]{.cargs}
:::

# Arguments

::: {.arguments} :::

[\*interp]{.carg .in type="Tcl_Interp"}
: Tcl interpreter handle.

[\*version]{.carg .in type="char"}
: A version string consisting of one or more decimal numbers separated by dots.

[exact]{.carg .in type="int"}
: Non-zero means that only the particular Tk version specified by *version* is acceptable. Zero means that versions newer than *version* are also acceptable as long as they have the same major version number as *version*.

:::

# Introduction

The Tcl stubs mechanism defines a way to dynamically bind extensions to a particular Tcl implementation at run time. the stubs mechanism requires no changes to applications incorporating Tcl/Tk interpreters.  Only developers creating C-based Tcl/Tk extensions need to take steps to use the stubs mechanism with their extensions. See the [Tcl\_InitStubs][InitStubs] page for more information.

Enabling the stubs mechanism for a Tcl/Tk extension requires the following steps:

1. Call [Tcl\_InitStubs][InitStubs] in the extension before calling any other Tcl functions.

2. Call **Tk\_InitStubs** if the extension before calling any other Tk functions.

3. Define the **USE\_TCL\_STUBS** and the **USE\_TK\_STUBS** symbols. Typically, you would include the **-DUSE\_TCL\_STUBS** and the **-DUSE\_TK\_STUBS** flags when compiling the extension.

4. Link the extension with the Tcl and Tk stubs libraries instead of the standard Tcl and Tk libraries.  On Unix platforms, the library names are *libtclstub8.4.a* and *libtkstub8.4.a*; on Windows platforms, the library names are *tclstub84.lib* and *tkstub84.lib*. Adjust the library names with appropriate version number but note that the extension may only be used with versions of Tcl/Tk that have that version number or higher.


# Description

**Tk\_InitStubs** attempts to initialize the Tk stub table pointers and ensure that the correct version of Tk is loaded.  In addition to an interpreter handle, it accepts as arguments a version number and a Boolean flag indicating whether the extension requires an exact version match or not.  If *exact* is 0, then the extension is indicating that newer versions of Tk are acceptable as long as they have the same major version number as *version*; non-zero means that only the specified *version* is acceptable. [Tcl\_InitStubs][InitStubs] returns a string containing the actual version of Tk satisfying the request, or NULL if the Tk version is not acceptable, does not support the stubs mechanism, or any other error condition occurred.


[InitStubs]: ../tcl-c/InitStubs.md
