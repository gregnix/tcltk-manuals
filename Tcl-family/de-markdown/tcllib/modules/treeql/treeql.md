---
CommandName: treeql
ManualSection: n
Version: 1.3.2
TclPart: tcllib
TclDescription: Tree Query Language
Keywords:
 - Cost
 - DOM
 - TreeQL
 - XPath
 - XSLT
 - structured queries
 - tree
 - tree query language
Copyright:
 - Copyright (c) 2004 Colin McCormack <coldstore@users.sourceforge.net>
 - Copyright (c) 2004 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

treeql – Abfrage von Baumobjekten

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [snit]{.lit} 
[package]{.cmd} [require]{.sub} [struct::list]{.lit} 
[package]{.cmd} [require]{.sub} [struct::set]{.lit} 
[package]{.cmd} [require]{.sub} [treeql]{.lit} [1.3.2]{.optlit} 
[treeql]{.cmd} [objectname]{.arg} [-tree]{.lit} [tree]{.arg} [-query query]{.optarg} [-nodes nodes]{.optarg} [args]{.optdot} 
[qo]{.ins} [query]{.sub} [args...]{.arg} 
[qo]{.ins} [result]{.sub} 
[qo]{.ins} [discard]{.sub} 
:::

# BESCHREIBUNG

Dieses Paket stellt Objekte bereit, mit denen Baumobjekte abgefragt und durch Transformationen verändert werden können, wobei die API der vom Paket **struct::tree** erstellten Baumobjekte befolgt wird.

Die hier verwendete Abfrage- und Bearbeitungssprache für Baumstrukturen, TreeQL, ist von Cost inspiriert (weitere Informationen finden Sie im Abschnitt **LITERATUR**).

Das Paket **treeql** ist eine relativ schlanke Abfragefunktion für baumstrukturierte Datentypen. Es implementiert eine geordnete Menge von Knoten (im Grunde eine Liste), die durch die Anwendung von TreeQL-Operatoren auf jeden Knoten nacheinander generiert und durch einen Filter gefiltert werden.

# API

## Treeql-Klassen-API

Der Befehl **treeql** ist vom Typ **snit**::type und implementiert die Treeql-Abfragesprache. Das bedeutet, dass er der API für Klassenbefehle folgt, wie sie im Paket **snit** festgelegt ist. Seine allgemeine Syntax lautet

**treeql** *objectname* **-tree** *tree* ?**-query** *query*? ?**-nodes** *nodes*? ?*args*...?
: Der Befehl erstellt ein neues Baumabfrageobjekt und gibt den vollqualifizierten Namen des Objektbefehls als Ergebnis zurück. Die API, der der zurückgegebene Befehl folgt, wird im Abschnitt **Treeql-Objekt-API** beschrieben. Jedes Abfrageobjekt ist mit einem einzelnen *tree*-Objekt verknüpft. Dies ist das Objekt, auf das alle Abfragen angewendet werden. Wenn die Option **-nodes** angegeben wurde, wird ihr Argument als Liste von Knoten behandelt. Diese Liste wird zur Initialisierung der Knotenmenge verwendet. Standardmäßig ist dies eine leere Liste. Wenn die Option **-query** angegeben wurde, wird ihr Argument als Objekt interpretiert, nämlich als die *Elternabfrage* dieser Abfrage. Standardmäßig ist dies das Objekt selbst. Alle Abfragen werden in der Umgebung dieses Objekts interpretiert. Alle Argumente, die auf die Optionen folgen, werden als Abfrage behandelt und sofort ausgeführt, nachdem die *Knotenmenge* initialisiert wurde. Dabei wird dieselbe Syntax für die Abfrage verwendet wie bei der Methode **query**. Die hierfür verfügbaren TreeQL-Operationen werden im Abschnitt über **DIE BAUMABFRAGESPRACHE** erläutert. In diesem Abschnitt wird auch der oben verwendete Begriff *Knotenmenge* erklärt.


