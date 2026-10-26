---
CommandName: tcl::chan::string
ManualSection: n
Version: 1.0.4
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

# NAME

tcl::chan::string – Schreibgeschützter In-Memory-Kanal

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [TclOO]{.lit} 
[package]{.cmd} [require]{.sub} [tcl::chan::events]{.lit} [1.1]{.optlit} 
[package]{.cmd} [require]{.sub} [tcl::chan::string]{.lit} [1.0.4]{.optlit} 
[::tcl::chan::string]{.cmd} [content]{.arg} 
:::

# BESCHREIBUNG

Das Paket **tcl::chan::string** stellt einen Befehl zur Verfügung, mit dem Kanäle erstellt werden können, die ausschließlich im Arbeitsspeicher existieren. Diese ermöglichen einen Direktzugriff, d. h., sie sind durchsuchbar. Im Gegensatz zu den von **tcl::chan::memchan** erstellten Kanälen sind sie jedoch schreibgeschützt; ihr Inhalt wird zum Zeitpunkt der Erstellung bereitgestellt und ist danach unveränderlich.

Die entsprechenden Pakete lauten **tcl::chan::memchan** und **tcl::chan::variable**.

Die interne Klasse „**TclOO**“, die den Kanal-Handler implementiert, ist eine Unterklasse des Rahmens „**tcl::chan::events**“.

# API

**::tcl::chan::string** *content*
: Dieser Befehl erstellt einen neuen Zeichenfolgenkanal und gibt dessen Handle zurück. Der Kanal ermöglicht einen zufälligen, schreibgeschützten Zugriff auf die Zeichenfolge *content*.


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
