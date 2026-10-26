---
CommandName: lrepeat
title: lrepeat
ManualSection: n
Version: 8.5
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - list(n)
 - lappend(n)
 - linsert(n)
 - llength(n)
 - lset(n)
Keywords:
 - element
 - index
 - list
Copyright:
 - Copyright (c) 2003 Simon Geard. All rights reserved.
---

# Name

lrepeat - Build a list by repeating elements

# Synopsis

::: {.synopsis} :::
[lrepeat]{.cmd} [count]{.arg} [element]{.optdot}
:::

# Description

The **lrepeat** command creates a list of size *count \* number of elements* by repeating *count* times the sequence of elements *element ...*.  *count* must be a non-negative integer, *element* can be any Tcl value.  Note that **lrepeat 1 element ...** is identical to **list element ...**.

# Examples

```
lrepeat 3 a
      → a a a
lrepeat 3 [lrepeat 3 0]
      → {0 0 0} {0 0 0} {0 0 0}
lrepeat 3 a b c
      → a b c a b c a b c
lrepeat 3 [lrepeat 2 a] b c
      → {a a} b c {a a} b c {a a} b c
```
