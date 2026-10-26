---
CommandName: struct::tree
title: struct::tree
ManualSection: n
Version: 2.1.1
TclPart: tcllib
TclDescription: Tcl Data Structures
Keywords:
 - breadth-first
 - depth-first
 - in-order
 - node
 - post-order
 - pre-order
 - serialization
 - tree
Copyright:
 - Copyright (c) 2002-2004,2012 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

struct::tree – Baumobjekte anlegen und bearbeiten

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [struct::tree]{.lit} [2.1.1]{.optlit}
[package]{.cmd} [require]{.sub} [struct::list]{.lit} [1.5]{.optlit}
[::struct::tree]{.cmd} [treeName]{.optarg} [[=|:=|as|deserialize]{.lit} [source]{.arg}]{.optarg}
[treeName]{.cmd} [option]{.lit} [arg arg]{.optdot}
[::struct::tree::prune]{.cmd}
[treeName]{.ins} [=]{.sub} [sourcetree]{.arg}
[treeName]{.ins} [-->]{.sub} [desttree]{.arg}
[treeName]{.ins} [ancestors]{.sub} [node]{.arg}
[treeName]{.ins} [append]{.sub} [node]{.arg} [key]{.arg} [value]{.arg}
[treeName]{.ins} [attr]{.sub} [key]{.arg}
[treeName]{.ins} [attr]{.sub} [key]{.arg} [-nodes]{.lit} [list]{.arg}
[treeName]{.ins} [attr]{.sub} [key]{.arg} [-glob]{.lit} [globpattern]{.arg}
[treeName]{.ins} [attr]{.sub} [key]{.arg} [-regexp]{.lit} [repattern]{.arg}
[treeName]{.ins} [children]{.sub} [-all]{.optlit} [node]{.arg} [[filter]{.lit} [cmdprefix]{.arg}]{.optarg}
[treeName]{.ins} [cut]{.sub} [node]{.arg}
[treeName]{.ins} [delete]{.sub} [node]{.arg} [node]{.optdot}
[treeName]{.ins} [depth]{.sub} [node]{.arg}
[treeName]{.ins} [descendants]{.sub} [node]{.arg} [[filter]{.lit} [cmdprefix]{.arg}]{.optarg}
[treeName]{.ins} [deserialize]{.sub} [serialization]{.arg}
[treeName]{.ins} [destroy]{.sub}
[treeName]{.ins} [exists]{.sub} [node]{.arg}
[treeName]{.ins} [get]{.sub} [node]{.arg} [key]{.arg}
[treeName]{.ins} [getall]{.sub} [node]{.arg} [pattern]{.optarg}
[treeName]{.ins} [keys]{.sub} [node]{.arg} [pattern]{.optarg}
[treeName]{.ins} [keyexists]{.sub} [node]{.arg} [key]{.arg}
[treeName]{.ins} [index]{.sub} [node]{.arg}
[treeName]{.ins} [insert]{.sub} [parent]{.arg} [index]{.arg} [child ?child]{.optdot}
[treeName]{.ins} [isleaf]{.sub} [node]{.arg}
[treeName]{.ins} [lappend]{.sub} [node]{.arg} [key]{.arg} [value]{.arg}
[treeName]{.ins} [leaves]{.sub}
[treeName]{.ins} [move]{.sub} [parent]{.arg} [index]{.arg} [node]{.arg} [node]{.optdot}
[treeName]{.ins} [next]{.sub} [node]{.arg}
[treeName]{.ins} [numchildren]{.sub} [node]{.arg}
[treeName]{.ins} [nodes]{.sub}
[treeName]{.ins} [parent]{.sub} [node]{.arg}
[treeName]{.ins} [previous]{.sub} [node]{.arg}
[treeName]{.ins} [rename]{.sub} [node]{.arg} [newname]{.arg}
[treeName]{.ins} [rootname]{.sub}
[treeName]{.ins} [serialize]{.sub} [node]{.optarg}
[treeName]{.ins} [set]{.sub} [node]{.arg} [key]{.arg} [value]{.optarg}
[treeName]{.ins} [size]{.sub} [node]{.optarg}
[treeName]{.ins} [splice]{.sub} [parent]{.arg} [from]{.arg} [to]{.optarg} [child]{.optarg}
[treeName]{.ins} [swap]{.sub} [node1]{.arg} [node2]{.arg}
[treeName]{.ins} [unset]{.sub} [node]{.arg} [key]{.arg}
[treeName]{.ins} [walk]{.sub} [node]{.arg} [[-order]{.lit} [order]{.arg}]{.optarg} [[-type]{.lit} [type]{.arg}]{.optarg} [loopvar]{.arg} [script]{.arg}
[treeName]{.ins} [walkproc]{.sub} [node]{.arg} [[-order]{.lit} [order]{.arg}]{.optarg} [[-type]{.lit} [type]{.arg}]{.optarg} [cmdprefix]{.arg}
:::

