---
CommandName: page_util_flow
title: page_util_flow
ManualSection: n
Version: 1.0
TclPart: tcllib
TclDescription: Parser generator tools
Keywords:
 - dataflow
 - graph walking
 - page
 - parser generator
 - text processing
 - tree walking
Copyright:
 - Copyright (c) 2007 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

page\_util\_flow – page-Dienstprogramm für Datenfluss und Baumdurchquerung

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [page::util::flow]{.lit} [0.2]{.optlit}
[package]{.cmd} [require]{.sub} [snit]{.lit}
[::page::util::flow]{.cmd} [start]{.arg} [flowvar]{.arg} [nodevar]{.arg} [script]{.arg}
[flow]{.ins} [visit]{.sub} [node]{.arg}
[flow]{.ins} [visitl]{.sub} [nodelist]{.arg}
[flow]{.ins} [visita]{.sub} [node...]{.arg}
:::

# Beschreibung

Dieses Paket stellt einen einzigen Hilfsbefehl bereit, der die auf dem Datenfluss beruhende Bearbeitung beliebiger Datenstrukturen, insbesondere abstrakter Syntaxbäume, erleichtert.

# API

**::page::util::flow** *start* *flowvar* *nodevar* *script*
: Dieser Befehl enthält die Kernlogik für das Durchlaufen einer beliebigen Datenstruktur, die sich in einzelne Teile zerlegen lässt. Beispiele für solche Strukturen sind Bäume und Graphen.

    Der Befehl macht keinerlei Annahmen über die API der zu durchlaufenden Struktur, außer dass ihre Teile, hier Knoten genannt, durch Zeichenketten identifiziert werden. Diese Zeichenketten werden unverändert aus den Argumenten und dem Rumpf übernommen und unverändert an den Rumpf zurückgegeben.

    Der Zugriff auf die eigentliche Datenstruktur und alle Entscheidungen, welche Knoten in welcher Reihenfolge besucht werden, werden an den Rumpf der Schleife weitergeleitet, also an das *script*.

    Der Rumpf wird zuerst für die Knoten der über *start* angegebenen Startmenge aufgerufen und danach für die Knoten, deren Besuch der Rumpf angefordert hat. Der Befehl endet, wenn die Menge der zu besuchenden Knoten leer wird. Zu beachten ist, dass ein Knoten mehrmals besucht werden kann. Darüber hat der Rumpf die vollständige Kontrolle.

    Der Rumpf wird im Kontext des Aufrufers aufgerufen. Die durch *nodevar* benannte Variable wird auf den aktuellen Knoten gesetzt, und die durch *flowvar* benannte Variable wird auf den Befehl des Flow-Objekts gesetzt, über den der Rumpf die als Nächstes zu besuchenden Knoten anfordern kann. Die API dieses Objekts beschreibt der nächste Abschnitt, [Flow-API].

    Zu beachten ist, dass der Befehl keine Zusagen über die Reihenfolge macht, in der Knoten besucht werden, außer dass die Knoten, deren Besuch die aktuelle Iteration angefordert hat, anschließend in irgendeiner Reihenfolge besucht werden.


# Flow-API

In diesem Abschnitt wird die API beschrieben, die das Flow-Objekt dem Rumpf-Skript von **::page::util::flow** bereitstellt.

*flow* **visit** *node*
: Der Aufruf dieser Methode fordert an, dass der Knoten *node* nach der aktuellen Iteration besucht wird.

*flow* **visitl** *nodelist*
: Durch den Aufruf dieser Methode wird angefordert, dass alle in der Liste *nodelist* gefundenen Knoten nach der aktuellen Iteration besucht werden.

*flow* **visita** *node*...
: Dies ist die Variante der Methode **visitl** mit variabler Argumentanzahl; siehe oben.


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
