---
CommandName: lsearch
title: lsearch
ManualSection: n
Version: 8.6
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - foreach(n)
 - list(n)
 - lappend(n)
 - lindex(n)
 - linsert(n)
 - llength(n)
 - lset(n)
 - lsort(n)
 - lrange(n)
 - lreplace(n)
 - string(n)
Keywords:
 - binary search
 - linear search
 - list
 - match
 - pattern
 - regular expression
 - search
 - string
Copyright:
 - Copyright (c) 1993 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
 - Copyright (c) 2001 Kevin B. Kenny <kennykb@acm.org>. All rights reserved.
 - Copyright (c) 2003-2004 Donal K. Fellows.
---

# Name

lsearch - Prüft, ob eine Liste ein bestimmtes Element enthält

# Übersicht

::: {.synopsis} :::
[lsearch]{.cmd} [options]{.optarg} [list]{.arg} [pattern]{.arg}
:::

# Beschreibung

Der Befehl durchsucht die Elemente von *list*, ob eines zu *pattern* passt. Dann gibt er den Index des ersten Treffers zurück (außer bei **-all** oder **-inline**). Sonst **-1** oder bei **-all**/**-inline** eine leere Zeichenkette. Die *option*-Argumente legen fest, wie verglichen wird; es muss einer der unten genannten Werte sein:

## Optionen für den Abgleichstil

Fehlen alle Abgleichstil-Optionen, ist der Standard **-glob**. Mehrere Abgleichstile: der zuletzt angegebene gilt.

[-exact]{.lit}
: *pattern* ist eine Literalzeichenkette; exakter Vergleich mit jedem Listenelement.

[-glob]{.lit}
: *pattern* ist ein Glob-Muster; Abgleich wie bei [string match][string].

[-regexp]{.lit}
: *pattern* ist ein regulärer Ausdruck; Regeln siehe [re\_syntax][re_syntax].

[-sorted]{.lit}
: Die Listenelemente sind sortiert. Dann nutzt **lsearch** einen effizienteren Suchalgorithmus. Ohne weitere Optionen gilt: sortiert aufsteigend, ASCII-Zeichenketten. Schließt **-glob** und **-regexp** aus; bei **-all** oder **-not** wie **-exact**.


## Allgemeine Modifikatoren

Gelten für alle Abgleichstile.

[-all]{.lit}
: Ergebnis ist die Liste aller passenden Indizes (oder aller passenden Werte mit **-inline**). Indizes in aufsteigender numerischer Reihenfolge; Werte in der Reihenfolge innerhalb von *list*.

[-inline]{.lit}
: Der passende Wert statt seines Index (leere Zeichenkette ohne Treffer). Mit **-all**: Liste aller passenden Werte.

[-not]{.lit}
: Negiert den Treffer; Index des ersten Nicht-Treffers.

[-start]{.lit} [index]{.arg}
: Suche ab Position *index*; Auslegung wie bei [string index][string] (Arithmetik, end-relativ).


## Optionen zur Inhaltsauslegung

Bedeuten nur mit **-exact** und **-sorted**. Mehrere: der letzte gilt. Standard: **-ascii**.

[-ascii]{.lit}
: Elemente als Unicode-Zeichenketten (Name aus Kompatibilitätsgründen).

[-dictionary]{.lit}
: Wörterbuch-Vergleich (siehe [lsort]). Nur mit **-sorted** sinnvoll anders als **-ascii**, da dictionary-gleich nur bei exakter Gleichheit.

[-integer]{.lit}
: Vergleich als Ganzzahlen.

[-nocase]{.lit}
: Vergleich ohne Groß-/Kleinschreibung. Keine Wirkung mit **-dictionary**, **-integer** oder **-real**.

[-real]{.lit}
: Vergleich als Fließkommazahlen.


## Optionen für sortierte Listen

Nur mit **-sorted**; mehrere: der letzte gilt. Standard: **-increasing**.

[-decreasing]{.lit}
: Liste absteigend sortiert. Nur mit **-sorted**.

[-increasing]{.lit}
: Liste aufsteigend sortiert. Nur mit **-sorted**.

[-bisect]{.lit}
: [Ungenauer Suchtreffer bei sortierter Liste. Aufsteigend: letzter Index, an dem das Element kleiner oder gleich *pattern* ist. Absteigend: größer oder gleich. Liegt *pattern* vor dem ersten Element oder ist die Liste leer: **-1**. Impliziert **-sorted**; nicht mit **-all** oder **-not**.]{version="8.6"}


## Optionen für verschachtelte Listen

Für Listen von Listen; kombinierbar mit anderen Optionen.

[-index]{.lit} [indexList]{.arg}
: Für verschachtelte Listen: Pfad von Indizes (wie bei [lindex]/[lset]) innerhalb jedes Elements zum Vergleichswert.

[-subindices]{.lit}
: Der Index (oder jeder bei **-all**) ist ein vollständiger Pfad im Gesamtlistensinn für [lindex]/[lset]. Nur sinnvoll mit **-index**; Kurzform.


# Beispiele

Einfache Suche:

```
lsearch {a b c d e} c
      → 2
lsearch -all {a b c a b c} c
      → 2 5
```

Filtern mit **lsearch**:

```
lsearch -inline {a20 b35 c47} b*
      → b35
lsearch -inline -not {a20 b35 c47} b*
      → a20
lsearch -all -inline -not {a20 b35 c47} b*
      → a20 c47
lsearch -all -not {a20 b35 c47} b*
      → 0 2
```

„Set-artiges“ Entfernen:

```
lsearch -all -inline -not -exact {a b c a d e a f g a} a
      → b c d e f g
```

Suche ab einer Position:

```
lsearch -start 3 {a b c a b c} c
      → 5
```

Suche innerhalb von Elementen:

```
lsearch -index 1 -all -inline {{abc abc} {abc bcd} {abc cde}} *bc*
      → {abc abc} {abc bcd}
```


[lindex]: lindex.md
[lset]: lset.md
[lsort]: lsort.md
[re_syntax]: re_syntax.md
[string]: string.md
