---
CommandName: apply
title: apply
ManualSection: n
Version: unknown
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - proc(n)
 - uplevel(n)
Keywords:
 - anonymous function
 - argument
 - lambda
 - procedure
Copyright:
 - Copyright (c) 2006 Miguel Sofer
 - Copyright (c) 2006 Donal K. Fellows
---

# Name

apply - Wendet eine anonyme Funktion an

# Übersicht

::: {.synopsis} :::
[apply]{.cmd} [func]{.arg} [arg1 arg2]{.optdot}
:::

# Beschreibung

Der Befehl **apply** wendet die Funktion *func* auf die Argumente *arg1 arg2 ...* an und gibt das Ergebnis zurück.

Die Funktion *func* ist eine Liste mit zwei Elementen *{args body}* oder mit drei Elementen *{args body namespace}* (als wäre der Befehl [list] verwendet worden). Das erste Element *args* legt die formalen Argumente von *func* fest. Die Spezifikation der formalen Argumente *args* ist mit dem Befehl [proc] identisch und wird auf der entsprechenden Manpage im Detail beschrieben.

Der Inhalt von *body* wird vom Tcl-Interpreter ausgeführt, nachdem den lokalen Variablen, die den formalen Argumenten entsprechen, die Werte der tatsächlichen Parameter *arg1 arg2 ...* zugewiesen wurden. Während *body* ausgeführt wird, beziehen sich Variablennamen normalerweise auf lokale Variablen, die beim ersten Zugriff automatisch erzeugt und beim Zurückkehren von **apply** gelöscht werden. Für jedes Argument der Funktion wird automatisch eine lokale Variable erzeugt. Auf globale Variablen kann nur über den Befehl [global] oder [upvar] zugegriffen werden. Auf Namespace-Variablen nur über [variable] oder [upvar].

Der Aufruf von **apply** legt einen Aufrufframe auf Tcls Auswertungsstack (den Stack der Frames, auf die [uplevel] zugreift). Die Ausführung von *body* erfolgt in diesem Aufrufframe im durch *namespace* angegebenen Namespace oder im globalen Namespace, wenn keiner angegeben wurde. Ist *namespace* gesetzt, wird es relativ zum globalen Namespace interpretiert, auch wenn der Name nicht mit "::" beginnt.

Die Semantik von **apply** lässt sich auch ungefähr so beschreiben:

```
proc apply {fun args} {
    set len [llength $fun]
    if {($len < 2) || ($len > 3)} {
        error "can't interpret \"$fun\" as anonymous function"
    }
    lassign $fun argList body ns
    set name ::$ns::[getGloballyUniqueName]
    set body0 {
        rename [lindex [info level 0] 0] {}
    }
    proc $name $argList ${body0}$body
    set code [catch {uplevel 1 $name $args} res opt]
    return -options $opt $res
}
```

# Beispiele

Dies zeigt, wie man einen einfachen allgemeinen Befehl erstellt, der eine Transformation auf jedes Element einer Liste anwendet.

```
proc map {lambda list} {
    set result {}
    foreach item $list {
        lappend result [apply $lambda $item]
    }
    return $result
}
map {x {return [string length $x]:$x}} {a bb ccc dddd}
      → 1:a 2:bb 3:ccc 4:dddd
map {x {expr {$x**2 + 3*$x - 2}}} {-4 -3 -2 -1 0 1 2 3 4}
      → 2 -2 -4 -4 -2 2 8 16 26
```

Der Befehl **apply** eignet sich auch zum Definieren von Callbacks für den Befehl [trace]:

```
set vbl "123abc"
trace add variable vbl write {apply {{v1 v2 op} {
    upvar 1 $v1 v
    puts "updated variable to \"$v\""
}}}
set vbl 123
set vbl abc
```


[global]: global.md
[list]: list.md
[proc]: proc.md
[trace]: trace.md
[uplevel]: uplevel.md
[upvar]: upvar.md
[variable]: variable.md