# Beschreibung

Ein Baum ist eine Sammlung benannter Elemente, Knoten genannt, von denen einer als Wurzel ausgezeichnet ist, zusammen mit einer Beziehung („Elternschaft“), die den Knoten eine hierarchische Struktur gibt. (Data Structures and Algorithms; Aho, Hopcroft und Ullman; Addison-Wesley, 1987).  Neben der Verwaltung der Knotenbeziehungen erlaubt diese Baumimplementierung, jedem Knoten beliebig viele Werte unter Schlüsseln zuzuordnen.

Die Namen der Elemente können beliebige Zeichenketten sein.

Ein Baum ähnelt somit einem Array, weist jedoch drei wesentliche Unterschiede auf:

1. Der Zugriff auf Bäume erfolgt über einen Objektbefehl, während der Zugriff auf Arrays über Variablen erfolgt. (Das bedeutet, dass Bäume nicht lokal zu einer Prozedur sein können.)

2. Bäume weisen eine hierarchische Struktur auf, während ein Array lediglich eine ungeordnete Sammlung ist.

3. Jeder Knoten eines Baums verfügt über eine eigene Sammlung von Attributen und Werten. Dies entspricht einem Array, bei dem jeder Wert ein Dictionary ist.


*Hinweis:* Die Hauptversion des Pakets **struct** ist wegen inkompatibler Änderungen an der API dieses Moduls auf 2.0 gewechselt. Die vollständige Liste aller Änderungen, inkompatibler und anderer, finden Sie im Abschnitt [Änderungen in Version 2.0].

# API

## Tree-Klasse-API

Die wichtigsten Befehle des Pakets lauten:

**::struct::tree** ?*treeName*? ?**=**|**:=**|**as**|**deserialize** *source*?
: Der Befehl erzeugt ein neues Baumobjekt mit einem zugehörigen globalen Tcl-Befehl, dessen Name *treeName* lautet. Mit diesem Befehl lassen sich verschiedene Operationen auf dem Baum aufrufen. Er hat die folgende allgemeine Form:

    **treeName** **option** ?*arg arg ...*?
    : *Option* und die *arg*s bestimmen das genaue Verhalten des Befehls.


    Ist *treeName* nicht angegeben, erzeugt das Paket selbst einen eindeutigen Namen. Ist eine *source* angegeben, wird der neue Baum daraus initialisiert. Bei den Operatoren **=**, **:=** und **as** wird *source* als Name eines anderen Baumobjekts interpretiert, und der Zuweisungsoperator **=** wird ausgeführt. Bei **deserialize** ist *source* ein serialisiertes Baumobjekt, und **deserialize** wird ausgeführt.

    Mit anderen Worten:

    ```
        ::struct::tree mytree = b
    ```

    entspricht

    ```
        ::struct::tree mytree
        mytree = b
    ```

    und

    ```
        ::struct::tree mytree deserialize $b
    ```

    entspricht

    ```
        ::struct::tree mytree
        mytree deserialize $b
    ```

**::struct::tree::prune**
: Dieser Befehl steht außerhalb der Baummethoden, da er selbst keine Baummethode ist. Er wirkt jedoch eng mit der Methode **walk** zusammen. Im walk-Skript verwendet, bewirkt er, dass der Durchlauf die Kindknoten des aktuellen Knotens überspringt. Dieser Befehl kann nicht mit den Durchlaufarten verwendet werden, die Kindknoten vor ihrem Elternknoten besuchen, d. h. **post** und **in**. Zulässig sind nur die Durchlaufreihenfolgen **pre** und **both**. Passen Befehl und gewählte Durchlaufreihenfolge nicht zusammen, wird ein Fehler ausgelöst.


