---
CommandName: struct::graph
title: struct::graph
ManualSection: n
Version: 2.4.4
TclPart: tcllib
TclDescription: Tcl Data Structures
Keywords:
 - adjacent
 - arc
 - cgraph
 - degree
 - edge
 - graph
 - loop
 - neighbour
 - node
 - serialization
 - subgraph
 - vertex
Copyright:
 - Copyright (c) 2002-2009,2019 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

struct::graph – Gerichtete Graphobjekte erzeugen und bearbeiten

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [struct::graph]{.lit} [2.4.4]{.optlit}
[package]{.cmd} [require]{.sub} [struct::list]{.lit} [1.8.6]{.optlit}
[package]{.cmd} [require]{.sub} [struct::set]{.lit} [2.2.4]{.optlit}
[::struct::graph]{.cmd} [aGraph]{.optarg} [[=|:=|as|deserialize]{.lit} [source]{.arg}]{.optarg}
[aGraph]{.ins} [=]{.sub} [sourceGraph]{.arg}
[aGraph]{.ins} [-->]{.sub} [destGraph]{.arg}
[aGraph]{.ins} [append]{.sub} [key]{.arg} [value]{.arg}
[aGraph]{.ins} [deserialize]{.sub} [serialization]{.arg}
[aGraph]{.ins} [destroy]{.sub}
[aGraph]{.ins} [arc]{.sub} [append]{.lit} [arc]{.arg} [key]{.arg} [value]{.arg}
[aGraph]{.ins} [arc]{.sub} [attr]{.lit} [key]{.arg}
[aGraph]{.ins} [arc]{.sub} [attr]{.lit} [key]{.arg} [-arcs]{.lit} [list]{.arg}
[aGraph]{.ins} [arc]{.sub} [attr]{.lit} [key]{.arg} [-glob]{.lit} [globpattern]{.arg}
[aGraph]{.ins} [arc]{.sub} [attr]{.lit} [key]{.arg} [-regexp]{.lit} [repattern]{.arg}
[aGraph]{.ins} [arc]{.sub} [delete]{.lit} [arc]{.arg} [arc]{.optdot}
[aGraph]{.ins} [arc]{.sub} [exists]{.lit} [arc]{.arg}
[aGraph]{.ins} [arc]{.sub} [flip]{.lit} [arc]{.arg}
[aGraph]{.ins} [arc]{.sub} [get]{.lit} [arc]{.arg} [key]{.arg}
[aGraph]{.ins} [arc]{.sub} [getall]{.lit} [arc]{.arg} [glob]{.optarg}
[aGraph]{.ins} [arc]{.sub} [getunweighted]{.lit}
[aGraph]{.ins} [arc]{.sub} [getweight]{.lit} [arc]{.arg}
[aGraph]{.ins} [arc]{.sub} [keys]{.lit} [arc]{.arg} [glob]{.optarg}
[aGraph]{.ins} [arc]{.sub} [keyexists]{.lit} [arc]{.arg} [key]{.arg}
[aGraph]{.ins} [arc]{.sub} [insert]{.lit} [start]{.arg} [end]{.arg} [name]{.optarg}
[aGraph]{.ins} [arc]{.sub} [lappend]{.lit} [arc]{.arg} [key]{.arg} [value]{.arg}
[aGraph]{.ins} [arc]{.sub} [rename]{.lit} [arc]{.arg} [newname]{.arg}
[aGraph]{.ins} [arc]{.sub} [set]{.lit} [arc]{.arg} [key]{.arg} [value]{.optarg}
[aGraph]{.ins} [arc]{.sub} [setunweighted]{.lit} [weight]{.optarg}
[aGraph]{.ins} [arc]{.sub} [setweight]{.lit} [arc]{.arg} [weight]{.arg}
[aGraph]{.ins} [arc]{.sub} [unsetweight]{.lit} [arc]{.arg}
[aGraph]{.ins} [arc]{.sub} [hasweight]{.lit} [arc]{.arg}
[aGraph]{.ins} [arc]{.sub} [source]{.lit} [arc]{.arg}
[aGraph]{.ins} [arc]{.sub} [target]{.lit} [arc]{.arg}
[aGraph]{.ins} [arc]{.sub} [nodes]{.lit} [arc]{.arg}
[aGraph]{.ins} [arc]{.sub} [move-source]{.lit} [arc]{.arg} [newsource]{.arg}
[aGraph]{.ins} [arc]{.sub} [move-target]{.lit} [arc]{.arg} [newtarget]{.arg}
[aGraph]{.ins} [arc]{.sub} [move]{.lit} [arc]{.arg} [newsource]{.arg} [newtarget]{.arg}
[aGraph]{.ins} [arc]{.sub} [unset]{.lit} [arc]{.arg} [key]{.arg}
[aGraph]{.ins} [arc]{.sub} [weights]{.lit}
[aGraph]{.ins} [arcs]{.sub} [[-key]{.lit} [key]{.arg} [[-value]{.lit} [value]{.arg}]{.optarg}]{.optarg} [[-filter]{.lit} [cmdprefix]{.arg}]{.optarg} [[-in|-out|-adj|-inner|-embedding]{.lit} [node]{.arg} ?node]{.optarg} ...?
[aGraph]{.ins} [lappend]{.sub} [key]{.arg} [value]{.arg}
[aGraph]{.ins} [node]{.sub} [append]{.lit} [node]{.arg} [key]{.arg} [value]{.arg}
[aGraph]{.ins} [node]{.sub} [attr]{.lit} [key]{.arg}
[aGraph]{.ins} [node]{.sub} [attr]{.lit} [key]{.arg} [-nodes]{.lit} [list]{.arg}
[aGraph]{.ins} [node]{.sub} [attr]{.lit} [key]{.arg} [-glob]{.lit} [globpattern]{.arg}
[aGraph]{.ins} [node]{.sub} [attr]{.lit} [key]{.arg} [-regexp]{.lit} [repattern]{.arg}
[aGraph]{.ins} [node]{.sub} [degree]{.lit} [-in|-out]{.optarg} [node]{.arg}
[aGraph]{.ins} [node]{.sub} [delete]{.lit} [node]{.arg} [node...]{.optarg}
[aGraph]{.ins} [node]{.sub} [exists]{.lit} [node]{.arg}
[aGraph]{.ins} [node]{.sub} [get]{.lit} [node]{.arg} [key]{.arg}
[aGraph]{.ins} [node]{.sub} [getall]{.lit} [node]{.arg} [glob]{.optarg}
[aGraph]{.ins} [node]{.sub} [keys]{.lit} [node]{.arg} [glob]{.optarg}
[aGraph]{.ins} [node]{.sub} [keyexists]{.lit} [node]{.arg} [key]{.arg}
[aGraph]{.ins} [node]{.sub} [insert]{.lit} [node...]{.optarg}
[aGraph]{.ins} [node]{.sub} [lappend]{.lit} [node]{.arg} [key]{.arg} [value]{.arg}
[aGraph]{.ins} [node]{.sub} [opposite]{.lit} [node]{.arg} [arc]{.arg}
[aGraph]{.ins} [node]{.sub} [rename]{.lit} [node]{.arg} [newname]{.arg}
[aGraph]{.ins} [node]{.sub} [set]{.lit} [node]{.arg} [key]{.arg} [value]{.optarg}
[aGraph]{.ins} [node]{.sub} [unset]{.lit} [node]{.arg} [key]{.arg}
[aGraph]{.ins} [nodes]{.sub} [[-key]{.lit} [key]{.arg}]{.optarg} [[-value]{.lit} [value]{.arg}]{.optarg} [[-filter]{.lit} [cmdprefix]{.arg}]{.optarg} [[-in|-out|-adj|-inner|-embedding]{.lit} [node]{.arg} [node...]{.arg}]{.optarg}
[aGraph]{.ins} [get]{.sub} [key]{.arg}
[aGraph]{.ins} [getall]{.sub} [pattern]{.optarg}
[aGraph]{.ins} [keys]{.sub} [pattern]{.optarg}
[aGraph]{.ins} [keyexists]{.sub} [key]{.arg}
[aGraph]{.ins} [serialize]{.sub} [node...]{.optarg}
[aGraph]{.ins} [set]{.sub} [key]{.arg} [value]{.optarg}
[aGraph]{.ins} [swap]{.sub} [node1]{.arg} [node2]{.arg}
[aGraph]{.ins} [unset]{.sub} [key]{.arg}
[aGraph]{.ins} [walk]{.sub} [node]{.arg} [[-type]{.lit} [type]{.arg}]{.optarg} [[-order]{.lit} [order]{.arg}]{.optarg} [[-dir]{.lit} [direction]{.arg}]{.optarg} -command [cmd]{.arg}
:::