## Treeql-Objekt-API

Da **treeql** in **snit** implementiert wurde, stehen dem Benutzer alle Standardmethoden der auf **snit** basierenden Basisklassen zur Verfügung und werden daher hier nicht aufgeführt. Bitte lesen Sie die Dokumentation zu **snit**, um zu erfahren, um welche es sich dabei handelt und welche Funktionen sie bieten.

Die vom Paket **treeql** bereitgestellten Methoden werden im Folgenden aufgeführt und erläutert.

*qo* **query** *args*...
: Diese Methode interpretiert ihre Argumente als eine Reihe von TreeQL-Operatoren und wertet diese von links nach rechts (d. h. vom ersten bis zum letzten) aus. Beachten Sie, dass der erste Operator die dem Objekt aktuell bekannten *Knotenmenge* verwendet, um seine Aktionen auszuführen. Mit anderen Worten: Die *Knotenmenge* wird vor der Ausführung der Abfrage *nicht* gelöscht oder anderweitig verändert. Dies ermöglicht es dem Benutzer, mehrere Abfragen nacheinander auszuführen, wobei jede Abfrage die Ergebnisse der vorherigen nutzt. Jegliche Initialisierung muss von der jeweiligen Abfrage selbst unter Verwendung von TreeQL-Operatoren vorgenommen werden. Das Ergebnis der Methode ist die *Knotenmenge* nach Ausführung des letzten Operators der Abfrage. *Hinweis*: Nicht abgefangene Fehler belassen die *Knotenmenge* des Objekts in einem Zwischenzustand, der den TreeQL-Operatoren entspricht, die vor dem Auftreten des Fehlers erfolgreich ausgeführt wurden. Im Einzelnen bedeutet dies Folgendes:


**\[1\]**
: Das erste Argument wird als Name eines Abfrageoperators interpretiert; anschließend wird die Anzahl der von diesem Operator benötigten Argumente ermittelt und aus den unmittelbar folgenden Argumenten entnommen. Aus diesem Grund dürfen Operatoren keine optionalen Argumente haben; alle Argumente müssen wie definiert vorhanden sein.  Wird dies nicht beachtet, führt dies zumindest zu Verwirrung beim Interpreter, verursacht jedoch höchstwahrscheinlich Fehler.

**\[2\]**
: Der Operator wird auf die aktuelle Knotenmenge angewendet, wodurch eine neue Knotenmenge entsteht und/oder das Baum-Objekt, mit dem das Abfrageobjekt verbunden ist, verändert wird.

**\[3\]**
: Die verwendeten Argumente (d. h. der Name des Operators und die Argumente) werden aus der Liste der Argumente für Methoden entfernt, und anschließend wird der gesamte Prozess ab Schritt \[1\] wiederholt, bis die Liste der Argumente leer ist oder ein Fehler aufgetreten ist.


```
    # q is the query object.

    q query root children get data

    # The above query
    # - Resets the node set to the root node - root
    # - Adds the children of root to the set - children
    # - Replaces the node set with the       - get data
    #   values for the attribute 'data',
    #   for all nodes in the set which
    #   have such an attribute.
    # - And returns this information.

    # Below we can see the same query, but rewritten
    # to show the structure as it is seen by the query
    # interpreter.

    q query \
	    root \
	    children \
	    get data
```

Die für diese Sprache verfügbaren Operatoren der TreeQL-Sprache werden im Abschnitt über **DIE BAUMABFRAGESPRACHE** erläutert. In diesem Abschnitt wird auch der oben verwendete Begriff *Knotenmenge* erläutert.

*qo* **result**
: Diese Methode gibt eine Liste zurück, die die aktuelle Knotenmenge enthält.

