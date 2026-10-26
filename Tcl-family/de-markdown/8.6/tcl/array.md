---
CommandName: array
title: array
ManualSection: n
Version: 8.3
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - list(n)
 - string(n)
 - variable(n)
 - trace(n)
 - foreach(n)
Keywords:
 - array
 - element names
 - search
Copyright:
 - Copyright (c) 1993-1994 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

array - Array-Variablen bearbeiten

# Übersicht

::: {.synopsis} :::
[array]{.cmd} [option]{.arg} [arrayName]{.arg} [arg arg]{.optdot}
:::

# Beschreibung

Der Befehl führt eine von mehreren Operationen an der Variable *arrayName* aus. Sofern unten nicht anders angegeben, muss *arrayName* eine bestehende Array-Variable sein. *option* bestimmt die Aktion (Abkürzungen erlaubt):

**array anymore** *arrayName searchId*
: Gibt 1 zurück, wenn in einer Arraysuche noch Elemente übrig sind, sonst 0. *searchId* bezeichnet die Suche (Rückgabewert von **array startsearch**). Nützlich bei leerem Elementnamen, da **array nextelement** allein nicht anzeigt, ob die Suche abgeschlossen ist.

**array donesearch** *arrayName searchId*
: Beendet eine Arraysuche und gibt den zugehörigen Zustand frei. *searchId* stammt von **array startsearch**. Rückgabe leerer String.

**array exists** *arrayName*
: 1, wenn *arrayName* ein Array ist; 0, wenn die Variable fehlt oder skalar ist.

**array get** *arrayName* ?*pattern*?
: Liste aus Paaren: ungerade Position = Elementname, gerade = Wert. Paarreihenfolge undefiniert. Ohne *pattern* alle Elemente. Mit *pattern* nur passende Namen ([string match][string]). Kein Array oder leeres Array: leere Liste. Ändern Traces die Elementliste während des Aufrufs, werden nur Elemente zurückgegeben, die vor und nach **array get** existieren.

**array names** *arrayName* ?*mode*? ?*pattern*?
: Liste der Elementnamen, die *pattern* entsprechen. *mode*: **-exact**, **-glob** oder **-regexp** (Standard **-glob**). Siehe [string match][string] und [regexp]. Ohne *pattern* alle Namen. Keine Treffer oder kein Array: leerer String.

**array nextelement** *arrayName searchId*
: Name des nächsten Elements oder leerer String, wenn die Suche erschöpft ist. *searchId* von **array startsearch**. Warnung: werden Elemente während der Suche hinzugefügt oder gelöscht, werden alle Suchen beendet wie bei **array donesearch**; **array nextelement** schlägt dann für diese Suchen fehl.

**array set** *arrayName list*
: Setzt ein oder mehrere Elemente. *list* wie von **array get**: gerade Anzahl von Elementen, ungerade = Name, folgendes = Wert. Existiert *arrayName* nicht und ist *list* leer, entsteht ein leeres Array.

**array size** *arrayName*
: Dezimalstring mit der Elementanzahl. Kein Array: 0.

**array startsearch** *arrayName*
: Startet elementweise Suche; **array nextelement** liefert die Namen. Abschluss mit **array donesearch**. Rückgabe: Such-ID für parallele Suchen im selben Array. Für die meisten Arrays sind **array get** oder **array names** mit [foreach] effizienter (siehe Beispiele).

**array statistics** *arrayName*
: Statistik zur Datenverteilung in der Hashtable des Arrays: Einträge, Buckets, Auslastung.

**array unset** *arrayName* ?*pattern*?
: Entfernt alle Elemente, deren Namen *pattern* entsprechen ([string match][string]). Kein Array oder keine Treffer: kein Fehler. Ohne *pattern* bei Array-Variable: gesamtes Array löschen. Rückgabe immer leerer String.


# Beispiele

```
array set colorcount {
    red   1
    green 5
    blue  4
    white 9
}

foreach {color count} [array get colorcount] {
    puts "Color: $color Count: $count"
}
  → Color: blue Count: 4
    Color: white Count: 9
    Color: green Count: 5
    Color: red Count: 1

foreach color [array names colorcount] {
    puts "Color: $color Count: $colorcount($color)"
}
  → Color: blue Count: 4
    Color: white Count: 9
    Color: green Count: 5
    Color: red Count: 1

foreach color [lsort [array names colorcount]] {
    puts "Color: $color Count: $colorcount($color)"
}
  → Color: blue Count: 4
    Color: green Count: 5
    Color: red Count: 1
    Color: white Count: 9

array statistics colorcount
  → 4 entries in table, 4 buckets
    number of buckets with 0 entries: 1
    number of buckets with 1 entries: 2
    number of buckets with 2 entries: 1
    number of buckets with 3 entries: 0
    number of buckets with 4 entries: 0
    number of buckets with 5 entries: 0
    number of buckets with 6 entries: 0
    number of buckets with 7 entries: 0
    number of buckets with 8 entries: 0
    number of buckets with 9 entries: 0
    number of buckets with 10 or more entries: 0
    average search distance for entry: 1.2
```


[foreach]: foreach.md
[regexp]: regexp.md
[string]: string.md
