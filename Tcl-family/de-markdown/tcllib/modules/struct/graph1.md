---
CommandName: struct::graph_v1
title: struct::graph_v1
ManualSection: n
Version: 1.2.2
TclPart: tcllib
TclDescription: Tcl Data Structures
Keywords:
 - cgraph
 - graph
Copyright:
 - Copyright (c) 2002 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

struct::graph\_v1 – Gerichtete Graphobjekte erzeugen und bearbeiten

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [struct::graph]{.lit} [1.2.2]{.optlit}
[graphName]{.cmd} [option]{.arg} [arg arg]{.optdot}
[graphName]{.ins} [destroy]{.sub}
[graphName]{.ins} [arc]{.sub} [append]{.lit} [arc]{.arg} [[-key]{.lit} [key]{.arg}]{.optarg} [value]{.arg}
[graphName]{.ins} [arc]{.sub} [delete]{.lit} [arc]{.arg} [arc]{.optdot}
[graphName]{.ins} [arc]{.sub} [exists]{.lit} [arc]{.arg}
[graphName]{.ins} [arc]{.sub} [get]{.lit} [arc]{.arg} [[-key]{.lit} [key]{.arg}]{.optarg}
[graphName]{.ins} [arc]{.sub} [getall]{.lit} [arc]{.arg}
[graphName]{.ins} [arc]{.sub} [keys]{.lit} [arc]{.arg}
[graphName]{.ins} [arc]{.sub} [keyexists]{.lit} [arc]{.arg} [[-key]{.lit} [key]{.arg}]{.optarg}
[graphName]{.ins} [arc]{.sub} [insert]{.lit} [start]{.arg} [end]{.arg} [child]{.optarg}
[graphName]{.ins} [arc]{.sub} [lappend]{.lit} [arc]{.arg} [[-key]{.lit} [key]{.arg}]{.optarg} [value]{.arg}
[graphName]{.ins} [arc]{.sub} [set]{.lit} [arc]{.arg} [[-key]{.lit} [key]{.arg}]{.optarg} [value]{.optarg}
[graphName]{.ins} [arc]{.sub} [source]{.lit} [arc]{.arg}
[graphName]{.ins} [arc]{.sub} [target]{.lit} [arc]{.arg}
[graphName]{.ins} [arc]{.sub} [unset]{.lit} [arc]{.arg} [[-key]{.lit} [key]{.arg}]{.optarg}
[graphName]{.ins} [arcs]{.sub} [[-key]{.lit} [key]{.arg}]{.optarg} [[-value]{.lit} [value]{.arg}]{.optarg} [[-in|-out|-adj|-inner|-embedding]{.lit} [nodelist]{.arg}]{.optarg}
[graphName]{.ins} [node]{.sub} [append]{.lit} [node]{.arg} [[-key]{.lit} [key]{.arg}]{.optarg} [value]{.arg}
[graphName]{.ins} [node]{.sub} [degree]{.lit} [-in|-out]{.optarg} [node]{.arg}
[graphName]{.ins} [node]{.sub} [delete]{.lit} [node]{.arg} [node]{.optdot}
[graphName]{.ins} [node]{.sub} [exists]{.lit} [node]{.arg}
[graphName]{.ins} [node]{.sub} [get]{.lit} [node]{.arg} [[-key]{.lit} [key]{.arg}]{.optarg}
[graphName]{.ins} [node]{.sub} [getall]{.lit} [node]{.arg}
[graphName]{.ins} [node]{.sub} [keys]{.lit} [node]{.arg}
[graphName]{.ins} [node]{.sub} [keyexists]{.lit} [node]{.arg} [[-key]{.lit} [key]{.arg}]{.optarg}
[graphName]{.ins} [node]{.sub} [insert]{.lit} [child]{.optarg}
[graphName]{.ins} [node]{.sub} [lappend]{.lit} [node]{.arg} [[-key]{.lit} [key]{.arg}]{.optarg} [value]{.arg}
[graphName]{.ins} [node]{.sub} [opposite]{.lit} [node]{.arg} [arc]{.arg}
[graphName]{.ins} [node]{.sub} [set]{.lit} [node]{.arg} [[-key]{.lit} [key]{.arg}]{.optarg} [value]{.optarg}
[graphName]{.ins} [node]{.sub} [unset]{.lit} [node]{.arg} [[-key]{.lit} [key]{.arg}]{.optarg}
[graphName]{.ins} [nodes]{.sub} [[-key]{.lit} [key]{.arg}]{.optarg} [[-value]{.lit} [value]{.arg}]{.optarg} [[-in|-out|-adj|-inner|-embedding]{.lit} [nodelist]{.arg}]{.optarg}
[graphName]{.ins} [get]{.sub} [[-key]{.lit} [key]{.arg}]{.optarg}
[graphName]{.ins} [getall]{.sub}
[graphName]{.ins} [keys]{.sub}
[graphName]{.ins} [keyexists]{.sub} [[-key]{.lit} [key]{.arg}]{.optarg}
[graphName]{.ins} [set]{.sub} [[-key]{.lit} [key]{.arg}]{.optarg} [value]{.optarg}
[graphName]{.ins} [swap]{.sub} [node1]{.arg} [node2]{.arg}
[graphName]{.ins} [unset]{.sub} [[-key]{.lit} [key]{.arg}]{.optarg}
[graphName]{.ins} [walk]{.sub} [node]{.arg} [[-order]{.lit} [order]{.arg}]{.optarg} [[-type]{.lit} [type]{.arg}]{.optarg} [[-dir]{.lit} [direction]{.arg}]{.optarg} -command [cmd]{.arg}
:::