*qo* **discard**
: Diese Methode gibt die aktuelle Knotenmenge zurück (wie die Methode **result**), löscht jedoch zusätzlich das Abfrageobjekt (*qo*). Dies ist nützlich beim Erstellen und Verwenden von Unterabfragen (%AUTO%-Objekte werden unmittelbar nach der Verwendung gelöscht).


# DIE BAUMABFRAGESPRACHE

In diesem und den folgenden Abschnitten wird die von den Abfrageobjekten dieses Pakets verwendete Baumabfragesprache im Detail festgelegt.

Zunächst erläutern wir die allgemeinen Konzepte, die der Sprache zugrunde liegen und für deren Verständnis erforderlich sind. Anschließend folgen die Spezifikationen für alle verfügbaren Abfrageoperatoren. Diese lassen sich in acht Kategorien einteilen, wobei jede Kategorie einen eigenen Abschnitt bildet.

**\[1\]**
: **Treeql-Konzepte**

**\[2\]**
: **Strukturgeneratoren**

**\[3\]**
: **Attributfilter**

**\[4\]**
: **Attribut-Mutatoren**

**\[5\]**
: **Zugriffsmethoden für Attributzeichenfolgen**

**\[6\]**
: **Unterabfragen**

**\[7\]**
: **Operatoren für Knotenmengen**

**\[8\]**
: **Iteratoren für Knotenmengen**

**\[9\]**
: **Unterstützung für typisierte Knoten**


## Treeql-Konzepte

Das wichtigste Konzept, das es zu verstehen gilt, ist das der *Knotenmenge*. Jedes Abfrageobjekt verwaltet genau eine solche *Knotenmenge*, und im Wesentlichen nutzen alle Operatoren diese sowohl als Eingabe als auch für ihr Ergebnis. Diese Struktur enthält lediglich die Referenzen aller Knoten, die für das Abfrageobjekt derzeit von Interesse sind. Die Bezeichnung *Menge* ist insofern etwas irreführend, da

**\[1\]**
: Ein Knoten (Handle) kann in der Struktur mehrmals vorkommen, und

**\[2\]**
: Auch die Reihenfolge der Knoten in der Struktur ist von Bedeutung. Wann immer ein Operator alle Knoten in der Knotenmenge verarbeitet, erfolgt dies in der Reihenfolge, in der sie in der Struktur vorkommen. Was das mögliche mehrfache Vorkommen eines Knotens betrifft, betrachten Sie eine Knotenmenge, die zwei Knoten A und B enthält, die beide den Knoten P als ihren unmittelbaren Elternknoten haben. Durch die Anwendung des TreeQL-Operators „parent“ wird P dann zweimal zur neuen Knotenmenge hinzugefügt, einmal pro Knoten, dessen Elternknoten er war. Das heißt, die neue Knotenmenge lautet dann {P P}.


## Strukturgeneratoren

Alle Operatoren für Baumstrukturen lokalisieren Knoten im Baum anhand einer strukturellen Beziehung zu den derzeit in der Menge enthaltenen Knoten und ersetzen anschließend die aktuelle Knotenmenge durch die Menge der gefundenen Knoten. Knoten, die eine solche Beziehung mehrfach erfüllen, werden so oft zum Ergebnis hinzugefügt, wie sie die Beziehung erfüllen.

Es ist wichtig zu beachten, dass die gefundenen Knoten während der Verarbeitung der Knotenmenge in einem separaten Speicherbereich gesammelt werden und erst dann zur aktuellen Knotenmenge hinzugefügt werden (oder diese ersetzen), wenn die aktuelle Knotenmenge vollständig verarbeitet wurde. Mit anderen Worten: Die neuen Knoten werden vom Operator *nicht* ebenfalls verarbeitet und haben keinen Einfluss auf die Iteration.

Wenn die Beschreibung eines Operators erfolgt, wird die Variable **N** verwendet, um auf einen beliebigen Knoten in der Knotenmenge zu verweisen.

