---
CommandName: Tk_GetUid
title: Tk_GetUid
ManualSection: 3
Version: unknown
TclPart: Tk
TclDescription: Tk Library Procedures
Keywords:
 - atom
 - unique identifier
Copyright:
 - Copyright (c) 1990 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

Tk\_GetUid, Tk\_Uid - convert from string to unique identifier

# Synopsis

::: {.synopsis} :::
**#include <tk.h>**
[Tk\_Uid]{.ret} [Tk\_GetUid]{.ccmd} [string]{.cargs}
:::

# Arguments

::: {.arguments} :::

[\*string]{.carg .in type="char"}
: String for which the corresponding unique identifier is desired.

:::

# Description

**Tk\_GetUid** returns the unique identifier corresponding to *string*. Unique identifiers are similar to atoms in Lisp, and are used in Tk to speed up comparisons and searches.  A unique identifier (type Tk\_Uid) is a string pointer and may be used anywhere that a variable of type "char \*" could be used.  However, there is guaranteed to be exactly one unique identifier for any given string value.  If **Tk\_GetUid** is called twice, once with string *a* and once with string *b*, and if *a* and *b* have the same string value (strcmp(a, b) == 0), then **Tk\_GetUid** will return exactly the same Tk\_Uid value for each call (Tk\_GetUid(a) == Tk\_GetUid(b)). This means that variables of type Tk\_Uid may be compared directly (x == y) without having to call **strcmp**. In addition, the return value from **Tk\_GetUid** will have the same string value as its argument (strcmp(Tk\_GetUid(a), a) == 0).
