---
CommandName: global
title: global
ManualSection: n
Version: unknown
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - namespace(n)
 - upvar(n)
 - variable(n)
Keywords:
 - global
 - namespace
 - procedure
 - variable
Copyright:
 - Copyright (c) 1993 The Regents of the University of California.
 - Copyright (c) 1994-1997 Sun Microsystems, Inc.
---

# Name

global - Zugriff auf globale Variablen

# Übersicht

::: {.synopsis} :::
[global]{.cmd} [varname]{.optdot}
:::

# Beschreibung

Dieser Befehl hat keine Wirkung, sofern er nicht im Kontext eines Prozedurrumpfs ausgeführt wird. Wird **global** im Kontext eines Prozedurrumpfs ausgeführt, werden lokale Variablen erzeugt, die mit den entsprechenden globalen Variablen verknüpft sind (diese verknüpften Variablen erscheinen, wie bei [upvar] erzeugte, nicht in der von [info locals][info] zurückgegebenen Liste).

Enthält *varname* Namespace-Qualifizierer, ist der Name der lokalen Variable der unqualifizierte Name der globalen Variable, wie vom Befehl [namespace tail][namespace] bestimmt.

*varname* wird stets als Variablenname behandelt, nicht als Array-Element. Sieht der Name wie ein Array-Element aus, etwa **a(b)**, wird ein Fehler zurückgegeben.

# Beispiele

Diese Prozedur setzt die Namespace-Variable *::a::x*:

```
proc reset {} {
    global a::x
    set x 0
}
```

Diese Prozedur sammelt die übergebenen Zeichenketten in einem globalen Puffer, durch Zeilenumbrüche getrennt. Nützlich, wenn eine Nachricht stückweise aufgebaut werden soll (wie mit [puts]), aber als Ganzes versendet werden soll (z. B. über eine mit [socket] geöffnete Verbindung oder als Teil einer HTTP-Antwort mit Content-Length).

```
proc accum {string} {
    global accumulator
    append accumulator $string \n
}
```


[info]: info.md
[namespace]: namespace.md
[puts]: puts.md
[socket]: socket.md
[upvar]: upvar.md
