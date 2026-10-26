---
CommandName: Tcl_Backslash
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

Tcl_Backslash - parse a backslash sequence

# Synopsis

::: {.synopsis} :::
[#include]{.cmd} [\<tcl.h>]{.lit}

char
[Tcl_Backslash]{.cmd}([src]{.arg}, [countPtr]{.arg})
:::

# Arguments

const char *\*src* (in)
: Pointer to a string starting with a backslash.

int *\*countPtr* (out)
: If *countPtr* is not NULL, *\*countPtr* gets filled in with number of characters in the backslash sequence, including the backslash character.


# Description

The use of **Tcl_Backslash** is deprecated in favor of **Tcl_UtfBackslash**.

This is a utility procedure provided for backwards compatibility with non-internationalized Tcl extensions.  It parses a backslash sequence and returns the low byte of the Unicode character corresponding to the sequence. **Tcl_Backslash** modifies *\*countPtr* to contain the number of characters in the backslash sequence.

See the Tcl manual entry for information on the valid backslash sequences. All of the sequences described in the Tcl manual entry are supported by **Tcl_Backslash**.
