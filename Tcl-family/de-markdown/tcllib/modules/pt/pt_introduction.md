---
CommandName: pt_introduction
title: pt_introduction
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: Parser Tools
Keywords:
 - EBNF
 - LL(k)
 - PEG
 - TDPL
 - context-free languages
 - expression
 - grammar
 - matching
 - parser
 - parsing expression
 - parsing expression grammar
 - push down automaton
 - recursive descent
 - state
 - top-down parsing languages
 - transducer
Copyright:
 - Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

pt\_introduction – Einleitung in die Parser-Tools

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
:::

# Beschreibung

Willkommen bei den Parser-Tools, einem System zur Erstellung und Bearbeitung von Parsern und den ihnen zugrunde liegenden Grammatiken.

Welche Ziele haben Sie dazu bewegt, hierher zu kommen?

1. Möchten Sie einfach nur einen Parser für eine bestimmte Sprache erstellen?

    In diesem Fall werfen Sie doch einen Blick auf unsere Parser-Generator-Anwendung **pt** oder, wenn Sie etwas tiefer in die Materie einsteigen möchten, auf das zugrunde liegende Paket **pt::pgen**.

2. Möchten Sie mehr über die Architektur des Systems erfahren?

    Diese wird im folgenden Abschnitt [Architektur von Parser-Tools] beschrieben.

3. Interessieren Sie sich für die theoretischen Grundlagen, auf denen die Pakete und Werkzeuge basieren?

    Lesen Sie dazu die *Introduction to Parsing Expression Grammars*.


# Architektur von Parser-Tools

Das System lässt sich grob in drei Schichten unterteilen, wie in der folgenden Abbildung dargestellt

IMAGE: architecture

Diese Schichten sind, von oben nach unten:

1. An oberster Stelle befinden sich die Anwendung und die Pakete, die die Pakete der darunterliegenden Schicht nutzen, um gängige Anwendungsfälle umzusetzen. Ein Beispiel ist das bereits erwähnte **pt::pgen**, das einen Parser-Generator bereitstellt.

    Die Liste der zu dieser Schicht gehörenden Pakete steht im Abschnitt [Benutzerpakete].

2. In dieser Schicht befinden sich die Pakete, die den Kern der Funktionalität für das gesamte System bilden. Im Wesentlichen handelt es sich dabei um eine Reihe von Bausteinen, die sich auf unzählige Arten kombinieren lassen, ähnlich wie bei Lego (tm). Die Pakete der vorherigen Schicht sind „lediglich“ vorgefertigte Kombinationen, um die wichtigsten Anwendungsfälle abzudecken.

    Die Liste der zu dieser Schicht gehörenden Pakete steht im Abschnitt [Kernpakete]

3. Zu guter Letzt gibt es die Schicht mit den Unterstützungspaketen, die allgemeine Funktionen bereitstellen, die nicht unbedingt in das Modul gehören.

    Die Liste der zu dieser Schicht gehörenden Pakete steht im Abschnitt [Unterstützungspakete]


## Benutzerpakete

- **pt::pgen**


## Kernpakete

Diese Schicht ist weiter in sechs Bereiche unterteilt: Speicherung, Import, Export, Transformation und Ausführung von Grammatiken sowie grammatikspezifische Unterstützungspakete.

Speicher
: siehe unten ...

    - **pt::peg::container**


Export
: siehe unten ...

    - **pt::peg::export**
    - **pt::peg::export::container**
    - **pt::peg::export::json**
    - **pt::peg::export::peg**
    - [pt::peg::to::container][pt_peg_to_container]
    - [pt::peg::to::json][pt_peg_to_json]
    - [pt::peg::to::peg][pt_peg_to_peg]
    - [pt::peg::to::param][pt_peg_to_param]
    - [pt::peg::to::tclparam][pt_peg_to_tclparam]
    - [pt::peg::to::cparam][pt_peg_to_cparam]


Import
: siehe unten ...

    - **pt::peg::import**
    - [pt::peg::import::container][pt_peg_import_container]
    - **pt::peg::import::json**
    - **pt::peg::import::peg**
    - [pt::peg::from::container][pt_peg_from_container]
    - [pt::peg::from::json][pt_peg_from_json]
    - [pt::peg::from::peg][pt_peg_from_peg]


Transformation
: siehe unten ...

Ausführung
: siehe unten ...

    - **pt::peg::interp**
    - **pt::rde**


Unterstützung
: siehe unten ...

    - **pt::tclparam::configuration::snit**
    - **pt::tclparam::configuration::tcloo**
    - **pt::cparam::configuration::critcl**
    - **pt::ast**
    - **pt::pe**
    - **pt::peg**



## Unterstützungspakete

- [pt::peg::container::peg][pt_peg_container_peg]
- **text::write**
- **configuration**
- **paths**
- **char**


# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *pt* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Parser und Grammatiken

# Copyright

```
Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```


[pt_peg_container_peg]: pt_peg_container_peg.md
[pt_peg_from_container]: pt_peg_from_container.md
[pt_peg_from_json]: pt_peg_from_json.md
[pt_peg_from_peg]: pt_peg_from_peg.md
[pt_peg_import_container]: pt_peg_import_container.md
[pt_peg_to_container]: pt_peg_to_container.md
[pt_peg_to_cparam]: pt_peg_to_cparam.md
[pt_peg_to_json]: pt_peg_to_json.md
[pt_peg_to_param]: pt_peg_to_param.md
[pt_peg_to_peg]: pt_peg_to_peg.md
[pt_peg_to_tclparam]: pt_peg_to_tclparam.md
