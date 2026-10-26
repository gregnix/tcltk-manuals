---
CommandName: doctools2idx_introduction
title: doctools2idx_introduction
ManualSection: n
Version: 2.0
TclPart: tcllib
TclDescription: Documentation tools
Links:
 - docidx_intro
 - doctoc_intro
 - doctools
 - doctools2doc_introduction
 - doctools2toc_introduction
 - doctools_lang_cmdref
 - doctools_lang_faq
 - doctools_lang_intro
 - doctools_lang_syntax
 - doctools_plugin_apiref
Keywords:
 - conversion
 - formatting
 - index
 - keyword index
 - markup
 - parsing
 - plugin
 - semantic markup
Copyright:
 - Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

doctools2idx\_introduction – DocTools – Schlüsselwortindizes

# Beschreibung

*docidx* (Abkürzung für *Dokumentations-Indizes*) steht für eine Reihe verwandter und doch unterschiedlicher Einheiten, die gemeinsam die einfache Erstellung und Umformung von Schlüsselwortindizes für die Dokumentation ermöglichen.

Dies sind

1. Eine auf Tcl basierende Sprache zur semantischen Auszeichnung eines Schlüsselwortindexes. Die Auszeichnung erfolgt mittels Tcl-Befehlen. Anfänger sollten mit der *Einleitung in die docidx-Sprache* beginnen. Die formale Spezifikation ist auf zwei Dokumente aufgeteilt: Das eine befasst sich mit der *Syntax der docidx-Sprache*, das andere ist eine *Befehlsreferenz zur docidx-Sprache*.

2. Eine Reihe von Paketen zur programmatischen Bearbeitung von Schlüsselwortindizes im Arbeitsspeicher sowie zu deren Konvertierung zwischen verschiedenen Formaten, zum Lesen und Schreiben. Die oben genannte Auszeichnungssprache ist eines der Formate, die sowohl gelesen als auch geschrieben werden können.

3. Das System zur Konvertierung von Indizes basiert auf einem Plugin-Mechanismus; hierfür stehen zwei APIs zur Verfügung, die die Schnittstelle zwischen den oben genannten Paketen und den Import-/Export-Plugins beschreiben.


Welche der ausführlicheren Dokumente für den Leser dieser Einleitung relevant sind, hängt von der jeweiligen Rolle im Dokumentationsprozess ab.

1. Ein *Autor* von Dokumentationen muss die Auszeichnungssprache selbst verstehen. Ein Anfänger im Umgang mit docidx sollte zunächst die eher informell verfasste *Einleitung in die docidx-Sprache* lesen. Ist diese aufgenommen, sollte die formale Spezifikation der *Syntax der docidx-Sprache* verständlich werden. Ein mit docidx vertrauter Autor braucht nur gelegentlich die *Befehlsreferenz der docidx-Sprache* zur Auffrischung.

    Während ein Dokument verfasst wird, kann die Anwendung **dtp** zur Validierung herangezogen werden; nach Fertigstellung führt sie zudem die Konvertierung in das gewählte visuelle Markup-System durch, sei es \*roff, HTML, Klartext, Wiki usw. Die einfachere Anwendung **dtplite** nutzt docidx intern bei der Verwaltung von Dokumentationsverzeichnissen und generiert automatisch einen passenden Schlüsselwortindex.

2. Ein *Verarbeiter* von Dokumentation, die in der Markup-Sprache *docidx* verfasst ist, muss wissen, welche Werkzeuge zur Verfügung stehen.

    Das wichtigste Werkzeug ist die bereits erwähnte Anwendung **dtp**, die von Tcllib bereitgestellt wird. Die einfachere Anwendung **dtplite** macht *docidx* dem Benutzer nicht zugänglich. Auf der untersten Ebene, die beiden Anwendungen gemeinsam ist, finden wir jedoch die drei Pakete, die die grundlegenden Mittel zur Verarbeitung von Schlüsselwortindizes bereitstellen, d. h. den Import aus Textformaten, die programmatische Bearbeitung im Speicher und den Export in Textformate. Diese sind

    **doctools::idx**
    : Programmatische Bearbeitung von Schlüsselwortindizes im Speicher.

    **doctools::idx::import**
    : Import von Schlüsselwortindizes aus verschiedenen Textformaten. Die Liste der unterstützten Formate lässt sich durch Plugin-Pakete erweitern.

    **doctools::idx::export**
    : Export von Schlüsselwortindizes in verschiedene Textformate. Die Auswahl der unterstützten Formate lässt sich durch Plugin-Pakete erweitern.


3. Siehe auch den Abschnitt [Paketübersicht] für einen Überblick über die Abhängigkeiten zwischen diesen und anderen, unterstützenden Paketen.

4. Nicht zuletzt müssen *Plugin-Entwickler* das Zusammenspiel der Import- und Export-Pakete mit ihren Plugins verstehen. Diese APIs sind in der Dokumentation der beiden zuständigen Pakete beschrieben, also

    - **doctools::idx::import**

    - **doctools::idx::export**



# Verwandte Formate

Das docidx-Format steht nicht für sich allein, sondern verfügt über zwei begleitende Formate. Diese heißen *doctoc* und *doctools* und sind jeweils für die Auszeichnung von *Inhaltsverzeichnissen* bzw. von allgemeiner Dokumentation vorgesehen. Sie werden in eigenen Dokumentensammlungen beschrieben, beginnend jeweils mit *DocTools – Inhaltsverzeichnisse* und *DocTools – Allgemein*.

# Paketübersicht

```
                                    ~~~~~~~~~~~ doctools::idx ~~~~~~~~~~~
                                   ~~                   |               ~~
                doctools::idx::export ~~~~~~~~~~~~~~~~~ | ~~~~~~~~~~~~~ doctools::idx::import
                        |                               |                       |
        +---------------+-------------------------+     |    +------------------+---------------+-----------------------+---------------+
        |               |                         |     |    |                  |               |                       |               |
struct::map             =                         |     |    |                  =       doctools::include       struct::map      fileutil::paths
                        |                         |     |    |                  |
                doctools::idx::export::<*>        |     |    |          doctools::idx::import::<*>
                        docidx                    |     |    |                  docidx, json
                        json                      |     |    |                  |           \
                        html                      |     |    |          doctools::idx::parse \
                        nroff                     |     |    |                  |             \
                        wiki                      |     |    |  +---------------+              json
                        text                      |     |    |  |               |
                                                doctools::idx::structure        |
                                                                                |
                                                                        +-------+---------------+
                                                                        |                       |
          doctools::html  doctools::html::cssdefaults           doctools::tcl::parse    doctools::msgcat
                |                                                                               |
          doctools::text  doctools::nroff::man_macros                                           =
                                                                                                |
                                                                                        doctools::msgcat::idx::<*>
                                                                                                c, en, de, fr
                                                                                                (fr == en for now)
        ~~      Interoperable objects, without actual package dependencies
        --      Package dependency, higher requires lower package
        =       Dynamic dependency through plugin system
        <*>     Multiple packages following the given form of naming.
```

# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *doctools* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Dokumentationswerkzeuge

# Copyright

```
Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
