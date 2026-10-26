---
CommandName: page_util_norm_peg
title: page_util_norm_peg
ManualSection: n
Version: 1.0
TclPart: tcllib
TclDescription: Parser generator tools
Keywords:
 - PEG
 - graph walking
 - normalization
 - page
 - parser generator
 - text processing
 - tree walking
Copyright:
 - Copyright (c) 2007 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

page\_util\_norm\_peg – page-AST-Normalisierung, PEG

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [page::util::norm\_peg]{.lit} [0.2]{.optlit}
[package]{.cmd} [require]{.sub} [snit]{.lit}
[::page::util::norm::peg]{.cmd} [tree]{.arg}
:::

# Beschreibung

Dieses Paket stellt einen einzigen Befehl zur Verfügung, der einen AST für eine Parsing Expression Grammar entgegennimmt und diesen auf verschiedene Weise normalisiert. Das Ergebnis wird als *normalisierter PE-Grammatikbaum* bezeichnet.

*Hinweis*: Dieses Paket kann nur innerhalb eines Plugins verwendet werden, das vom Paket **page::pluginmgr** verwaltet wird.

# API

**::page::util::norm::peg** *tree*
: Dieser Befehl geht davon aus, dass das Objekt *tree* eine Parsing Expression Grammar enthält. Er normalisiert diesen Baum an Ort und Stelle. Das Ergebnis wird als *normalisierter PE-Grammatikbaum* bezeichnet.

    Die folgenden Operationen werden durchgeführt:

    1. Die Daten aller Terminale werden in deren Großelternknoten gespeichert. Die Terminalknoten und ihre Elternknoten werden entfernt. Typinformationen werden verworfen.

    2. Alle Knoten, die genau einen Kindknoten haben, sind irrelevant und werden entfernt, mit Ausnahme des Wurzelknotens. Der unmittelbare Kindknoten des Wurzelknotens ist ebenfalls irrelevant und wird ebenfalls entfernt.

    3. Der Name der Grammatik wird von dem Baumknoten, in dem er gespeichert ist, in ein Attribut des Wurzelknotens verschoben, und der Baumknoten wird entfernt.

        Der Knoten, der den Startausdruck getrennt hält, wird als irrelevant entfernt, und der Wurzelknoten des Startausdrucks wird mit einem Marker-Attribut versehen; sein Handle wird zum schnellen Zugriff in einem Attribut des Wurzelknotens gespeichert.

    4. Hinweisinformationen zu Nichtterminalen werden aus den Knoten in Attribute verschoben, und die nun überflüssigen Knoten werden gelöscht.

        *Hinweis:* Diese Transformation setzt das Entfernen aller Knoten mit genau einem Kindknoten voraus, weil dabei bereits alle „Attribute“-Knoten entfernt werden. Andernfalls müsste diese Transformation die Informationen in den Großelternknoten einfügen.

        Der vorgegebene Modus der Nichtterminale ist **value**.

        Wie bei der Definition der globalen Metadaten werden bestimmte Informationen aus den Knoten in Attribute verschoben, die nun überflüssigen Knoten gelöscht und die Wurzelknoten aller Definitionen mit Marker-Attributen versehen. Dadurch entsteht außerdem eine Zuordnung von Nichtterminalnamen zu ihren definierenden Knoten, die zum schnellen Nachschlagen in einem Attribut des Wurzelknotens gespeichert wird.

        Zuletzt wird der von einer Definition abgedeckte Bereich in der Eingabe berechnet. Die linke Grenze kommt vom Terminal für das Nichtterminalsymbol, das die Definition definiert. Die rechte Grenze kommt vom am weitesten rechts stehenden Kindknoten unter der Definition. Auch wenn dies noch kein Ausdrucksbaum ist, sind die Positionsdaten bereits stimmig.

    5. Die verbleibenden Knoten unter allen Definitionen werden in echte Ausdrucksbäume umgewandelt. Zuerst Zeichenbereiche, danach unäre Operationen, Zeichen und Nichtterminale. Zuletzt wird der Baum durch Entfernen überflüssiger innerer Knoten abgeflacht.

        Die Reihenfolge ist entscheidend, um möglichst früh so viele Knoten wie möglich zu entfernen und späteren unnötigen Aufwand zu vermeiden.



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