## API für Baumobjekte

Zuvor zwei allgemeine Anmerkungen:

1. Der Wurzelknoten des Baums kann an den meisten Stellen verwendet werden, an denen ein Knoten verlangt wird. Der Standardname des Wurzelknotens lautet „root“, dieser kann jedoch mit der Methode **rename** geändert werden (siehe unten). Wie auch immer der Wurzelknoten des Baums gerade heißt, sein Name lässt sich mit der Methode **rootname** abfragen.

2. Die Methode **insert** ist die einzige Möglichkeit, neue Knoten anzulegen; sie werden automatisch einem Elternknoten zugeordnet. Ein Baumobjekt kann außer dem Wurzelknoten keine Knoten ohne Elternknoten enthalten.


Und nun die Methoden, die die von diesem Paket erzeugten Baumobjekte unterstützen:

*treeName* **=** *sourcetree*
: Dies ist der Zuweisungsoperator für Baumobjekte. Er kopiert den im Baumobjekt *sourcetree* enthaltenen Baum über die Baumdaten in *treeName*. Der bisherige Inhalt von *treeName* wird durch diesen Vorgang gelöscht.

    Dieser Vorgang entspricht im Wesentlichen

    ```
        treeName deserialize [sourcetree serialize]
    ```

*treeName* **-->** *desttree*
: Dies ist der umgekehrte Zuweisungsoperator für Baumobjekte. Er kopiert den im Baumobjekt *treeName* enthaltenen Baum über die Baumdaten im Objekt *desttree*. Der bisherige Inhalt von *desttree* wird durch diesen Vorgang gelöscht.

    Dieser Vorgang entspricht im Wesentlichen

    ```
        desttree deserialize [treeName serialize]
    ```

*treeName* **ancestors** *node*
: Diese Methode erweitert die Methode **parent** und gibt eine Liste aller Vorfahren des angegebenen *node* zurück. Der unmittelbare Vorfahr, also der Elternknoten, ist das erste Element dieser Liste, dessen Elternknoten das zweite Element und so weiter, bis der Wurzelknoten erreicht ist, der somit das letzte Element der zurückgegebenen Liste bildet.

*treeName* **append** *node* *key* *value*
: Hängt *value* an einen der Werte an, die einem Knoten unter einem Schlüssel zugeordnet sind. Gibt den neuen Wert des Attributs *key* zurück.

*treeName* **attr** *key*
: siehe unten ...

*treeName* **attr** *key* **-nodes** *list*
: siehe unten ...

*treeName* **attr** *key* **-glob** *globpattern*
: siehe unten ...

*treeName* **attr** *key* **-regexp** *repattern*
: Diese Methode ruft den Wert des Attributs mit dem Namen *key* für alle Knoten im Baum ab, die der über eine der möglichen Optionen festgelegten Einschränkung entsprechen und das angegebene Attribut besitzen.

    Das Ergebnis ist ein Dictionary, das Knotennamen den Werten des Attributs *key* an diesen Knoten zuordnet. Knoten, die das Attribut *key* nicht besitzen oder eine angegebene Einschränkung nicht erfüllen, werden im Ergebnis nicht aufgeführt.

    Die möglichen Einschränkungen sind:

    **-nodes**
    : Der Wert ist eine Liste von Knoten. Nur die in dieser Liste aufgeführten Knoten werden nach dem Attribut durchsucht.

    **-glob**
    : Der Wert ist ein Glob-Muster. Nur die Knoten im Baum, deren Namen diesem Muster entsprechen, werden nach dem Attribut durchsucht.

    **-regexp**
    : Der Wert ist ein regulärer Ausdruck. Nur die Knoten im Baum, deren Namen diesem Muster entsprechen, werden nach dem Attribut durchsucht.


