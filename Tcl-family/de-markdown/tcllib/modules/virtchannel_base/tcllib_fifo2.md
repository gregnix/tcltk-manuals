---
CommandName: tcl::chan::fifo2
title: tcl::chan::fifo2
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: Reflected/virtual channel support
Keywords:
 - connected fifos
 - fifo
 - in-memory channel
 - inter-thread communication
 - reflected channel
 - tip 219
 - virtual channel
Copyright:
 - Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

tcl::chan::fifo2 – Im Speicher verbundene FIFO-Kanäle

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [TclOO]{.lit}
[package]{.cmd} [require]{.sub} [tcl::chan::events]{.lit} [1.1]{.optlit}
[package]{.cmd} [require]{.sub} [tcl::chan::halfpipe]{.lit} [1.1]{.optlit}
[package]{.cmd} [require]{.sub} [tcl::chan::fifo2]{.lit} [1.1]{.optlit}
[::tcl::chan::fifo2]{.cmd}
:::

# Beschreibung

Das Paket **tcl::chan::fifo2** stellt einen Befehl bereit, mit dem Paare von Kanälen erstellt werden können, die ausschließlich im Speicher existieren und nach dem FIFO-Prinzip miteinander verbunden sind. Was in die eine Hälfte des Paares geschrieben wird, kann in derselben Reihenfolge aus der anderen Hälfte gelesen werden. Eine besondere Anwendungsmöglichkeit hierfür ist die Kommunikation zwischen Threads, wobei eine Hälfte des Paares in den Thread verschoben wird, mit dem kommuniziert werden soll. Dies entspricht den „fifo2“-Kanälen, die vom Paket **Memchan** bereitgestellt werden, mit dem Unterschied, dass dies in reinem Tcl und nicht in C geschrieben ist. Andererseits ist ist **Memchan** mit Tcl 8.4 und früheren Versionen kompatibel, während dieses Paket Tcl 8.5 oder höher sowie **TclOO** erfordert.

Die interne Klasse „**TclOO**“, die den Kanal-Handler implementiert, ist eine Unterklasse des Rahmens „**tcl::chan::events**“.

# API

**::tcl::chan::fifo2**
: Dieser Befehl erstellt ein neues verbundenes Paar von FIFO-Kanälen und gibt deren Handles als Liste mit zwei Elementen zurück.


# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *virtchannel* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Kanäle

# Copyright

```
Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
