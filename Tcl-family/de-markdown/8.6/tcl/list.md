---
CommandName: list
title: list
ManualSection: n
Version: unknown
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - lappend(n)
 - lindex(n)
 - linsert(n)
 - llength(n)
 - lrange(n)
 - lrepeat(n)
 - lreplace(n)
 - lsearch(n)
 - lset(n)
 - lsort(n)
Keywords:
 - element
 - list
 - quoting
Copyright:
 - Copyright (c) 1993 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
 - Copyright (c) 2001 Kevin B. Kenny <kennykb@acm.org>. All rights reserved.
---

# Name

list - Erstellt eine Liste

# Übersicht

::: {.synopsis} :::
[list]{.cmd} [arg arg]{.optdot}
:::

# Beschreibung

Dieser Befehl gibt eine Liste zurück, die aus allen *arg*s besteht, oder einen leeren String, wenn keine *arg*s angegeben sind. Geschweifte Klammern und Backslashes werden bei Bedarf hinzugefügt, sodass der Befehl [lindex] auf das Ergebnis angewendet werden kann, um die ursprünglichen Argumente wieder zu extrahieren, und sodass [eval] verwendet werden kann, um die resultierende Liste auszuführen, wobei *arg1* den Namen des Befehls und die anderen *arg*s dessen Argumente bilden. **list** erzeugt leicht andere Ergebnisse als [concat]: [concat] entfernt eine Ebene der Gruppierung, bevor die Liste gebildet wird, während **list** direkt mit den ursprünglichen Argumenten arbeitet.

# Beispiel

Der Befehl

```
list a b "c d e  " "  f {g h}"
```

gibt zurück

```
a b {c d e  } {  f {g h}}
```

während [concat] mit den gleichen Argumenten zurückgibt

```
a b c d e f {g h}
```


[concat]: concat.md
[eval]: eval.md
[lindex]: lindex.md
