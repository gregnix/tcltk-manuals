---
CommandName: upvar
title: upvar
ManualSection: n
Version: unknown
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - global(n)
 - namespace(n)
 - uplevel(n)
 - variable(n)
Keywords:
 - context
 - frame
 - global
 - level
 - namespace
 - procedure
 - upvar
 - variable
Copyright:
 - Copyright (c) 1993 The Regents of the University of California.
 - Copyright (c) 1994-1997 Sun Microsystems, Inc.
---

# Name

upvar - Verknüpfung zu einer Variable in einem anderen Stack-Frame erstellen

# Übersicht

::: {.synopsis} :::
[upvar]{.cmd} [level]{.optarg} [otherVar]{.arg} [myVar]{.arg} [otherVar myVar]{.optdot}
:::

# Beschreibung

Dieser Befehl richtet ein, dass eine oder mehrere lokale Variablen in der aktuellen Prozedur auf Variablen in einem umschließenden Prozeduraufruf oder auf globale Variablen verweisen. *Level* kann jede für den Befehl [uplevel] zulässige Form haben und kann weggelassen werden (Standard **1**). Für jedes Argument *otherVar* macht **upvar** die Variable mit diesem Namen im durch *level* angegebenen Prozedur-Frame (oder auf globaler Ebene, wenn *level* **#0** ist) in der aktuellen Prozedur unter dem Namen aus dem zugehörigen Argument *myVar* zugänglich. Die von *otherVar* benannte Variable muss zum Zeitpunkt des Aufrufs noch nicht existieren; sie wird beim ersten Zugriff auf *myVar* erzeugt, wie eine gewöhnliche Variable. Zum Zeitpunkt des Aufrufs von **upvar** darf noch keine Variable mit dem Namen *myVar* existieren. *MyVar* wird stets als Name einer Variable behandelt, nicht als Array-Element. Wenn der Name wie ein Array-Element aussieht, z. B. **a(b)**, wird ein Fehler zurückgegeben. *OtherVar* kann eine Skalarvariable, ein Array oder ein Array-Element bezeichnen. **Upvar** gibt eine leere Zeichenkette zurück.

Der Befehl **upvar** vereinfacht die Implementierung von Call-by-Name-Prozeduraufrufen und erleichtert den Aufbau neuer Steuerkonstrukte als Tcl-Prozeduren. Als Beispiel dient folgende Prozedur:

```
proc add2 name {
    upvar $name x
    set x [expr {$x + 2}]
}
```

Wird *add2* mit einem Argument aufgerufen, das den Namen einer Variable angibt, addiert es zwei zum Wert dieser Variable. Obwohl *add2* auch mit [uplevel] statt **upvar** implementiert werden könnte, erleichtert **upvar** *add2* den Zugriff auf die Variable im Prozedur-Frame des Aufrufers.

[namespace eval][namespace] ist ein weiterer Weg (neben Prozeduraufrufen), wie sich der Tcl-Namenskontext ändern kann. Er fügt dem Stack einen Aufruf-Frame hinzu, der den Namespace-Kontext repräsentiert. Das bedeutet, dass jeder Befehl [namespace eval][namespace] als weitere Aufrufebene für [uplevel] und **upvar** zählt. Beispielsweise liefert [info level][info] **1** eine Liste, die einen Befehl beschreibt, der entweder der äußerste Prozeduraufruf oder der äußerste Befehl [namespace eval][namespace] ist. Außerdem wertet [uplevel #0][uplevel] ein Skript auf oberster Ebene im äußersten Namespace (dem globalen Namespace) aus.

Wird eine upvar-Variable gelöscht (z. B. **x** in **add2** oben), betrifft [unset] die verknüpfte Variable, nicht die upvar-Variable. Eine upvar-Variable lässt sich nur durch Verlassen der Prozedur löschen, in der sie definiert ist. Es ist jedoch möglich, eine upvar-Variable umzubinden, indem ein weiterer **upvar**-Befehl ausgeführt wird.

# Traces und upvar

Upvar interagiert mit Traces auf einfache, aber möglicherweise unerwartete Weise. Ist auf *otherVar* ein Variablen-Trace definiert, wird dieser Trace durch Aktionen ausgelöst, die *myVar* betreffen. Die Trace-Prozedur erhält jedoch den Namen von *myVar*, nicht den Namen von *otherVar*. Die Ausgabe des folgenden Codes lautet daher „*localVar*“ und nicht „*originalVar*“:

```
proc traceproc { name index op } {
    puts $name
}
proc setByUpvar { name value } {
    upvar $name localVar
    set localVar $value
}
set originalVar 1
trace variable originalVar w traceproc
setByUpvar originalVar 2
```

Bezieht sich *otherVar* auf ein Element eines Arrays, werden Variablen-Traces, die auf das gesamte Array gesetzt sind, beim Zugriff auf *myVar* nicht ausgelöst (Traces auf das jeweilige Element werden jedoch weiterhin ausgelöst). Insbesondere werden Änderungen an *myVar* nicht korrekt an Unterprozesse weitergegeben, wenn das Array [env][tclvars] ist.

# Beispiel

Ein Befehl **decr**, der wie [incr] funktioniert, aber den Wert von der Variable subtrahiert statt addiert:

```
proc decr {varName {decrement 1}} {
    upvar 1 $varName var
    incr var [expr {-$decrement}]
}
```


[incr]: incr.md
[info]: info.md
[namespace]: namespace.md
[tclvars]: tclvars.md
[unset]: unset.md
[uplevel]: uplevel.md