**ancestors**
: Ersetzt die aktuelle Knotenmenge durch die Vorfahren aller Knoten **N** in der Knotenmenge, sofern **N** einen Elternknoten hat. Mit anderen Worten: Knoten ohne Elternknoten fließen nicht in die neue Knotenmenge ein. Mit anderen Worten: Es werden alle Knoten auf dem Pfad vom Knoten **N** zur Wurzel in dieser Reihenfolge (Wurzel zuletzt) für alle Knoten **N** in der Knotenmenge verwendet. Dies schließt die Wurzel ein, jedoch nicht den Knoten selbst.

**rootpath**
: Ersetzt die aktuelle Knotenmenge durch die Vorfahren aller Knoten **N** in der Knotenmenge, sofern **N** einen Elternknoten besitzt. Mit anderen Worten: Knoten ohne Elternknoten fließen nicht in die neue Knotenmenge ein. Im Gegensatz zum Operator **ancestors** werden die Knoten jedoch in umgekehrter Reihenfolge hinzugefügt, d. h. der Wurzelknoten zuerst.

**parent**
: Ersetzt die aktuelle Knotenmenge durch den Elternknoten von **N** für alle Knoten **N** in der Knotenmenge, sofern **N** einen Elternknoten hat. Mit anderen Worten: Knoten ohne Elternknoten fließen nicht in die neue Knotenmenge ein.

**children**
: Ersetzt die aktuelle Knotenmenge durch die unmittelbaren Kindknoten des Knotens **N** für alle Knoten **N** in der Knotenmenge, sofern **N** Kindknoten besitzt. Mit anderen Worten: Knoten ohne Kindknoten fließen nicht in die neue Knotenmenge ein.

**left**
: Ersetzt die aktuelle Knotenmenge durch den vorherigen bzw. linken Geschwisterknoten für alle Knoten **N** in der Knotenmenge, sofern **N** Geschwisterknoten auf der linken Seite hat. Mit anderen Worten: Knoten ohne Geschwisterknoten auf der linken Seite fließen nicht in die neue Knotenmenge ein.

**right**
: Ersetzt die aktuelle Knotenmenge für alle Knoten **N** in der Knotenmenge durch den nächsten/rechten Geschwisterknoten, sofern **N** Geschwisterknoten auf der rechten Seite hat. Mit anderen Worten: Knoten ohne Geschwisterknoten auf der rechten Seite fließen nicht in die neue Knotenmenge ein.

**prev**
: Ersetzt die aktuelle Knotenmenge durch alle vorherigen/linken Geschwisterknoten des Knotens **N** für alle Knoten **N** in der Knotenmenge, sofern **N** Geschwisterknoten auf der linken Seite besitzt. Mit anderen Worten: Knoten ohne linke Geschwister werden ignoriert. Der linke Geschwisterknoten, der direkt an den Knoten angrenzt, wird zuerst hinzugefügt, der am weitesten links liegende Geschwisterknoten zuletzt (umgekehrte Baumreihenfolge).

**esib**
: Ersetzt die aktuelle Knotenmenge durch alle vorherigen/linken Geschwisterknoten des Knotens **N** für alle Knoten **N** in der Knotenmenge, sofern **N** Geschwisterknoten auf der linken Seite besitzt. Mit anderen Worten: Knoten ohne linke Geschwister werden ignoriert. Der am weitesten links liegende Geschwisterknoten wird zuerst hinzugefügt, der an den Knoten angrenzende linke Geschwisterknoten zuletzt (in Baumreihenfolge). Der Name der Methode ist eine Abkürzung für *Earlier SIBling*.

**next**
: Ersetzt die aktuelle Knotenmenge durch alle nächsten/rechten Geschwisterknoten des Knotens **N** für alle Knoten **N** in der Knotenmenge, sofern **N** Geschwisterknoten auf der rechten Seite besitzt. Mit anderen Worten: Knoten ohne Geschwister rechts tragen nicht zur neuen Knotenmenge bei. Das rechts angrenzende Geschwisterknoten des Knotens wird zuerst hinzugefügt, das ganz rechts liegende Geschwisterknoten zuletzt (in Baumreihenfolge).

