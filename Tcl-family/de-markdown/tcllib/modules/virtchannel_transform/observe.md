---
CommandName: tcl::transform::observe
title: tcl::transform::observe
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: Reflected/virtual channel support
Keywords:
 - channel transformation
 - observer
 - reflected channel
 - stream copy
 - tip 230
 - transformation
 - virtual channel
Copyright:
 - Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

tcl::transform::observe – Beobachter-Transformation, Stream-Kopie

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [tcl::transform::core]{.lit} [1.1]{.optlit}
[package]{.cmd} [require]{.sub} [tcl::transform::observe]{.lit} [1.1]{.optlit}
[::tcl::transform::observe]{.cmd} [chan]{.arg} [logw]{.arg} [logr]{.arg}
:::

# Beschreibung

Das Paket **tcl::transform::observer** stellt einen Befehl zur Verfügung, mit dem eine Kanal-Transformation erstellt wird, die die gelesenen und geschriebenen Bytes unverändert weiterleitet (wie bei **tcl::transform::identity**), jedoch zusätzlich die in jeder Richtung empfangenen Daten in Kanäle kopiert, die bei der Erstellung festgelegt wurden.

Zu diesem Modul gehörende Transformationen sind **tcl::transform::adler32**, **tcl::transform::counter**, **tcl::transform::crc32** und **tcl::transform::identity**.

Die interne Klasse „**TclOO**“, die den Handler für Transformationen implementiert, ist eine Unterklasse des Rahmens „**tcl::transform::core**“.

# API

**::tcl::transform::observe** *chan* *logw* *logr*
: Dieser Befehl erstellt eine Beobachtertransformation auf dem Kanal *chan* und gibt deren Handle zurück. Die Kanal-Handles *logr* und *logw* dienen als Ziel für die Kopie der Daten.


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
