---
CommandName: page_util_peg
title: page_util_peg
ManualSection: n
Version: 1.0
TclPart: tcllib
TclDescription: Parser generator tools
Keywords:
 - PEG
 - page
 - parser generator
 - parsing expression grammar
 - text processing
 - transformation
Copyright:
 - Copyright (c) 2007 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

page\_util\_peg – page-Hilfsprogramme für PEG-Transformationen

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [page::util::peg]{.lit} [0.2]{.optlit}
[package]{.cmd} [require]{.sub} [snit]{.lit}
[::page::util::peg::symbolNodeOf]{.cmd} [tree]{.arg} [node]{.arg}
[::page::util::peg::symbolOf]{.cmd} [tree]{.arg} [node]{.arg}
[::page::util::peg::updateUndefinedDueRemoval]{.cmd} [tree]{.arg}
[::page::util::peg::flatten]{.cmd} [treequery]{.arg} [tree]{.arg}
[::page::util::peg::getWarnings]{.cmd} [tree]{.arg}
[::page::util::peg::printWarnings]{.cmd} [msg]{.arg}
[::page::util::peg::peOf]{.cmd} [tree]{.arg} [eroot]{.arg}
[::page::util::peg::printTclExpr]{.cmd} [pe]{.arg}
:::

# Beschreibung

Dieses Paket stellt einige gängige Operationen für PEG-Transformationen bereit. Als Eingabe wird ein *normalisierter PE-Grammatikbaum* vorausgesetzt; siehe dazu das Paket **page::util::norm::peg**, der gegebenenfalls um Attribute ergänzt werden kann, die aus Transformationen stammen, die nicht im Widerspruch zur Basisdefinition stehen.

# API

**::page::util::peg::symbolNodeOf** *tree* *node*
: Zu einem beliebigen Ausdrucksknoten *node* im AST *tree* ermittelt diese Funktion den Knoten (den Knoten selbst oder einen Vorfahren), der den Namen des Nichtterminals enthält, zu dem der Knoten gehört, und gibt dessen ID zurück. Das Ergebnis ist entweder die Wurzel des Baums (beim Startausdruck) oder ein Definitionsknoten.

**::page::util::peg::symbolOf** *tree* *node*
: Wie **::page::util::peg::symbolNodeOf**, gibt jedoch anstelle des Knotens den Namen des Symbols zurück.

**::page::util::peg::updateUndefinedDueRemoval** *tree*
: Das Entfernen von Knoten im AST *tree* kann dazu führen, dass Symbole eine oder mehrere Verwendungsstellen verlieren.

    ```
    	A used by B and C,
    	B is reachable,
    	C is not,

    	so A now loses the node in the expression for C calling it,
    	or rather, not calling it anymore.
    ```

    Dieser Befehl aktualisiert die Querverweise und welche Nichtterminale nun undefiniert sind.

**::page::util::peg::flatten** *treequery* *tree*
: Dieser Befehl flacht verschachtelte Sequenz- und Auswahloperatoren im AST *tree* ab und verwendet das **treeql**-Objekt *treequery* erneut, um die Abfrage auszuführen, die ermittelt, welche Knoten entfernt werden.

**::page::util::peg::getWarnings** *tree*
: Dieser Befehl prüft die Attribute des AST *tree* auf Probleme der Grammatik und stellt Warnungen zusammen. Sie hindern uns nicht daran, die Grammatik zu schreiben, stellen aber dennoch Probleme dar, auf die der Benutzer hingewiesen werden sollte.

    Das Ergebnis des Befehls ist ein Dictionary, das die Namen der Nichtterminale ihren Warnungen zuordnet.

**::page::util::peg::printWarnings** *msg*
: Das Argument des Befehls ist ein Dictionary, das Nichtterminalnamen ihren Warnungen zuordnet, wie es zum Beispiel der Befehl **::page::util::peg::getWarnings** erzeugt.

    Die darin enthaltenen Warnungen werden formatiert und dann über den Protokollbefehl **page\_info** ausgegeben. Dieser Befehl kann daher nur innerhalb eines Plugins verwendet werden, das vom Paket **page::pluginmgr** verwaltet wird.

**::page::util::peg::peOf** *tree* *eroot*
: Dieser Befehl wandelt den Parsing-Ausdruck, der am Knoten *eroot* im AST *tree* beginnt, in eine verschachtelte Liste um. Die genaue Syntax dieser Liste wird durch das Paket **grammar::peg** festgelegt.

**::page::util::peg::printTclExpr** *pe*
: Dieser Befehl wandelt den in der verschachtelten Liste *pe* enthaltenen Parsing-Ausdruck in eine Tcl-Zeichenkette um, die in ein Tcl-Skript eingefügt werden kann. Die genaue Syntax von *pe* entnehmen Sie bitte dem Paket **grammar::peg**.


# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *page* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Page-Parsergenerator

# Copyright

```
Copyright (c) 2007 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```


[page_pluginmgr]: page_pluginmgr.md