*treeName* **children** ?**-all**? *node* ?**filter** *cmdprefix*?
: Gibt eine Liste der Kindknoten von *node* zurück. Ist die Option **-all** angegeben, enthält das Ergebnis nicht nur die direkten Kindknoten, sondern auch deren Kindknoten usw. Ist ein Filterbefehl angegeben, enthält das Endergebnis nur die Knoten, die den Test bestehen. Der Befehl in *cmdprefix* wird mit zwei Argumenten aufgerufen: dem Namen des Baumobjekts und dem Namen des betreffenden Knotens. Er wird im Kontext des Aufrufers ausgeführt und muss einen booleschen Wert zurückgeben. Knoten, für die der Befehl **false** zurückgibt, werden aus der Ergebnisliste entfernt, bevor diese an den Aufrufer zurückgegeben wird.

    Einige Beispiele:

    ```
        mytree insert root end 0 ; mytree set 0 volume 30
        mytree insert root end 1
        mytree insert root end 2
        mytree insert 0    end 3
        mytree insert 0    end 4
        mytree insert 4    end 5 ; mytree set 5 volume 50
        mytree insert 4    end 6

        proc vol {t n} {
    	$t keyexists $n volume
        }
        proc vgt40 {t n} {
    	if {![$t keyexists $n volume]} {return 0}
    	expr {[$t get $n volume] > 40}
        }

        tclsh> lsort [mytree children -all root filter vol]
        0 5

        tclsh> lsort [mytree children -all root filter vgt40]
        5

        tclsh> lsort [mytree children root filter vol]
        0

        tclsh> puts ([lsort [mytree children root filter vgt40]])
        ()
    ```

*treeName* **cut** *node*
: Entfernt den durch *node* festgelegten Knoten aus dem Baum, jedoch nicht dessen Kinder. Die Kinder von *node* werden zu Kindern des Elternknotens von *node*, und zwar an dem Index, an dem *node* stand.

*treeName* **delete** *node* ?*node* ...?
: Entfernt die angegebenen Knoten aus dem Baum. Alle Kindknoten dieser Knoten werden ebenfalls entfernt, damit keine verwaisten Knoten zurückbleiben.

*treeName* **depth** *node*
: Gibt die Anzahl der Schritte vom Knoten *node* zum Wurzelknoten zurück.

*treeName* **descendants** *node* ?**filter** *cmdprefix*?
: Diese Methode erweitert die Methode **children** und gibt eine Liste zurück, die alle Knoten enthält, die von *node* abstammen und den Filter erfüllen, wenn ein solcher angegeben wurde.

    Das ist dasselbe wie „*treeName* **children** **-all**“. **descendants** ist vorzuziehen; „children -all“ wird irgendwann als veraltet erklärt.

*treeName* **deserialize** *serialization*
: Das Gegenstück zu **serialize**. Ersetzt die Baumdaten in *treeName* durch den Baum, den der Wert *serialization* beschreibt. Der bisherige Inhalt von *treeName* wird durch diesen Vorgang gelöscht.

*treeName* **destroy**
: Zerstört den Baum einschließlich seines Speichers und des zugehörigen Befehls.

*treeName* **exists** *node*
: Gibt true zurück, wenn der angegebene Knoten im Baum existiert.

*treeName* **get** *node* *key*
: Gibt den Wert zurück, der dem Schlüssel *key* für den Knoten *node* zugeordnet ist.

*treeName* **getall** *node* ?*pattern*?
: Gibt ein Dictionary zurück (geeignet für die Verwendung mit \[**array set**\]), das die Attributdaten von *node* enthält. Ist das glob-Muster *pattern* angegeben, sind nur die Attribute, deren Namen mit dem Muster übereinstimmen, Bestandteil des Dictionarys.

*treeName* **keys** *node* ?*pattern*?
: Gibt eine Liste der Schlüssel von *node* zurück. Ist *pattern* angegeben, enthält die zurückgegebene Liste nur die Attribute, deren Namen auf das Muster passen. Das Muster ist ein **glob**-Muster.

*treeName* **keyexists** *node* *key*
: Gibt true zurück, wenn der angegebene *key* für *node* existiert.

*treeName* **index** *node*
: Gibt den Index von *node* in der Kinderliste seines Elternknotens zurück. Hat ein Knoten beispielsweise *nodeFoo*, *nodeBar* und *nodeBaz* in dieser Reihenfolge als Kinder, beträgt der Index von *nodeBar* 1.

