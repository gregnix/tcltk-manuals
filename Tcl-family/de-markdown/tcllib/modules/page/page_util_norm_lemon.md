---
CommandName: page_util_norm_lemon
title: page_util_norm_lemon
ManualSection: n
Version: 1.0
TclPart: tcllib
TclDescription: Parser generator tools
Keywords:
 - graph walking
 - lemon
 - normalization
 - page
 - parser generator
 - text processing
 - tree walking
Copyright:
 - Copyright (c) 2007 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

page\_util\_norm\_lemon – page-AST-Normalisierung, LEMON

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [page::util::norm\_lemon]{.lit} [0.2]{.optlit}
[package]{.cmd} [require]{.sub} [snit]{.lit}
[::page::util::norm::lemon]{.cmd} [tree]{.arg}
:::

# Beschreibung

Dieses Paket stellt einen einzigen Hilfsbefehl zur Verfügung, der einen AST einer Lemon-Grammatik entgegennimmt und diesen auf verschiedene Weise normalisiert. Das Ergebnis wird als *normalisierter Lemon-Grammatikbaum* bezeichnet.

*Hinweis*: Dieses Paket kann nur innerhalb eines Plugins verwendet werden, das vom Paket **page::pluginmgr** verwaltet wird.

# API

**::page::util::norm::lemon** *tree*
: Dieser Befehl setzt voraus, dass das *tree*-Objekt eine Lemon-Grammatik enthält. Er normalisiert diesen Baum an Ort und Stelle. Das Ergebnis wird als *normalisierter Lemon-Grammatikbaum* bezeichnet.

    Die genauen durchgeführten Operationen werden vorerst nicht dokumentiert.


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
