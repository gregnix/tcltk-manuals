---
CommandName: lsort
ManualSection: n
Version: 8.5
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
 - lset(n)
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

# NAME

lsort - Sortiert die Elemente einer Liste

# ÜBERSICHT

::: {.synopsis} :::
[lsort]{.cmd} [options]{.optarg} [list]{.arg} 
:::

# BESCHREIBUNG

Der Befehl sortiert die Elemente von *list* und gibt eine neue, sortierte Liste zurück. Die Implementierung nutzt Merge-Sort — stabil, O(n log n).

Standard ist ASCII-Sortierung in aufsteigender Reihenfolge. Vor *list* können Optionen stehen (Abkürzungen erlaubt):

**-ascii**
: Zeichenkettenvergleich in Unicode-Codepoint-Reihenfolge (Name aus Kompatibilitätsgründen). Standard.

**-dictionary**
: Wörterbuch-Vergleich. Wie **-ascii**, aber (a) Groß-/Klein nur als Tie-Breaker und (b) eingebettete Zahlen vergleichen als Ganzzahlen. Beispiel: **bigBoy** zwischen **bigbang** und **bigboy**; **x10y** zwischen **x9y** und **x11y**. Überschreibt **-nocase**.

**-integer**
: Elemente als Ganzzahlen vergleichen.

**-real**
: Elemente als Fließkommazahlen vergleichen.

**-command** *command*
: *command* als Vergleichsbefehl. Zwei Elemente werden verglichen, indem ein Tcl-Skript aus *command* mit den beiden Elementen als zusätzliche Argumente ausgewertet wird. Rückgabe: Ganzzahl < 0, = 0 oder > 0, wenn das erste Element kleiner, gleich oder größer sein soll.

**-increasing**
: Aufsteigend sortieren („kleinste“ zuerst). Standard.

**-decreasing**
: Absteigend sortieren („größte“ zuerst).

**-indices**
: Liste der Indizes in *list* in sortierter Reihenfolge statt der Werte.

**-index** *indexList*
: Jedes Element von *list* muss eine Tcl-Unterliste sein (außer mit **-stride**). Sortierung nach dem *indexList*-ten Element jeder Unterliste (wie **lindex**). Beispiel:

    ```
    lsort -integer -index 1 \
          {{First 24} {Second 18} {Third 30}}
    ```
    liefert **{Second 18} {First 24} {Third 30}**,

    ```
    lsort -index end-1 \
            {{a 1 e i} {b 2 3 f g} {c 4 5 6 d h}}
    ```
    liefert **{c 4 5 6 d h} {a 1 e i} {b 2 3 f g}**, und

    ```
    lsort -index {0 1} {
        {{b i g} 12345}
        {{d e m o} 34512}
        {{c o d e} 54321}
    }
    ```
    liefert **{{d e m o} 34512} {{b i g} 12345} {{c o d e} 54321}** (weil **e** vor **i** vor **o**). Effizienter als **-command** für denselben Effekt.

**-stride** *strideLength*
: Die Liste gilt als Gruppen zu je *strideLength* Elementen; Gruppen werden am ersten Element oder (mit **-index**) am durch den ersten **-index** bezeichneten Element der Gruppe sortiert (**-index** ignoriert diesen Teil). Elemente bleiben innerhalb der Gruppe an ihrer Position.
    Listenlänge muss Vielfaches von *strideLength* sein (mindestens 2). Beispiel:

    ```
    lsort -stride 2 {carrot 10 apple 50 banana 25}
    ```
    liefert „apple 50 banana 25 carrot 10“, und

    ```
    lsort -stride 2 -index 1 -integer {carrot 10 apple 50 banana 25}
    ```
    liefert „carrot 10 banana 25 apple 50“.

**-nocase**
: Vergleich ohne Groß-/Kleinschreibung. Keine Wirkung mit **-dictionary**, **-integer** oder **-real**.

**-unique**
: Nur die letzte Gruppe doppelter Elemente bleibt. Duplikate relativ zum verwendeten Vergleich; mit **-index 0** gelten **{1 a}** und **{1 b}** als Duplikat — nur **{1 b}** bleibt.

# HINWEISE

Die **lsort**-Optionen steuern nur die Vergleichsart, nicht zwingend den tatsächlichen Typ der Werte. Das fällt nur bei Listen mit weniger als zwei Elementen auf.

**lsort** ist reentrant — sicher als Implementierung eines in **-command** verwendeten Befehls.

# BEISPIELE

ASCII-Sortierung:

```
% lsort {a10 B2 b1 a1 a2}
B2 a1 a10 a2 b1
```

Wörterbuch-Sortierung:

```
% lsort -dictionary {a10 B2 b1 a1 a2}
a1 a2 a10 b1 B2
```

Ganzzahllisten:

```
% lsort -integer {5 3 1 2 11 4}
1 2 3 4 5 11
% lsort -integer {1 2 0x5 7 0 4 -1}
-1 0 1 2 4 0x5 7
```

Fließkommalisten:

```
% lsort -real {5 3 1 2 11 4}
1 2 3 4 5 11
% lsort -real {.5 0.07e1 0.4 6e-1}
0.4 .5 6e-1 0.07e1
```

Sortieren mit Indizes:

```
% # Leerzeichen vor dem c beachten
% lsort {{a 5} { c 3} {b 4} {e 1} {d 2}}
{ c 3} {a 5} {b 4} {d 2} {e 1}
% lsort -index 0 {{a 5} { c 3} {b 4} {e 1} {d 2}}
{a 5} {b 4} { c 3} {d 2} {e 1}
% lsort -index 1 {{a 5} { c 3} {b 4} {e 1} {d 2}}
{e 1} {d 2} { c 3} {b 4} {a 5}
```

Dictionary sortieren:

```
% set d [dict create c d a b h i f g c e]
c e a b h i f g
% lsort -stride 2 $d
a b c e f g h i
```

Stride und mehrere Indizes:

```
% # Erster Indexwert ist relativ zur Gruppe
% lsort -stride 3 -index {0 1} \
     {{Bob Smith} 25 Audi {Jane Doe} 40 Ford}
{{Jane Doe} 40 Ford {Bob Smith} 25 Audi}
```

Duplikate entfernen durch Sortieren:

```
% lsort -unique {a b c a b c a b c}
a b c
```

Vergleichsfunktion:

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