**root**
: Ersetzt die aktuelle Knotenmenge durch eine Knotenmenge, die einen einzigen Knoten enthält, nämlich die Wurzel des Baums.

**tree**
: Ersetzt die aktuelle Knotenmenge durch eine Knotenmenge, die alle im Baum gefundenen Knoten enthält. Die Knoten werden in der Vorreihenfolge hinzugefügt (zuerst die Elternknoten, dann die Kindknoten, wobei letztere von links nach rechts und vom ersten bis zum letzten Knoten aufgeführt werden).

**descendants**
: Ersetzt die aktuelle Knotenmenge durch die Knoten aller Teilbäume, deren Wurzel der Knoten **N** ist, und zwar für alle Knoten **N** in der Knotenmenge, sofern **N** Kindknoten besitzt. Mit anderen Worten: Knoten ohne Kindknoten fließen nicht in die neue Knotenmenge ein. Dies entspricht dem Operator **children**, umfasst jedoch auch die Kindknoten der Kindknoten, d. h. alle *echten Nachkommen*. „Mit Wurzel bei **N**“ bedeutet, dass **N** selbst nicht zur neuen Menge hinzugefügt wird, was auch durch den Begriff *echte Nachkommen* impliziert wird.

**subtree**
: Ähnlich wie der Operator **descendants**, umfasst jedoch zusätzlich den Knoten **N**. Mit anderen Worten: Ersetzt die aktuelle Knotenmenge durch die Knoten des Teilbaums des Knotens **N** für alle Knoten **N** in der Knotenmenge, sofern **N** Kindknoten besitzt. Mit anderen Worten: Knoten ohne Kindknoten fließen nicht in die neue Knotenmenge ein. Das entspricht also dem Operator **children**, umfasst jedoch auch die Kindknoten der Kindknoten usw. „Von **N**“ bedeutet, dass **N** selbst zur neuen Menge hinzugefügt wird.

**forward**
: Ersetzt die aktuelle Knotenmenge durch die Knoten in den Teilbäumen, deren Wurzelknoten die rechten Geschwisterknoten des Knotens **N** sind, und zwar für alle Knoten **N** in der Knotenmenge, sofern **N** rechte Geschwister hat und diese wiederum Kindknoten besitzen. Mit anderen Worten: Knoten ohne rechte Geschwister sowie rechte Geschwister ohne Kindknoten werden ignoriert. Dies entspricht der Operatorfolge


```
next descendants
```

**later**
: Dies ist ein Alias für den Operator **forward**.

**backward**
: Ersetzt die aktuelle Knotenmenge durch die Knoten der abgeflachten vorherigen Teilbäume in umgekehrter Baumstruktur. Dies entspricht nahezu der Operatorfolge


```
prev descendants
```

: Der einzige Unterschied besteht darin, dass hierbei die Knoten in umgekehrter Reihenfolge verwendet werden.


**earlier**
: Ersetzt die aktuelle Knotenmenge durch die Knoten der abgeflachten vorherigen Teilbäume in der Reihenfolge des Baums. Dies entspricht der Operatorfolge


```
prev subtree
```

## Attributfilter

Diese Operatoren filtern die Knotenmenge anhand von Attributen der Knoten und deren Eigenschaften. Filtern bedeutet, dass alle Knoten, die die Kriterien nicht erfüllen, aus der Knotenmenge entfernt werden. Mit anderen Worten: Die Knotenmenge wird durch die Menge der Knoten ersetzt, die die Filterkriterien erfüllen.

**hasatt** *attr*
: Reduziert die Knotenmenge auf jene Knoten, die ein Attribut mit dem Namen *attr* besitzen.

