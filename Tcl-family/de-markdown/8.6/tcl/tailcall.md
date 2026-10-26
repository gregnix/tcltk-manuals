---
CommandName: tailcall
title: tailcall
ManualSection: n
Version: 8.6
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - apply(n)
 - proc(n)
 - uplevel(n)
Keywords:
 - call
 - recursion
 - tail recursion
Copyright:
 - Copyright (c) 1993 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

tailcall - Ersetzt die aktuelle Prozedur durch einen anderen Befehl

# Übersicht

::: {.synopsis} :::
[tailcall]{.cmd} [command]{.arg} [arg]{.optdot}
:::

# Beschreibung

Der Befehl **tailcall** ersetzt die gerade ausgeführte Prozedur, Lambda-Anwendung oder Methode durch einen anderen Befehl. *command* wird mit den Argumenten *arg ...* (falls angegeben) aufgerufen und im aktuellen Namespace-Kontext aufgelöst, nicht in dem des Aufrufers. Abgesehen von dieser Auflösungsdifferenz ist er äquivalent zu:

```
return [uplevel 1 [list command ?arg ...?]]
```

Dieser Befehl darf nicht aus einem [uplevel] in eine Prozedur oder aus einem [catch] innerhalb einer Prozedur oder eines Lambdas aufgerufen werden.

# Beispiele

Berechnet die Fakultät einer Zahl.

```
proc factorial {n {accum 1}} {
    if {$n < 2} {
        return $accum
    }
    tailcall factorial [expr {$n - 1}] [expr {$accum * $n}]
}
```

Gibt die Elemente einer Liste aus, wobei abwechselnde Zeilen unterschiedliche Einrückungen haben.

```
proc printList {theList} {
    if {[llength $theList]} {
        puts "> [lindex $theList 0]"
        tailcall printList2 [lrange $theList 1 end]
    }
}
proc printList2 {theList} {
    if {[llength $theList]} {
        puts "< [lindex $theList 0]"
        tailcall printList [lrange $theList 1 end]
    }
}
```


[catch]: catch.md
[uplevel]: uplevel.md