# Beschreibung

*Dieses Paket ist abgelöst durch* **struct::graph** *Version 2.*

Der Befehl [::struct::graph][graph] erzeugt ein neues Graphobjekt mit einem zugehörigen globalen Tcl-Befehl namens *graphName*. Mit diesem Befehl lassen sich verschiedene Operationen auf dem Graphen ausführen. Er hat die folgende allgemeine Form:

**graphName** *option* ?*arg arg ...*?
: *Option* und die *arg*s legen das genaue Verhalten des Befehls fest.


Ein gerichteter Graph ist eine Struktur mit zwei Mengen von Elementen, *Knoten* und *Bögen*, zusammen mit einer Beziehung („Verbundenheit“), die Knoten und Bögen eine allgemeine Struktur gibt.

Jeder Bogen verbindet zwei Knoten. Einer heißt *Quelle*, der andere *Ziel*. Das gibt dem Bogen eine Richtung: Er führt von der Quelle zum Ziel. Quelle und Ziel eines Bogens dürfen derselbe Knoten sein. Ein solcher Bogen heißt *Schleife*. Ist ein Knoten Quelle oder Ziel eines Bogens, heißen beide *benachbart*. Das setzt sich in eine Beziehung zwischen Knoten fort: Sind zwei Knoten über mindestens einen Bogen verbunden, heißen auch sie *benachbart*.

Jeder Knoten kann Quelle und Ziel beliebig vieler Bögen sein. Die ersten heißen die *ausgehenden Bögen* des Knotens, die zweiten die *eingehenden Bögen* des Knotens. Die Zahl der Kanten in der jeweiligen Menge heißt der *Eingangs-* beziehungsweise der *Ausgangsgrad* des Knotens.

Neben den Beziehungen zwischen Knoten und Bögen erlaubt diese Graphimplementierung, jedem Knoten und jedem Bogen beliebig viele Schlüsselwerte zuzuordnen.

Für Graphobjekte sind die folgenden Befehle möglich:

*graphName* **destroy**
: Zerstört den Graphen, einschließlich seines Speichers und des zugehörigen Befehls.

*graphName* **arc append** *arc* ?-key *key*? *value*
: Hängt einen *value* an einen der *arc* zugeordneten Schlüsselwerte an. Ist kein *key* angegeben, gilt der Schlüssel **data**.

*graphName* **arc delete** *arc* ?*arc* ...?
: Entfernt die angegebenen Bögen aus dem Graphen.

*graphName* **arc exists** *arc*
: Gibt wahr zurück, wenn der angegebene *arc* im Graphen vorhanden ist.

