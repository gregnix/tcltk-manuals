---
CommandName: tcl::chan::memchan
title: tcl::chan::memchan
ManualSection: n
Version: 1.0.5
TclPart: tcllib
TclDescription: Reflected/virtual channel support
Keywords:
 - in-memory channel
 - reflected channel
 - tip 219
 - virtual channel
Copyright:
 - Copyright (c) 2009-2017 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

tcl::chan::memchan – In-Memory-Kanal

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [TclOO]{.lit}
[package]{.cmd} [require]{.sub} [tcl::chan::events]{.lit} [1.1]{.optlit}
[package]{.cmd} [require]{.sub} [tcl::chan::memchan]{.lit} [1.0.5]{.optlit}
[::tcl::chan::memchan]{.cmd}
:::

# Beschreibung

Das Paket **tcl::chan::memchan** stellt einen Befehl zur Verfügung, mit dem Kanäle erstellt werden können, die ausschließlich im Arbeitsspeicher liegen. Diese ermöglichen einen Direktzugriff, d. h., sie sind durchsuchbar. Dies entspricht den memchan-Kanälen des Pakets **Memchan**, mit dem Unterschied, dass dieses in reinem Tcl und nicht in C geschrieben ist. Andererseits ist ist **Memchan** mit Tcl 8.4 und früheren Versionen kompatibel, während dieses Paket Tcl 8.5 oder höher sowie **TclOO** erfordert.

Die entsprechenden Pakete lauten **tcl::chan::string** und **tcl::chan::variable**.

Die interne Klasse „**TclOO**“, die den Kanal-Handler implementiert, ist eine Unterklasse des Rahmens „**tcl::chan::events**“.

# API

**::tcl::chan::memchan**
: Dieser Befehl erstellt einen neuen Memchan-Kanal und gibt dessen Handle zurück.


# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *virtchannel* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Kanäle

# Copyright

```
Copyright (c) 2009-2017 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
