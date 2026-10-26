---
CommandName: processman
title: processman
ManualSection: n
Version: 0.8
TclPart: tcllib
TclDescription: processman
Keywords:
 - odie
 - processman
Copyright:
 - Copyright (c) 2015 Sean Woods <yoda@etoyoc.com>
---

# Name

processman – Tool zur Automatisierung der periodischen Rückruffunktion für Befehle

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [twapi]{.lit} [3.1]{.lit}
[package]{.cmd} [require]{.sub} [cron]{.lit} [1.1]{.lit}
[package]{.cmd} [require]{.sub} [processman]{.lit} [0.8]{.optlit}
[::processman::find\_exe]{.cmd} [name]{.arg}
[::processman::kill]{.cmd} [id]{.arg}
[::processman::kill\_all]{.cmd}
[::processman::killexe]{.cmd} [name]{.arg}
[::processman::onexit]{.cmd} [id]{.arg} [cmd]{.arg}
[::processman::priority]{.cmd} [id]{.arg} [level]{.arg}
[::processman::process\_list]{.cmd}
[::processman::process\_list]{.cmd} [id]{.arg}
[::processman::spawn]{.cmd} [id]{.arg} [cmd]{.arg} [args]{.arg}
:::

# Beschreibung

Das Paket **processman** enthält eine Reihe von Pure-Tcl-Dienstprogrammen zur plattformunabhängigen Verwaltung von untergeordneten Prozessen.

# Befehle

**::processman::find\_exe** *name*
: Sucht im Systempfad nach einer ausführbaren Datei mit dem Namen *name*. Fügen Sie unter Windows zusätzlich die Dateiendung .exe hinzu, wenn diese nicht angegeben ist.

**::processman::kill** *id*
: Beendet den untergeordneten Prozess mit der ID *id*.

**::processman::kill\_all**
: Beendet alle von diesem Programm gestarteten Prozesse

**::processman::killexe** *name*
: Beendet einen Prozess, der durch die ausführbare Datei identifiziert wird. Unter Unix löst dies einen „killall“-Befehl aus. Unter Windows wird „**twapi::get\_process\_ids**“ verwendet, um einen Namen einer oder mehreren IDs zuzuordnen, die anschließend beendet werden.

**::processman::onexit** *id* *cmd*
: Sorgt dafür, dass das Skript *cmd* ausgeführt wird, wenn dieses Programm feststellt, dass der Prozess *id* beendet wurde.

**::processman::priority** *id* *level*
: Kennzeichnet den Prozess *id* mit der Prioritätsstufe *level*. Gültige Stufen: low, high, default.

    Unter Unix wird der Prozess mit dem Befehl **nice** gekennzeichnet.

    Unter Windows wird der Prozess über den Befehl **twapi::set\_priority\_class** geändert.

**::processman::process\_list**
: Gibt eine Liste der Prozesse zurück, die von diesem Programm ausgelöst wurden, sowie ein boolesches Flag, das angibt, ob der Prozess noch läuft.

**::processman::process\_list** *id*
: Gibt „true“ zurück, wenn der Prozess *id* noch läuft, andernfalls „false“.

**::processman::spawn** *id* *cmd* *args*
: Startet einen Kindprozess, der durch *id* gekennzeichnet ist. *cmd* ist der Name des auszuführenden Befehls. *args* sind die Argumente, die an diesen Befehl übergeben werden sollen.


# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *odie* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

System

# Copyright

```
Copyright (c) 2015 Sean Woods <yoda@etoyoc.com>
```