# Beschreibung

Ein gerichteter Graph ist eine Datenstruktur mit zwei Mengen von Elementen, *Knoten* und *Bögen* (auch *Kanten* genannt), sowie einer Beziehung, die Knoten und Bögen verbindet.

Jeder Bogen verbindet zwei Knoten. Einer heißt *Quelle*, der andere *Ziel*. Das gibt dem Bogen eine Richtung: Er führt von der Quelle zum Ziel. Sind Quelle und Ziel derselbe Knoten, heißt der Bogen eine *Schleife*.

Ist ein Knoten Quelle oder Ziel eines Bogens, heißen Knoten und Bogen *benachbart*. Sind zwei Knoten über einen oder mehrere Bögen verbunden, heißen auch die Knoten *benachbart*.

Ein Knoten kann Quelle beliebig vieler *ausgehender Bögen* und Ziel beliebig vieler *eingehender Bögen* sein. Die Zahl der *ausgehenden Bögen* ist der *Ausgangsgrad* des Knotens, die Zahl der *eingehenden Bögen* der *Eingangsgrad*.

Das Paket **struct::graph** verwaltet Graphen aus Knoten, Bögen und ihren Beziehungen. Zusätzlich lassen sich beliebig viele benannte *Attribute* mit dem Graphen selbst und mit jedem seiner Knoten und Bögen verbinden.

Befehle für eine große Zahl üblicher Graphalgorithmen stehen im Paket **struct::graph::ops**.

*Hinweis:* Die Hauptversion von **struct::graph** ist auf Version 2 gewechselt, weil sich die API des Moduls inkompatibel geändert hat. Wer Version 1 nutzt, liest den Abschnitt [Änderungen für v2]. Dort steht die vollständige Liste der Änderungen, einschließlich der Inkompatibilitäten mit Version 1.

Ab Version 2.2 gibt es eine C-Implementierung auf critcl-Basis. Sie verlangt Tcl 8.4 oder neuer.

# API

**::struct::graph** ?*aGraph*? ?**=**|**:=**|**as**|**deserialize** *source*?
: Dieser Befehl erzeugt ein neues Graphobjekt mit einem zugehörigen globalen Tcl-Befehl. Ist *aGraph* angegeben, trägt der globale Befehl diesen Namen; sonst erzeugt das Paket einen eindeutigen Namen.

    Ist eine *source* angegeben, wird der neue Graph daraus initialisiert. Bei den Operatoren **=**, **:=** und **as** ist das Argument *source* der Name eines anderen Graphobjekts, und der Zuweisungsoperator **=** wird ausgeführt. Beim Operator **deserialize** gilt *source* als serialisiertes Graphobjekt, und **deserialize** wird ausgeführt.

    Zum Beispiel:

    ```
        ::struct::graph graphA = graphB
    ```

    entspricht

    ```
        ::struct::graph graphA
        graphA = graphB
    ```

    und

    ```
        ::struct::graph graphA deserialize $graphB
    ```

    entspricht

    ```
        ::struct::graph graphA
        graphA deserialize $graphB
    ```

    Sobald das Graphobjekt und der zugehörige Befehl erzeugt sind, dient der Befehl den verschiedenen Graphoperationen. Sie haben alle dieselbe allgemeine Form:

    *aGraph* *method* ?*arg ...*?

    Die *method* und die *arg*s legen fest, welche Operation ausgeführt wird.


