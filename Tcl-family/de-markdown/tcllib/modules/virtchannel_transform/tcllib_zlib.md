---
CommandName: tcl::transform::zlib
title: tcl::transform::zlib
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: Reflected/virtual channel support
Keywords:
 - channel transformation
 - compression
 - decompression
 - reflected channel
 - tip 230
 - tip 234
 - transformation
 - virtual channel
 - zlib
Copyright:
 - Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

tcl::transform::zlib – (De-)Komprimierung mit zlib

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [tcl::transform::core]{.lit} [1.1]{.optlit}
[package]{.cmd} [require]{.sub} [tcl::transform::zlib]{.lit} [1.1]{.optlit}
[::tcl::transform::zlib]{.cmd} [chan]{.arg} [level]{.optarg}
:::

# Beschreibung

Das Paket **tcl::transform::zlib** enthält einen Befehl, mit dem eine Kanal-Transformation erstellt wird, die die geschriebenen Daten mit zlib komprimiert und beim Lesen wieder dekomprimiert.

Die interne Klasse „**TclOO**“, die den Handler für Transformationen implementiert, ist eine Unterklasse des Rahmens „**tcl::transform::core**“.

# API

**::tcl::transform::zlib** *chan* ?*level*?
: Dieser Befehl erstellt eine zlib-Komprimierungstransformation für den Kanal *chan* und gibt dessen Handle zurück.

    Der Parameter *level* legt fest, wie intensiv die Komprimierung erfolgen soll, wobei die Werte von **0** bis **9** reichen; der Standardwert ist **4**.


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
