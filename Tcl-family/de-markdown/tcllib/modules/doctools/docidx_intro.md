---
CommandName: docidx_intro
title: docidx_intro
ManualSection: n
Version: 1.0
TclPart: tcllib
TclDescription: Documentation tools
Links:
 - docidx_lang_cmdref
 - docidx_lang_faq
 - docidx_lang_intro
 - docidx_lang_syntax
 - docidx_plugin_apiref
 - doctoc_intro
 - doctools::idx
 - doctools_intro
Keywords:
 - index
 - keyword index
 - markup
 - semantic markup
Copyright:
 - Copyright (c) 2007 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

docidx\_intro – Einleitung in docidx

# Beschreibung

*docidx* (kurz für *documentation index*) bezeichnet eine Reihe miteinander verbundener, aber dennoch unterschiedlicher Komponenten, die zusammenwirken, um die Erstellung und Transformation von Schlüsselwortindizes für Dokumentation zu vereinfachen. Dabei handelt es sich um

1. Eine auf Tcl basierende Sprache zur semantischen Auszeichnung eines Schlüsselwortindexes. Die Auszeichnung wird durch Tcl-Befehle dargestellt.

2. Ein Paket, das die Möglichkeit bietet, Texte zu lesen und zu transformieren, die in dieser Auszeichnungssprache verfasst sind. Es ist wichtig zu beachten, dass die eigentliche Transformation des Eingabetextes an Plugins weitergeleitet wird.

3. Eine API, die die Schnittstelle zwischen dem oben genannten Paket und einem Plugin beschreibt.


Welche der ausführlicheren Dokumente für den Leser dieser Einleitung relevant sind, hängt von seiner Rolle im Dokumentationsprozess ab.

1. Ein *Autor* von Dokumentationen muss die Auszeichnungssprache selbst verstehen. Ein Anfänger im Umgang mit docidx sollte zunächst die eher informell verfasste *Einleitung in die docidx-Sprache* lesen. Nachdem er diese verinnerlicht hat, sollte die formale Spezifikation der *docidx-Sprachsyntax* verständlich werden. Ein mit docidx erfahrener Autor benötigt möglicherweise nur gelegentlich die *docidx-Befehlsreferenz*, um sein Gedächtnis aufzufrischen.

    Während ein Dokument verfasst wird, kann die Anwendung **dtp** zur Validierung herangezogen werden; nach Fertigstellung führt sie zudem die Umwandlung in das gewählte System visueller Auszeichnung durch, sei es \*roff, HTML, Klartext, Wiki usw. Die einfachere Anwendung **dtplite** verwendet docidx intern, wenn sie Verzeichnisse mit Dokumentation bearbeitet, und erzeugt für sie automatisch einen passenden Schlüsselwortindex.

2. Ein *Verarbeiter* von Dokumentation, die in der Auszeichnungssprache *docidx* verfasst ist, muss wissen, welche Werkzeuge zur Verfügung stehen.

    Das wichtigste Werkzeug ist die bereits erwähnte Anwendung **dtp**, die von Tcllib bereitgestellt wird. Die einfachere Anwendung **dtplite** zeigt dem Benutzer docidx nicht. Auf der untersten Ebene, die beiden Anwendungen gemeinsam ist, befindet sich jedoch das Paket **doctoools::idx**, das die grundlegenden Funktionen zum Lesen und Verarbeiten von Dateien bereitstellt, die Text im docidx-Format enthalten.

3. Nicht zuletzt müssen *Plugin-Entwickler* die Wechselwirkung zwischen dem Paket **doctools::idx** und dessen Plugins verstehen, wie in der *docidx-Plugin-API-Referenz* beschrieben.


# Verwandte Formate

docidx steht nicht für sich allein, sondern hat zwei begleitende Formate. Diese heißen *doctoc* und *doctools* und dienen jeweils zur Auszeichnung von *Inhaltsverzeichnissen* bzw. allgemeiner Dokumentation. Sie werden in eigenen Dokumentensammlungen beschrieben, beginnend jeweils mit der *doctoc-Einleitung* und der *doctools-Einleitung*.

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