*treeName* **insert** *parent* *index* ?*child* ?*child* ...??
: Fügt einen oder mehrere Knoten als Kinder des Knotens *parent* in den Baum ein. Die Knoten werden in der Reihenfolge hinzugefügt, in der sie angegeben werden. Wenn *parent* gleich **root** ist, bezieht sich dies auf die Wurzel des Baums. Die neuen Knoten werden an der durch *index* angegebenen Position in die Kinderliste des Knotens *parent* eingefügt. *index* kann **end** sein; dann werden die neuen Knoten hinter dem derzeit letzten Kind eingefügt. Indizes in der Form „end-**n**“ werden ebenfalls akzeptiert.

    Existieren angegebene Kinder bereits in *treeName*, werden diese Knoten von ihrer bisherigen Stelle an die von diesem Befehl angegebene neue Stelle verschoben.

    Wird kein *child* angegeben, wird ein einzelner Knoten hinzugefügt und ein Name für den neuen Knoten generiert. Der generierte Name hat die Form *node*__x__, wobei **x** eine Zahl ist. Angegebene Namen dürfen weder Leerraum noch Doppelpunkte („:“) enthalten.

    Das Ergebnis dieses Befehls ist eine Liste der hinzugefügten Knoten.

*treeName* **isleaf** *node*
: Gibt true zurück, wenn *node* ein Blatt des Baums ist (d. h., wenn *node* keine Kinder hat), sonst false.

*treeName* **lappend** *node* *key* *value*
: Hängt *value* (als Liste) an einen der Werte an, die *node* unter einem Schlüssel zugeordnet sind. Gibt den neuen Wert des Attributs *key* zurück.

*treeName* **leaves**
: Gibt eine Liste aller Blattknoten des Baums zurück.

*treeName* **move** *parent* *index* *node* ?*node* ...?
: Macht die angegebenen Knoten zu Kindern von *parent* und fügt sie an dem durch *index* angegebenen Index in die Kinderliste des Elternknotens ein. Beachten Sie, dass der Befehl alle Knoten aus dem Baum herausnimmt, bevor er sie unter dem neuen Elternknoten einfügt, und dass er die Einfügeposition nach dem Herausnehmen und vor dem erneuten Einfügen bestimmt. Das ist wichtig, wenn ein oder mehrere Knoten an einen anderen Index verschoben werden sollen, ohne dass sich ihr Elternknoten ändert.

*treeName* **next** *node*
: Gibt den rechten Geschwisterknoten von *node* zurück oder die leere Zeichenkette, wenn *node* das letzte Kind seines Elternknotens war.

*treeName* **numchildren** *node*
: Gibt die Anzahl der direkten Kinder von *node* zurück.

*treeName* **nodes**
: Gibt eine Liste aller Knoten des Baums zurück.

*treeName* **parent** *node*
: Gibt den Elternknoten von *node* zurück.

*treeName* **previous** *node*
: Gibt den linken Geschwisterknoten von *node* zurück oder die leere Zeichenkette, wenn *node* das erste Kind seines Elternknotens war.

*treeName* **rename** *node* *newname*
: Benennt den Knoten *node* in *newname* um. Es wird ein Fehler ausgelöst, wenn der Knoten entweder nicht existiert oder bereits ein Knoten mit dem Namen *newname* vorhanden ist. Das Ergebnis des Befehls ist der neue Name des Knotens.

*treeName* **rootname**
: Gibt den Namen des Wurzelknotens des Baums zurück.

