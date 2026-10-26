---
CommandName: doctools2toc_introduction
ManualSection: n
Version: 2.0
TclPart: tcllib
TclDescription: Documentation tools
Links:
 - doctoc_intro
 - doctools
 - doctools2doc_introduction
 - doctools2idx_introduction
 - doctools_lang_cmdref
 - doctools_lang_faq
 - doctools_lang_intro
 - doctools_lang_syntax
 - doctools_plugin_apiref
Keywords:
 - contents
 - conversion
 - formatting
 - markup
 - parsing
 - plugin
 - semantic markup
 - table of contents
Copyright:
 - Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

doctools2toc_introduction – DocTools – Inhaltsverzeichnisse

# BESCHREIBUNG

*doctoc* (kurz für *documentation tables of contents*) bezeichnet eine Reihe verwandter, aber verschiedener Dinge, die zusammenwirken, damit sich Inhaltsverzeichnisse für Dokumentation leicht erzeugen und umwandeln lassen.

Dies sind

**\[1\]**
: Eine auf Tcl beruhende Sprache für die semantische Auszeichnung eines Inhaltsverzeichnisses. Die Auszeichnung besteht aus Tcl-Befehlen. Anfänger beginnen mit der *doctoc language introduction*. Die formale Spezifikation ist auf zwei Dokumente verteilt, eines zur *doctoc language syntax*, das andere eine *doctoc language command reference*.

**\[2\]**
: Eine Reihe von Paketen zur programmgesteuerten Bearbeitung von Inhaltsverzeichnissen im Arbeitsspeicher und zu ihrer Umwandlung zwischen verschiedenen Formaten, lesend und schreibend. Die genannte Auszeichnungssprache ist eines der Formate, die sich sowohl lesen als auch schreiben lassen.

**\[3\]**
: Das System zur Umwandlung von Inhaltsverzeichnissen beruht auf einem Plugin-Mechanismus. Dafür gibt es zwei APIs, die die Schnittstelle zwischen den genannten Paketen und den Import- und Export-Plugins beschreiben. Welche der ausführlicheren Dokumente für den Leser dieser Einleitung relevant sind, hängt von der Rolle im Dokumentationsprozess ab.

**\[1\]**
: Ein *Autor* von Dokumentation muss die Auszeichnungssprache selbst verstehen. Wer mit doctoc anfängt, liest zuerst die eher informell geschriebene *doctoc language introduction*. Danach sollte die formale Spezifikation der *doctoc language syntax* verständlich sein. Wer doctoc schon kennt, braucht die *doctoc language command reference* nur noch gelegentlich zur Erinnerung. Während ein Dokument geschrieben wird, kann die Anwendung **dtp** es prüfen, und nach der Fertigstellung wandelt sie es auch in das gewählte System visueller Auszeichnung um, sei es \*roff, HTML, Klartext, Wiki und so weiter. Die einfachere Anwendung **dtplite** verwendet doctoc intern, wenn sie Verzeichnisse mit Dokumentation bearbeitet, und erzeugt für sie automatisch ein passendes Inhaltsverzeichnis.

**\[2\]**
: Ein *Verarbeiter* von Dokumentation in der Auszeichnungssprache *doctoc* muss wissen, welche Werkzeuge es gibt. Das wichtigste Werkzeug ist die genannte Anwendung **dtp** aus Tcllib. Die einfachere Anwendung **dtplite** zeigt dem Benutzer doctoc nicht. Auf der untersten Ebene, die beiden Anwendungen gemeinsam ist, liegen die drei Pakete mit den grundlegenden Mitteln für Inhaltsverzeichnisse, also Import aus Textformaten, programmgesteuerte Bearbeitung im Arbeitsspeicher und Export in Textformate. Das sind


**doctoools::toc**
: Programmgesteuerte Bearbeitung von Inhaltsverzeichnissen im Arbeitsspeicher.

**doctoools::toc::import**
: Import von Inhaltsverzeichnissen aus verschiedenen Textformaten. Die Menge der unterstützten Formate lässt sich durch Plugin-Pakete erweitern.

**doctoools::toc::export**
: Export von Inhaltsverzeichnissen in verschiedene Textformate. Die Menge der unterstützten Formate lässt sich durch Plugin-Pakete erweitern.


: Siehe auch den Abschnitt **PAKETÜBERSICHT** für einen Überblick über die Abhängigkeiten zwischen diesen und anderen, unterstützenden Paketen.

**\[3\]**
: Nicht zuletzt müssen *Plugin-Entwickler* das Zusammenspiel der Import- und Export-Pakete mit ihren Plugins verstehen. Diese APIs sind in der Dokumentation der beiden zuständigen Pakete beschrieben, also


**•**
: **doctoools::toc::import**

**•**
: **doctoools::toc::export**


# VERWANDTE FORMATE

Das doctoc-Format steht nicht allein, es hat zwei begleitende Formate. Sie heißen *docidx* und *doctools* und sind für die Auszeichnung von *Schlüsselwortindizes* beziehungsweise von allgemeiner Dokumentation bestimmt. Beschrieben sind sie in eigenen Dokumentgruppen, beginnend mit *DocTools - Keyword Indices* beziehungsweise *DocTools - General*.

# PAKETÜBERSICHT

```
                                    ~~~~~~~~~~~ doctools::toc ~~~~~~~~~~~
                                   ~~                   |               ~~
                doctools::toc::export ~~~~~~~~~~~~~~~~~ | ~~~~~~~~~~~~~ doctools::toc::import
                        |                               |                       |
        +---------------+-------------------------+     |    +------------------+---------------+-----------------------+---------------+
        |               |                         |     |    |                  |               |                       |               |
struct:map              =                         |     |    |                  =       doctools::include       struct::map      fileutil::paths
                        |                         |     |    |                  |
                doctools::toc::export::<*>        |     |    |          doctools::toc::import::<*>
                        doctoc                    |     |    |                  doctoc, json
                        json                      |     |    |                  |           \
                        html                      |     |    |          doctools::toc::parse \
                        nroff                     |     |    |                  |             \
                        wiki                      |     |    |  +---------------+              json
                        text                      |     |    |  |               |
                                                doctools::toc::structure        |
                                                                                |
                                                                        +-------+---------------+
                                                                        |                       |
          doctools::html  doctools::html::cssdefaults           doctools::tcl::parse    doctools::msgcat
                |                                                                               |
          doctools::text  doctools::nroff::man_macros                                           =
                                                                                                |
                                                                                        doctools::msgcat::toc::<*>
                                                                                                c, en, de, fr
                                                                                                (fr == en for now)
        ~~      Interoperable objects, without actual package dependencies
        --      Package dependency, higher requires lower package
        =       Dynamic dependency through plugin system
        <*>     Multiple packages following the given form of naming.
```

# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *doctools* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Dokumentationswerkzeuge

# COPYRIGHT

```
Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
