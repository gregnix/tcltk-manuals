---
CommandName: lset
title: lset
ManualSection: n
Version: 8.4
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
 - lreplace(n)
 - lreverse(n)
 - lsearch(n)
 - lseq(n)
 - lsort(n)
 - string(n)
Keywords:
 - element
 - index
 - list
 - replace
 - set
Copyright:
 - Copyright (c) 2001 Kevin B. Kenny <kennykb@acm.org>. All rights reserved.
---

# Name

lset - Ändert ein Element in einer Liste

# Übersicht

::: {.synopsis} :::
[lset]{.cmd} [varName]{.arg} ?index ...? newValue
:::

# Beschreibung

**lset** nimmt *varName* als Namen einer Variable mit einer Tcl-Liste, null oder mehr Indizes in die Liste und einen neuen Wert *newValue* für ein Element. Die Indizes können entweder nacheinander auf der Befehlszeile oder als Tcl-Liste gruppiert in einem einzigen Argument angegeben werden.

Ohne Indizes:

```
lset varName newValue
```

oder

```
lset varName {} newValue
```

Dann ersetzt *newValue* den alten Inhalt von *varName*.

Bei einem Index behandelt **lset** den Inhalt von *varName* als Tcl-Liste und adressiert das *index*-te Element (0 = erstes Element). Beim Interpretieren gelten dieselben Regeln für Klammern, Anführungszeichen und Backslashes wie beim Interpreter; Variablen- und Befehlssubstitution finden nicht statt. Es entsteht eine neue Liste mit ersetztem Element, wird in *varName* geschrieben und ist der Rückgabewert.

Ist *index* negativ oder größer als die Elementanzahl in *$varName*, tritt ein Fehler auf.

Ist *index* gleich der Elementanzahl in *$varName*, wird das gegebene Element angehängt.

Die Auslegung jedes einfachen *index* entspricht [string index][string] (Arithmetik, end-relativ).

Weitere *index*-Argumente adressieren nacheinander Elemente in Unterlisten der vorherigen Indexoperation — Änderung oder Anhängen in Unterlisten. Der Befehl

```
lset a 1 2 newValue
```

oder

```
lset a {1 2} newValue
```

ersetzt Element 2 der Unterliste 1 durch *newValue*.

Jede Ganzzahl in einem *index* muss ≥ 0 und ≤ der Länge der zugehörigen Liste sein. **lset** kann die Listengröße nur durch Anhängen (Setzen des Elements hinter dem aktuellen Ende) vergrößern. Liegt ein Index außerhalb, wird ein Fehler gemeldet.

# Beispiele

Anfangswert von *x* in jedem Beispiel:

```
set x [list [list a b c] [list d e f] [list g h i]]
      → {a b c} {d e f} {g h i}
```

Der angegebene Rückgabewert wird neuer Wert von *x* (außer beim letzten Fall — Fehler, *x* unverändert):

```
lset x {j k l}
      → j k l
lset x {} {j k l}
      → j k l
lset x 0 j
      → j {d e f} {g h i}
lset x 2 j
      → {a b c} {d e f} j
lset x end j
      → {a b c} {d e f} j
lset x end-1 j
      → {a b c} j {g h i}
lset x 2 1 j
      → {a b c} {d e f} {g j i}
lset x {2 1} j
      → {a b c} {d e f} {g j i}
lset x {2 3} j
      → {a b c} {d e f} {g h i j}
lset x {2 4} j
      → list index out of range
```

Weitere Beispiele; Anfangswert von *x*:

```
set x [list [list [list a b] [list c d]] \
            [list [list e f] [list g h]]]
      → {{a b} {c d}} {{e f} {g h}}
```

Der angegebene Rückgabewert wird neuer Wert von *x*.

```
lset x 1 1 0 j
      → {{a b} {c d}} {{e f} {j h}}
lset x {1 1 0} j
      → {{a b} {c d}} {{e f} {j h}}
```


[string]: string.md