*treeName* **serialize** ?*node*?
: Diese Methode serialisiert den Teilbaum, der bei *node* beginnt. Mit anderen Worten: Sie gibt einen Tcl-*value* zurück, der den bei *node* beginnenden Baum vollständig beschreibt. Dies ermöglicht beispielsweise die Übertragung von Baumobjekten (oder Teilen davon) über beliebige Kanäle, die dauerhafte Speicherung usw. Diese Methode ist zudem die Grundlage für Kopierkonstruktor und Zuweisungsoperator.

    Das Ergebnis dieser Methode muss über alle Implementierungen der Baumschnittstelle hinweg semantisch identisch sein. Erst das erlaubt es, Baumdaten zwischen verschiedenen Implementierungen derselben Schnittstelle zu kopieren.

    Das Ergebnis ist eine Liste, die ein Vielfaches von drei Elementen enthält. Sie ähnelt einem serialisierten Array, nur dass auf jeden Schlüssel zwei Werte folgen. Die Schlüssel sind die Namen der Knoten im serialisierten Baum. Die beiden Werte sind, in dieser Reihenfolge, ein Verweis auf den Elternknoten und die Attributdaten.

    Für den Wurzelknoten des Baums ist der Verweis auf den Elternknoten die leere Zeichenkette. Bei allen anderen Knoten ist es der Index des Elternknotens in der Liste. Es sind also ganze Zahlen größer oder gleich null, kleiner als die Länge der Liste und Vielfache von drei. Die Reihenfolge der Knoten in der Liste ist insofern wichtig, als aus ihr die Kinderlisten jedes Knotens rekonstruiert werden. Die Kinder eines Knotens müssen in der Serialisierung in derselben Reihenfolge stehen wie bei ihrem Elternknoten im Baum.

    Die Attributdaten eines Knotens sind ein Dictionary, d. h. eine Liste mit gerader Länge, die ein serialisiertes Array enthält. Bei einem Knoten ohne Attributdaten ist das Dictionary die leere Liste.

    *Hinweis:* Die aktuelle Implementierung liefert den Wurzelknoten als erstes Element der Liste, gefolgt von seinen Kindern und deren Kindern in Tiefensuche-Reihenfolge; das gilt aber nicht zwangsläufig für andere Implementierungen. Die einzige Information, auf die sich ein Leser der serialisierten Daten hinsichtlich der Struktur des Baums verlassen kann, ist, dass der Wurzelknoten durch die leere Zeichenkette für die Elternreferenz gekennzeichnet ist, dass alle anderen Knoten über den Index in der Liste auf ihren Elternknoten verweisen und dass die Kinder in derselben Reihenfolge auftreten wie in ihrem Elternknoten.

    ```
     A possible serialization for the tree structure

                 +- d
           +- a -+
     root -+- b  +- e
           +- c
     is

     {root {} {} a 0 {} d 3 {} e 3 {} b 0 {} c 0 {}}

     The above assumes that none of the nodes have attributes.
    ```

*treeName* **set** *node* *key* ?*value*?
: Setzt oder liest einen der Werte, die einem Knoten unter einem Schlüssel zugeordnet sind. Einem Knoten können beliebig viele solcher Werte zugeordnet sein.  Wenn *value* nicht angegeben wird, gibt dieser Befehl den aktuell dem Schlüssel zugewiesenen Wert zurück; wenn *value* angegeben wird, weist dieser Befehl dem Schlüssel diesen Wert zu und gibt ihn zurück.

*treeName* **size** ?*node*?
: Gibt die Anzahl der Nachkommen des Knotens *node* zurück; ist kein Knoten angegeben, wird **root** angenommen.

*treeName* **splice** *parent* *from* ?*to*? ?*child*?
: Fügt einen Knoten mit dem Namen *child* als Kind des Knotens *parent* in den Baum ein. Ist *parent* gleich **root**, ist die Wurzel des Baums gemeint. Der neue Knoten wird an dem durch *from* angegebenen Index in die Kinderliste des Elternknotens eingefügt.  Die Kinder von *parent*, die im Bereich der Indizes *from* und *to* liegen, werden zu Kindern von *child* gemacht.  Ist *to* nicht angegeben, ist der Standardwert **end**.  Wenn für *child* kein Name angegeben wird, wird für den neuen Knoten ein Name generiert. Der generierte Name hat die Form *node*__x__, wobei **x** eine Zahl ist.  Der Befehl gibt den Namen des neuen Knotens zurück.

    Die Argumente *from* und *to* sind reguläre Listenindizes, d. h. auch die Form „end-**n**“ wird akzeptiert.

*treeName* **swap** *node1* *node2*
: Vertauscht die Positionen von *node1* und *node2* im Baum.

*treeName* **unset** *node* *key*
: Entfernt einen Wert unter einem Schlüssel vom Knoten *node*. Existiert *key* nicht, tut die Methode nichts.

