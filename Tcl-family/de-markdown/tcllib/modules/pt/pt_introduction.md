---
CommandName: pt_introduction
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

# NAME

pt_introduction – Einleitung in die Parser-Tools

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
:::

# BESCHREIBUNG

Willkommen bei den Parser-Tools, einem System zur Erstellung und Bearbeitung von Parsern und den ihnen zugrunde liegenden Grammatiken.

Welche Ziele haben Sie dazu bewegt, hierher zu kommen?

**\[1\]**
: Möchten Sie einfach nur einen Parser für eine bestimmte Sprache erstellen? In diesem Fall werfen Sie doch einen Blick auf unsere Parser-Generator-Anwendung **pt** oder, wenn Sie etwas tiefer in die Materie einsteigen möchten, auf das zugrunde liegende Paket **pt::pgen**.

**\[2\]**
: Möchten Sie mehr über die Architektur des Systems erfahren? Diese wird im folgenden Abschnitt **ARCHITEKTUR VON PARSER-TOOLS** beschrieben.

**\[3\]**
: Interessieren Sie sich für die theoretischen Grundlagen, auf denen die Pakete und Werkzeuge basieren? Lesen Sie dazu die *Introduction to Parsing Expression Grammars*.


# ARCHITEKTUR VON PARSER-TOOLS

Das System lässt sich grob in drei Schichten unterteilen, wie in der folgenden Abbildung dargestellt

IMAGE: architecture

Diese Schichten sind, von oben nach unten:

**\[1\]**
: An oberster Stelle befinden sich die Anwendung und die Pakete, die die Pakete der darunterliegenden Schicht nutzen, um gängige Anwendungsfälle umzusetzen. Ein Beispiel ist das bereits erwähnte **pt::pgen**, das einen Parser-Generator bereitstellt. Die Liste der zu dieser Schicht gehörenden Pakete steht im Abschnitt **Benutzerpakete**.

**\[2\]**
: In dieser Schicht befinden sich die Pakete, die den Kern der Funktionalität für das gesamte System bilden. Im Wesentlichen handelt es sich dabei um eine Reihe von Bausteinen, die sich auf unzählige Arten kombinieren lassen, ähnlich wie bei Lego (tm). Die Pakete der vorherigen Schicht sind „lediglich“ vorgefertigte Kombinationen, um die wichtigsten Anwendungsfälle abzudecken. Die Liste der zu dieser Schicht gehörenden Pakete steht im Abschnitt **Kernpakete**

**\[3\]**
: Zu guter Letzt gibt es die Schicht mit den Unterstützungspaketen, die allgemeine Funktionen bereitstellen, die nicht unbedingt in das Modul gehören. Die Liste der zu dieser Schicht gehörenden Pakete steht im Abschnitt **Unterstützungspakete**


## Benutzerpakete

**pt::pgen**
: 


## Kernpakete

Diese Schicht ist weiter in sechs Bereiche unterteilt: Speicherung, Import, Export, Transformation und Ausführung von Grammatiken sowie grammatikspezifische Unterstützungspakete.

**Speicher**
: 


**pt::peg::container**
: 


**Export**
: 


**pt::peg::export**
: ...siehe nächstes...

**pt::peg::export::container**
: ...siehe nächstes...

**pt::peg::export::json**
: ...siehe nächstes...

**pt::peg::export::peg**
: ...siehe nächstes...

**pt::peg::to::container**
: ...siehe nächstes...

**pt::peg::to::json**
: ...siehe nächstes...

**pt::peg::to::peg**
: ...siehe nächstes...

**pt::peg::to::param**
: ...siehe nächstes...

**pt::peg::to::tclparam**
: ...siehe nächstes...

**pt::peg::to::cparam**
: 


**Import**
: 


**pt::peg::import**
: ...siehe nächstes...

**pt::peg::import::container**
: ...siehe nächstes...

**pt::peg::import::json**
: ...siehe nächstes...

**pt::peg::import::peg**
: ...siehe nächstes...

**pt::peg::from::container**
: ...siehe nächstes...

**pt::peg::from::json**
: ...siehe nächstes...

**pt::peg::from::peg**
: 


**Transformation**
: ...siehe nächstes...

**Ausführung**
: 


**pt::peg::interp**
: ...siehe nächstes...

**pt::rde**
: 


**Unterstützung**
: 


**pt::tclparam::configuration::snit**
: ...siehe nächstes...

**pt::tclparam::configuration::tcloo**
: ...siehe nächstes...

**pt::cparam::configuration::critcl**
: ...siehe nächstes...

**pt::ast**
: ...siehe nächstes...

**pt::pe**
: ...siehe nächstes...

**pt::peg**
: 


## Unterstützungspakete

**pt::peg::container::peg**
: ...siehe nächstes...

**text::write**
: ...siehe nächstes...

**configuration**
: ...siehe nächstes...

**paths**
: ...siehe nächstes...

**char**
: 


# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *pt* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Parser und Grammatiken

# COPYRIGHT

```
Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