## Methoden

*aGraph* **=** *sourceGraph*
: Der Operator **=** ist der *Zuweisungs*operator für Graphobjekte. Er kopiert den Graphen aus dem Graphobjekt *sourceGraph* über die Graphdaten in *aGraph*. Der bisherige Inhalt von *aGraph* wird dabei gelöscht.

    Die Operation entspricht praktisch

    ```
        aGraph deserialize [sourceGraph serialize]
    ```

    Die Operation setzt voraus, dass *sourceGraph* eine Methode **serialize** bereitstellt, die eine gültige Graphserialisierung zurückgibt.

*aGraph* **-->** *destGraph*
: Der Operator **-->** ist der Operator der *umgekehrten Zuweisung* für Graphobjekte. Er kopiert den Graphen aus dem Graphobjekt *aGraph* über die Graphdaten im Objekt *destGraph*. Der bisherige Inhalt von *destGraph* wird dabei gelöscht.

    Die Operation entspricht praktisch

    ```
        destGraph deserialize [aGraph serialize]
    ```

    Die Operation setzt voraus, dass *destGraph* eine Methode **deserialize** bereitstellt, die eine Graphserialisierung entgegennimmt, und dass *aGraph* eine Methode **serialize** bereitstellt, die eine gültige Graphserialisierung zurückgibt.

*aGraph* **append** *key* *value*
: Hängt *value* an das Graphattribut zum angegebenen *key* an. Gibt den neuen Wert des Graphattributs zu *key* zurück.

*aGraph* **deserialize** *serialization*
: Das ist das Gegenstück zur Methode **serialize**. Sie ersetzt die Graphdaten in *aGraph* durch den Graphen, den der Wert *serialization* beschreibt. Der bisherige Inhalt von *aGraph* wird dabei gelöscht.

*aGraph* **destroy**
: Zerstört den Graphen, einschließlich seines Speichers und des zugehörigen Befehls.

*aGraph* **arc append** *arc* *key* *value*
: Hängt *value* an das Attribut des angegebenen *arc* zum angegebenen *key* an. Gibt den neuen Wert des Attributs von *arc* zu *key* zurück.

*aGraph* **arc attr** *key*
: siehe unten ...

*aGraph* **arc attr** *key* **-arcs** *list*
: siehe unten ...

*aGraph* **arc attr** *key* **-glob** *globpattern*
: siehe unten ...

*aGraph* **arc attr** *key* **-regexp** *repattern*
: Sind keine Optionen angegeben, gibt die Methode **arc attr** ein **dict** zurück, dessen Schlüssel die Namen *jedes* Bogens im Graphen *aGraph* sind. Zu jedem Schlüssel dieses **dict** ist der zugehörige Wert der Wert des Bogenattributs zum angegebenen *key*. Bögen ohne diesen *key* fehlen im Ergebnis-**dict**.

    Ist eine der Optionen angegeben, entsteht praktisch dasselbe Ergebnis-**dict** wie ohne Optionen, gefiltert auf die Bögen, die der Einschränkung der Option entsprechen.

    Die möglichen Einschränkungen sind:

    **-arcs**
    : Der Wert muss eine Liste von Bogennamen sein. Nur die in dieser Liste genannten Bögen werden nach dem Attribut *key* durchsucht.

    **-glob**
    : Der Wert ist ein Glob-Muster. Nur die Bögen im Graphen, deren Namen diesem Muster entsprechen, werden nach dem Attribut *key* durchsucht.

    **-regexp**
    : Der Wert ist ein regulärer Ausdruck. Nur die Bögen im Graphen, deren Namen diesem Muster entsprechen, werden nach dem Attribut *key* durchsucht.


*aGraph* **arc delete** *arc* ?*arc* ...?
: Entfernt die angegebenen Bögen aus dem Graphen.

    Existiert einer der Bögen nicht, wird ein Fehler ausgelöst.

*aGraph* **arc exists** *arc*
: Gibt **1** (wahr) zurück, wenn der angegebene *arc* im Graphen vorhanden ist, sonst **0** (falsch).

*aGraph* **arc flip** *arc*
: Kehrt die Richtung von *arc* um, das heißt, Quell- und Zielknoten des Bogens werden vertauscht.

*aGraph* **arc get** *arc* *key*
: Gibt den Wert zu *key* von *arc* zurück.

    Existiert *arc* nicht oder existiert *key* nicht, wird ein Fehler ausgelöst.

*aGraph* **arc getall** *arc* ?*glob*?
: Gibt ein Dictionary (geeignet für \[**array set**\]) der Attributschlüssel und -werte von *arc* zurück.

    Ist ein *glob*-Muster angegeben, werden nur die Attribute aufgenommen, deren Schlüssel passen.

*aGraph* **arc getunweighted**
: Gibt eine Liste der Namen aller Bögen des Graphen zurück, denen *kein* Gewicht zugeordnet ist.

*aGraph* **arc getweight** *arc*
: Gibt das *arc* zugeordnete Gewicht zurück.

    Existiert *arc* nicht oder hat er kein Gewicht, wird ein Fehler ausgelöst.

*aGraph* **arc keys** *arc* ?*glob*?
: Gibt eine Liste der Schlüssel von *arc* zurück.

    Ist *glob* angegeben, gehören nur die Attribute zur Liste, deren Namen zum Glob passen.

*aGraph* **arc keyexists** *arc* *key*
: Gibt **1** (wahr) zurück, wenn *arc* den angegebenen *key* hat, sonst **0** (falsch).