*graphName* **arc get** *arc* ?-key *key*?
: Gibt den Wert zum Schlüssel *key* für *arc* zurück. Ist kein Schlüssel angegeben, gilt der Schlüssel **data**.

*graphName* **arc getall** *arc*
: Gibt eine serialisierte Liste von Schlüssel-Wert-Paaren (geeignet für \[**array set**\]) für *arc* zurück.

*graphName* **arc keys** *arc*
: Gibt eine Liste der Schlüssel von *arc* zurück.

*graphName* **arc keyexists** *arc* ?-key *key*?
: Gibt wahr zurück, wenn der angegebene *key* für *arc* existiert. Ist kein *key* angegeben, gilt der Schlüssel **data**.

*graphName* **arc insert** *start* *end* ?*child*?
: Fügt einen Bogen namens *child* in den Graphen ein, der am Knoten *start* beginnt und am Knoten *end* endet. Ist der Name des neuen Bogens nicht angegeben, erzeugt das System einen eindeutigen Namen der Form *arcx*.

*graphName* **arc lappend** *arc* ?-key *key*? *value*
: Hängt einen *value* (als Liste) an einen der *arc* zugeordneten Schlüsselwerte an. Ist kein *key* angegeben, gilt der Schlüssel **data**.

*graphName* **arc set** *arc* ?-key *key*? ?*value*?
: Setzt oder liest einen der einem Bogen zugeordneten Schlüsselwerte. Ist kein Schlüssel angegeben, gilt der Schlüssel **data**. Jedem Bogen, der einem Graphen hinzugefügt wird, wird für den Schlüssel **data** automatisch die leere Zeichenkette zugewiesen. Einem Bogen können beliebig viele Schlüsselwerte zugeordnet sein. Ist *value* nicht angegeben, gibt dieser Befehl den aktuellen Wert des Schlüssels zurück; ist *value* angegeben, weist dieser Befehl diesen Wert dem Schlüssel zu.

*graphName* **arc source** *arc*
: Gibt den Knoten zurück, an dem der angegebene *arc* beginnt.

*graphName* **arc target** *arc*
: Gibt den Knoten zurück, an dem der angegebene *arc* endet.

*graphName* **arc unset** *arc* ?-key *key*?
: Entfernt einen Schlüsselwert vom Bogen *arc*. Ist kein Schlüssel angegeben, gilt der Schlüssel **data**.

*graphName* **arcs** ?-key *key*? ?-value *value*? ?-in|-out|-adj|-inner|-embedding *nodelist*?
: Gibt eine Liste der Bögen im Graphen zurück. Ist keine Einschränkung angegeben, enthält die Liste alle Bögen. Einschränkungen können die Liste der zurückgegebenen Bögen anhand der Knoten begrenzen, die der Bogen verbindet, anhand der dem Bogen zugeordneten Schlüsselwerte oder anhand von beidem. Einschränkungen, die verbundene Knoten betreffen, haben eine Liste von Knoten als Argument, angegeben nach dem Namen der Einschränkung selbst.

    **-in**
    : Gibt eine Liste aller Bögen zurück, deren Ziel einer der Knoten in *nodelist* ist.

    **-out**
    : Gibt eine Liste aller Bögen zurück, deren Quelle einer der Knoten in *nodelist* ist.

    **-adj**
    : Gibt eine Liste aller Bögen zurück, die zu mindestens einem der Knoten in *nodelist* benachbart sind. Das ist die Vereinigung der von **-in** und **-out** zurückgegebenen Knoten.

    **-inner**
    : Gibt eine Liste aller Bögen zurück, die zu zwei der Knoten in *nodelist* benachbart sind. Das ist die Menge der Bögen im Teilgraphen, den die angegebenen Knoten aufspannen.

    **-embedding**
    : Gibt eine Liste aller Bögen zurück, die zu genau einem der Knoten in *nodelist* benachbart sind. Das ist die Menge der Bögen, die den von den angegebenen Knoten aufgespannten Teilgraphen mit dem Rest des Graphen verbinden.

    **-key** *key*
    : Beschränkt die Liste der zurückgegebenen Bögen auf die Bögen, die einen zugeordneten Schlüssel *key* haben.

    **-value** *value*
    : Diese Einschränkung ist nur zusammen mit **-key** verwendbar. Sie beschränkt die Liste der zurückgegebenen Bögen auf die Bögen, deren zugehöriger Schlüssel *key* den Wert *value* hat.


    Die Einschränkungen durch **-in**, **-out**, **-adj**, **-inner** oder **-embedded** werden zuerst angewandt. Mehr als eine davon anzugeben, ist unzulässig. Zuletzt werden die Einschränkungen über **-key** (und **-value**) angewandt. Mehr als einen **-key** (und **-value**) anzugeben, ist unzulässig.

