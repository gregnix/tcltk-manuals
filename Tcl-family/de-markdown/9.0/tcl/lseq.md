---
CommandName: lseq
title: lseq
ManualSection: n
Version: 9.0
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - foreach(n)
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
 - lreplace(n)
 - lreverse(n)
 - lsearch(n)
 - lset(n)
 - lsort(n)
Keywords:
 - element
 - index
 - list
Copyright:
 - Copyright (c) 2022 Eric Taylor. All rights reserved.
---

# Name

lseq - Numerische Folge erzeugen und als Liste zurückgeben

# Übersicht

::: {.synopsis} :::
[lseq]{.cmd} [start]{.arg} [(..|to)]{.optarg} [end]{.arg} [[by]{.optlit} [step]{.arg}]{.optarg}
[lseq]{.cmd} [start]{.arg} [count]{.lit} [count]{.arg} [[by]{.optlit} [step]{.arg}]{.optarg}
[lseq]{.cmd} [count]{.arg} [[by]{.lit} [step]{.arg}]{.optarg}
:::

# Beschreibung

Der Befehl **lseq** erzeugt eine Folge numerischer Werte, die entweder breite Ganzzahlen oder Gleitkommazahlen sein können, anhand der Parameter *start*, *end* und *step*. Das Argument *operation* „**..**“ oder „**to**“ definiert den Bereich. Die Option „**count**“ legt die Anzahl der Elemente in der Liste fest. In der Kurzform mit nur einem Zählwert entsteht ein Bereich von 0 bis *count*-1.

Der Befehl **lseq** kann sowohl aufsteigende als auch absteigende Folgen erzeugen. Sind *start* und *end* ohne *step* angegeben, ist die Folge aufsteigend, wenn *start* <= *end*, und absteigend, wenn *start* > *end*. Ist ein *step*-Wert angegeben, sollte sein Vorzeichen zur Richtung der Folge passen (absteigend → negativ, aufsteigend → positiv); andernfalls wird eine leere Liste zurückgegeben. Beispiele:

```
# aufsteigend:
% lseq 1 to 5
→ 1 2 3 4 5

# absteigend:
% lseq 5 to 1
→ 5 4 3 2 1

# Gleitkommazahlen:
% lseq 0 0.5 by 0.1
→ 0.0 0.1 0.2 0.3 0.4 0.5

# absteigend, Schritt mit falschem Vorzeichen:
% lseq 6 to 1 by 2
→ {}

# Schritt 0,
% lseq 3 to 9 by 0
→ 3
```

*Start* legt den Anfangswert fest und *end* die Grenze, nicht notwendigerweise den letzten Wert. **lseq** erzeugt immer eine Liste mit *count* Elementen, auch wenn *step* 0 ist. Ist *count* nicht angegeben, wird es berechnet als:

```
count = int( ( (end - start) / step ) + 1 )
```

# Beispiele

```
lseq 3
→ 0 1 2

lseq 3 0
→ 3 2 1 0

lseq 10 .. 1 by -2
→ 10 8 6 4 2

set l [lseq 0 -5]
→ 0 -1 -2 -3 -4 -5

lseq 1 count 5 by 0
→ 1 1 1 1 1

foreach i [lseq [llength $l]] {
    puts l($i)=[lindex $l $i]
}
→ l(0)=0
→ l(1)=-1
→ l(2)=-2
→ l(3)=-3
→ l(4)=-4
→ l(5)=-5

foreach i [lseq {[llength $l]-1} 0] {
    puts l($i)=[lindex $l $i]
}
→ l(5)=-5
→ l(4)=-4
→ l(3)=-3
→ l(2)=-2
→ l(1)=-1
→ l(0)=0

set i 17
→ 17

if {$i in [lseq 0 50]} { # äquivalent zu: (0 <= $i && $i <= 50)
    puts "Ok"
} else {
    puts "outside :("
} → Ok

set sqrs [lmap i [lseq 1 10] { expr {$i*$i} }]
→ 1 4 9 16 25 36 49 64 81 100
```
