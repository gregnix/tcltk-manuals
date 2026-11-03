---
CommandName: lsort
title: lsort
ManualSection: n
Version: 8.5
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - list(n)
 - lappend(n)
 - lindex(n)
 - linsert(n)
 - llength(n)
 - lsearch(n)
 - lset(n)
 - lrange(n)
 - lreplace(n)
Keywords:
 - element
 - list
 - order
 - sort
Copyright:
 - Copyright (c) 1993 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
 - Copyright (c) 1999 Scriptics Corporation
 - Copyright (c) 2001 Kevin B. Kenny <kennykb@acm.org>. All rights reserved.
---

# Name

lsort - Sortiert die Elemente einer Liste

# Übersicht

::: {.synopsis} :::
[lsort]{.cmd} [options]{.optarg} [list]{.arg}
:::

# Beschreibung

Dieser Befehl sortiert die Elemente von *list* und gibt eine neue Liste in sortierter Reihenfolge zurück. Die Implementierung des Befehls **lsort** verwendet den Merge-Sort-Algorithmus. Dieser sortiert stabil und hat ein Laufzeitverhalten von O(n log n).

Standardmäßig wird ASCII-Sortierung verwendet, und das Ergebnis wird in aufsteigender Reihenfolge zurückgegeben. Sie können jedoch vor *list* jede der folgenden Optionen angeben, um den Sortiervorgang zu steuern (eindeutige Abkürzungen werden akzeptiert):

**-ascii**
: Verwendet einen Zeichenkettenvergleich mit der Sortierreihenfolge der Unicode-Codepoints (der Name ist aus Gründen der Abwärtskompatibilität so gewählt). Dies ist die Voreinstellung.

**-dictionary**
: Verwendet einen Vergleich im Wörterbuchstil. Dieser entspricht **-ascii**, mit zwei Ausnahmen: (a) Die Groß-/Kleinschreibung wird nur zur Entscheidung bei Gleichstand herangezogen, und (b) wenn zwei Zeichenketten eingebettete Zahlen enthalten, werden die Zahlen als Ganzzahlen verglichen, nicht als Zeichen. Im Modus **-dictionary** wird zum Beispiel **bigBoy** zwischen **bigbang** und **bigboy** einsortiert und **x10y** zwischen **x9y** und **x11y**. Diese Option setzt die Option **-nocase** außer Kraft.

**-integer**
: Wandelt die Listenelemente in Ganzzahlen um und verwendet einen ganzzahligen Vergleich.

**-real**
: Wandelt die Listenelemente in Gleitkommawerte um und verwendet einen Gleitkommavergleich.

**-command** *command*
: Verwendet *command* als Vergleichsbefehl. Um zwei Elemente zu vergleichen, wird ein Tcl-Skript ausgewertet, das aus *command* besteht, an das die beiden Elemente als zusätzliche Argumente angehängt sind. Das Skript sollte eine Ganzzahl kleiner als, gleich oder größer als null zurückgeben, wenn das erste Element als kleiner als, gleich oder größer als das zweite gelten soll.

**-increasing**
: Sortiert die Liste in aufsteigender Reihenfolge (die „kleinsten“ Elemente zuerst). Dies ist die Voreinstellung.

**-decreasing**
: Sortiert die Liste in absteigender Reihenfolge (die „größten“ Elemente zuerst).

**-indices**
: Gibt statt der Werte selbst eine Liste der Indizes in *list* in sortierter Reihenfolge zurück.

**-index** *indexList*
: Wenn diese Option angegeben ist, muss jedes Element von *list* selbst eine korrekte Tcl-Unterliste sein (sofern nicht **-stride** verwendet wird). Statt anhand der ganzen Unterlisten zu sortieren, entnimmt **lsort** jeder Unterliste das *indexList*-te Element (so, als würden das jeweilige Gesamtelement und *indexList* an [lindex] übergeben) und sortiert anhand dieses Elements. Zum Beispiel gibt

    ```
    lsort -integer -index 1 \
          {{First 24} {Second 18} {Third 30}}
    ```

    **{Second 18} {First 24} {Third 30}** zurück,

    ```
    lsort -index end-1 \
            {{a 1 e i} {b 2 3 f g} {c 4 5 6 d h}}
    ```

    gibt **{c 4 5 6 d h} {a 1 e i} {b 2 3 f g}** zurück, und

    ```
    lsort -index {0 1} {
        {{b i g} 12345}
        {{d e m o} 34512}
        {{c o d e} 54321}
    }
    ```

    gibt **{{d e m o} 34512} {{b i g} 12345} {{c o d e} 54321}** zurück (weil **e** vor **i** einsortiert wird, das wiederum vor **o** einsortiert wird). Diese Option ist wesentlich effizienter, als dieselbe Wirkung mit **-command** zu erreichen.

