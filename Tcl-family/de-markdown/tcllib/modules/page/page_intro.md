---
CommandName: page_intro
title: page_intro
ManualSection: n
Version: 1.0
TclPart: tcllib
TclDescription: Parser generator tools
Keywords:
 - page
 - parser generator
 - text processing
Copyright:
 - Copyright (c) 2007 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

page\_intro – Einleitung zu page

# Beschreibung

*page* (kurz für *parser generator*) steht für eine Reihe verwandter Pakete, die bei der Erstellung von Parser-Generatoren helfen, und für andere Hilfsprogramme, die Textverarbeitung betreiben.

Sie dienen in erster Linie der Unterstützung der Tcllib-Anwendung **page**, wobei das Paket **page::pluginmgr** eine zentrale Rolle als Plugin-Verwaltung für die Anwendung spielt. Die übrigen Pakete führen Textverarbeitungsaufgaben auf niedriger Ebene sowie Hilfsaufgaben durch, die auf die Generierung von Parsern ausgerichtet sind, und **page** greift auf sie hauptsächlich über Plugins zu.

Die Pakete, die die Plugins implementieren, sind nicht wie gewöhnliche Pakete dokumentiert, da sie ohne umfangreiche Vorbereitungsmaßnahmen am Interpreter nicht in einen allgemeinen Interpreter wie tclsh geladen werden können. Diese Vorbereitungsmaßnahmen werden vom Plugin-Manager für sie vorgenommen.

# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *page* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Page-Parsergenerator

# Copyright

```
Copyright (c) 2007 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
