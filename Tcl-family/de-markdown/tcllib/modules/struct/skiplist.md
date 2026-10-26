---
CommandName: struct::skiplist
title: struct::skiplist
ManualSection: n
Version: 1.4
TclPart: tcllib
TclDescription: Tcl Data Structures
Keywords:
 - skiplist
Copyright:
 - Copyright (c) 2000 Keith Vetter
---

# Name

struct::skiplist – Skiplisten anlegen und bearbeiten

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [struct::skiplist]{.lit} [1.4]{.optlit}
[skiplistName]{.cmd} [option]{.arg} [arg arg]{.optdot}
[skiplistName]{.ins} [delete]{.sub} [node]{.arg} [node...]{.optarg}
[skiplistName]{.ins} [destroy]{.sub}
[skiplistName]{.ins} [insert]{.sub} [key]{.arg} [value]{.arg}
[skiplistName]{.ins} [search]{.sub} [node]{.arg} [[-key]{.lit} [key]{.arg}]{.optarg}
[skiplistName]{.ins} [size]{.sub}
[skiplistName]{.ins} [walk]{.sub} [cmd]{.arg}
:::

# Beschreibung

Der Befehl **::struct::skiplist** erzeugt ein neues Skiplist-Objekt mit einem zugehörigen globalen Tcl-Befehl, dessen Name *skiplistName* lautet. Mit diesem Befehl lassen sich verschiedene Operationen auf der Skiplist aufrufen. Er hat die folgende allgemeine Form:

**skiplistName** *option* ?*arg arg ...*?
: *Option* und die *arg*s bestimmen das genaue Verhalten des Befehls.


Skiplisten sind eine Alternative zu Binärbäumen als Datenstruktur. Mit ihnen lassen sich geordnete Listen über beliebige Folgen von Einfügungen und Löschungen hinweg pflegen. Skiplisten erreichen durch Zufall eine probabilistische Balancierung; daher sind die Algorithmen zum Einfügen und Löschen in Skiplisten wesentlich einfacher und schneller als die für Binärbäume.

Mehr zu Skiplisten finden Sie bei Pugh, William. *Skip lists: a probabilistic alternative to balanced trees* In: Communications of the ACM, Juni 1990, 33(6) 668–676.

Derzeit kann der Schlüssel entweder eine Zahl oder eine Zeichenkette sein, und Vergleiche werden mit dem eingebauten Größer-als-Operator durchgeführt. Für Skiplist-Objekte sind folgende Befehle möglich:

*skiplistName* **delete** *node* ?*node*...?
: Entfernt die angegebenen Knoten aus der Skiplist.

*skiplistName* **destroy**
: Zerstört die Skiplist einschließlich ihres Speichers und des zugehörigen Befehls.

*skiplistName* **insert** *key value*
: Fügt einen Knoten mit dem angegebenen *key* und *value* in die Skiplist ein. Gibt es bereits einen Knoten mit diesem Schlüssel, wird dessen Wert aktualisiert und seine Knotenebene zurückgegeben. Andernfalls wird ein neuer Knoten angelegt und 0 zurückgegeben.

*skiplistName* **search** *node* ?**-key** *key*?
: Sucht einen bestimmten Schlüssel in der Skiplist. Wird er nicht gefunden, wird 0 zurückgegeben. Wird er gefunden, wird eine Liste aus zwei Elementen zurückgegeben: 1, gefolgt vom Wert des Knotens.

*skiplistName* **size**
: Gibt die Anzahl der Knoten in der Skiplist zurück.

*skiplistName* **walk** *cmd*
: Durchläuft die Skiplist vom ersten Knoten bis zum letzten. An jedem Knoten wird der Befehl *cmd* ausgewertet, mit Schlüssel und Wert des aktuellen Knotens als angehängten Argumenten.


# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *struct :: skiplist* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Datenstrukturen

# Copyright

```
Copyright (c) 2000 Keith Vetter
```
