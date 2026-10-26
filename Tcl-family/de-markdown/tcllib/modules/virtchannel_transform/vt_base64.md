---
CommandName: tcl::transform::base64
title: tcl::transform::base64
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: Reflected/virtual channel support
Keywords:
 - base64
 - channel transformation
 - reflected channel
 - tip 230
 - tip 317
 - transformation
 - virtual channel
Copyright:
 - Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

tcl::transform::base64 – Transformation der Base64-Kodierung

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [tcl::transform::core]{.lit} [1.1]{.optlit}
[package]{.cmd} [require]{.sub} [tcl::transform::base64]{.lit} [1.1]{.optlit}
[::tcl::transform::base64]{.cmd} [chan]{.arg}
:::

# Beschreibung

Das Paket „**tcl::transform::base64**“ enthält einen Befehl, mit dem eine Kanal-Transformation erstellt wird, die die in den Kanal geschriebenen Daten in Base64-Code kodiert und die aus dem Kanal gelesenen Daten wieder entschlüsselt.

Eine damit verbundene Transformation in diesem Modul ist **tcl::transform::hex**.

Die interne Klasse „**TclOO**“, die den Handler für Transformationen implementiert, ist eine Unterklasse des Rahmens „**tcl::transform::core**“.

# API

**::tcl::transform::base64** *chan*
: Dieser Befehl erstellt eine Base64-Transformation auf dem Kanal *chan* und gibt dessen Handle zurück.


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
