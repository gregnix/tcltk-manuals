---
CommandName: lindex
title: lindex
ManualSection: n
Version: 8.4
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - list(n)
 - lappend(n)
 - linsert(n)
 - llength(n)
 - lsearch(n)
 - lset(n)
 - lsort(n)
 - lrange(n)
 - lreplace(n)
 - string(n)
Keywords:
 - element
 - index
 - list
Copyright:
 - Copyright (c) 1993 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
 - Copyright (c) 2001 Kevin B. Kenny <kennykb@acm.org>. All rights reserved.
---

# Name

lindex - Liest ein Element aus einer Liste

# Übersicht

::: {.synopsis} :::
[lindex]{.cmd} [list]{.arg} [index]{.optdot}
:::

# Beschreibung

Der Befehl **lindex** nimmt den Parameter *list*, den er als Tcl-Liste behandelt, und null oder mehr *index*-Angaben in die Liste. Die Indizes können nacheinander auf der Befehlszeile stehen oder in einer Tcl-Liste gruppiert als ein einziges Argument übergeben werden.

Ohne Indizes hat der Befehl die Form:

```
lindex list
```

oder

```
lindex list {}
```

In diesem Fall ist der Rückgabewert von **lindex** einfach der Wert des Parameters *list*.

Bei einem einzelnen Index behandelt **lindex** *list* als Tcl-Liste und gibt das *index*-te Element zurück (0 bezeichnet das erste Element). Beim Extrahieren gelten dieselben Regeln für geschweifte Klammern, Anführungszeichen und Backslashes wie beim Tcl-Befehlsinterpreter; Variablen- und Befehlssubstitution finden jedoch nicht statt. Ist *index* negativ oder größer oder gleich der Elementanzahl in *list*, wird eine leere Zeichenkette zurückgegeben. Die Auslegung jedes einfachen *index*-Werts entspricht [string index][string], einschließlich einfacher Indexarithmetik und Indizes relativ zum Listenende.

Weitere *index*-Argumente wählen nacheinander aus dem Ergebnis der vorherigen Indexoperation ein Element — damit lassen sich Elemente aus Unterlisten wählen. Der Befehl

```
lindex $a 1 2 3
```

oder

```
lindex $a {1 2 3}
```

ist gleichbedeutend mit

```
lindex [lindex [lindex $a 1] 2] 3
```

# Beispiele

Listen können von beiden Enden indiziert werden:

```
lindex {a b c} 0
      → a
lindex {a b c} 2
      → c
lindex {a b c} end
      → c
lindex {a b c} end-1
      → b
```

Listen oder Indexfolgen ermöglichen Zugriff in Listen von Listen:

```
lindex {a b c}
      → a b c
lindex {a b c} {}
      → a b c
lindex {{a b c} {d e f} {g h i}} 2 1
      → h
lindex {{a b c} {d e f} {g h i}} {2 1}
      → h
lindex {{{a b} {c d}} {{e f} {g h}}} 1 1 0
      → g
lindex {{{a b} {c d}} {{e f} {g h}}} {1 1 0}
      → g
```

Listenindizes können begrenzte Berechnungen ausführen, indem feste Beträge zu anderen Indizes addiert oder subtrahiert werden:

```
set idx 1
lindex {a b c d e f} $idx+2
      → d
set idx 3
lindex {a b c d e f} $idx+2
      → f
```


[string]: string.md
