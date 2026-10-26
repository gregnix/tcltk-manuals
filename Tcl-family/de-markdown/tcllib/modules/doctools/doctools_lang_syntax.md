---
CommandName: doctools_lang_syntax
ManualSection: n
Version: 1.0
TclPart: tcllib
TclDescription: Documentation tools
Links:
 - doctools_intro
 - doctools_lang_cmdref
 - doctools_lang_faq
 - doctools_lang_intro
Keywords:
 - doctools commands
 - doctools language
 - doctools markup
 - doctools syntax
 - markup
 - semantic markup
Copyright:
 - Copyright (c) 2007 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

doctools_lang_syntax – doctools-Sprachsyntax

# BESCHREIBUNG

Dieses Dokument enthält die formale Spezifikation der Syntax der doctools-Markup-Sprache, Version 1, in Backus-Naur-Form. Dieses Dokument ist als Nachschlagewerk gedacht und ergänzt die *doctools-Befehlsreferenz*. Anfängern wird empfohlen, zunächst die wesentlich informeller verfasste *Einleitung in die doctools-Sprache* zu lesen, bevor sie versuchen, dieses Dokument oder die Befehlsreferenz zu verstehen.

# GRUNDLAGEN

Im weitesten Sinne ähnelt die *doctools-Auszeichnungssprache* eher LaTeX als SGML und ähnlichen Sprachen. Ein in dieser Sprache verfasstes Dokument besteht in erster Linie aus Text, in den Auszeichnungsbefehle eingebettet sind.

Jeder Markup-Befehl ist lediglich ein Tcl-Befehl, der von einem passenden Paar aus „**\[**“ und „**\]**“ umgeben ist. Welche Befehle verfügbar sind und welche Argumente sie erfordern, d. h. ihre Syntax, wird in der *doctools-Befehlsreferenz* festgelegt.

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

Die hier aufgeführten Regeln legen lediglich die Syntax von doctools-Dokumenten fest. Die lexikalische Ebene der Sprache wurde im vorangegangenen Abschnitt behandelt.

Zur Syntax der (E)BNF selbst

**\[1\]**
: Das Konstrukt { X } steht für null oder mehr Vorkommen von X.

**\[2\]**
: Das Konstrukt \[ X \] steht für kein oder ein Vorkommen von X.

**\[3\]**
: Das Konstrukt LIST_BEGIN\<X> steht für den Markup-Befehl **list_begin** mit **X** als Typ-Argument. Die Syntax:


```
manpage = defs
          MANPAGE_BEGIN
          header
          DESCRIPTION
          body
          MANPAGE_END
          { <WHITE> }

defs    = { INCLUDE | VSET | <WHITE> }

header  = { TITLEDESC | MODDESC | COPYRIGHT | REQUIRE | defs | xref }

xref    = KEYWORDS | SEE_ALSO | CATEGORY

body    = paras { SECTION    sbody  }
sbody   = paras { SUBSECTION ssbody }
ssbody  = paras

paras   = tblock { (PARA | NL) tblock }

tblock  = { <TEXT> | defs | markup | xref | an_example | a_list }

markup  = ARG     | CLASS | CMD     | CONST     | EMPH   | FILE
        | FUN     | LB    | METHOD  | NAMESPACE | OPT    | OPTION
        | PACKAGE | RB    | SECTREF | STRONG    | SYSCMD | TERM
        | TYPE    | URI   | USAGE   | VAR       | WIDGET

example = EXAMPLE
        | EXAMPLE_BEGIN extext EXAMPLE_END

extext  = { <TEXT> | defs | markup }

a_list  = LIST_BEGIN<arguments>   argd_list   LIST_END
        | LIST_BEGIN<commands>    cmdd_list   LIST_END
        | LIST_BEGIN<definitions> def_list    LIST_END
        | LIST_BEGIN<enumerated>  enum_list   LIST_END
        | LIST_BEGIN<itemized>    item_list   LIST_END
        | LIST_BEGIN<options>     optd_list   LIST_END
        | LIST_BEGIN<tkoptions>   tkoptd_list LIST_END

argd_list   = [ <WHITE> ] { ARG_DEF      paras }
cmdd_list   = [ <WHITE> ] { CMD_DEF      paras }
def_list    = [ <WHITE> ] { (DEF|CALL)   paras }
enum_list   = [ <WHITE> ] { ENUM         paras }
item_list   = [ <WHITE> ] { ITEM         paras }
optd_list   = [ <WHITE> ] { OPT_DEF      paras }
tkoptd_list = [ <WHITE> ] { TKOPTION_DEF paras }
```

# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *doctools* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Dokumentationswerkzeuge

# COPYRIGHT

```
Copyright (c) 2007 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
