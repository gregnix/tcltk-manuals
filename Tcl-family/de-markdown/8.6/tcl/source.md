---
CommandName: source
title: source
ManualSection: n
Version: unknown
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - file(n)
 - cd(n)
 - encoding(n)
 - info(n)
Keywords:
 - file
 - script
Copyright:
 - Copyright (c) 1993 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
 - Copyright (c) 2000 Scriptics Corporation.
---

# Name

source - Wertet eine Datei oder Ressource als Tcl-Skript aus

# Übersicht

::: {.synopsis} :::
[source]{.cmd} [fileName]{.arg}
[source]{.cmd} [-encoding]{.lit} [encodingName]{.arg} [fileName]{.arg}
:::

# Beschreibung

Der Befehl liest die angegebene Datei oder Ressource und übergibt den Inhalt dem Tcl-Interpreter als Textskript. Der Rückgabewert von **source** ist der des zuletzt im Skript ausgeführten Befehls. Tritt bei der Auswertung ein Fehler auf, gibt **source** diesen zurück. Wird im Skript [return] aufgerufen, wird der Rest der Datei übersprungen und **source** kehrt normal mit dem Ergebnis von [return] zurück.

Das Dateiende-Zeichen ist auf allen Plattformen „\\32“ (^Z). **source** liest Dateien bis zu diesem Zeichen. [read] und [gets] kennen diese Einschränkung nicht; so sind Dateien mit Code- und Datensegmenten möglich (Scripted Documents). Wird ^Z im Code für einen Zeichenkettenvergleich gebraucht, kann man „\\032“ oder „\\u001a“ schreiben; der Tcl-Interpreter setzt das sicher in ^Z um.

Eine führende BOM (Byte Order Mark) in der Datei wird bei Unicode-Kodierungen (utf-8, unicode) ignoriert.

Die Option **-encoding** legt die Kodierung der Daten in *fileName* fest. Ohne **-encoding** wird die Systemkodierung angenommen.

# Beispiele

Skripte in **foo.tcl** und **bar.tcl** nacheinander ausführen:

```
source foo.tcl
source bar.tcl
```

Alternativ:

```
foreach scriptFile {foo.tcl bar.tcl} {
    source $scriptFile
}
```


[gets]: gets.md
[read]: read.md
[return]: return.md
