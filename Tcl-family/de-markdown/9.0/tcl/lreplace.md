---
CommandName: lreplace
title: lreplace
ManualSection: n
Version: 7.4
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - list(n)
 - lappend(n)
 - lassign(n)
 - ledit(n)
 - lindex(n)
 - linsert(n)
 - llength(n)
 - lmap(n)
 - lpop(n)
 - lrange(n)
 - lremove(n)
 - lrepeat(n)
 - lreverse(n)
 - lsearch(n)
 - lseq(n)
 - lset(n)
 - lsort(n)
 - string(n)
Keywords:
 - element
 - list
 - replace
Copyright:
 - Copyright (c) 1993 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
 - Copyright (c) 2001 Kevin B. Kenny <kennykb@acm.org>. All rights reserved.
---

# Name

lreplace - Ersetzt Elemente in einer Liste durch neue Elemente

# Übersicht

::: {.synopsis} :::
[lreplace]{.cmd} [list]{.arg} [first]{.arg} [last]{.arg} [element element]{.optdot}
:::

# Beschreibung

**lreplace** gibt eine neue Liste zurück, die entsteht, wenn null oder mehr Elemente von *list* durch die *element*-Argumente ersetzt werden. *first* und *last* begrenzen den zu ersetzenden Bereich; ihre Auslegung entspricht [string index][string] (Arithmetik, end-relativ). 0 ist das erste Element, **end** das letzte.

Ist *first* oder *last* kleiner als null, gilt die Position vor dem ersten Element — so können Elemente vorangestellt werden. Liegt *first* oder *last* hinter dem letzten Index, gilt Index „eins hinter dem letzten“ — so können Elemente angehängt werden.

Ist *last* kleiner als *first*, werden die *element*s vor dem von *first* bezeichneten Element eingefügt, ohne dass etwas gelöscht wird.

Die *element*-Argumente sind die neuen Elemente an Stelle der gelöschten; jedes wird ein separates Listenelement. Ohne *element* werden nur die Elemente von *first* bis *last* entfernt.

# Beispiele

Ein Element ersetzen:

```
% lreplace {a b c d e} 1 1 foo
a foo c d e
```

Zwei Elemente durch drei ersetzen:

```
% lreplace {a b c d e} 1 2 three more elements
a three more elements d e
```

Letztes Element aus einer Variablenliste entfernen:

```
% set var {a b c d e}
a b c d e
% set var [lreplace $var end end]
a b c d
```

Prozedur zum Entfernen eines Werts:

```
proc lremove {listVariable value} {
    upvar 1 $listVariable var
    set idx [lsearch -exact $var $value]
    set var [lreplace $var $idx $idx]
}
```

Anhängen; **end+2** wird zunächst wie 6 behandelt, liegt aber hinter dem letzten Index und verhält sich wie ein Index hinter dem Ende:

```
% set var {a b c d e}
a b c d e
% set var [lreplace $var 12345 end+2 f g h i]
a b c d e f g h i
```


[string]: string.md