*aGraph* **arc insert** *start* *end* ?*name*?
: Fügt einen Bogen in den Graphen ein, der am Knoten *start* beginnt und am Knoten *end* endet. Der neue Bogen heißt *name*, wenn das angegeben ist; sonst wird ein eindeutiger, vom System erzeugter Name der Form *arcx* verwendet.

*aGraph* **arc lappend** *arc* *key* *value*
: Hängt den angegebenen *value* (als Liste) an den Wert zu *key* von *arc* an und gibt den neuen Wert von *key* von *arc* zurück.

*aGraph* **arc rename** *arc* *newname*
: Benennt *arc* in *newname* um und gibt *newname* zurück.

    Löst einen Fehler aus, wenn der angegebene *arc* nicht existiert oder bereits ein Bogen namens *newname* existiert.

*aGraph* **arc set** *arc* *key* ?*value*?
: Liest oder setzt den Wert des *arc* zugeordneten *key*.

    Ist *value* *nicht* angegeben, wird der Wert des *arc* zugeordneten *key* zurückgegeben. Ist ein *value* angegeben, wird dieser *value* dem angegebenen *key* zugewiesen, und der Wert des *arc* zugeordneten *key* wird zurückgegeben.

    Einem Bogen können beliebig viele Schlüssel-Wert-Paare zugeordnet sein.

*aGraph* **arc setunweighted** ?*weight*?
: Setzt das Gewicht aller Bögen ohne Gewicht auf *weight*. Ist kein *weight* angegeben, ist die Vorgabe **0**. Gibt die leere Zeichenkette zurück.

*aGraph* **arc setweight** *arc* *weight*
: Setzt das Gewicht von *arc* auf *weight* und gibt *weight* zurück.

*aGraph* **arc unsetweight** *arc*
: Entfernt das Gewicht von *arc*, falls vorhanden; sonst geschieht nichts. Gibt die leere Zeichenkette zurück.

*aGraph* **arc hasweight** *arc*
: Gibt **1** (wahr) zurück, wenn *arc* ein Gewicht hat, sonst **0** (falsch).

*aGraph* **arc source** *arc*
: Gibt den Knoten zurück, an dem der angegebene *arc* beginnt.

*aGraph* **arc target** *arc*
: Gibt den Knoten zurück, an dem der angegebene *arc* endet.

*aGraph* **arc nodes** *arc*
: Gibt eine zweielementige Liste der Knoten zurück, an denen der angegebene *arc* beginnt und endet.

*aGraph* **arc move-source** *arc* *newsource*
: Setzt den Quellknoten von *arc* auf *newsource*. Das lässt sich als Drehen des Bogens um seinen Zielknoten beschreiben.

*aGraph* **arc move-target** *arc* *newtarget*
: Setzt den Zielknoten von *arc* auf *newtarget*. Das lässt sich als Drehen des Bogens um seinen Quellknoten beschreiben.

*aGraph* **arc move** *arc* *newsource* *newtarget*
: Setzt Quell- und Zielknoten von *arc* auf *newsource* beziehungsweise *newtarget*.

*aGraph* **arc unset** *arc* *key*
: Entfernt *key* von *arc* und den zugehörigen Wert. Es geschieht nichts, wenn *key* nicht existiert.

*aGraph* **arc weights**
: Gibt ein **dict** zurück, in dem jeder Schlüssel der Name eines Bogens mit Gewicht ist und jeder zugehörige Wert das Gewicht dieses Bogens.

*aGraph* **arcs** ?-key *key* ?-value *value*?? ?-filter *cmdprefix*? ?-in|-out|-adj|-inner|-embedding *node* ?node? ...?
: Gibt eine Liste der Bögen des Graphen zurück.

    Ist keine Einschränkung angegeben, steht jeder Bogen in der Liste.

    *Einschränkungen*

    Einschränkungen können begrenzen, welche Bögen in die Liste kommen: anhand der Knoten, die der Bogen verbindet, anhand der dem Bogen zugeordneten Schlüsselwerte oder anhand von beidem. Ein allgemeiner Filterbefehl ist ebenfalls möglich. Einschränkungen, die verbundene Knoten betreffen, nehmen eine variable Zahl von Knoten als Argument, angegeben nach dem Namen der Einschränkung selbst.

    Höchstens eine Einschränkung **-key** darf angegeben werden, und wenn sie vorhanden ist, höchstens eine Einschränkung **-value**. **key** (und, falls vorhanden, **-value**) wird, wenn angegeben, *als Zweites* angewandt. (Werden zwei oder mehr Optionen **-key** verwendet oder wird **-value** ohne zugehörigen **key** verwendet, wird ein Fehler ausgelöst.)

    **-key** *key*
    : Gibt nur Bögen zurück, die den zugeordneten *key* haben.

    **-value** *value*
    : Gibt nur Bögen zurück, die den zugeordneten *key* haben (der *zwingend* mit der Option **-key** anzugeben ist), *und* bei denen der Wert von *key* gleich *value* ist.


    Höchstens ein Befehl **-filter** darf angegeben werden, und wenn er vorhanden ist, wird er *zuletzt* angewandt. (Werden zwei oder mehr Optionen **-filter** verwendet, wird ein Fehler ausgelöst.)

    **-filter** *cmdprefix*
    : Gibt nur Bögen zurück, für die das angegebene *cmdprefix* **1** (wahr) zurückgibt.

        Für jeden in Frage kommenden Bogen wird *cmdprefix* im Kontext des Aufrufers ausgeführt. Es wird mit zwei Argumenten aufgerufen: dem Namen des Graphobjekts und dem Namen des in Frage kommenden Bogens. Der Befehl *cmdprefix* soll entweder **1** (wahr; den Bogen in der zurückzugebenden Liste behalten) oder **0** (falsch; den Bogen aus der zurückzugebenden Liste entfernen) zurückgeben.


    Höchstens eine Einschränkung darf mit einem von **-in**, **-out**, **-adj**, **-inner** oder **-embedding** angegeben werden. Ist eine davon vorhanden, wird sie *zuerst* angewandt. (Werden zwei oder mehr dieser Optionen verwendet, wird ein Fehler ausgelöst.)

    **-in**
    : Gibt nur Bögen zurück, deren Ziel einer der angegebenen Knoten ist. Mit anderen Worten: die Vereinigung aller eingehenden Bögen der angegebenen Knoten.

    **-out**
    : Gibt nur Bögen zurück, deren Quelle einer der angegebenen Knoten ist. Mit anderen Worten: die Vereinigung aller ausgehenden Bögen der angegebenen Knoten.

    **-adj**
    : Gibt nur Bögen zurück, die zu mindestens einem der angegebenen Knoten benachbart sind. Mit anderen Worten: die Vereinigung aller eingehenden *und* ausgehenden Bögen der angegebenen Knoten (also die Vereinigung von **-in** und **-out**).

    **-inner**
    : Gibt nur Bögen zurück, die zu zwei der angegebenen Knoten benachbart sind. Das ist die Menge der Bögen im Teilgraphen, den die angegebenen Knoten bilden.

    **-embedding**
    : Gibt nur Bögen zurück, die zu genau einem der angegebenen Knoten benachbart sind. Das ist die Menge der Bögen, die den Teilgraphen der angegebenen Knoten mit dem Rest des Graphen verbinden.


    *Hinweis*: Nach der Angabe einer der obigen Optionen wird jedes Wort mit führendem Bindestrich, das keine gültige Option ist, als Knotenname behandelt und nicht als ungültige Option. Das gilt, bis entweder eine gültige Option die Knotenliste beendet oder das Ende des Befehls erreicht ist, je nachdem, was zuerst eintritt.

