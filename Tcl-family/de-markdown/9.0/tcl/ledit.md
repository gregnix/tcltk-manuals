---
CommandName: ledit
ManualSection: n
Version: 9.0
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - list(n)
 - lappend(n)
 - lassign(n)
 - lindex(n)
 - linsert(n)
 - llength(n)
 - lmap(n)
 - lpop(n)
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
 - list
 - replace
Copyright:
 - Copyright (c) 2022 Ashok P. Nadkarni <apnmbx-public@yahoo.com>. All rights reserved.
---

# NAME

ledit - Ersetzt Elemente einer in einer Variable gespeicherten Liste

# ÜBERSICHT

::: {.synopsis} :::
[ledit]{.cmd} [listVar]{.arg} [first]{.arg} [last]{.arg} [value value]{.optdot} 
:::

# BESCHREIBUNG

Der Befehl liest den Listenwert in der Variable *listVar* und ersetzt die Elemente im durch die Indizes *first* bis *last* (einschließlich) angegebenen Bereich durch die Argumente *value*. Die resultierende Liste wird wieder in *listVar* gespeichert und als Ergebnis des Befehls zurückgegeben.

Die Argumente *first* und *last* sind Indexwerte für das erste und letzte Element des zu ersetzenden Bereichs. Sie werden wie Indexwerte für **string index** interpretiert, einschließlich einfacher Index-Arithmetik und Indizes relativ zum Listenende. Der Index **0** bezeichnet das erste Element der Liste, **end** das letzte. (Anders als bei **lpop**, **lset** und **lindex** werden Indizes in Unterlisten nicht unterstützt.)

Ist *first* oder *last* kleiner als null, bezieht es sich auf die Position vor dem ersten Element der Liste. So können Elemente vorangestellt werden.

Steht *first* oder *last* für eine Position größer als der Index des letzten Elements, wird es behandelt als Index um eins hinter dem letzten Element. So können Elemente angehängt werden.

Ist *last* kleiner als *first*, werden die *element*s vor dem von *first* bezeichneten Element eingefügt, ohne dass etwas gelöscht wird.

Die Argumente *value* legen null oder mehr neue Elemente fest, die anstelle der gelöschten in die Liste eingefügt werden. Jedes *value* wird ein separates Listenelement. Sind keine *value*-Argumente angegeben, werden die Elemente zwischen *first* und *last* nur gelöscht.

# BEISPIELE

Am Listenanfang einfügen:

```
set lst {c d e f g}
      → c d e f g
ledit lst -1 -1 a b
      → a b c d e f g
```

An die Liste anhängen:

```
ledit lst end+1 end+1 h i
      → a b c d e f g h i
```

Drittes und viertes Element löschen:

```
ledit lst 2 3
      → a b e f g h i
```

Zwei Elemente durch drei ersetzen:

```
ledit lst 2 3 x y z
      → a b x y z g h i
set lst
      → a b x y z g h i
```
