---
CommandName: doctoc_intro
title: doctoc_intro
ManualSection: n
Version: 1.0
TclPart: tcllib
TclDescription: Documentation tools
Links:
 - docidx_intro
 - doctoc_lang_cmdref
 - doctoc_lang_faq
 - doctoc_lang_intro
 - doctoc_lang_syntax
 - doctoc_plugin_apiref
 - doctools::toc
 - doctools_intro
Keywords:
 - markup
 - semantic markup
 - table of contents
 - toc
Copyright:
 - Copyright (c) 2007 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

doctoc\_intro – Einleitung in doctoc

# Beschreibung

*doctoc* (Abkürzung für *documentation tables of contents*) bezeichnet eine Reihe miteinander verbundener, jedoch unterschiedlicher Komponenten, die zusammenwirken, um die Erstellung und Transformation von Inhaltsverzeichnissen für Dokumentationen zu vereinfachen. Dabei handelt es sich um

1. Eine auf Tcl basierende Sprache für die semantische Auszeichnung eines Inhaltsverzeichnisses. Die Auszeichnung wird durch Tcl-Befehle dargestellt.

2. Ein Paket, das die Möglichkeit bietet, Texte zu lesen und zu transformieren, die in dieser Auszeichnungssprache verfasst sind. Es ist wichtig zu beachten, dass die eigentliche Transformation des Eingabetextes an Plugins weitergeleitet wird.

3. Eine API, die die Schnittstelle zwischen dem oben genannten Paket und einem Plugin beschreibt.


Welche der ausführlicheren Dokumente für den Leser dieser Einleitung relevant sind, hängt von seiner Rolle im Dokumentationsprozess ab.

1. Ein *Autor* von Dokumentationen muss die Auszeichnungssprache selbst verstehen. Ein Anfänger im Umgang mit doctoc sollte zunächst die eher informell verfasste *Einleitung in die doctoc-Sprache* lesen. Nachdem er diese verinnerlicht hat, sollte die formale Spezifikation der *doctoc-Syntax* verständlich werden. Ein mit doctoc erfahrener Autor benötigt möglicherweise nur gelegentlich die *Befehlsreferenz der doctoc-Sprache*, um sein Gedächtnis aufzufrischen.

    Während ein Dokument verfasst wird, kann die Anwendung **dtp** zur Prüfung verwendet werden, und nach der Fertigstellung führt sie auch die Umwandlung in das gewählte System visueller Auszeichnung durch, sei es \*roff, HTML, Klartext, Wiki usw. Die einfachere Anwendung **dtplite** verwendet doctoc intern, wenn sie Verzeichnisse mit Dokumentation bearbeitet, und erzeugt für sie automatisch ein passendes Inhaltsverzeichnis.

2. Ein *Verarbeiter* von Dokumentation, die in der Auszeichnungssprache *doctoc* verfasst ist, muss wissen, welche Werkzeuge zur Verfügung stehen.

    Das wichtigste Werkzeug ist die bereits erwähnte Anwendung **dtp**, die von Tcllib bereitgestellt wird. Das einfachere **dtplite** zeigt dem Benutzer doctoc nicht. Auf der untersten Ebene, die beiden Anwendungen gemeinsam ist, befindet sich jedoch das Paket **doctoools::toc**, das die grundlegenden Funktionen zum Lesen und Verarbeiten von Dateien bereitstellt, die Text im doctoc-Format enthalten.

3. Zu guter Letzt müssen *Plugin-Entwickler* die Wechselwirkungen zwischen dem Paket **doctools::toc** und dessen Plugins verstehen, wie in der *doctoc-Plugin-API-Referenz* beschrieben.


# Verwandte Formate

doctoc steht nicht für sich allein, sondern verfügt über zwei begleitende Formate. Diese heißen *docidx* und *doctools* und dienen jeweils der Auszeichnung von *Schlüsselwortindizes* bzw. allgemeiner Dokumentation. Sie werden in eigenen Dokumentenreihen beschrieben, beginnend jeweils mit der *docidx-Einleitung* und der *doctools-Einleitung*.

# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *doctools* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Dokumentationswerkzeuge

# Copyright

```
Copyright (c) 2007 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
