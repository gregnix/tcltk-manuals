---
CommandName: join
title: join
ManualSection: n
Version: unknown
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - list(n)
 - lappend(n)
 - split(n)
Keywords:
 - element
 - join
 - list
 - separator
Copyright:
 - Copyright (c) 1993 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

join - Erzeugt eine Zeichenkette durch Verbinden von Listenelementen

# Übersicht

::: {.synopsis} :::
[join]{.cmd} [list]{.arg} [joinString]{.optarg}
:::

# Beschreibung

Das Argument *list* muss eine gültige Tcl-Liste sein. Der Befehl gibt die Zeichenkette zurück, die entsteht, wenn alle Elemente von *list* mit *joinString* zwischen jeweils benachbarten Elementen verbunden werden. *joinString* ist standardmäßig ein Leerzeichen.

# Beispiele

Erzeugt eine kommagetrennte Liste:

```
set data {1 2 3 4 5}
join $data ", "
     → 1, 2, 3, 4, 5
```

Verwendet **join**, um eine Liste um eine Ebene zu flachen:

```
set data {1 {2 3} 4 {5 {6 7} 8}}
join $data
     → 1 2 3 4 5 {6 7} 8
```
