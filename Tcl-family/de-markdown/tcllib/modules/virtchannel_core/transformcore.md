---
CommandName: tcl::transform::core
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: Reflected/virtual channel support
Keywords:
 - reflected channel
 - tip 219
 - virtual channel
Copyright:
 - Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

tcl::transform::core – Grundlegende Unterstützung für reflektierte/virtuelle Kanal-Transformationen

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [TclOO]{.lit} 
[package]{.cmd} [require]{.sub} [tcl::transform::core]{.lit} [1.1]{.optlit} 
[::tcl::transform::core]{.cmd} [objectName]{.arg} 
[objectName]{.ins} [initialize]{.sub} [thechannel]{.arg} [mode]{.arg} 
[objectName]{.ins} [finalize]{.sub} [thechannel]{.arg} 
[objectName]{.ins} [destroy]{.sub} 
:::

# BESCHREIBUNG

Das Paket „**tcl::transform::core**“ enthält die Klasse „**TclOO**“, die das allgemeine Verhalten implementiert, das für nahezu jede reflektierte oder virtuelle Transformation des Kanals erforderlich ist (Initialisierung, Finalisierung).

Diese Klasse ist dafür vorgesehen, entweder als Oberklasse einer konkreten Kanal-Klasse verwendet oder in eine solche Klasse eingemischt zu werden.

# API FÜR KLASSEN

**::tcl::transform::core** *objectName*
: Dieser Befehl erstellt ein neues Transformationskernobjekt mit einem zugehörigen globalen Tcl-Befehl, dessen Name *objectName* lautet. Mit diesem Befehl können verschiedene Operationen auf das Objekt angewendet werden, wie im Abschnitt zur **INSTANZ-API** beschrieben.


# INSTANZ-API

Die API der Transform-Core-Instanzen stellt lediglich zwei Methoden bereit, die beide den Befehlen des Transform-Handlers entsprechen (siehe dazu [TIP 230](http:/tip.tcl.tk/230)]). Sie sind dafür vorgesehen, von der Objektinstanz aus aufgerufen zu werden, in die der Transform-Core integriert wurde.

*objectName* **initialize** *thechannel* *mode*
: Diese Methode implementiert das Standardverhalten für die Methode **initialize** der Transformations-Handler. Mithilfe von Introspektion ermittelt sie die von der Instanz unterstützten Handler-Methoden und gibt eine Liste mit deren Namen zurück, wie es die Unterstützung für reflektierte Transformationen im Tcl-Kern erwartet. Zudem speichert sie das Kanal-Handle in einer Instanzvariablen, damit Unterklassen darauf zugreifen können.

*objectName* **finalize** *thechannel*
: Diese Methode implementiert das Standardverhalten für die Methode **finalize** der Kanalhandler. Sie löscht sich lediglich selbst.

*objectName* **destroy**
: Durch das Löschen der Transformationskern-Instanz wird der Kanal geschlossen, für den die Transformation initialisiert wurde; siehe dazu die Methode **initialize**. Wird die Instanz im Rahmen eines Aufrufs von **finalize** gelöscht, geschieht dies nicht, da davon ausgegangen wird, dass der Kanal und die Transformation von Tcl gelöscht werden.


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