*aGraph* **lappend** *key* *value*
: Hängt *value* (als Liste) an das Graphattribut zum angegebenen *key* an und gibt das Attribut mit dem neuen Wert von *key* zurück.

*aGraph* **node append** *node* *key* *value*
: Hängt *value* an das Attribut von *node* zum angegebenen *key* an und gibt das Attribut mit dem neuen Wert von *key* zurück.

*aGraph* **node attr** *key*
: siehe unten ...

*aGraph* **node attr** *key* **-nodes** *list*
: siehe unten ...

*aGraph* **node attr** *key* **-glob** *globpattern*
: siehe unten ...

*aGraph* **node attr** *key* **-regexp** *repattern*
: Gibt ein **dict** zurück, dessen Schlüssel Knotennamen sind und dessen zugehörige Werte die Attributwerte dieser Knoten zum angegebenen *key* sind.

    Das zurückgegebene **dict** enthält alle Knoten des Graphen, die den angegebenen *key* haben, *oder*, wenn eine optionale Einschränkung angegeben ist, die Teilmenge dieser Knoten, die der Einschränkung entsprechen. Knoten, die den angegebenen *key* *nicht* haben oder die Einschränkung *nicht* erfüllen (falls angegeben), fehlen im zurückgegebenen **dict**.

    Die möglichen Einschränkungen sind:

    **-nodes**
    : Nur die Knoten des Graphen, die in der angegebenen *list* stehen und den angegebenen *key* haben, werden in das Ergebnis-**dict** aufgenommen.

    **-glob**
    : Nur die Knoten des Graphen, deren Namen zum angegebenen Glob-Muster *globpattern* passen und den angegebenen *key* haben, werden in das Ergebnis-**dict** aufgenommen.

    **-regexp**
    : Nur die Knoten des Graphen, deren Namen zum angegebenen regulären Ausdruck *repattern* passen und den angegebenen *key* haben, werden in das Ergebnis-**dict** aufgenommen.


*aGraph* **node degree** ?-in|-out? *node*
: Gibt die Zahl der zum angegebenen *node* benachbarten Bögen zurück.

    Ist die Einschränkung **-in** angegeben, werden nur die eingehenden Bögen gezählt; ist **-out** angegeben, nur die ausgehenden. Ist keine Einschränkung angegeben, werden alle eingehenden und ausgehenden Bögen gezählt.

*aGraph* **node delete** *node* ?*node*...?
: Löscht die angegebenen Knoten aus dem Graphen *und außerdem* alle Bögen dieser Knoten (damit keine unverbundenen Bögen bleiben).

*aGraph* **node exists** *node*
: Gibt **1** (wahr) zurück, wenn der angegebene *node* im Graphen vorhanden ist, sonst **0** (falsch).

*aGraph* **node get** *node* *key*
: Gibt den *node* zugeordneten Wert zu *key* zurück.

    Löst einen Fehler aus, wenn *node* den angegebenen *key* nicht hat.

*aGraph* **node getall** *node* ?*glob*?
: Gibt ein **dict** (geeignet für \[**array set**\]) für *node* zurück. Die Schlüssel des **dict** sind Attributnamen (also ihre Schlüssel), die Werte die zugehörigen Attributwerte.

    Ist *glob* angegeben, werden nur die Attribute in das zurückgegebene Dictionary aufgenommen, deren Namen (also Schlüssel) zu diesem Glob-Muster passen.

*aGraph* **node keys** *node* ?*glob*?
: Gibt eine Liste der Attributschlüssel von *node* zurück.

    Ist *glob* angegeben, werden nur die Attribute in die zurückgegebene Liste aufgenommen, deren Namen (also Schlüssel) zu diesem Glob-Muster passen.

*aGraph* **node keyexists** *node* *key*
: Gibt **1** (wahr) zurück, wenn *node* den angegebenen *key* hat, sonst **0** (falsch).

*aGraph* **node insert** ?*node*...?
: Fügt einen oder mehrere Knoten in den Graphen ein und gibt eine Liste der eingefügten Knoten zurück. Diese neuen Knoten sind mit keinem Bogen verbunden.

    Ist kein Knoten angegeben, wird ein einzelner neuer Knoten eingefügt und zurückgegeben. Der neue Knoten erhält einen eindeutigen, vom System erzeugten Namen der Form *nodex*.

