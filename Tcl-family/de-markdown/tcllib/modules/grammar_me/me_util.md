---
CommandName: grammar::me::util
ManualSection: n
Version: 0.2
TclPart: tcllib
TclDescription: Grammar operations and usage
Keywords:
 - abstract syntax tree
 - syntax tree
 - tree
Copyright:
 - Copyright (c) 2005 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

grammar::me::util – AST-Dienstprogramme

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [grammar::me::util]{.lit} [0.2]{.optlit} 
[::grammar::me::util::ast2tree]{.cmd} [ast]{.arg} [tree]{.arg} [root]{.optarg} 
[::grammar::me::util::ast2etree]{.cmd} [ast]{.arg} [mcmd]{.arg} [tree]{.arg} [root]{.optarg} 
[mcmd]{.cmd} [lc]{.sub} [location]{.arg} 
[mcmd]{.cmd} [tok]{.sub} [from]{.arg} [to]{.optarg} 
[::grammar::me::util::tree2ast]{.cmd} [tree]{.arg} [root]{.optarg} 
:::

# BESCHREIBUNG

Dieses Paket stellt eine Reihe von Hilfsbefehlen zur Umwandlung zwischen den verschiedenen Darstellungen abstrakter Syntaxbäume bereit, wie sie im Dokument **grammar::me_ast** festgelegt sind.

**::grammar::me::util::ast2tree** *ast* *tree* ?*root*?
: Dieser Befehl wandelt einen *ast* von der Wertdarstellung in die Objektdarstellung um. Alle Knoten im *ast* werden zu Knoten dieses *tree*, wobei die Wurzel des AST ein Kindknoten des Knotens *root* wird. Wird dieser Knoten nicht ausdrücklich angegeben, wird die Wurzel des Baums verwendet. Der bisherige Inhalt des Baums bleibt unberührt, er wird weder entfernt noch verändert, außer dass der angegebene Wurzelknoten einen neuen Kindknoten erhält.

**::grammar::me::util::ast2etree** *ast* *mcmd* *tree* ?*root*?
: Dieser Befehl entspricht dem Befehl **::grammar::me::util::ast2tree**, mit dem Unterschied, dass das Ergebnis in der erweiterten Objektdarstellung des Eingabe-AST vorliegt. Die Quelle der erweiterten Informationen ist das Befehlspräfix *mcmd*. Es muss zwei Methoden verstehen, **lc** und **tok**, mit der unten festgelegten Semantik.


**mcmd** **lc** *location*
: Nimmt die Position eines Tokens entgegen, die als Offset im Eingabestrom angegeben ist, und gibt eine Liste mit zwei Elementen zurück, die die zugehörige Zeilennummer und den Spaltenindex in dieser Reihenfolge enthält.

**mcmd** **tok** *from* ?*to*?
: Nimmt eine oder zwei Positionen *from* und *to* als Offset im Eingabestrom entgegen und gibt eine Tcl-Liste zurück, die den angegebenen Teil des Eingabestroms enthält. Beide Positionen sind inklusive. Wenn *to* nicht angegeben ist, wird standardmäßig der Wert von *from* verwendet. Jedes Element der zurückgegebenen Liste ist eine Liste, die das Token, das zugehörige Lexem, die Zeilennummer und den Spaltenindex in dieser Reihenfolge enthält.


Sowohl der Ensemble-Befehl **::grammar::me::tcl**, der vom Paket **grammar::me::tcl** bereitgestellt wird, als auch der Objektbefehl, den das Paket **grammar::me::cpu** erzeugt, entsprechen der oben genannten Spezifikation.

**::grammar::me::util::tree2ast** *tree* ?*root*?
: Dieser Befehl wandelt einen *ast* in (erweiterter) Objektdarstellung in einen Wert um und gibt ihn zurück. Ist ein Knoten *root* angegeben, wird der AST von diesem Knoten abwärts erzeugt. Andernfalls dient die Wurzel des Baumobjekts als Ausgangspunkt.


# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *grammar_me* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Grammatiken und endliche Automaten

# COPYRIGHT

```
Copyright (c) 2005 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
