---
CommandName: tcl::randomseed
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: Reflected/virtual channel support
Keywords:
 - /dev/random
 - merge
 - random
 - reflected channel
 - seed
 - tip 219
 - virtual channel
Copyright:
 - Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

tcl::randomseed – Dienstprogramme für zufällige Kanäle

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [TclOO]{.lit} 
[package]{.cmd} [require]{.sub} [tcl::randomseed]{.lit} [1.1]{.optlit} 
[::tcl::randomseed]{.cmd} 
[::tcl::combine]{.cmd} [seed1]{.arg} [seed2]{.arg} 
:::

# BESCHREIBUNG

Das Paket „**tcl::randomseed**“ enthält einige Befehle, die bei der Initialisierung von **tcl::chan::random**-Kanälen helfen.

# API

**::tcl::randomseed**
: Dieser Befehl gibt eine Liste von Startwerten zurück, die als Startwertargument für Zufallskanäle geeignet sind. Die Zahlen werden aus der Prozess-ID, der aktuellen Uhrzeit und dem Tcl-Zufallszahlengenerator abgeleitet.

**::tcl::combine** *seed1* *seed2*
: Dieser Befehl nimmt zwei Startlisten entgegen und führt sie zu einer einzigen Liste zusammen, indem er sie elementweise mit dem XOR-Operator modulo 256 verknüpft. Wenn die Listen nicht gleich lang sind, wird die kürzere der beiden mit Nullen aufgefüllt, bevor sie mit der anderen zusammengeführt wird.


# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *virtchannel* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Kanäle

# COPYRIGHT

```
Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
