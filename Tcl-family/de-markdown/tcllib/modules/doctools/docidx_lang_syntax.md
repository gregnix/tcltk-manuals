---
CommandName: docidx_lang_syntax
ManualSection: n
Version: 1.0
TclPart: tcllib
TclDescription: Documentation tools
Links:
 - docidx_intro
 - docidx_lang_cmdref
 - docidx_lang_faq
 - docidx_lang_intro
Keywords:
 - docidx commands
 - docidx language
 - docidx markup
 - docidx syntax
 - markup
 - semantic markup
Copyright:
 - Copyright (c) 2007-2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

docidx_lang_syntax – docidx-Sprachsyntax

# BESCHREIBUNG

Dieses Dokument enthält die formale Spezifikation der Syntax der Markup-Sprache docidx, Version 1, in Backus-Naur-Form. Dieses Dokument ist als Nachschlagewerk gedacht und ergänzt die *docidx-Befehlsreferenz*. Anfängern wird empfohlen, zunächst die wesentlich informeller verfasste *Einleitung in die Sprache docidx* zu lesen, bevor sie versuchen, dieses Dokument oder die Befehlsreferenz zu verstehen.

# GRUNDLAGEN

Im weitesten Sinne ist die *docidx-Auszeichnungssprache* wie SGML und ähnliche Sprachen. Ein in dieser Sprache verfasstes Dokument besteht in erster Linie aus Auszeichnungsbefehlen, wobei an einigen Stellen Text in das Dokument eingebettet ist.

Jeder Markup-Befehl ist lediglich ein Tcl-Befehl, der von einem passenden Paar aus „**\[**“ und „**\]**“ umgeben ist. Welche Befehle verfügbar sind und welche Argumente sie erfordern, d. h. ihre Syntax, wird in der *docidx-Befehlsreferenz für die Sprache* festgelegt.

In diesem Dokument legen wir zunächst das Lexem fest und legen anschließend die Syntax fest, d. h., wie sich Text und Markup-Befehle miteinander mischen lassen.

# LEXIKALISCHE DEFINITIONEN

In den im folgenden Abschnitt aufgeführten Syntaxregeln

**\[1\]**
: \<TEXT> steht für den gesamten Text mit Ausnahme von Markup-Befehlen.

**\[2\]**
: Jedes „XXX“ steht für den Markup-Befehl \[xxx\] einschließlich seiner Argumente. Jeder Markup-Befehl ist ein Tcl-Befehl, der von einem passenden Paar aus **\[** und **\]** umgeben ist. Innerhalb dieser Begrenzungszeichen gelten die üblichen Regeln für einen Tcl-Befehl hinsichtlich der Quotierung von Wörtern, verschachtelter Befehle, Fortsetzungszeilen usw.

**\[3\]**
: \<WHITE> steht für sämtlichen Text, der ausschließlich aus Leerzeichen, Zeilenumbrüchen, Tabulatoren und dem Markup-Befehl **comment** besteht.


# SYNTAX

Die hier aufgeführten Regeln legen lediglich die Syntax von docidx-Dokumenten fest. Die lexikalische Ebene der Sprache wurde im vorangegangenen Abschnitt behandelt.

Zur Syntax der (E)BNF selbst

**\[1\]**
: Das Konstrukt { X } steht für null oder mehr Vorkommen von X.

**\[2\]**
: Das Konstrukt \[ X \] steht für das einmalige oder nullmalige Vorkommen von X. Die Syntax lautet:


```
index     = defs
            INDEX_BEGIN
            [ contents ]
            INDEX_END
            { <WHITE> }

defs      = { INCLUDE | VSET | <WHITE> }
contents  = keyword { keyword }

keyword   = defs KEY ref { ref }
ref       = MANPAGE | URL | defs
```

Zuletzt eine Regel, die wir in der EBNF-Syntax nicht erfassen konnten, weil sie die Argumente der Markup-Befehle betrifft, etwas, das hier nicht modelliert ist.

**\[1\]**
: Die Argumente aller Markup-Befehle müssen reiner Text sein, Text-Markup-Befehle oder beides. Als Text-Markup-Befehle gelten:


**\[1\]**
: **lb**,

**\[2\]**
: **rb**, oder

**\[3\]**
: **vset** (Form mit einem Argument).


# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *doctools* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Dokumentationswerkzeuge

# COPYRIGHT

```
Copyright (c) 2007-2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
