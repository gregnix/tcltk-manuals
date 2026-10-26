---
CommandName: tcl::chan::events
title: tcl::chan::events
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: Reflected/virtual channel support
Keywords:
 - event management
 - reflected channel
 - tip 219
 - virtual channel
Copyright:
 - Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

tcl::chan::events – Ereignisunterstützung für reflektierte/virtuelle Kanäle

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [TclOO]{.lit}
[package]{.cmd} [require]{.sub} [tcl::chan::core]{.lit} [1.1]{.optlit}
[package]{.cmd} [require]{.sub} [tcl::chan::events]{.lit} [1.1]{.optlit}
[::tcl::chan::events]{.cmd} [objectName]{.arg}
[objectName]{.ins} [finalize]{.sub} [thechannel]{.arg}
[objectName]{.ins} [watch]{.sub} [thechannel]{.arg} [eventmask]{.arg}
[objectName]{.ins} [allow]{.sub} [eventname...]{.arg}
[objectName]{.ins} [disallow]{.sub} [eventname...]{.arg}
:::

# Beschreibung

Das Paket „**tcl::chan::events**“ enthält die Klasse „**TclOO**“, die ein allgemeines Verhalten implementiert, das von nahezu jedem reflektierten oder virtuellen Kanal benötigt wird, der ereignisgesteuerte E/A unterstützt. Es handelt sich um eine Unterklasse von „**tcl::chan::core**“, die deren gesamtes Verhalten übernimmt.

Diese Klasse ist dafür vorgesehen, entweder als Oberklasse einer konkreten Kanal-Klasse verwendet oder in eine solche Klasse eingemischt zu werden.

# API für Klassen

**::tcl::chan::events** *objectName*
: Dieser Befehl erstellt ein neues Kanalereignis-Kernobjekt mit einem zugehörigen globalen Tcl-Befehl, dessen Name *objectName* lautet. Mit diesem Befehl können verschiedene Operationen auf dem Objekt aufgerufen werden, wie im Abschnitt zur [Instanz-API] beschrieben.


# Instanz-API

Die API der Channel-Event-Core-Instanzen stellt lediglich vier Methoden bereit, von denen zwei den Befehlen des Ereignisbehandlers entsprechen (siehe dazu [TIP 219](http:/tip.tcl.tk/219)) und die anderen beiden von Unterklassen zur Steuerung der Ereignisgenerierung verwendet werden. Erstere erwarten, dass sie von der Objekt-Instanz aufgerufen werden, in die der Kanal-Ereignis-Kern integriert wurde.

*objectName* **finalize** *thechannel*
: Diese Methode implementiert das Standardverhalten für die Methode „**finalize**“ von Kanal-Handlern. Sie überschreibt das von „**tcl::chan::core**“ geerbte Verhalten und deaktiviert darüber hinaus jegliche Ereignisgenerierung, bevor sie sich selbst beendet.

*objectName* **watch** *thechannel* *eventmask*
: Diese Methode implementiert das Standardverhalten für die Methode **watch** der Kanalhandler. Sie wird vom E/A-System aufgerufen, sobald sich das Interesse an einem Ereignis ändert, und aktualisiert den Instanzzustand, um die Erzeugung der (nicht) relevanten Ereignisse zu aktivieren bzw. zu unterdrücken.

*objectName* **allow** *eventname*...
: siehe unten ...

*objectName* **disallow** *eventname*...
: Diese beiden Methoden werden in Unterklassen exportiert, sodass deren Instanzen ihrem Ereigniskern mitteilen können, welche Ereignisse der von ihnen implementierte Kanal erzeugen darf (zulassen) oder nicht erzeugen darf (verbieten). Zusammen mit den Informationen über die vom Tcl-E/A-System angeforderten Ereignisse, die über die Methode **watch** eingehen, kann der Ereigniskern feststellen, welche Ereignisse er erzeugen soll (bzw. nicht erzeugen soll), und entsprechend handeln.


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