*aGraph* **node lappend** *node* *key* *value*
: Hängt *value* (als Liste) an das Attribut von *node* zum angegebenen *key* an und gibt das Attribut mit dem neuen Wert von *key* zurück.

*aGraph* **node opposite** *node* *arc*
: Gibt den Knoten am anderen Ende des angegebenen *arc* zurück. Dieser Bogen muss zum angegebenen *node* benachbart sein.

*aGraph* **node rename** *node* *newname*
: Benennt *node* in *newname* um und gibt den neuen Namen des Knotens zurück.

    Ein Fehler wird ausgelöst, wenn der Knoten nicht existiert oder bereits ein Knoten namens *newname* existiert.

*aGraph* **node set** *node* *key* ?*value*?
: Liest oder setzt das Attribut von *node*, das der angegebene *key* bezeichnet.

    Ist *value* nicht angegeben, gibt dieser Befehl den aktuellen Wert von *key* zurück. Ist *value* angegeben, weist dieser Befehl *value* dem *key* von *node* zu.

    Jedem Knoten können beliebig viele Schlüsselwerte zugeordnet sein.

*aGraph* **node unset** *node* *key*
: Entfernt *key* von *node* und den zugehörigen Wert aus den Attributen von *node*. Es geschieht nichts, wenn *node* den angegebenen *key* nicht hat.

*aGraph* **nodes** ?-key *key*? ?-value *value*? ?-filter *cmdprefix*? ?-in|-out|-adj|-inner|-embedding *node* *node*...?
: Gibt eine Liste der Knoten des Graphen zurück. Jeder Knoten steht in der Liste, solange keine Einschränkungen angegeben sind.

    Einschränkungen können die Knoten in der Liste anhand der dem Knoten zugeordneten Schlüsselwerte oder anhand benachbarter Knoten begrenzen. Einschränkungen, die benachbarte Knoten betreffen, nehmen eine Liste von Knoten als Argument, angegeben nach dem Namen der Einschränkung selbst.

    Die Einschränkungen entsprechen im Wesentlichen denen der Methode **arcs**. Die genaue Bedeutung ändert sich etwas, weil die Einschränkungen hier auf Knoten statt auf Bögen wirken; das allgemeine Verhalten bleibt dasselbe, besonders bei Wörtern mit führendem Bindestrich in Knotenlisten.

    *Einschränkungen*

    **-in**
    : Gibt die *eingehenden Nachbarn* zurück, also eine Liste aller Knoten mit mindestens einem ausgehenden Bogen, der in einem Knoten der angegebenen Knotenmenge endet. (Anders ausgedrückt: die Menge der Quellknoten der **-in**-Bögen dieser Knotenmenge.)

    **-out**
    : Gibt die *ausgehenden Nachbarn* zurück, also eine Liste aller Knoten mit mindestens einem eingehenden Bogen, der in einem Knoten der angegebenen Knotenmenge beginnt. (Anders ausgedrückt: die Menge der Zielknoten der **-out**-Bögen dieser Knotenmenge.)

    **-adj**
    : Gibt die *Nachbarn* zurück, also die Vereinigung der von **-in** und **-out** zurückgegebenen Knoten.

    **-inner**
    : Gibt die Menge der Nachbarn zurück (siehe **-adj** oben), die auch in der angegebenen Knotenmenge liegen, also den Schnitt der von **-adj** zurückgegebenen Nachbarn mit der Knotenmenge.

    **-embedding**
    : Gibt die Menge der Nachbarn zurück (siehe **-adj** oben), die *nicht* in der Knotenmenge liegen, also die Differenz zwischen den von **-adj** zurückgegebenen Nachbarn und der Knotenmenge.

    **-key** *key*
    : Gibt nur Knoten zurück, die den angegebenen *key* haben.

    **-value** *value*
    : Gibt nur Knoten zurück, die den angegebenen *key* haben und deren zugehöriger Wert *value* ist.

        Diese Einschränkung ist nur zusammen mit **-key** verwendbar.

    **-filter** *cmdprefix*
    : Gibt nur die Knoten zurück, für die der Befehl *cmdprefix* **1** (wahr) zurückgibt.

        Der Befehl *cmdprefix* wird mit zwei Argumenten aufgerufen, dem Namen des Graphobjekts und dem Namen des betreffenden Knotens. Er wird im Kontext des Aufrufers ausgeführt und muss einen booleschen Wert zurückgeben, **0** (falsch; den Knoten nicht aufnehmen) oder **1** (wahr; den Knoten aufnehmen).


*aGraph* **get** *key*
: Gibt den dem *key* des Graphen zugeordneten Wert zurück.

    Löst einen Fehler aus, wenn der Graph den angegebenen *key* nicht hat.

    Siehe die Methode **set**.

*aGraph* **getall** ?*pattern*?
: Gibt ein Dictionary (geeignet für \[**array set**\]) mit allen Schlüsseln des Graphen und ihren zugehörigen Werten zurück.

    Ist *pattern* angegeben, gehören nur die Attribute zum zurückgegebenen Dictionary, deren Namen zum Muster passen. Das Muster ist ein **glob**-Muster.

*aGraph* **keys** ?*pattern*?
: Gibt eine Liste aller Schlüssel des Graphen zurück.

    Ist *pattern* angegeben, gehören nur die Attribute zur zurückgegebenen Liste, deren Namen zum Muster passen. Das Muster ist ein **glob**-Muster.

*aGraph* **keyexists** *key*
: Gibt **1** (wahr) zurück, wenn der Graph den angegebenen *key* hat, sonst **0** (falsch).

