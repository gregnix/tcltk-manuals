---
CommandName: tcl::chan::variable
title: tcl::chan::variable
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
 - Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

tcl::chan::variable – In-Memory-Kanal unter Verwendung einer Variablen zur Speicherung

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [TclOO]{.lit}
[package]{.cmd} [require]{.sub} [tcl::chan::events]{.lit} [1.1]{.optlit}
[package]{.cmd} [require]{.sub} [tcl::chan::variable]{.lit} [1.0.5]{.optlit}
[::tcl::chan::variable]{.cmd} [varname]{.arg}
:::

# Beschreibung

Das Paket **tcl::chan::variable** stellt einen Befehl zur Verfügung, mit dem Kanäle erstellt werden können, die ausschließlich im Arbeitsspeicher liegen. Diese ermöglichen einen Direktzugriff, d. h., sie sind durchsuchbar. Im Gegensatz zu den von **tcl::chan::memchan** erstellten Kanälen werden die Daten jedoch nicht im Kanal selbst verborgen, sondern in einer zugehörigen Variable gespeichert, die zum Zeitpunkt der Erstellung festgelegt wird.

Die entsprechenden Pakete lauten **tcl::chan::memchan** und **tcl::chan::string**.

Die interne Klasse „**TclOO**“, die den Kanal-Handler implementiert, ist eine Unterklasse des Rahmens „**tcl::chan::events**“.

# API

**::tcl::chan::variable** *varname*
: Dieser Befehl erstellt einen neuen Variablenkanal und gibt dessen Handle zurück. Der Inhalt des Kanals wird in der zugehörigen Namespace-Variablen *varname* gespeichert.


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