*graphName* **node append** *node* ?-key *key*? *value*
: Hängt einen *value* an einen der *node* zugeordneten Schlüsselwerte an. Ist kein *key* angegeben, gilt der Schlüssel **data**.

*graphName* **node degree** ?-in|-out? *node*
: Gibt die Zahl der zum angegebenen *node* benachbarten Bögen zurück. Ist eine der Einschränkungen **-in** oder **-out** angegeben, werden nur die eingehenden beziehungsweise ausgehenden Bögen gezählt.

*graphName* **node delete** *node* ?*node* ...?
: Entfernt die angegebenen Knoten aus dem Graphen. Alle Bögen dieser Knoten werden ebenfalls entfernt, damit keine unverbundenen Bögen bleiben.

*graphName* **node exists** *node*
: Gibt wahr zurück, wenn der angegebene *node* im Graphen vorhanden ist.

*graphName* **node get** *node* ?-key *key*?
: Gibt den Wert zum Schlüssel *key* für *node* zurück. Ist kein Schlüssel angegeben, gilt der Schlüssel **data**.

*graphName* **node getall** *node*
: Gibt eine serialisierte Liste von Schlüssel-Wert-Paaren (geeignet für \[**array set**\]) für *node* zurück.

*graphName* **node keys** *node*
: Gibt eine Liste der Schlüssel von *node* zurück.

*graphName* **node keyexists** *node* ?-key *key*?
: Gibt wahr zurück, wenn der angegebene *key* für *node* existiert. Ist kein *key* angegeben, gilt der Schlüssel **data**.

*graphName* **node insert** ?*child*?
: Fügt einen Knoten namens *child* in den Graphen ein. Der Knoten hat keine Bögen. Ist der Name des neuen Knotens nicht angegeben, erzeugt das System einen eindeutigen Namen der Form *nodex*.

*graphName* **node lappend** *node* ?-key *key*? *value*
: Hängt einen *value* (als Liste) an einen der *node* zugeordneten Schlüsselwerte an. Ist kein *key* angegeben, gilt der Schlüssel **data**.

*graphName* **node opposite** *node* *arc*
: Gibt den Knoten am anderen Ende des angegebenen *arc* zurück. Dieser Bogen muss zum angegebenen *node* benachbart sein.

*graphName* **node set** *node* ?-key *key*? ?*value*?
: Setzt oder liest einen der einem Knoten zugeordneten Schlüsselwerte. Ist kein Schlüssel angegeben, gilt der Schlüssel **data**. Jedem Knoten, der einem Graphen hinzugefügt wird, wird für den Schlüssel **data** automatisch die leere Zeichenkette zugewiesen. Ein Knoten kann beliebig viele zugeordnete Schlüsselwerte haben. Ist *value* nicht angegeben, gibt dieser Befehl den aktuellen Wert des Schlüssels zurück; ist *value* angegeben, weist dieser Befehl diesen Wert dem Schlüssel zu.

*graphName* **node unset** *node* ?-key *key*?
: Entfernt einen Schlüsselwert vom Knoten *node*. Ist kein Schlüssel angegeben, gilt der Schlüssel **data**.

*graphName* **nodes** ?-key *key*? ?-value *value*? ?-in|-out|-adj|-inner|-embedding *nodelist*?
: Gibt eine Liste der Knoten im Graphen zurück. Einschränkungen können die Liste der zurückgegebenen Knoten anhand benachbarter Knoten oder anhand der dem Knoten zugeordneten Schlüsselwerte begrenzen. Einschränkungen, die benachbarte Knoten betreffen, haben eine Liste von Knoten als Argument, angegeben nach dem Namen der Einschränkung selbst.

    Die möglichen Einschränkungen sind dieselben wie bei der Methode **arcs**. Die zurückzugebende Knotenmenge wird als Vereinigung aller Quell- und Zielknoten aller Bögen berechnet, die die für **arcs** festgelegte Einschränkung erfüllen.

