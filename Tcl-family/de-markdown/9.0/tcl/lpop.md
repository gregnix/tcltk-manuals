---
CommandName: lpop
title: lpop
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
 - lrange(n)
 - lremove(n)
 - lrepeat(n)
 - lreplace(n)
 - lreverse(n)
 - lsearch(n)
 - lseq(n)
 - lset(n)
 - lsort(n)
 - string(n)
Keywords:
 - element
 - index
 - list
 - remove
 - pop
 - stack
 - queue
Copyright:
 - Copyright (c) 2018 Peter Spjuth. All rights reserved.
---

# Name

lpop - Holt ein Listenelement und entfernt es

# Übersicht

::: {.synopsis} :::
[lpop]{.cmd} [varName]{.arg} [index]{.optdot}
:::

# Beschreibung

**lpop** erwartet *varName* als Namen einer Variable mit einer Tcl-Liste sowie einen oder mehrere Indizes in die Liste. Ohne Indizes gilt **end**.

Mit einem Index wird das *index*-te Element geholt, aus der Liste entfernt und zurückgegeben.

Ist *index* negativ oder größer oder gleich der Elementanzahl in *varName*, tritt ein Fehler auf.

Die Auslegung jedes einfachen *index* entspricht [string index][string] (Arithmetik, end-relativ).

Weitere *index*-Argumente adressieren wie bei [lindex] und [lset] verschachtelte Unterlisten:

```
lpop a 1 2
```

holt und entfernt Element 2 der Unterliste 1.

# Beispiele

Anfangswert von *x* in jedem Beispiel:

```
set x [list [list a b c] [list d e f] [list g h i]]
      → {a b c} {d e f} {g h i}
```

Der angezeigte Wert wird der neue Wert von *x* (außer beim letzten: Fehler, *x* unverändert).

```
lpop x 0
      → {d e f} {g h i}
lpop x 2
      → {a b c} {d e f}
lpop x end
      → {a b c} {d e f}
lpop x end-1
      → {a b c} {g h i}
lpop x 2 1
      → {a b c} {d e f} {g i}
lpop x 2 3 j
      → list index out of range
```

Weitere Beispiele, Anfangswert von *x*:

```
set x [list [list [list a b] [list c d]] \
            [list [list e f] [list g h]]]
      → {{a b} {c d}} {{e f} {g h}}
```

Der angezeigte Wert wird der neue Wert von *x*.

```
lpop x 1 1 0
      → {{a b} {c d}} {{e f} h}
```


[lindex]: lindex.md
[lset]: lset.md
[string]: string.md
