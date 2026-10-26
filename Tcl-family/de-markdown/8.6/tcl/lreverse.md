---
CommandName: lreverse
title: lreverse
ManualSection: n
Version: 8.5
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - list(n)
 - lsearch(n)
 - lsort(n)
Keywords:
 - element
 - list
 - reverse
Copyright:
 - Copyright (c) 2006 Donal K. Fellows. All rights reserved.
---

# Name

lreverse - Kehrt die Reihenfolge einer Liste um

# Übersicht

::: {.synopsis} :::
[lreverse]{.cmd} [list]{.arg}
:::

# Beschreibung

**lreverse** gibt eine Liste mit denselben Elementen wie *list* zurück, jedoch in umgekehrter Reihenfolge.

# Beispiele

```
lreverse {a a b c}
      → c b a a
lreverse {a b {c d} e f}
      → f e {c d} b a
```
