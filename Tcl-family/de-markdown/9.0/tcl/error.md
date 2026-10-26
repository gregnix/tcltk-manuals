---
CommandName: error
ManualSection: n
Version: unknown
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - catch(n)
 - return(n)
Keywords:
 - error
 - exception
Copyright:
 - Copyright (c) 1993 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# NAME

error - Löst einen Fehler aus

# ÜBERSICHT

::: {.synopsis} :::
[error]{.cmd} [message]{.arg} [info]{.optarg} [code]{.optarg} 
:::

# BESCHREIBUNG

Gibt den Rückgabecode **TCL_ERROR** zurück und bricht die Befehlsauswertung ab. *message* ist eine Zeichenkette für die Anwendung, die den Fehler beschreibt.

Die Rückgabeoption **-errorinfo** des Interpreters sammelt einen Stack-Trace des laufenden Kontexts; beim Unwinden verschachtelter Befehle ergänzt der Interpreter **-errorinfo**. Ist *info* angegeben, initialisiert es **-errorinfo**; der erste Unwind-Schritt des Interpreters entfällt — der Befehl mit **error** erscheint nicht im Stack-Trace, stattdessen steht dort *info*. Historisch besonders mit **catch**: lässt sich ein gefangener Fehler nicht beheben, kann *info* den Stack-Trace am ursprünglichen Fehlerort wiederherstellen:

```
catch {...} errMsg
set savedInfo $::errorInfo
# ...
error $errMsg $savedInfo
```

Ab Tcl 8.5 stattdessen:

```
catch {...} errMsg options
# ...
return -options $options $errMsg
```

Ist *code* angegeben, wird sein Wert in **-errorcode** gespeichert — maschinenlesbare Fehlerbeschreibung; Format siehe **return**.

# BEISPIELE

Fehler, wenn eine einfache Rechenoperation scheitert:

```
if {1+2 != 3} {
    error "something is very wrong with addition"
}
```