**withatt** *attr* *value*
: Reduziert die Knotenmenge auf jene Knoten, die ein Attribut mit dem Namen *attr* besitzen und bei denen der Wert dieses Attributs gleich *value* ist (der Operator „==“ ist **string equal -nocase**).

**withatt!** *attr* *val*
: Dies entspricht **withatt**, allerdings müssen alle Knoten in der Knotenmenge über das Attribut verfügen, und der Operator „==“ lautet **string equal**, d. h. nicht **-nocase**. Der Operator führt zu einem Fehler, wenn die Knoten das Attribut nicht besitzen.

**attof** *attr* *vals*
: Reduziert die Knotenmenge auf jene Knoten, die ein Attribut namens *attr* besitzen und bei denen der Wert dieses Attributs in der Liste *vals* der zulässigen Werte enthalten ist. Der hier verwendete Operator für das Enthaltensein führt eine Glob-Übereinstimmung durch (wobei der Attributwert als Muster dient) und ignoriert die Groß-/Kleinschreibung des Attributwerts, *jedoch nicht* bei den Elementen von *vals*.

**attmatch** *attr* *match*
: Genau wie bei **withatt**, jedoch wird bei **string match** der Operator „==“ verwendet, und *match* ist das Muster, auf das geprüft wird. *Hinweis*: *match* wird als unvollständige Argument*liste* für **string match** interpretiert. Das bedeutet, dass es als Liste interpretiert wird, die das Muster enthält, und dem Musterelement können Optionen vorangestellt werden, die von **string match** verstanden werden, wie beispielsweise **-nocase**. Dies ist besonders wichtig, falls das Muster Leerzeichen enthält. Es muss in eine Liste eingeschlossen werden, damit der Interpreter es korrekt interpretieren kann.


## Attribut-Mutatoren

Diese Operatoren ändern die Attribute der Knoten innerhalb des zugrunde liegenden Baums. Mit anderen Worten: Alle diese Operatoren haben *Nebenwirkungen*.

**set** *attr* *val*
: Setzt das Attribut *attr* für alle Knoten **N** in der Knotenmenge auf den Wert *val*. Der Operator schlägt fehl, wenn ein Knoten kein Attribut mit dem Namen *attr* besitzt. Der Baum verbleibt in einem teilweise geänderten Zustand.

**unset** *attr*
: Hebt das Attribut *attr* für alle Knoten **N** in der Knotenmenge auf. Der Operator schlägt fehl, wenn ein Knoten kein Attribut mit dem Namen *attr* besitzt. Der Baum verbleibt in einem teilweise geänderten Zustand.


## Zugriffsmethoden für Attributzeichenfolgen

Diese Operatoren rufen die Werte der Knotenattribute aus dem zugrunde liegenden Baum ab. Die erfassten Ergebnisse werden in der Knotenmenge gespeichert, sind jedoch keine tatsächlichen Knoten.

Mit anderen Worten: Sie definieren die Semantik der vom Abfrageobjekt gespeicherten Knotenmenge neu, sodass diese nach ihrer Ausführung auch Daten enthält, die keine Knoten sind.

Der Interpreter wird beendet, sobald er die Verarbeitung eines dieser Operatoren abgeschlossen hat, wobei alle nachfolgenden Abfrageelemente stillschweigend verworfen werden. Dies bedeutet auch, dass unsere Ausführungen zur Pflege einer Knotenmenge nicht ganz zutreffend sind. Es handelt sich zwar um eine Knotenmenge, solange der Interpreter Befehle verarbeitet, doch kann sie am Ende der Abfrageverarbeitung als Wertmenge für Attribute belassen werden.

