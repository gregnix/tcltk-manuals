---
CommandName: tcl::transform::spacer
title: tcl::transform::spacer
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: Reflected/virtual channel support
Keywords:
 - channel transformation
 - reflected channel
 - spacing
 - tip 230
 - transformation
 - virtual channel
Copyright:
 - Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

tcl::transform::spacer – Einsetzen und Entnehmen von Zwischenstücken

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [tcl::transform::core]{.lit} [1.1]{.optlit}
[package]{.cmd} [require]{.sub} [tcl::transform::spacer]{.lit} [1.1]{.optlit}
[::tcl::transform::spacer]{.cmd} [chan]{.arg} [n]{.arg} [space]{.optarg}
:::

# Beschreibung

Das Paket **tcl::transform::spacer** enthält einen Befehl zum Erstellen einer Kanal-Transformation, die den in den Kanal geschriebenen Daten Leerzeichen hinzufügt und diese Leerzeichen aus den aus dem Kanal gelesenen Daten entfernt.

Die interne Klasse „**TclOO**“, die den Handler für Transformationen implementiert, ist eine Unterklasse des Rahmens „**tcl::transform::core**“.

# API

**::tcl::transform::spacer** *chan* *n* ?*space*?
: Dieser Befehl erstellt eine Spacer-Transformation auf dem Kanal *chan* und gibt deren Handle zurück.

    Die Zeichenfolge *space* wird alle *n* geschriebenen Datenbytes eingefügt; auf der Leseseite erfolgt der Vorgang in umgekehrter Reihenfolge, wobei die Abstände entfernt werden. Wenn *space* nicht festgelegt wird, wird standardmäßig ein einzelnes Leerzeichen (ASCII 32) verwendet.


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
