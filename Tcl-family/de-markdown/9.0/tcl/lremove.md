---
CommandName: lremove
title: lremove
ManualSection: n
Version: 9.0
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
 - remove
Copyright:
 - Copyright (c) 2019 Donal K. Fellows.
---

# Name

lremove - Entfernt Listenelemente nach Index

# Übersicht

::: {.synopsis} :::
[lremove]{.cmd} [list]{.arg} [index]{.optdot}
:::

# Beschreibung

**lremove** gibt eine neue Liste zurück, in der gleichzeitig null oder mehr Elemente von *list* an den durch beliebig viele *index*-Argumente genannten Positionen entfernt werden. Indizes in beliebiger Reihenfolge und wiederholbar; jedes Element wird höchstens einmal entfernt. Die Auslegung entspricht [string index][string] (Arithmetik, end-relativ). 0 = erstes Element, **end** = letztes.

# Beispiele

Drittes Element entfernen:

```
% lremove {a b c d e} 2
a b d e
```

Zwei Elemente entfernen:

```
% lremove {a b c d e} end-1 1
a c e
```

Dasselbe Element zweifach angegeben:

```
% lremove {a b c d e} 2 end-2
a b d e
```


[string]: string.md