*aGraph* **serialize** ?*node*...?
: Gibt den Graphen (oder einen Teilgraphen) als einzelnen Tcl-Wert serialisiert zurück. Mit der Methode **deserialize** lässt sich der Wert wieder in einen Graphen zurückverwandeln.

    Serialisiert wird der gesamte Graph, es sei denn, ein oder mehrere *node*s sind angegeben; dann wird nur der von diesen Knoten aufgespannte Teilgraph serialisiert.

    Ein serialisierter Graph ist ein Tcl-Wert und lässt sich wie jede Tcl-Zeichenkette kopieren, zum Beispiel an einen Kanal senden oder in eine Datei schreiben.

    Diese Methode ist auch die Grundlage für Kopierkonstruktor und Zuweisungsoperator des Graphen.

    Die Implementierung der Methode serialize jeder Graphschnittstelle muss semantisch gleichwertige Serialisierungswerte erzeugen, damit diese Werte zwischen Implementierungen austauschbar sind.

    Der serialisierte Wert ist eine Liste von Tripeln plus einem **dict** am Ende. Das heißt *\[llength $serial\] % 3 == 1*. Gültige Werte sind unter anderem 1, 4, 7, ….

    Das letzte Element der Liste ist ein **dict** mit den Attributen des gesamten Graphen.

    Alle vorangehenden Elemente sind Tripel, eines je Knoten, jeweils bestehend aus:

    1. Der Name des Knotens.

    2. Ein **dict** mit den Attributen des Knotens.

    3. Eine Liste aller Bögen, die an diesem Knoten beginnen (siehe unten).


    Jedes Element der Bogenliste eines Knotens ist selbst eine Liste aus drei oder vier Elementen, und zwar:

    1. Der Name des Bogens.

    2. Ein Verweis auf den Zielknoten des Bogens. Dieser Verweis ist der ganzzahlige Index des Zielknotens in der Hauptserialisierungsliste. (Diese Ganzzahl ist immer *>= 0* und *< \[llength $serial\]* und ein Vielfaches von drei.)

        *Hinweis:* Der inneren Konsistenz wegen verlangt die Serialisierung, dass jeder in einem Graphen verwendete Bogenname eindeutig ist, ob am selben Knoten oder an einem anderen.

    3. Ein **dict** mit den Attributen des Bogens.

    4. Ein optionales Bogengewicht. Fehlt es, hat dieser Bogen kein zugeordnetes Gewicht.

        *Hinweis:* Diese Angabe ist neu gegenüber der Serialisierung von **graph** 2.3 und früher. Optionale Bogengewichte im neuen Format erhalten einen Teil der Kompatibilität mit dem alten. Insbesondere hat jeder Graph, der *keine* Gewichte verwendet, eine Serialisierung, die das ältere Graphpaket deserialisieren kann. Werden dagegen Gewichte verwendet, können ältere Pakete nicht deserialisieren.


    Für alle Attributdictionaries ist jeder Schlüssel ein Attributname, und der dem Schlüssel zugeordnete Wert enthält den Wert des Attributs.

    *Hinweis:* Die Reihenfolge der Knoten in der Serialisierung und der Bögen innerhalb jedes Knotens hat keine Bedeutung. Zwei semantisch gleichwertige Graphen können also verschiedene Serialisierungen haben.

    ```
        # A possible serialization for the graph structure
        #
        #        d -----> %2
        #       /         ^ \
        #      /         /   \
        #     /         b     \
        #    /         /       \
        #  %1 <- a - %0         e
        #    ^         \\      /
        #     \\        c     /
        #      \\        \\  /
        #       \\        v v
        #        f ------ %3
        # is
        #
        # %3 {} {{f 6 {}}} %0 {} {{a 6 {}} {b 9 {}} {c 0 {}}} %1 {} {{d 9 {}}} %2 {} {{e 0 {}}} {}
        #
        # This assumes that the graph has neither attribute data nor weighted arcs.
    ```

*aGraph* **set** *key* ?*value*?
: Liest oder setzt den Wert zum angegebenen Graph-*key*.

    Ist kein *value* angegeben, wird der *key* zugeordnete Wert zurückgegeben. Ist *value* angegeben, wird *key* auf den angegebenen *value* gesetzt und *value* zurückgegeben.

    Löst einen Fehler aus, wenn kein *value* angegeben ist (also beim Lesen) und der Graph den angegebenen *key* nicht hat.

    Einem Graphen können beliebig viele Schlüsselwerte zugeordnet sein. Siehe auch die Methode **get**.

*aGraph* **swap** *node1* *node2*
: Vertauscht die Positionen von *node1* und *node2* im Graphen.

*aGraph* **unset** *key*
: Entfernt *key* des Graphen und den zugehörigen Wert. Es geschieht nichts, wenn *key* nicht existiert.

*aGraph* **walk** *node* ?-type *type*? ?-order *order*? ?-dir *direction*? -command *cmd*
: Führt einen Breiten- oder Tiefendurchlauf des Graphen aus, beginnend bei *node* und in Richtung **forward** (Richtung der ausgehenden Bögen) oder **backward** (Gegenrichtung der eingehenden Bögen).

    Ist der Typ des Durchlaufs angegeben, muss er **dfs** (Tiefe zuerst; die Vorgabe) oder **bfs** (Breite zuerst) sein.

    Ist die Ordnung angegeben, muss sie **pre** (Vorordnung; die Vorgabe), **post** (Nachordnung) oder **both** sein.

    Vorordnung heißt, ein Knoten wird besucht, bevor einer seiner Nachbarn besucht wird (festgelegt durch *direction*, siehe unten). Nachordnung heißt, ein Knoten wird besucht, nachdem seine Nachbarn besucht wurden. Bei beiden Ordnungen wird ein Knoten vor *und* nach seinen Nachbarn besucht. Der Breitendurchlauf lässt sich *nur* mit der Vorordnung kombinieren; nur der Tiefendurchlauf ist mit Vorordnung, Nachordnung oder beiden Ordnungen verwendbar.

    Ist die Richtung angegeben, muss sie **backward** (Gegenrichtung der eingehenden Bögen) oder **forward** (Richtung der ausgehenden Bögen) sein.

    Im Verlauf des Durchlaufs wird der Befehl *cmd* an jedem Knoten ausgewertet und erhält drei Argumente. Die Argumente sind der Modus des Aufrufs (**enter** oder **leave**), der Graph selbst (also *aGraph*) und der Name des aktuellen Knotens. Bei einem Durchlauf in Vorordnung werden alle Knoten betreten (Modus **enter** wird an *cmd* übergeben); bei einem Durchlauf in Nachordnung werden alle Knoten verlassen (Modus **leave** wird übergeben). Bei beiden Ordnungen ist der erste Besuch eines Knotens der Eintritt (Modus **enter**) und der zweite Besuch der Austritt (Modus **leave**).


