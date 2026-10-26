---
CommandName: Tcl_Backslash
title: Tcl_Backslash
ManualSection: 3
Version: 8.1
TclPart: Tcl
TclDescription: Tcl Library Procedures
Links:
 - Tcl(n)
 - Tcl_UtfBackslash(3)
Keywords:
 - backslash
 - parse
Copyright:
 - Copyright (c) 1989-1993 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

Tcl\_Backslash - parse a backslash sequence

# Synopsis

::: {.synopsis} :::
**#include <tcl.h>**
[char]{.ret} [Tcl\_Backslash]{.ccmd} [src, countPtr]{.cargs}
:::

# Arguments

::: {.arguments} :::

[\*src]{.carg .in type="const char"}
: Pointer to a string starting with a backslash.

[\*countPtr]{.carg .out type="int"}
: If *countPtr* is not NULL, *\*countPtr* gets filled in with number of characters in the backslash sequence, including the backslash character.

:::

# Description

The use of **Tcl\_Backslash** is deprecated in favor of [Tcl\_UtfBackslash][Utf].

This is a utility procedure provided for backwards compatibility with non-internationalized Tcl extensions.  It parses a backslash sequence and returns the low byte of the Unicode character corresponding to the sequence. **Tcl\_Backslash** modifies *\*countPtr* to contain the number of characters in the backslash sequence.

See the Tcl manual entry for information on the valid backslash sequences. All of the sequences described in the Tcl manual entry are supported by **Tcl\_Backslash**.


[Utf]: Utf.md
