---
CommandName: doctoc_lang_syntax
title: doctoc_lang_syntax
ManualSection: n
Version: 1.0
TclPart: tcllib
TclDescription: Documentation tools
Links:
 - doctoc_intro
 - doctoc_lang_cmdref
 - doctoc_lang_faq
 - doctoc_lang_intro
Keywords:
 - doctoc commands
 - doctoc language
 - doctoc markup
 - doctoc syntax
 - markup
 - semantic markup
Copyright:
 - Copyright (c) 2007-2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

doctoc\_lang\_syntax – Syntax der doctoc-Sprache

# Beschreibung

Dieses Dokument enthält die formale Spezifikation der Syntax der Markup-Sprache „doctoc“, Version 1.1, in Backus-Naur-Form. Dieses Dokument ist als Nachschlagewerk gedacht und ergänzt die *doctoc-Befehlsreferenz*. Anfänger sollten zunächst die wesentlich informeller verfasste *Einleitung in die Sprache doctoc* lesen, bevor sie versuchen, dieses Dokument oder die Befehlsreferenz zu verstehen.

# Grundlagen

Im weitesten Sinne ähnelt die *doctoc-Auszeichnungssprache* SGML und ähnlichen Sprachen. Ein in dieser Sprache verfasstes Dokument besteht in erster Linie aus Auszeichnungsbefehlen, wobei an einigen Stellen Text in das Dokument eingebettet ist.

Jeder Markup-Befehl ist lediglich ein Tcl-Befehl, der von einem passenden Paar aus „**\[**“ und „**\]**“ umgeben ist. Welche Befehle verfügbar sind und welche Argumente sie erfordern, d. h. ihre Syntax, wird in der *Befehlsreferenz der Sprache doctoc* festgelegt.

In diesem Dokument legen wir zunächst das Lexem fest und legen anschließend die Syntax fest, d. h., wie sich Text und Markup-Befehle miteinander mischen lassen.

# Lexikalische Definitionen

In den im folgenden Abschnitt aufgeführten Syntaxregeln

1. <TEXT> steht für den gesamten Text mit Ausnahme von Markup-Befehlen.

2. Jedes „XXX“ steht für den Markup-Befehl \[xxx\] einschließlich seiner Argumente. Jeder Markup-Befehl ist ein Tcl-Befehl, der von einem passenden Paar aus **\[** und **\]** umgeben ist. Innerhalb dieser Begrenzungszeichen gelten die üblichen Regeln für einen Tcl-Befehl hinsichtlich der Quotierung von Wörtern, verschachtelter Befehle, Fortsetzungszeilen usw.

3. <WHITE> steht für sämtlichen Text, der ausschließlich aus Leerzeichen, Zeilenumbrüchen, Tabulatoren und dem Markup-Befehl [comment][docidx_lang_cmdref] besteht.


# Syntax

Die hier aufgeführten Regeln legen lediglich die Syntax von doctoc-Dokumenten fest. Die lexikalische Ebene der Sprache wurde im vorangegangenen Abschnitt behandelt.

Zur Syntax der (E)BNF selbst

1. Das Konstrukt { X } steht für null oder mehr Vorkommen von X.

2. Das Konstrukt \[ X \] steht für das einmalige oder nullmalige Vorkommen von X.


Die Syntax lautet:

```
toc       = defs
            TOC_BEGIN
            contents
            TOC_END
            { <WHITE> }

defs      = { INCLUDE | VSET | <WHITE> }
contents  = { defs entry } [ defs ]

entry     = ITEM | division

division  = DIVISION_START
            contents
            DIVISION_END
```

# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *doctools* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Dokumentationswerkzeuge

# Copyright

```
Copyright (c) 2007-2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```


[docidx_lang_cmdref]: docidx_lang_cmdref.md
