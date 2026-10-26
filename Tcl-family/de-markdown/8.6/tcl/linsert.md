---
CommandName: linsert
title: linsert
ManualSection: n
Version: 8.2
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - list(n)
 - lappend(n)
 - lindex(n)
 - llength(n)
 - lsearch(n)
 - lset(n)
 - lsort(n)
 - lrange(n)
 - lreplace(n)
 - string(n)
Keywords:
 - element
 - insert
 - list
Copyright:
 - Copyright (c) 1993 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
 - Copyright (c) 2001 Kevin B. Kenny <kennykb@acm.org>. All rights reserved.
---

# Name

linsert - Fügt Elemente in eine Liste ein

# Übersicht

::: {.synopsis} :::
[linsert]{.cmd} [list]{.arg} [index]{.arg} [element element]{.optdot}
:::

# Beschreibung

Der Befehl erzeugt aus *list* eine neue Liste, indem alle *element*-Argumente unmittelbar vor dem *index*-ten Element von *list* eingefügt werden. Jedes *element* wird ein separates Element der neuen Liste. Ist *index* kleiner oder gleich null, kommen die neuen Elemente an den Anfang; ist *index* größer oder gleich der Listenlänge, gilt es wie **end**. Wie bei [string index][string] unterstützt *index* Indexarithmetik und end-relative Indizes.

Unter der Voraussetzung, dass Indizes gültige Positionen in der Liste bezeichnen und die *element*s in der angegebenen Reihenfolge eingefügt werden, gilt: bei start-relativem *index* steht das erste *element* an diesem Index in der Ergebnisliste; bei end-relativem *index* steht das letzte *element* an diesem Index.

# Beispiele

Werte in eine Liste einfügen — einmal vom Anfang, einmal vom Ende, dann verkettet:

```
set oldList {the fox jumps over the dog}
set midList [linsert $oldList 1 quick]
set newList [linsert $midList end-1 lazy]
# Die alten Listen existieren weiter...
set newerList [linsert [linsert $oldList end-1 quick] 1 lazy]
```


[string]: string.md
