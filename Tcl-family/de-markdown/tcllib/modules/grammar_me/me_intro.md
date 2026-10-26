---
CommandName: grammar::me_intro
title: grammar::me_intro
ManualSection: n
Version: 0.2
TclPart: tcllib
TclDescription: Grammar operations and usage
Keywords:
 - CFG
 - CFL
 - LL(k)
 - PEG
 - TPDL
 - context-free grammar
 - context-free languages
 - expression
 - grammar
 - matching
 - parsing
 - parsing expression grammar
 - push down automaton
 - recursive descent
 - top-down parsing languages
 - transducer
 - virtual machine
Copyright:
 - Copyright (c) 2005 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

grammar::me\_intro – Einleitung in virtuelle Maschinen zum Parsen von Token-Strömen

# Beschreibung

Dieses Dokument ist eine Einleitung in die grundlegenden Mittel zum Parsen und/oder Abgleichen von *token*-Strömen und ein Überblick darüber. Zeichen sind eine häufig genutzte Möglichkeit im Token-Bereich.

Die Pakete selbst bieten allesamt Varianten einer *virtuellen Maschine* an, die *Match-Engine* genannt wird (kurz *ME*). Sie hat alle Mittel, die zum Abgleichen und Parsen eines Stroms nötig sind. Die Varianten werden entweder direkt gesteuert oder mit einem Match-Programm angepasst. Die virtuelle Maschine ist im Grunde ein Pushdown-Automat mit zusätzlichen Elementen für das Backtracking und/oder die Verarbeitung semantischer Daten sowie die Erstellung abstrakter Syntaxbäume (*AST*).

Aufgrund der großen Ähnlichkeit der konkreten Implementierungen der oben genannten virtuellen Maschine und der Datenstrukturen, die sie empfangen und erzeugen, werden diese gemeinsamen Teile in einem separaten Dokument festgelegt, auf das die Dokumentation der Pakete verweist, die die Maschine tatsächlich implementieren.

Die entsprechenden Dokumente sind:

[grammar::me\_vm][me_vm]
: Spezifikation der virtuellen Maschine.

[grammar::me\_ast][me_ast]
: Spezifikation verschiedener Darstellungsformen für abstrakte Syntaxbäume.

**grammar::me::util**
: Dienstprogramme.

**grammar::me::tcl**
: Implementierung einer virtuellen ME-Maschine als Singleton, die hinsichtlich Kontrollfluss und Stacks an Tcl gebunden ist. Für Pull-Betrieb fest verdrahtet. Während der Verarbeitung nicht unterbrechbar.

**grammar::me::cpu**
: Objektbasierte Implementierung einer virtuellen ME-Maschine mit explizitem Kontrollfluss und Stacks unter Verwendung von Bytecodes. Aussetzbar und fortsetzbar. Push-/Pull-Betrieb.

**grammar::me::cpu::core**
: Kernfunktionalität zur Zustandsmanipulation und zur schrittweisen Ausführung, die in der Bytecode-basierten Implementierung von virtuellen ME-Maschinen zum Einsatz kommt.


# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *grammar\_me* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Grammatiken und endliche Automaten

# Copyright

```
Copyright (c) 2005 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```


[me_ast]: me_ast.md
[me_vm]: me_vm.md