**string** *op* *attr*
: Wendet den Zeichenfolgenoperator *op* auf das Attribut *attr* für alle Knoten **N** in der Knotenmenge an, sammelt die Ergebnisse dieser Anwendung und legt sie in der Knotenmenge ab. Der Operator schlägt fehl, wenn ein Knoten kein Attribut namens *attr* besitzt. Das Argument *op* wird als teilweise Argumentliste für den integrierten Befehl **string** interpretiert.  Sein erstes Wort muss einer der von **string** unterstützten Unterbefehle sein. Darauf müssen alle für den Unterbefehl erforderlichen Argumente folgen, mit Ausnahme des letzten. Dieses letzte Argument wird durch den Wert des Attributs bereitgestellt.

**get** *pattern*
: Für alle Knoten **N** in der Knotenmenge ermittelt der Operator zunächst alle Attribute, deren Namen dem Glob-*pattern* entsprechen, anschließend die Werte dieser Attribute und ersetzt schließlich die Knotenmenge durch die Liste dieser Attributwerte.

**attlist**
: Dies ist eine praktische Kurzdefinition für den Operator **getvals \***. Mit anderen Worten: Sie ersetzt die Knotenmenge durch eine Liste der Werte für alle Attribute aller Knoten **N** in der Knotenmenge.

**attrs** *glob*
: Ersetzt die aktuelle Knotenmenge durch eine Liste von Attributlisten, wobei für jeden Knoten **N** in der Knotenmenge eine eigene Attributliste vorhanden ist.

**attval** *attname*
: Reduziert die aktuelle Knotenmenge mithilfe des Operators **hasatt** und ersetzt sie anschließend durch eine Liste, die die Werte des Attributs *attname* für alle Knoten **N** in der Knotenmenge enthält.


## Unterabfragen

Unterabfragen liefern Knotenmengen, die anschließend dazu verwendet werden, die aktuelle Knotenmenge zu erweitern, zu verkleinern oder zu ersetzen.

**andq** *query*
: Ersetzt die Knotenmenge durch die Schnittmenge der durch die Unterabfrage *query* erzeugten Knotenmenge und der aktuellen Knotenmenge. Bei der Ausführung der Unterabfrage wird die aktuelle Knotenmenge als eigene Ausgangsknotenmenge verwendet.

**orq** *query*
: Ersetzt die Knotenmenge durch die Vereinigung der durch die Unterabfrage *query* erzeugten Knotenmenge und der aktuellen Knotenmenge. Doppelte Knoten werden entfernt. Bei der Ausführung der Unterabfrage wird die aktuelle Knotenmenge als eigene Ausgangsknotenmenge verwendet.

**notq** *query*
: Ersetzt die Knotenmenge durch die Menge der Knoten, die durch die Unterabfrage *query* generiert wurden und die ebenfalls nicht in der aktuellen Knotenmenge enthalten sind. Mit anderen Worten: Es handelt sich um die Differenz zwischen der aktuellen Knotenmenge und der durch die Unterabfrage generierten Knotenmenge. Bei der Ausführung der Unterabfrage wird die aktuelle Knotenmenge als eigene Ausgangsknotenmenge verwendet.


## Operatoren für Knotenmengen

Diese Operatoren ändern die Knotenmenge direkt, ohne auf den Baum zurückzugreifen.

**unique**
: Entfernt doppelte Knoten aus der Knotenmenge unter Beibehaltung der Reihenfolge. Mit anderen Worten: Das früheste Vorkommen eines Knoten-Handles bleibt erhalten, alle weiteren Vorkommen werden entfernt.

**select**
: Ersetzt die aktuelle Knotenmenge durch eine Knotenmenge, die ausschließlich den ersten Knoten der aktuellen Knotenmenge enthält

**transform** *query* *var* *body*
: Zunächst interpretiert es die Unterabfrage *query* und verwendet dabei die aktuelle Knotenmenge als Ausgangsknotenmenge. Anschließend durchläuft es das Ergebnis dieser Abfrage, wobei es den Handle jedes Knotens an die in *var* benannte Variable bindet und das Skript *body* ausführt. Die gesammelten Ergebnisse dieser Ausführungen bilden die neue Knotenmenge, die die aktuelle ersetzt. Das Skript *body* wird im Kontext des Aufrufers ausgeführt.

