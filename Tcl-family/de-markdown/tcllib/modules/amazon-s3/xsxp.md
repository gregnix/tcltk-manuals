---
CommandName: xsxp
title: xsxp
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: Amazon S3 Web Service Utilities
Keywords:
 - dom
 - parser
 - xml
Copyright:
---

# Name

xsxp – eXtremely Simple Xml Parser

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [xsxp]{.lit} [1.1]{.lit}
[package]{.cmd} [require]{.sub} [xml]{.lit}
[xsxp::parse]{.cmd} [xml]{.arg}
[xsxp::fetch]{.cmd} [pxml]{.arg} [path]{.arg} [part]{.optarg}
[xsxp::fetchall]{.cmd} [pxml\_list]{.arg} [path]{.arg} [part]{.optarg}
[xsxp::only]{.cmd} [pxml]{.arg} [tagname]{.arg}
[xsxp::prettyprint]{.cmd} [pxml]{.arg} [chan]{.optarg}
:::

# Beschreibung

Dieses Paket bietet eine einfache Schnittstelle, um XML in eine Liste aus reinen Werten zu parsen. Es stellt zudem Zugriffsfunktionen bereit, um bestimmte Untertags zu extrahieren, ähnlich wie beim DOM-Zugriff. Dieses Paket wurde für das Amazon-S3-Zugriffspaket von Darren New geschrieben und wird dort verwendet.

Das ist zwar ziemlich dürftig, aber ich benötigte so etwas für S3, und damals funktionierte TclDOM aufgrund von Problemen mit den Versionsnummern nicht mit dem neuen Tcl 8.5.

Zudem handelt es sich hierbei um eine reine Wertimplementierung. So gibt es beispielsweise im Falle eines ausgelösten Fehlers nichts aufzuräumen. Dies vereinfacht den Code bei ausreichend kleinen XML-Dokumenten, was durch Amazons S3 gewährleistet wird.

Copyright 2006 Darren New. Alle Rechte vorbehalten. ES WERDEN KEINERLEI GEWÄHRLEISTUNGEN JEGLICHER ART ÜBERNOMMEN. DAS KOPIEREN ODER DIE NUTZUNG BEFREIT DEN AUTOR IN JEDER HINSICHT VON JEGLICHER HAFTUNG. Diese Software wird unter im Wesentlichen denselben Bedingungen wie Tcl lizenziert. Die Bedingungen finden Sie in der Datei „LICENSE.txt“.

# Befehle

Das Paket implementiert fünf relativ einfache Prozeduren. Eine parst, eine dient der Fehlersuche, und die übrigen extrahieren verschiedene Teile des analysierten Dokuments zur weiteren Verarbeitung.

**xsxp::parse** *xml*
: Diese Funktion analysiert ein XML-Dokument (unter Verwendung des Standardmoduls „xml“ der tcllib in einer SAX-ähnlichen Weise) und erstellt eine Datenstruktur, die bei erfolgreicher Analyse zurückgegeben wird. Der Rückgabewert wird im Folgenden als „pxml“ oder „parsed xml“ bezeichnet. Die Liste besteht aus zwei oder mehr Elementen:

    - Das erste Element ist der Name des Tags.

    - Das zweite Element ist eine als Array-Get formatierte Liste von Schlüssel-Wert-Paaren. Die Schlüssel sind Attributnamen und die Werte sind Attributwerte. Diese Liste ist leer, wenn das Tag keine Attribute enthält.

    - Die Elemente vom dritten bis zum letzten sind die Kindknoten des Knotens, sofern vorhanden. Jeder Kindknoten ist rekursiv ein pxml.

    - Hinweis: Wenn das nullte Element, d. h. der Tag-Name, „%PCDATA“ lautet, sind die Attribute leer und das dritte Element enthält den Text des Elements. Wenn der Inhalt eines Elements zudem ausschließlich aus PCDATA besteht, hat es nur einen Kindknoten, und alle PCDATA-Elemente werden miteinander verkettet. Mit anderen Worten: Dieser Parser eignet sich nur bedingt für XML mit Elementen, die sowohl Kind-Tags als auch PCDATA enthalten. Da Amazon S3 dies nicht tut (und dies im Übrigen auch bei den meisten Anwendungen von XML, bei denen XML eine ungeeignete Wahl ist, nicht der Fall ist), stellt dies wahrscheinlich keine gravierende Einschränkung dar.


