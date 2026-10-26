---
CommandName: lmap
ManualSection: n
Version: unknown
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - break(n)
 - continue(n)
 - for(n)
 - foreach(n)
 - while(n)
 - list(n)
 - lappend(n)
 - lassign(n)
 - ledit(n)
 - lindex(n)
 - linsert(n)
 - llength(n)
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
Keywords:
 - foreach
 - iteration
 - list
 - loop
 - map
Copyright:
 - Copyright (c) 2012 Trevor Davel
---

# NAME

lmap - Iteriert über alle Elemente einer oder mehrerer Listen und sammelt Ergebnisse

# ÜBERSICHT

::: {.synopsis} :::
[lmap]{.cmd} [varname]{.arg} [list]{.arg} [body]{.arg} 
[lmap]{.cmd} [varlist1]{.arg} [list1]{.arg} [varlist2 list2]{.optdot} [body]{.arg} 
:::

# BESCHREIBUNG

Der Befehl **lmap** implementiert eine Schleife, in der die Schleifenvariable(n) Werte aus einer oder mehreren Listen annehmen und die Schleife eine Liste der bei jeder Iteration gesammelten Ergebnisse zurückgibt.

Im einfachsten Fall gibt es eine Schleifenvariable *varname* und eine Liste *list* mit Werten, die *varname* zugewiesen werden. Das Argument *body* ist ein Tcl-Skript. Für jedes Element von *list* (in Reihenfolge von erstem zu letztem) weist **lmap** den Inhalt des Elements *varname* zu, als ob **lindex** zum Extrahieren verwendet worden wäre, und ruft dann den Tcl-Interpreter auf, um *body* auszuführen. Schließt die Ausführung von *body* normal ab, wird das Ergebnis von *body* an eine Akkumulatorliste angehängt. **lmap** gibt die Akkumulatorliste zurück.

Im allgemeinen Fall kann es mehr als eine Werteliste geben (z. B. *list1* und *list2*), und jeder Werteliste kann eine Liste von Schleifenvariablen zugeordnet sein (z. B. *varlist1* und *varlist2*). In jeder Iteration werden den Variablen jeder *varlist* aufeinanderfolgende Werte aus der zugehörigen *list* zugewiesen. Werte in jeder *list* werden in Reihenfolge von erstem zu letztem verwendet, und jeder Wert genau einmal. Die Gesamtzahl der Schleifeniterationen ist groß genug, um alle Werte aus allen Wertelisten aufzubrauchen. Enthält eine Werteliste nicht genug Elemente für alle ihre Schleifenvariablen in einer Iteration, werden leere Werte für die fehlenden Elemente verwendet.

**break** und **continue** können innerhalb von *body* aufgerufen werden, mit derselben Wirkung wie bei **for** und **foreach**. In diesen Fällen schließt *body* nicht normal ab, und das Ergebnis wird nicht an die Akkumulatorliste angehängt.

# BEISPIELE

Listen zusammenführen:

```
set list1 {a b c d}
set list2 {1 2 3 4}
set zipped [lmap a $list1 b $list2 {list $a $b}]
# Der Wert von zipped ist "{a 1} {b 2} {c 3} {d 4}"
```

Liste filtern, um ungerade Werte zu entfernen:

```
set values {1 2 3 4 5 6 7 8}
proc isEven {n} {expr {($n % 2) == 0}}
set goodOnes [lmap x $values {expr {
    [isEven $x] ? $x : [continue]
}}]
# Der Wert von goodOnes ist "2 4 6 8"
```

Präfix einer Liste anhand ihres Inhalts nehmen:

```
set values {8 7 6 5 4 3 2 1}
proc isGood {counter} {expr {$n > 3}}
set prefix [lmap x $values {expr {
    [isGood $x] ? $x : [break]
}}]
# Der Wert von prefix ist "8 7 6 5 4"
```