# Änderungen für v2

## Änderungen für v2.4

Das Serialisierungsformat der Methode **serialize** hat sich geändert, um die (optionale) Verwendung von Gewichten abzubilden. Einzelheiten stehen in der Beschreibung der Methode.

## Änderungen für v2.x

Die folgenden nennenswerten Änderungen sind eingetreten:

1. Die API für den Zugriff auf Attribute und ihre Werte ist vereinfacht.

    Alle Funktionen zum Vorgabeattribut "data" sind entfernt. Dieses Vorgabeattribut gibt es nicht mehr. Jeder Zugriff auf Attribute muss den Namen des Attributs angeben. Diese rückwärts *inkompatible* Änderung hat die Signaturen aller Methoden mit Attributen vereinfacht.

    Insbesondere ist die Option **-key** entfallen. Die Beschreibung der neuen APIs steht bei den Bogen- und Knotenmethoden **get**, **getall**, **set**, **unset**, **append**, **lappend**, **keyexists** und **keys**.

2. Die Methoden **keys** und **getall** nehmen jetzt ein optionales Glob-Muster als Argument. Ist es angegeben, beschränken sie die zurückgegebenen Attributdaten auf die Schlüssel, die zum Muster passen.

3. Bögen und Knoten lassen sich jetzt umbenennen. Siehe die Beschreibung der Methoden **arc rename** und **node rename**.

4. Die Struktur ist um APIs zur Serialisierung und Deserialisierung von Graphen erweitert und um eine Reihe von Operationen auf diesen Methoden (zum Beispiel Graphzuweisung, Kopierkonstruktion).

    Siehe die Beschreibung der Methoden **serialize**, **deserialize**, **=** und **-->** sowie die Beschreibung der Erzeugung von Graphobjekten.

    Serialisierung und Deserialisierung bedeuten, dass sich Graphen wie jede Tcl-Zeichenkette kopieren lassen, zum Beispiel an einen Kanal senden oder in eine Datei schreiben.

5. Sowohl **arc** als auch **node** haben jetzt eine Methode **attr**, die auf Attributdaten zugreift, unabhängig von den Beziehungen zwischen Bögen und Knoten.

6. Sowohl **arcs** als auch **nodes** können jetzt Einschränkungen angeben, die die zurückgegebenen Bögen oder Knoten filtern; Einzelheiten stehen in ihrer Beschreibung.


# Beispiele

Das folgende Beispiel zeigt die Grundzüge der Verwendung des Pakets **struct::graph**.

Eine Abbildung des im Beispiel verwendeten Graphen:

```
                SW45
          /------------------BOS
         /                   /|
        /  /--→ORD      NW35/ |
       ↙  /   / D↑  AA1387 ↙  |
    SFO  /  U/  L| /-----JFK  |
        /   A|  3| |      |   |
       |    8|  3| |      |   |
  UA120|    7|  5/ /      |   |
       |    7↓  / /       /   |DL247
       |     DFW←/      A/    |
       |    /   ↖       A|    |
       |   /AA49 \      9|   /
      LAX←/       \     0|  /
        ↖     AA523\    3↓ ↙
         \          \--MIA
          \-----------/
            AA411
```

Der Code, der den oben gezeigten Graphen darstellt, zusammen mit Gewichten (Flugstrecken in Kilometern).

```
proc visit_airport {mode graph airport} {
    puts " [expr {$mode eq "enter" ? "→" : "←"}] $graph $airport"
}

try { ;# Adapted from "Data Structures and Algorithms in Java"
    ::struct::graph flights
    flights node insert SFO
    flights node insert LAX
    flights node insert ORD
    flights node insert DFW
    flights node insert JFK
    flights node insert BOS
    flights node insert MIA
    flights arc insert JFK SFO SW45
    flights arc setweight SW45 4152
    flights arc insert JFK DFW AA1387
    flights arc setweight AA1387 2235
    flights arc insert JFK MIA AA903
    flights arc setweight AA903 1756
    flights arc insert BOS JFK NW35
    flights arc setweight NW35 300
    flights arc insert BOS MIA DL247
    flights arc setweight DL247 2027
    flights arc insert MIA DFW AA523
    flights arc setweight AA523 1802
    flights arc insert MIA LAX AA411
    flights arc setweight AA411 3763
    flights arc insert LAX ORD UA120
    flights arc setweight UA120 2802
    flights arc insert DFW LAX AA49
    flights arc setweight AA49 1983
    flights arc insert DFW ORD DL335
    flights arc setweight DL335 1290
    flights arc insert ORD DFW UA877
    flights arc setweight UA877 1290
    puts "flights walk ORD:"
    puts [flights walk ORD -order both -command visit_airport]
    puts "All flights: [lsort -dictionary [flights arcs]]"
    puts "Chicago flights: [flights arcs -embedding ORD]"
    puts "Chicago direct connections: [flights nodes -embedding ORD]"
} finally {
    flights destroy
}
=>
flights walk ORD:
 → flights ORD
 → flights DFW
 → flights LAX
 ← flights LAX
 ← flights DFW
 ← flights ORD

All flights: AA49 AA411 AA523 AA903 AA1387 DL247 DL335 NW35 SW45 UA120 UA877
Chicago flights: DL335 UA120 UA877
Chicago direct connections: DFW LAX
```

# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *struct :: graph* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Datenstrukturen

# Copyright

```
Copyright (c) 2002-2009,2019 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