*treeName* **walk** *node* ?**-order** *order*? ?**-type** *type*? *loopvar* *script*
: Durchläuft den Baum in Breiten- oder Tiefensuche, beginnend am Knoten *node*. Die Art des Durchlaufs – Breitensuche oder Tiefensuche – wird durch den Wert von *type* bestimmt; **bfs** steht für die Breitensuche, **dfs** für die Tiefensuche.  Die Tiefensuche ist die Standardeinstellung. Die Reihenfolge der Durchquerung – Pre-Order, Post-Order, Both-Order oder In-Order – wird durch den Wert von *order* bestimmt; **pre** steht für „Pre-Order“, **post** für „Post-Order“, **both** für „Both-Order“ und **in** für „In-Order“. „Pre-Order“ ist die Standardeinstellung.

    „Pre-Order“-Durchlauf bedeutet, dass ein Elternknoten vor allen seinen Kindern besucht wird.  Beispielsweise besucht eine Breitensuche, die an der Wurzel beginnt, zunächst die Wurzel, gefolgt von allen Kindern der Wurzel und anschließend von allen Enkelknoten der Wurzel. „Post-Order“-Durchlauf bedeutet, dass ein Elternknoten nach allen seinen Kindern besucht wird. „Both-Order“-Durchlauf bedeutet, dass ein Elternknoten sowohl vor *als auch* nach allen seinen Kindern besucht wird. „In-Order“-Durchlauf bedeutet, dass ein Elternknoten nach seinem ersten Kind und vor dem zweiten besucht wird. Dies ist eine Verallgemeinerung des „In-Order“-Durchlaufs für Binärbäume und führt zu dem gewünschten Ergebnis, wenn ein Binärbaum durchlaufen wird. Die Kombination einer Breitensuche mit einer In-Order-Durchquerung ist unzulässig.

    Im Verlauf des Durchlaufs wird *script* an jedem Knoten ausgewertet. Die Auswertung erfolgt im Kontext des Aufrufers der Methode. Die Schleifenvariablen stehen in *loopvar*. Ist nur eine Variable angegeben, wird sie auf die ID des Knotens gesetzt. Sind zwei Variablen angegeben, d. h. *loopvar* ist eine echte Liste, wird die erste Variable auf die am Knoten ausgeführte Aktion gesetzt und die andere auf die ID des Knotens selbst. Alle Schleifenvariablen werden im Kontext des Aufrufers angelegt.

    Es gibt drei mögliche Aktionen: **enter**, **leave** oder **visit**.  **enter**-Aktionen finden bei Pre-Order-Durchläufen statt; **leave**-Aktionen finden bei Post-Order-Durchläufen statt; **visit**-Aktionen finden bei In-Order-Durchläufen statt.  Bei einem „Both-Order“-Durchlauf wird der Befehl für jeden Knoten zweimal ausgewertet; die Aktion lautet **enter** für die erste Auswertung und **leave** für die zweite.

    *Hinweis*: Die Aktion **enter** für einen Knoten wird immer ausgeführt, bevor der Walker die Kinder dieses Knotens untersucht. Das bedeutet, dass Änderungen, die *script* an den Kindern des Knotens vornimmt, sich unmittelbar auf den Walker und die von ihm ausgeführten Schritte auswirken.

    Jede andere Manipulation, beispielsweise an Knoten, die in der Baumstruktur höher liegen (d. h. bereits besucht wurden), oder beim Verlassen des Knotens, führt zu undefinierten Ergebnissen. Diese können erfolgreich sein, zu einem Fehler führen, stillschweigend ein falsches Ergebnis berechnen oder irgendetwas dazwischen.

    Abschließend eine kleine Tabelle, die die Zusammenhänge zwischen den verschiedenen Optionen und den möglichen Aktionen veranschaulicht.

    ```
     order       type    actions         notes
     -----       ----    -----           -----
     pre         dfs     enter           parent before children
     post        dfs     leave           parent after children
     in          dfs     visit           parent between first and second child.
     both        dfs     enter, leave    parent before and after children
     -----       ----    -----           -----
     pre         bfs     enter           parent before children
     post        bfs     leave           parent after children
     in          bfs             -- illegal --
     both        bfs     enter, leave    parent before and after children
     -----       ----    -----           -----
    ```

    Beachten Sie den Befehl **::struct::tree::prune**. Mit diesem Befehl im walk-Skript lässt sich erzwingen, dass der Durchlauf die Kindknoten des aktuellen Knotens überspringt. Ist die Durchlaufreihenfolge **post** oder **in**, löst er einen Fehler aus, da diese Modi die Kinder vor ihrem Elternknoten besuchen und das Beschneiden dann sinnlos ist.

