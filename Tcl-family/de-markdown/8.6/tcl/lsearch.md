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

Dieser Befehl durchsucht die Elemente von *list* danach, ob eines von ihnen zu *pattern* passt. Ist das der Fall, gibt der Befehl den Index des ersten passenden Elements zurück (sofern nicht die Optionen **-all** oder **-inline** angegeben sind). Andernfalls gibt der Befehl **-1** zurück oder (wenn die Optionen **-all** oder **-inline** angegeben sind) die leere Zeichenkette. Die *option*-Argumente geben an, wie die Elemente der Liste mit *pattern* verglichen werden, und müssen einen der folgenden Werte haben:

## Optionen für den Abgleichstil

Fehlen alle Optionen für den Abgleichstil, ist der Standard-Abgleichstil **-glob**. Ist mehr als ein Abgleichstil angegeben, hat der zuletzt angegebene Vorrang.

[-exact]{.lit}
: *Pattern* ist eine literale Zeichenkette, die mit jedem Listenelement auf exakte Gleichheit verglichen wird.

[-glob]{.lit}
: *Pattern* ist ein Muster im Glob-Stil, das nach denselben Regeln wie beim Befehl [string match][string] mit jedem Listenelement verglichen wird.

[-regexp]{.lit}
: *Pattern* wird als regulärer Ausdruck behandelt und nach den Regeln, die auf der Referenzseite [re\_syntax][re_syntax] beschrieben sind, mit jedem Listenelement verglichen.

[-sorted]{.lit}
: Die Listenelemente liegen in sortierter Reihenfolge vor. Ist diese Option angegeben, verwendet **lsearch** einen effizienteren Suchalgorithmus, um *list* zu durchsuchen. Sind keine weiteren Optionen angegeben, wird angenommen, dass *list* aufsteigend sortiert ist und ASCII-Zeichenketten enthält. Diese Option schließt **-glob** und **-regexp** aus und wird genau wie **-exact** behandelt, wenn **-all** oder **-not** angegeben ist.


## Allgemeine Modifikatoren

Diese Optionen können mit allen Abgleichstilen angegeben werden.

[-all]{.lit}
: Ändert das Ergebnis so, dass es die Liste aller passenden Indizes ist (oder aller passenden Werte, wenn zusätzlich **-inline** angegeben ist). Werden Indizes zurückgegeben, stehen sie in aufsteigender numerischer Reihenfolge. Werden Werte zurückgegeben, entspricht ihre Reihenfolge der Reihenfolge dieser Werte in der Eingabeliste *list*.

[-inline]{.lit}
: Statt seines Index wird der passende Wert zurückgegeben (oder eine leere Zeichenkette, wenn kein Wert passt). Ist zusätzlich **-all** angegeben, ist das Ergebnis des Befehls die Liste aller passenden Werte.

[-not]{.lit}
: Kehrt den Sinn des Vergleichs um; zurückgegeben wird der Index des ersten nicht passenden Wertes in der Liste.

[-start]{.lit} [index]{.arg}
: Die Liste wird ab Position *index* durchsucht. Der Wert *index* wird genauso interpretiert wie beim Befehl [string index][string]; einfache Indexarithmetik und Indizes relativ zum Ende der Liste werden unterstützt.


## Optionen zur Inhaltsauslegung

Diese Optionen beschreiben, wie die Elemente der durchsuchten Liste interpretiert werden. Sie sind nur zusammen mit den Optionen **-exact** und **-sorted** sinnvoll. Ist mehr als eine angegeben, hat die zuletzt angegebene Vorrang. Der Standard ist **-ascii**.

[-ascii]{.lit}
: Die Listenelemente werden als Unicode-Zeichenketten untersucht (der Name ist aus Gründen der Abwärtskompatibilität so gewählt).

[-dictionary]{.lit}
: Die Listenelemente werden im Wörterbuchstil verglichen (eine ausführlichere Beschreibung finden Sie bei [lsort]). Beachten Sie, dass sich dies nur dann merklich von der Option **-ascii** unterscheidet, wenn die Option **-sorted** angegeben ist, denn Werte sind im Wörterbuchstil nur dann gleich, wenn sie exakt gleich sind.

[-integer]{.lit}
: Die Listenelemente werden als Ganzzahlen verglichen.

[-nocase]{.lit}
: Bewirkt, dass bei Vergleichen die Groß- und Kleinschreibung nicht beachtet wird. Hat keine Wirkung, wenn die Option mit den Optionen **-dictionary**, **-integer** oder **-real** kombiniert wird.

[-real]{.lit}
: Die Listenelemente werden als Gleitkommawerte verglichen.


## Optionen für sortierte Listen

Diese Optionen (nur zusammen mit der Option **-sorted** sinnvoll) legen fest, wie die Liste sortiert ist. Ist mehr als eine angegeben, hat die zuletzt angegebene Vorrang. Die Standardoption ist **-increasing**.

[-decreasing]{.lit}
: Die Listenelemente sind absteigend sortiert. Diese Option ist nur zusammen mit **-sorted** sinnvoll.

[-increasing]{.lit}
: Die Listenelemente sind aufsteigend sortiert. Diese Option ist nur zusammen mit **-sorted** sinnvoll.

[-bisect]{.lit}
: [Ungenaue Suche, wenn die Listenelemente sortiert sind. Bei einer aufsteigend sortierten Liste wird der letzte Index zurückgegeben, an dem das Element kleiner oder gleich dem Muster ist. Bei einer absteigend sortierten Liste wird der letzte Index zurückgegeben, an dem das Element größer oder gleich dem Muster ist. Liegt das Muster vor dem ersten Element oder ist die Liste leer, wird -1 zurückgegeben. Diese Option schließt **-sorted** ein und kann weder mit **-all** noch mit **-not** verwendet werden.]{version="8.6"}


## Optionen für verschachtelte Listen

Diese Optionen dienen zum Durchsuchen von Listen aus Listen. Sie können mit allen anderen Optionen verwendet werden.

[-index]{.lit} [indexList]{.arg}
: Diese Option ist für die Suche in verschachtelten Listen gedacht. Das Argument *indexList* gibt einen Pfad von Indizes innerhalb jedes Elements an (ähnlich wie bei den Befehlen [lindex] oder [lset]), über den der Wert gefunden wird, mit dem verglichen werden soll.

[-subindices]{.lit}
: Ist diese Option angegeben, ist das Index-Ergebnis dieses Befehls (bzw. jedes Index-Ergebnis, wenn zusätzlich **-all** angegeben ist) ein vollständiger Pfad innerhalb der Gesamtliste zum gefundenen Wert (geeignet für [lindex] oder [lset]). Diese Option hat nur eine Wirkung, wenn auch **-index** angegeben ist, und ist lediglich eine bequeme Abkürzung.


# Beispiele

Einfache Suche:

```
lsearch {a b c d e} c
      → 2
lsearch -all {a b c a b c} c
      → 2 5
```

Listen mit **lsearch** filtern:

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

Damit lässt sich sogar ein „mengenartiges“ Entfernen durchführen:

```
lsearch -all -inline -not -exact {a b c a d e a f g a} a
      → b c d e f g
```

Die Suche kann mitten in der Liste beginnen:

```
lsearch -start 3 {a b c a b c} c
      → 5
```

Es ist auch möglich, innerhalb von Elementen zu suchen:

```
lsearch -index 1 -all -inline {{abc abc} {abc bcd} {abc cde}} *bc*
      → {abc abc} {abc bcd}
```


[lindex]: lindex.md
[lset]: lset.md
[lsort]: lsort.md
[re_syntax]: re_syntax.md
[string]: string.md
