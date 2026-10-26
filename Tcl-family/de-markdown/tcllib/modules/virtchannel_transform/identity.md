---
CommandName: tcl::transform::identity
title: tcl::transform::identity
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: Reflected/virtual channel support
Keywords:
 - channel transformation
 - identity
 - reflected channel
 - tip 230
 - transformation
 - virtual channel
Copyright:
 - Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

tcl::transform::identity – Transformation der Identität

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [tcl::transform::core]{.lit} [1.1]{.optlit}
[package]{.cmd} [require]{.sub} [tcl::transform::identity]{.lit} [1.1]{.optlit}
[::tcl::transform::identity]{.cmd} [chan]{.arg}
:::

# Beschreibung

Das Paket **tcl::transform::identity** enthält einen Befehl zur Erstellung einer Identitätskanal-Transformation, die nichts anderes tut, als die gelesenen und geschriebenen Bytes unverändert durchzulassen. In einer Anwendung ist dies zwar nicht wirklich nützlich, doch als prototypische Beobachter-Transformation dient der Code als nützlicher Ausgangspunkt für alle anderen Beobachter, die möglicherweise geschrieben werden sollen.

Die in diesem Modul enthaltenen Transformationen, die aus dem Code von „Identity“ abgeleitet wurden, lauten **tcl::transform::adler32**, **tcl::transform::counter**, **tcl::transform::crc32** und **tcl::transform::observe**.

Die interne Klasse „**TclOO**“, die den Handler für Transformationen implementiert, ist eine Unterklasse des Rahmens „**tcl::transform::core**“.

# API

**::tcl::transform::identity** *chan*
: Dieser Befehl erstellt eine Identitätstransformation auf dem Kanal *chan* und gibt deren Handle zurück.


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
