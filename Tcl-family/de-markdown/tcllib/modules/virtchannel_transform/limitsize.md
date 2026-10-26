---
CommandName: tcl::transform::limitsize
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: Reflected/virtual channel support
Keywords:
 - channel transformation
 - limitsize
 - reflected channel
 - size limit
 - tip 230
 - transformation
 - virtual channel
Copyright:
 - Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

tcl::transform::limitsize – Eingabebeschränkung

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [tcl::transform::core]{.lit} [1.1]{.optlit} 
[package]{.cmd} [require]{.sub} [tcl::transform::limitsize]{.lit} [1.1]{.optlit} 
[::tcl::transform::limitsize]{.cmd} [chan]{.arg} [max]{.arg} 
:::

# BESCHREIBUNG

Das Paket **tcl::transform::limitsize** enthält einen Befehl zur Erstellung einer Kanaltransformation, die die Anzahl der Zeichen begrenzt, die aus dem Kanal gelesen werden können. Ein Generator für ein künstliches EOF.

Die interne Klasse „**TclOO**“, die den Handler für Transformationen implementiert, ist eine Unterklasse des Rahmens „**tcl::transform::core**“.

# API

**::tcl::transform::limitsize** *chan* *max*
: Dieser Befehl erstellt eine Transformation zur Größenbegrenzung auf dem Kanal *chan* und gibt deren Handle zurück. *max* ist die Anzahl der Bytes, die aus dem Kanal gelesen werden können, bevor die Transformation ein EOF signalisiert. Hinweis: Durch das Entfernen der Transformation wird auch das von ihr generierte EOF gelöscht.


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
