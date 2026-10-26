---
CommandName: grammar::me_ast
title: grammar::me_ast
ManualSection: n
Version: 0.2
TclPart: tcllib
TclDescription: Grammar operations and usage
Keywords:
 - AST
 - abstract syntax tree
Copyright:
 - Copyright (c) 2005 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

grammar::me\_ast – Verschiedene Darstellungen von ASTs

# Beschreibung

Dieses Dokument legt verschiedene Darstellungsformen für die *abstrakten Syntaxbäume* (kurz *AST*), die von Instanzen virtueller ME-Maschinen generiert werden, fest, unabhängig von der jeweiligen Variante. Bitte lesen Sie zunächst das Dokument **grammar::me\_intro**, wenn Sie nicht wissen, was eine virtuelle ME-Maschine ist.

ASTs und alle von uns festgelegten Darstellungen unterscheiden zwischen zwei Arten von Knoten, nämlich:

Terminal
: Terminalknoten beziehen sich auf die im Tokenstrom vorkommenden Terminalsymbole. Es sind stets Blattknoten. Terminalknoten haben niemals Kindknoten.

Nonterminal
: Nichtterminale Knoten stellen ein nichtterminales Symbol der bei der Syntaxanalyse verwendeten Grammatik dar. Sie können als Blattknoten und als innere Knoten des Baums vorkommen.


Beide Knotentypen enthalten grundlegende Bereichsinformationen, die dem Benutzer mitteilen, welche Teile der Eingabe von dem Knoten abgedeckt werden, indem sie die Position des ersten und letzten Tokens angeben, die innerhalb dieses Bereichs gefunden wurden. Die Positionen werden als nicht-negative ganzzahlige Offsets vom Anfang des Token-Stroms angegeben, wobei das erste im Strom gefundene Token am Offset 0 (Null) liegt.

Die Wurzel eines AST kann entweder ein Terminal- oder ein Nichtterminalknoten sein.

# AST-Werte

Diese Darstellung von ASTs erfolgt als Tcl-Liste. Die Hauptliste stellt den Wurzelknoten des Baums dar, wobei die Darstellungen der Kindknoten darin verschachtelt sind.

Jeder Knoten wird durch eine einzelne Tcl-Liste dargestellt, die drei oder mehr Elemente enthält. Das erste Element ist entweder die leere Zeichenkette oder der Name eines nichtterminalen Symbols (der niemals die leere Zeichenkette ist). Das zweite und dritte Element geben dann die Positionen des ersten bzw. letzten Tokens an. Alle weiteren Elemente nach dem dritten sind die Darstellungen der Kindknoten, wobei der am weitesten links stehende Kindknoten zuerst kommt, also als viertes Element der Liste, die den Knoten darstellt.

# AST-Objekte

In dieser Darstellung wird ein AST durch einen Tcl-Objektbefehl dargestellt, dessen API mit den Baumobjekten des Pakets **struct::tree** kompatibel ist. Das heißt, er muss mindestens alle von diesem Paket beschriebenen Methoden unterstützen und kann weitere unterstützen.

Aus diesem Grund werden die übrigen Spezifikationen unter Verwendung der Begriffe aus **struct::tree** verfasst.

Jeder Knoten des AST ist direkt einem Knoten im Baum-Objekt zugeordnet. Alle Daten jenseits der Kindknoten, also Knotentyp und Eingabepositionen, werden in Attributen des Knotens im Baumobjekt gespeichert. Diese sind:

type
: Der Typ des AST-Knotens. Die zulässigen Werte sind **terminal** und **nonterminal**.

range
: Die Positionen des ersten und letzten Tokens der Terminal-Daten in der vom Knoten abgedeckten Eingabe. Hierbei handelt es sich um eine Liste, die zwei Positionen enthält.

detail
: Dieses Attribut ist nur bei nichtterminalen Knoten vorhanden. Es enthält den Namen des im Knoten gespeicherten nichtterminalen Symbols.


# Erweiterte AST-Objekte

Erweiterte AST-Objekte entsprechen AST-Objekten, enthalten jedoch zusätzliche Informationen.

detail
: Dieses Attribut ist nun an allen Knoten vorhanden. Sein Inhalt bleibt bei nichtterminalen Knoten unverändert. Bei terminalen Knoten enthält es eine Liste, die alle Token aus der Eingabe beschreibt, die von dem Knoten abgedeckt werden.

    Jedes Element der Liste enthält in dieser Reihenfolge den Tokennamen, das zugehörige Lexem-Attribut, die Zeilennummer und den Spaltenindex.

range\_lc
: Dieses neue Attribut ist für alle Knoten definiert und enthält die Positionen aus dem Attribut *range*, umgerechnet in Zeilennummern und Spalten-Indizes. Die Zeilen werden ab 1 gezählt, die Spalten ab 0.


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


[me_intro]: me_intro.md
