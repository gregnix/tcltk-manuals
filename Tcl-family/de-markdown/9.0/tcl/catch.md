---
CommandName: catch
title: catch
ManualSection: n
Version: 8.5
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - break(n)
 - continue(n)
 - dict(n)
 - error(n)
 - errorCode(n)
 - errorInfo(n)
 - info(n)
 - return(n)
Keywords:
 - catch
 - error
 - exception
Copyright:
 - Copyright (c) 1993-1994 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

catch - Wertet ein Skript aus und fängt außergewöhnliche Rückgaben ab

# Übersicht

::: {.synopsis} :::
[catch]{.cmd} [script]{.arg} [resultVarName]{.optarg} [optionsVarName]{.optarg}
:::

# Beschreibung

Mit dem Befehl **catch** lässt sich verhindern, dass Fehler die Befehlsauswertung abbrechen. Der Befehl **catch** ruft den Tcl-Interpreter rekursiv auf, um *script* auszuführen. Er kehrt immer zurück, ohne einen Fehler auszulösen, unabhängig davon, welche Fehler bei der Ausführung von *script* auftreten.

Löst *script* einen Fehler aus, gibt **catch** eine von null verschiedene Ganzzahl zurück, die dem außergewöhnlichen Rückgabecode der Auswertung von *script* entspricht. Tcl legt als normalen Rückgabecode einer Skriptauswertung null (0) fest, also **TCL\_OK**. Außerdem definiert Tcl vier außergewöhnliche Rückgabecodes: 1 (**TCL\_ERROR**), 2 (**TCL\_RETURN**), 3 (**TCL\_BREAK**) und 4 (**TCL\_CONTINUE**). Fehler bei der Auswertung eines Skripts werden durch den Rückgabecode **TCL\_ERROR** angezeigt. Die übrigen außergewöhnlichen Rückgabecodes werden von den Befehlen [return], [break] und [continue] sowie in anderen, jeweils dokumentierten Sondersituationen zurückgegeben. Neue Befehle, die von Tcl-Paketen definiert werden, und Skripte, die den Befehl [return -code][return] verwenden, können andere Ganzzahlen als Rückgabecode zurückgeben. Diese müssen jedoch außerhalb des Bereichs liegen, der für Tcl reserviert ist; dieser Bereich ist beim Befehl [return] dokumentiert.

Ist das Argument *resultVarName* angegeben, wird die Variable, die es benennt, auf das Ergebnis der Skriptauswertung gesetzt. Ist der Rückgabecode des Skripts 1 (**TCL\_ERROR**), ist der in *resultVarName* gespeicherte Wert eine Fehlermeldung. Ist der Rückgabecode des Skripts 0 (**TCL\_OK**), ist der in *resultVarName* gespeicherte Wert der Wert, den *script* zurückgegeben hat.

Ist das Argument *optionsVarName* angegeben, wird die Variable, die es benennt, auf ein Dictionary der Rückgabeoptionen gesetzt, die die Auswertung von *script* zurückgegeben hat. Tcl legt zwei Einträge fest, die in diesem Dictionary immer definiert sind: **-code** und **-level**. Ist der Rückgabecode der Auswertung von *script* nicht **TCL\_RETURN**, hat der Eintrag **-level** den Wert 0, und der Eintrag **-code** hat denselben Wert wie der Rückgabecode. Nur wenn der Rückgabecode **TCL\_RETURN** ist, haben die Einträge **-level** und **-code** andere Werte; dies ist in der Dokumentation des Befehls [return] näher beschrieben.

Ist der Rückgabecode der Auswertung von *script* **TCL\_ERROR**, sind im Dictionary der Rückgabeoptionen, das in *optionsVarName* gespeichert wird, vier weitere Einträge definiert: **-errorinfo**, **-errorcode**, **-errorline** und **-errorstack**. Der Wert des Eintrags **-errorinfo** ist ein formatierter Stack-Trace mit weiteren Informationen über den Kontext, in dem der Fehler aufgetreten ist. Der formatierte Stack-Trace ist dafür gedacht, von Menschen gelesen zu werden. Der Wert des Eintrags **-errorcode** enthält zusätzliche Informationen über den Fehler, gespeichert als Liste. Der Wert von **-errorcode** ist zur Weiterverarbeitung durch Programme gedacht und für Menschen unter Umständen nicht besonders gut lesbar. Der Wert des Eintrags **-errorline** ist eine Ganzzahl, die angibt, welche Zeile von *script* ausgewertet wurde, als der Fehler auftrat. Der Wert des Eintrags **-errorstack** ist eine Liste gerader Länge aus Token-Parameter-Paaren, die beim Abbauen des Stacks gesammelt werden. Das Token kann „**CALL**“ sein; dann ist der Parameter eine Liste aus dem Prozedurnamen und den Argumenten auf der entsprechenden Ebene. Oder es kann „**UP**“ sein; dann ist der Parameter die relative Ebene (wie bei [uplevel]) des vorhergehenden **CALL**. Die wesentlichen Unterschiede zu **-errorinfo** sind:

1. Es handelt sich um eine maschinenlesbare Form, die sich mit \[[foreach] {tok prm} ...\] verarbeiten lässt,

2. es enthält die tatsächlichen (ersetzten) Werte, die an die Funktionen übergeben wurden, statt des statischen Texts der Aufrufstellen, und

3. es ist grobkörniger und enthält nur ein Element pro Stack-Frame (wie bei Prozeduren; es gibt zum Beispiel keine eigenen Elemente für [foreach]-Konstrukte).


Die Werte der Einträge **-errorinfo** und **-errorcode** des letzten Fehlers stehen außerdem als Werte der globalen Variablen **::errorInfo** beziehungsweise **::errorCode** zur Verfügung. Der Wert des Eintrags **-errorstack** wird über [info errorstack][info] zugänglich.

Tcl-Pakete können Befehle bereitstellen, die weitere Einträge im Dictionary der Rückgabeoptionen setzen. Außerdem können Skripte mit dem Befehl [return] zusätzlich zu den oben definierten Rückgabeoptionen weitere setzen.

# Beispiele

Der Befehl **catch** kann in einem [if] verwendet werden, um abhängig vom Erfolg eines Skripts zu verzweigen.

```
if { [catch {open $someFile w} fid] } {
    puts stderr "Could not open $someFile for writing\n$fid"
    exit 1
}
```

Komplexere Beispiele für die Verwendung von **catch** finden Sie in der Dokumentation des Befehls [return].


[break]: break.md
[continue]: continue.md
[foreach]: foreach.md
[if]: if.md
[info]: info.md
[return]: return.md
[uplevel]: uplevel.md
