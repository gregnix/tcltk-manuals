---
CommandName: tcl::transform::hex
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: Reflected/virtual channel support
Keywords:
 - channel transformation
 - hexadecimal
 - reflected channel
 - tip 230
 - transformation
 - virtual channel
Copyright:
 - Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

tcl::transform::hex – Transformation der Hexadezimal-Kodierung

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [tcl::transform::core]{.lit} [1.1]{.optlit} 
[package]{.cmd} [require]{.sub} [tcl::transform::hex]{.lit} [1.1]{.optlit} 
[::tcl::transform::hex]{.cmd} [chan]{.arg} 
:::

# BESCHREIBUNG

Das Paket **tcl::transform::hex** enthält einen Befehl, mit dem eine Kanaltransformation erstellt wird, die die in den Kanal geschriebenen Daten hexadezimal codiert und die aus dem Kanal gelesenen Daten wieder decodiert.

Eine damit verbundene Transformation in diesem Modul ist **tcl::transform::base64**.

Die interne Klasse „**TclOO**“, die den Handler für Transformationen implementiert, ist eine Unterklasse des Rahmens „**tcl::transform::core**“.

# API

**::tcl::transform::hex** *chan*
: Dieser Befehl erstellt eine Hex-Transformation auf dem Kanal *chan* und gibt dessen Handle zurück.


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