*treeName* **walkproc** *node* ?**-order** *order*? ?**-type** *type*? *cmdprefix*
: Diese Methode entspricht in allen wesentlichen Punkten der Methode **walk**, mit Ausnahme der Schnittstelle zum Benutzercode. Diese Methode ruft ein Befehlspräfix mit drei zusätzlichen Argumenten (Baum, Knoten und Aktion) auf, anstatt ein Skript auszuwerten und den Knoten über eine Schleifenvariable zu übergeben.


## Änderungen in Version 2.0

Die folgenden nennenswerten Änderungen sind eingetreten:

1. Die API für den Zugriff auf Attribute und deren Werte wurde vereinfacht.

    Alle Funktionen im Zusammenhang mit dem Standardattribut „data“ wurden entfernt. Dieses Standardattribut existiert nicht mehr. Bei allen Zugriffen auf Attribute muss der Name des jeweiligen Attributs angegeben werden. Diese *inkompatible* Änderung ermöglichte es uns, die Signatur aller Methoden, die mit Attributen arbeiten, zu vereinfachen.

    Insbesondere das Flag **-key** ist nicht mehr erforderlich; mehr noch, seine Verwendung ist nun untersagt. Bitte lesen Sie die Dokumentation zu den Methoden **set**, **get**, **getall**, **unset**, **append**, **lappend**, **keyexists** und **keys**, um eine Beschreibung der neuen APIs zu erhalten.

2. Die Methoden **keys** und **getall** akzeptieren nun ein optionales Muster-Argument und geben nur noch Attributdaten für Schlüssel zurück, die diesem Muster entsprechen.

3. Knoten können nun umbenannt werden. Weitere Informationen finden Sie in der Dokumentation zur Methode **rename**.

4. Die Struktur wurde um APIs für die Serialisierung und Deserialisierung von Baumobjekten sowie um eine Reihe darauf basierender Operationen (Baumzuweisung, Kopierkonstruktion) erweitert.

    Bitte lesen Sie die Dokumentation zu den Methoden **serialize**, **deserialize**, **=** und **-->** sowie die Dokumentation zum Erzeugen von Baumobjekten.

    Über das Kopieren ganzer Baumobjekte hinaus ermöglichen diese neuen APIs auch die Übertragung von Baumobjekten über beliebige Kanäle und ein einfaches dauerhaftes Speichern.

5. Die Walker-API wurde verschlankt und stärker an den Befehl **foreach** angeglichen. Im Einzelnen:

    - Die überflüssige Option **-command** wurde entfernt.

    - Ebenso die Platzhalter. Statt der Platzhalter sind zwei Schleifenvariablen anzugeben, die Knoten und Aktion aufnehmen.

    - Das alte Befehlsargument ist jetzt als Skript dokumentiert, was es auch früher schon war.

    - Dass **enter**-Aktionen aufgerufen werden, bevor der Walker die Kinder eines Knotens betrachtet, ist nun dokumentiert. Mit anderen Worten: Es ist nun offiziell zulässig, die Kinderliste eines Knotens unter *diesen* Umständen zu manipulieren. Es wurde klargestellt, dass Änderungen unter allen anderen Umständen zu undefinierten Ergebnissen führen können – von der stillschweigenden Berechnung eines falschen Ergebnisses bis hin zum Auftreten eines Fehlers.


6. Es wurde eine neue Methode, **attr**, hinzugefügt, die die Abfrage und den Abruf von Attributdaten unabhängig von der Knotenbeziehung ermöglicht.

7. Die Methode **children** wurde um die Möglichkeit erweitert, anhand eines beliebigen Filterkriteriums unter den Kindern des Knotens auszuwählen. Eine weitere Erweiterung besteht darin, dass nicht nur die direkten Kinder des Knotens, sondern der gesamte darunterliegende Baum berücksichtigt werden kann.


# Beispiele

Das folgende Beispiel zeigt das Anlegen neuer Knoten:

```
    mytree insert root end 0   ; # Create node 0, as child of the root
    mytree insert root end 1 2 ; # Ditto nodes 1 & 2
    mytree insert 0    end 3   ; # Now create node 3 as child of node 0
    mytree insert 0    end     ; # Create another child of 0, with a
    #                              generated name. The name is returned
    #                              as the result of the command.
```

# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *struct :: tree* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Datenstrukturen

# Copyright

```
Copyright (c) 2002-2004,2012 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
