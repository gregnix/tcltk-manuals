---
CommandName: bgerror
title: bgerror
ManualSection: n
Version: 7.5
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - after(n)
 - errorCode(n)
 - errorInfo(n)
 - interp(n)
Keywords:
 - background error
 - reporting
Copyright:
 - Copyright (c) 1990-1994 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

bgerror - Befehl zur Behandlung von Hintergrundfehlern

# Übersicht

::: {.synopsis} :::
[bgerror]{.cmd} [message]{.arg}
:::

# Beschreibung

Tcl 8.5 unterstützt den Befehl [interp bgerror][interp], mit dem Anwendungen in einem Interpreter den Befehl registrieren können, der Hintergrundfehler in diesem Interpreter behandelt. In älteren Tcl-Versionen war diese Steuerung nicht verfügbar; Anwendungen konnten Hintergrundfehler nur steuern, indem sie im globalen Namespace eines Interpreters einen Befehl mit genau dem Namen **bgerror** definierten. Die folgende Dokumentation beschreibt die Schnittstellenanforderungen des Befehls **bgerror**, den eine Anwendung definieren kann, um mit Tcl-Versionen vor 8.5 kompatibel zu bleiben. Anwendungen, die nur Tcl 8.5 und neuer unterstützen wollen, sollten [interp bgerror][interp] verwenden.

Der Befehl **bgerror** ist kein eingebauter Teil von Tcl. Stattdessen können einzelne Anwendungen oder Benutzer einen Befehl **bgerror** definieren (z. B. als Tcl-Prozedur), wenn sie Hintergrundfehler behandeln möchten.

Ein Hintergrundfehler tritt auf, wenn ein Fehler in einem Ereignishandler oder einem anderen Befehl auftritt, der nicht von der Anwendung stammt. Tritt beispielsweise ein Fehler beim Ausführen eines mit [after] angegebenen Befehls auf, handelt es sich um einen Hintergrundfehler. Bei einem Nicht-Hintergrundfehler kann der Fehler einfach durch verschachtelte Tcl-Befehlsauswertungen nach oben gereicht werden, bis er den Anwendungscode auf oberster Ebene erreicht; dann kann die Anwendung den Fehler melden, wie sie es wünscht. Bei einem Hintergrundfehler endet das Entwinden in der Tcl-Bibliothek, und Tcl hat keinen offensichtlichen Weg, den Fehler zu melden.

Wenn Tcl einen Hintergrundfehler erkennt, speichert es Informationen über den Fehler und ruft später einen mit [interp bgerror][interp] registrierten Handler-Befehl als Idle-Ereignishandler auf. Der Standard-Handler ruft wiederum den Befehl **bgerror** auf. Vor dem Aufruf von **bgerror** stellt Tcl [errorInfo][tclvars] und [errorCode][tclvars] auf die Werte zum Zeitpunkt des Fehlers wieder her und ruft dann **bgerror** mit der Fehlermeldung als einzigem Argument auf. Tcl geht davon aus, dass die Anwendung den Befehl **bgerror** implementiert hat und dass der Befehl den Fehler sinnvoll für die Anwendung meldet. Tcl ignoriert jedes von **bgerror** zurückgegebene Ergebnis, solange kein Fehler erzeugt wird.

Tritt innerhalb von **bgerror** ein weiterer Tcl-Fehler auf (z. B. weil kein **bgerror** definiert wurde), meldet Tcl den Fehler selbst, indem es eine Meldung nach stderr schreibt.

Häufen sich mehrere Hintergrundfehler an, bevor **bgerror** sie verarbeitet, wird **bgerror** einmal pro Fehler in der Reihenfolge ihres Auftretens aufgerufen. Gibt **bgerror** jedoch mit einer **break**-Ausnahme zurück, werden verbleibende Fehler übersprungen, ohne **bgerror** aufzurufen.

Schreiben Sie Code, der von anderen als Teil eines Pakets oder einer Bibliothek genutzt wird, sollten Sie **bgerror** vermeiden. Der Programmierer der Anwendung möchte möglicherweise ebenfalls **bgerror** definieren oder anderen Code verwenden, der das tut — die Integration Ihres Codes wird dann schwierig.

# Beispiele

Diese **bgerror**-Prozedur hängt Fehler mit Zeitstempel an eine Datei an.

```
proc bgerror {message} {
    set timestamp [clock format [clock seconds]]
    set fl [open mylog.txt {WRONLY CREAT APPEND}]
    puts $fl "$timestamp: bgerror in $::argv '$message'"
    close $fl
}
```


[after]: after.md
[interp]: interp.md
[tclvars]: tclvars.md
