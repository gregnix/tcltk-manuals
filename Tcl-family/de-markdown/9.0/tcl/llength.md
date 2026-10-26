---
CommandName: llength
title: llength
ManualSection: n
Version: unknown
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - list(n)
 - lappend(n)
 - lassign(n)
 - ledit(n)
 - lindex(n)
 - linsert(n)
 - lmap(n)
 - lpop(n)
 - lrange(n)
 - lremove(n)
 - lrepeat(n)
 - lreplace(n)
 - lreverse(n)
 - lsearch(n)
 - lseq(n)
 - lset(n)
 - lsort(n)
Keywords:
 - element
 - list
 - length
Copyright:
 - Copyright (c) 1993 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
 - Copyright (c) 2001 Kevin B. Kenny <kennykb@acm.org>. All rights reserved.
---

# Name

llength - Zählt die Elemente einer Liste

# Übersicht

::: {.synopsis} :::
[llength]{.cmd} [list]{.arg}
:::

# Beschreibung

Behandelt *list* als Liste und gibt eine Dezimalzeichenkette mit der Elementanzahl zurück.

# Beispiele

Das Ergebnis ist die Anzahl der Elemente:

```
% llength {a b c d e}
5
% llength {a b c}
3
% llength {}
0
```

Elemente sind nicht zwingend „Wörter“ im Wörterbuch-Sinn, besonders bei Quoting:

```
% llength {a b {c d} e}
4
% llength {a b { } c d e}
6
```

Eine leere Liste ist nicht notwendigerweise eine leere Zeichenkette:

```
% set var { }; puts "[string length $var],[llength $var]"
1,0
```