**map** *var* *body*
: Durchläuft die aktuelle Knotenmenge, führt dabei die Bindung des Handles jedes Knotens an die in *var* angegebene Variable durch und führt das Skript *body* aus. Die gesammelten Ergebnisse dieser Ausführungen bilden die neue Knotenmenge, die die aktuelle ersetzt. Das Skript *body* wird im Kontext des Aufrufers ausgeführt.

**quote** *val*
: Fügt den Literalwert *val* an die aktuelle Knotenmenge an.

**replace** *val*
: Ersetzt die aktuelle Knotenmenge durch den Literalwert *val*.


## Iteratoren für Knotenmengen

**foreach** *query* *var* *body*
: Es wertet die Unterabfrage *query* aus und führt anschließend auf den Knoten in der durch diese Abfrage erstellten Knotenmenge eine Operation durch, die dem Operator **over** entspricht. Die aktuelle Knotenmenge wird nicht verändert, außer durch Nebenwirkungen des Skripts *body*. Das Skript *body* wird im Kontext des Aufrufers ausgeführt.

**with** *query* *body*
: Der Interpreter wertet die *query* aus und führt anschließend das Skript *body* auf der durch die Abfrage generierten Knotenmenge aus. Zuletzt wird die aktuelle Knotenmenge in den Zustand zurückversetzt, in dem sie sich vor der Ausführung der Abfrage befand. Das Skript *body* wird im Kontext des Aufrufers ausgeführt.

**over** *var* *body*
: Führt das Skript *body* für jeden Knoten in der Knotenmenge aus, wobei die durch *var* benannte Variable auf den Namen des aktuellen Knotens gesetzt wird. Das Skript *body* wird im Kontext des Aufrufers ausgeführt. Dies entspricht dem eingebauten Befehl **foreach**, wobei die Knotenmenge als Quelle der zu durchlaufenden Liste dient. Die Ergebnisse der Ausführung von *body* werden ignoriert.

**delete**
: Löscht alle Knoten, die in der aktuellen Knotenmenge enthalten sind, aus dem Baum.


## Unterstützung für typisierte Knoten

Diese Filter und Zugriffsfunktionen setzen das Vorhandensein eines Attributs namens **@type** voraus und stellen Kurzformen dar, die sich für Cost-artige Baumabfragen, die Bearbeitung von HTML-Bäumen und Ähnliches eignen.

**nodetype**
: Gibt den Knotentyp der Knoten zurück. Zugriffsmethode für Attributzeichenfolgen. Dies entspricht


```
get @type
```

**oftype** *t*
: Reduziert die Knotenmenge auf jene Knoten, deren Typ mit *t* übereinstimmt, wobei die Groß-/Kleinschreibung ignoriert wird.

**nottype** *t*
: Reduziert die Knotenmenge auf jene Knoten, deren Typ nicht *t* entspricht, wobei die Groß-/Kleinschreibung ignoriert wird.

**oftypes** *attrs*
: Reduziert die Menge auf Knoten, deren @type ein Element der Liste *attrs* von Typen ist. Der Wert von @type wird als Glob-Muster verwendet, wobei die Groß- und Kleinschreibung beachtet wird.


# BEISPIELE

... Zu erledigen ...

# LITERATUR

**\[1\]**
: [COST](http://wiki.tcl.tk/COST) im Tcler-Wiki.

**\[2\]**
: [TreeQL](http://wiki.tcl.tk/treeql) im Tcler-Wiki. Bitte diskutieren Sie dieses Paket dort.


# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *treeql* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Datenstrukturen

# COPYRIGHT

```
Copyright (c) 2004 Colin McCormack <coldstore@users.sourceforge.net>
Copyright (c) 2004 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