*graphName* **get** ?-key *key*?
: Gibt den Wert zum Schlüssel *key* für den Graphen zurück. Ist kein Schlüssel angegeben, gilt der Schlüssel **data**.

*graphName* **getall**
: Gibt eine serialisierte Liste von Schlüssel-Wert-Paaren (geeignet für \[**array set**\]) für den gesamten Graphen zurück.

*graphName* **keys**
: Gibt eine Liste der Schlüssel für den gesamten Graphen zurück.

*graphName* **keyexists** ?-key *key*?
: Gibt wahr zurück, wenn der angegebene *key* für den gesamten Graphen existiert. Ist kein *key* angegeben, gilt der Schlüssel **data**.

*graphName* **set** ?-key *key*? ?*value*?
: Setzt oder liest einen der einem Graphen zugeordneten Schlüsselwerte. Ist kein Schlüssel angegeben, gilt der Schlüssel **data**. Jedem Graphen wird für den Schlüssel **data** automatisch die leere Zeichenkette zugewiesen. Ein Graph kann beliebig viele zugeordnete Schlüsselwerte haben. Ist *value* nicht angegeben, gibt dieser Befehl den aktuellen Wert des Schlüssels zurück; ist *value* angegeben, weist dieser Befehl diesen Wert dem Schlüssel zu.

*graphName* **swap** *node1* *node2*
: Vertauscht die Position von *node1* und *node2* im Graphen.

*graphName* **unset** ?-key *key*?
: Entfernt einen Schlüsselwert vom Graphen. Ist kein Schlüssel angegeben, gilt der Schlüssel **data**.

*graphName* **walk** *node* ?-order *order*? ?-type *type*? ?-dir *direction*? -command *cmd*
: Führt einen Breiten- oder Tiefendurchlauf des Graphen aus, beginnend beim Knoten *node*, entweder in Richtung der ausgehenden Bögen oder entgegengesetzt zu den eingehenden Bögen.

    Den Typ des Durchlaufs, Breite zuerst oder Tiefe zuerst, legt der Wert von *type* fest; **bfs** bedeutet Breite zuerst, **dfs** bedeutet Tiefe zuerst. Tiefe zuerst ist die Vorgabe.

    Die Ordnung des Durchlaufs, Vorordnung, Nachordnung oder beide Ordnungen, legt der Wert von *order* fest; **pre** bedeutet Vorordnung, **post** bedeutet Nachordnung, **both** bedeutet beide Ordnungen. Vorordnung ist die Vorgabe. Vorordnung heißt, ein Knoten wird besucht, bevor einer seiner Nachbarn besucht wird (festgelegt durch *direction*, siehe unten). Nachordnung heißt, ein Elternknoten wird besucht, nachdem seine Nachbarn besucht wurden. Bei beiden Ordnungen wird ein Knoten vor *und* nach seinen Nachbarn besucht. Die Kombination eines Breitendurchlaufs mit Nachordnung oder beiden Ordnungen ist unzulässig.

    Die Richtung des Durchlaufs legt der Wert von *dir* fest; **backward** bedeutet die Gegenrichtung der eingehenden Bögen, **forward** die Richtung der ausgehenden Bögen.

    Im Verlauf des Durchlaufs wird der Befehl *cmd* an jedem Knoten ausgewertet, und der Modus des Aufrufs (**enter** oder **leave**) sowie die Werte *graphName* und der Name des aktuellen Knotens werden angehängt. Bei einem Durchlauf in Vorordnung werden alle Knoten betreten (**enter**), bei einem Durchlauf in Nachordnung werden alle Knoten verlassen. Bei beiden Ordnungen wird der Knoten beim ersten Besuch betreten (**enter**) und beim zweiten Besuch verlassen (**leave**).


# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *struct :: graph* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Datenstrukturen

# Copyright

```
Copyright (c) 2002 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```


[graph]: graph.md