**-stride** *strideLength*
: Wenn diese Option angegeben ist, wird die Liste so behandelt, als bestünde sie aus Gruppen von je *strideLength* Elementen. Die Gruppen werden entweder nach ihrem ersten Element sortiert oder, wenn die Option **-index** verwendet wird, nach dem Element innerhalb jeder Gruppe, das der erste an **-index** übergebene Index bezeichnet (dieser Index wird dann von **-index** ignoriert). Die Elemente bleiben stets an derselben Position innerhalb ihrer Gruppe.

    Die Listenlänge muss ein ganzzahliges Vielfaches von *strideLength* sein; dieser Wert muss seinerseits mindestens 2 betragen.

    Zum Beispiel gibt

    ```
    lsort -stride 2 {carrot 10 apple 50 banana 25}
    ```

    „apple 50 banana 25 carrot 10“ zurück, und

    ```
    lsort -stride 2 -index 1 -integer {carrot 10 apple 50 banana 25}
    ```

    gibt „carrot 10 banana 25 apple 50“ zurück.

**-nocase**
: Bewirkt, dass Vergleiche ohne Berücksichtigung der Groß-/Kleinschreibung durchgeführt werden. Hat keine Wirkung, wenn die Option mit **-dictionary**, **-integer** oder **-real** kombiniert wird.

**-unique**
: Wenn diese Option angegeben ist, wird von jeder Gruppe doppelter Elemente in der Liste nur das zuletzt gefundene behalten. Beachten Sie, dass Duplikate anhand des beim Sortieren verwendeten Vergleichs bestimmt werden. Wird also **-index 0** verwendet, gelten **{1 a}** und **{1 b}** als Duplikate, und nur das zweite Element, **{1 b}**, wird behalten.


# Hinweise

Die Optionen von **lsort** steuern nur, welche Art von Vergleich verwendet wird. Sie schränken nicht zwangsläufig ein, was die Werte selbst tatsächlich sind. Dieser Unterschied fällt nur auf, wenn die zu sortierende Liste weniger als zwei Elemente hat.

Der Befehl **lsort** ist reentrant. Er kann also gefahrlos in der Implementierung eines Befehls verwendet werden, der in der Option **-command** benutzt wird.

# Beispiele

Eine Liste mit ASCII-Sortierung sortieren:

```
% lsort {a10 B2 b1 a1 a2}
B2 a1 a10 a2 b1
```

Eine Liste mit Wörterbuch-Sortierung sortieren:

```
% lsort -dictionary {a10 B2 b1 a1 a2}
a1 a2 a10 b1 B2
```

Listen von Ganzzahlen sortieren:

```
% lsort -integer {5 3 1 2 11 4}
1 2 3 4 5 11
% lsort -integer {1 2 0x5 7 0 4 -1}
-1 0 1 2 4 0x5 7
```

Listen von Gleitkommazahlen sortieren:

```
% lsort -real {5 3 1 2 11 4}
1 2 3 4 5 11
% lsort -real {.5 0.07e1 0.4 6e-1}
0.4 .5 6e-1 0.07e1
```

Mit Indizes sortieren:

```
% # Leerzeichen vor dem c beachten
% lsort {{a 5} { c 3} {b 4} {e 1} {d 2}}
{ c 3} {a 5} {b 4} {d 2} {e 1}
% lsort -index 0 {{a 5} { c 3} {b 4} {e 1} {d 2}}
{a 5} {b 4} { c 3} {d 2} {e 1}
% lsort -index 1 {{a 5} { c 3} {b 4} {e 1} {d 2}}
{e 1} {d 2} { c 3} {b 4} {a 5}
```

[Ein Dictionary sortieren:]{version="8.6"}

```
% set d [dict create c d a b h i f g c e]
c e a b h i f g
% lsort -stride 2 $d
a b c e f g h i
```

Mit Gruppen (Stride) und mehreren Indizes sortieren:

```
% # Erster Indexwert ist relativ zur Gruppe
% lsort -stride 3 -index {0 1} \
     {{Bob Smith} 25 Audi {Jane Doe} 40 Ford}
{{Jane Doe} 40 Ford {Bob Smith} 25 Audi}
```

Doppelte Werte durch Sortieren entfernen:

```
% lsort -unique {a b c a b c a b c}
a b c
```

Komplexeres Sortieren mit einer Vergleichsfunktion:

```
% proc compare {a b} {
    set a0 [lindex $a 0]
    set b0 [lindex $b 0]
    if {$a0 < $b0} {
        return -1
    } elseif {$a0 > $b0} {
        return 1
    }
    return [string compare [lindex $a 1] [lindex $b 1]]
}
% lsort -command compare \
        {{3 apple} {0x2 carrot} {1 dingo} {2 banana}}
{1 dingo} {2 banana} {0x2 carrot} {3 apple}
```


[lindex]: lindex.md
