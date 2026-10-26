---
CommandName: lrange
ManualSection: n
Version: 7.4
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - list(n)
 - lappend(n)
 - lindex(n)
 - linsert(n)
 - llength(n)
 - lsearch(n)
 - lset(n)
 - lreplace(n)
 - lsort(n)
 - string(n)
Keywords:
 - element
 - list
 - range
 - sublist
Copyright:
 - Copyright (c) 1993 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
 - Copyright (c) 2001 Kevin B. Kenny <kennykb@acm.org>. All rights reserved.
---

# NAME

lrange - Gibt ein oder mehrere benachbarte Listenelemente zurück

# ÜBERSICHT

::: {.synopsis} :::
[lrange]{.cmd} [list]{.arg} [first]{.arg} [last]{.arg} 
:::

# BESCHREIBUNG

*list* muss eine gültige Tcl-Liste sein. Der Befehl gibt eine neue Liste aus den Elementen *first* bis *last* einschließlich zurück. *first* und *last* werden wie Indizes bei **string index** ausgelegt, einschließlich einfacher Indexarithmetik und Indizes relativ zum Listenende. Ist *first* kleiner als null, gilt es als 0. Ist *last* größer oder gleich der Elementanzahl, gilt es als **end**. Ist *first* größer als *last*, wird eine leere Zeichenkette zurückgegeben.

„**lrange** *list first first*“ liefert nicht immer dasselbe wie „**lindex** *list first*“ (bei einfachen, nicht in Klammern stehenden Feldern oft schon); es entspricht aber genau „**list [lindex** *list first*__]__“.

# BEISPIELE

Die ersten zwei Elemente:

```
% lrange {a b c d e} 0 1
a b
```

Die letzten drei Elemente:

```
% lrange {a b c d e} end-2 end
c d e
```

Alles außer erstem und letztem Element:

```
% lrange {a b c d e} 1 end-1
b c d
```

Ein Element mit **lrange** statt **lindex**:

```
% set var {some {elements to} select}
some {elements to} select
% lindex $var 1
elements to
% lrange $var 1 1
{elements to}
```