**xsxp::fetch** *pxml* *path* ?*part*?
: *pxml* ist ein geparstes XML, wie es von xsxp::parse zurückgegeben wird. *path* ist eine Liste von Element-Tag-Namen. Jedes Element ist der Name eines zu suchenden Kindknotens, optional gefolgt von einem Rautezeichen („#“) und einer Ziffernfolge. Eine leere Liste oder ein anfängliches leeres Element wählt *pxml* aus. Wenn kein Rautezeichen vorhanden ist, verhält es sich so, als wäre „#0“ an dieses Element angehängt worden. (Zusätzlich zu einer Liste können Schrägstriche Unterteile trennen, wo dies zweckmäßig ist.)

    Ein Element von *path* durchsucht die Kindknoten auf der angegebenen Ebene nach der n-ten Instanz eines Kindknotens, dessen Tag mit dem Teil des Elements vor dem Rautezeichen übereinstimmt. Wenn ein Element lediglich aus „#“ gefolgt von Ziffern besteht, wird der entsprechend indizierte Kindknoten ausgewählt, unabhängig von den Tags der Kindknoten. Daher wählt ein Element von „#3“ stets den vierten Kindknoten des betreffenden Knotens aus.

    *part* ist standardmäßig auf „%ALL“ gesetzt. Es kann einer der folgenden Begriffe sein, wobei die Groß- und Kleinschreibung beachtet werden muss:

    %ALL
    : gibt das gesamte ausgewählte Element zurück.

    %TAGNAME
    : Gibt **lindex** 0 des ausgewählten Elements zurück.

    %ATTRIBUTES
    : Gibt den Index 1 des ausgewählten Elements zurück.

    %CHILDREN
    : Gibt den Bereich von lrange 2 bis zum Ende des ausgewählten Elements zurück, wodurch eine Liste von Elementen zurückgegeben wird.

    %PCDATA
    : Gibt eine Verkettung aller Inhalte der direkten Kindknoten dieses Knotens zurück, deren Tag %PCDATA lautet. Es wird ein Fehler ausgelöst, wenn keine solchen Kindknoten gefunden werden. Das heißt, part=%PCDATA bedeutet, dass der Textinhalt dieses Knotens zurückgegeben wird, nicht jedoch der seiner Kindknoten.

    %PCDATA?
    : verhält sich wie %PCDATA, gibt jedoch eine leere Zeichenfolge zurück, wenn keine PCDATA-Daten gefunden werden.


    Um beispielsweise den ersten fett gesetzten Text aus dem fünften Absatz des body der HTML-Datei abzurufen,

    ```
    xsxp::fetch $pxml {body p#4 b} %PCDATA
    ```

**xsxp::fetchall** *pxml\_list* *path* ?*part*?
: Diese Funktion durchläuft jedes PXML in *pxml\_list* (die eine Liste von PXMLs sein muss), wählt den angegebenen Pfad daraus aus, erstellt eine neue Liste mit den ausgewählten Daten und gibt diese neue Liste zurück.

    Beispielsweise könnte *pxml\_list* die %CHILDREN eines bestimmten Elements sein, und die Parameter *path* und *part* könnten aus jedem Kindknoten ein Unterelement auswählen, an dem Interesse besteht.

**xsxp::only** *pxml* *tagname*
: Diese Funktion durchläuft die direkten Kindknoten von *pxml* und wählt nur diejenigen aus, deren Tag *tagname* lautet. Sie gibt eine Liste der übereinstimmenden Elemente zurück.

**xsxp::prettyprint** *pxml* ?*chan*?
: Dadurch wird eine übersichtliche Darstellung von *pxml* an *chan* (standardmäßig stdout) ausgegeben.


# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *amazon-s3* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Textverarbeitung

# Copyright

```
2006 Darren New. All Rights Reserved.
```
