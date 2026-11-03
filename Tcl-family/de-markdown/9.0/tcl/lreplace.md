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

**lreplace** gibt eine neue Liste zurück, die entsteht, indem null oder mehr Elemente von *list* durch die *element*-Argumente ersetzt werden. *first* und *last* sind Indexwerte, die das erste und das letzte Element des zu ersetzenden Bereichs festlegen. Die Indexwerte *first* und *last* werden genauso interpretiert wie Indexwerte beim Befehl [string index][string]; einfache Indexarithmetik und Indizes relativ zum Ende der Liste werden unterstützt. 0 bezeichnet das erste Element der Liste, und **end** bezeichnet das letzte Element der Liste.

Ist *first* oder *last* kleiner als null, gilt es als Verweis auf die Stelle vor dem ersten Element der Liste. Dadurch kann **lreplace** Elemente am Anfang von *list* einfügen. Bezeichnet *first* oder *last* eine Position, die größer ist als der Index des letzten Elements der Liste, wird der Wert so behandelt, als wäre er ein Index, der um eins größer ist als der des letzten Elements. Dadurch kann **lreplace** Elemente an *list* anhängen.

Ist *last* kleiner als *first*, werden alle angegebenen Elemente vor dem durch *first* bezeichneten Element in die Liste eingefügt, ohne dass Elemente gelöscht werden.

Die *element*-Argumente legen null oder mehr neue Elemente fest, die anstelle der gelöschten Elemente in die Liste aufgenommen werden. Jedes *element*-Argument wird zu einem eigenen Element der Liste. Wird kein *element*-Argument angegeben, werden die Elemente zwischen *first* und *last* einfach gelöscht.

# Beispiele

Ein Element einer Liste durch ein anderes ersetzen:

```
% lreplace {a b c d e} 1 1 foo
a foo c d e
```

Zwei Elemente einer Liste durch drei ersetzen:

```
% lreplace {a b c d e} 1 2 three more elements
a three more elements d e
```

Das letzte Element aus einer Liste in einer Variablen löschen:

```
% set var {a b c d e}
a b c d e
% set var [lreplace $var end end]
a b c d
```

Eine Prozedur, die ein bestimmtes Element aus einer Liste löscht:

```
proc lremove {listVariable value} {
    upvar 1 $listVariable var
    set idx [lsearch -exact $var $value]
    set var [lreplace $var $idx $idx]
}
```

Elemente an die Liste anhängen. Beachten Sie, dass **end+2** hier zunächst so behandelt wird, als wäre es **6**. Dieser Wert und **12345** sind jedoch beide größer als der Index des letzten Elements und verhalten sich daher gleich:

```
% set var {a b c d e}
a b c d e
% set var [lreplace $var 12345 end+2 f g h i]
a b c d e f g h i
```


[string]: string.md
