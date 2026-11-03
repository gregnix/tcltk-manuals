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
 - lindex(n)
 - linsert(n)
 - llength(n)
 - lsearch(n)
 - lsort(n)
 - lrange(n)
 - lreplace(n)
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
[lset]{.cmd} [varName]{.arg} [index]{.optdot} newValue
:::

# Beschreibung

Der Befehl **lset** nimmt einen Parameter *varName* entgegen, den er als Namen einer Variablen interpretiert, die eine Tcl-Liste enthält. Außerdem nimmt er null oder mehr *Indizes* in die Liste entgegen. Die Indizes können entweder nacheinander auf der Befehlszeile angegeben oder in einer Tcl-Liste zusammengefasst als ein einziges Argument übergeben werden. Schließlich nimmt er einen neuen Wert für ein Element von *varName* entgegen.

Werden keine Indizes angegeben, hat der Befehl die Form:

```
lset varName newValue
```

oder

```
lset varName {} newValue
```

In diesem Fall ersetzt *newValue* den alten Wert der Variablen *varName*.

Wird ein einzelner Index angegeben, behandelt der Befehl **lset** den Inhalt der Variablen *varName* als Tcl-Liste. Er adressiert darin das *index*-te Element (0 bezeichnet das erste Element der Liste). Beim Interpretieren der Liste beachtet **lset** dieselben Regeln für geschweifte Klammern, Anführungszeichen und Backslashes wie der Tcl-Befehlsinterpreter; Variablenersetzung und Befehlsersetzung finden jedoch nicht statt. Der Befehl baut eine neue Liste auf, in der das bezeichnete Element durch *newValue* ersetzt ist. Diese neue Liste wird in der Variablen *varName* gespeichert und ist zugleich der Rückgabewert des Befehls **lset**.

Ist *index* negativ oder größer als die Anzahl der Elemente in *$varName*, tritt ein Fehler auf.

Ist *index* gleich der Anzahl der Elemente in *$varName*, wird das angegebene Element an die Liste angehängt.

Jeder einfache *index*-Wert wird genauso interpretiert wie beim Befehl [string index][string]; einfache Indexarithmetik und Indizes relativ zum Ende der Liste werden unterstützt.

Werden weitere *index*-Argumente angegeben, dient jedes Argument der Reihe nach dazu, ein Element innerhalb der Unterliste zu adressieren, die die vorherige Indexoperation bezeichnet hat. So kann das Skript Elemente in Unterlisten ändern (oder Elemente an Unterlisten anhängen). Der Befehl

```
lset a 1 2 newValue
```

oder

```
lset a {1 2} newValue
```

ersetzt Element 2 der Unterliste 1 durch *newValue*.

Die Ganzzahl in jedem *index*-Argument muss größer oder gleich null sein. Die Ganzzahl in jedem *index*-Argument muss kleiner oder gleich der Länge der entsprechenden Liste sein. Mit anderen Worten: Der Befehl **lset** kann die Größe einer Liste nur ändern, indem er ein Element anhängt (also das Element nach dem aktuellen Ende setzt). Liegt ein Index außerhalb des zulässigen Bereichs, wird ein Fehler gemeldet.

# Beispiele

In jedem dieser Beispiele ist der Anfangswert von *x*:

```
set x [list [list a b c] [list d e f] [list g h i]]
      → {a b c} {d e f} {g h i}
```

Der angegebene Rückgabewert wird außerdem zum neuen Wert von *x* (außer im letzten Fall; dieser ist ein Fehler, der den Wert von *x* unverändert lässt).

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
      → list index out of range
```

In den folgenden Beispielen ist der Anfangswert von *x*:

```
set x [list [list [list a b] [list c d]] \
            [list [list e f] [list g h]]]
      → {{a b} {c d}} {{e f} {g h}}
```

Der angegebene Rückgabewert wird außerdem zum neuen Wert von *x*.

```
lset x 1 1 0 j
      → {{a b} {c d}} {{e f} {j h}}
lset x {1 1 0} j
      → {{a b} {c d}} {{e f} {j h}}
```


[string]: string.md
