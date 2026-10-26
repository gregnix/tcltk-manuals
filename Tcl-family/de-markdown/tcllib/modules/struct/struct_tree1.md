---
CommandName: struct::tree_v1
ManualSection: n
Version: 1.2.3
TclPart: tcllib
TclDescription: Tcl Data Structures
Keywords:
 - tree
Copyright:
 - Copyright (c) 2002 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

struct::tree_v1 – Baumobjekte anlegen und bearbeiten

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [struct::tree]{.lit} [1.2.3]{.optlit} 
[treeName]{.cmd} [option]{.sub} [arg arg]{.optdot} 
[treeName]{.ins} [append]{.sub} [node]{.arg} [-key key]{.optarg} [value]{.arg} 
[treeName]{.ins} [children]{.sub} [node]{.arg} 
[treeName]{.ins} [cut]{.sub} [node]{.arg} 
[treeName]{.ins} [delete]{.sub} [node]{.arg} [node]{.optdot} 
[treeName]{.ins} [depth]{.sub} [node]{.arg} 
[treeName]{.ins} [destroy]{.sub} 
[treeName]{.ins} [exists]{.sub} [node]{.arg} 
[treeName]{.ins} [get]{.sub} [node]{.arg} [-key key]{.optarg} 
[treeName]{.ins} [getall]{.sub} [node]{.arg} 
[treeName]{.ins} [keys]{.sub} [node]{.arg} 
[treeName]{.ins} [keyexists]{.sub} [node]{.arg} [-key key]{.optarg} 
[treeName]{.ins} [index]{.sub} [node]{.arg} 
[treeName]{.ins} [insert]{.sub} [parent]{.arg} [index]{.arg} [child ?child]{.optdot} 
[treeName]{.ins} [isleaf]{.sub} [node]{.arg} 
[treeName]{.ins} [lappend]{.sub} [node]{.arg} [-key key]{.optarg} [value]{.arg} 
[treeName]{.ins} [move]{.sub} [parent]{.arg} [index]{.arg} [node]{.arg} [node]{.optdot} 
[treeName]{.ins} [next]{.sub} [node]{.arg} 
[treeName]{.ins} [numchildren]{.sub} [node]{.arg} 
[treeName]{.ins} [parent]{.sub} [node]{.arg} 
[treeName]{.ins} [previous]{.sub} [node]{.arg} 
[treeName]{.ins} [set]{.sub} [node]{.arg} [-key key]{.optarg} [value]{.optarg} 
[treeName]{.ins} [size]{.sub} [node]{.optarg} 
[treeName]{.ins} [splice]{.sub} [parent]{.arg} [from]{.arg} [to]{.optarg} [child]{.optarg} 
[treeName]{.ins} [swap]{.sub} [node1]{.arg} [node2]{.arg} 
[treeName]{.ins} [unset]{.sub} [node]{.arg} [-key key]{.optarg} 
[treeName]{.ins} [walk]{.sub} [node]{.arg} [-order order]{.optarg} [-type type]{.optarg} [-command]{.lit} [cmd]{.arg} 
:::

# BESCHREIBUNG

Der Befehl **::struct::tree** erzeugt ein neues Baumobjekt mit einem zugehörigen globalen Tcl-Befehl, dessen Name *treeName* lautet. Mit diesem Befehl lassen sich verschiedene Operationen auf dem Baum aufrufen. Er hat die folgende allgemeine Form:

**treeName** **option** ?*arg arg ...*?
: *Option* und die *arg*s bestimmen das genaue Verhalten des Befehls. Ein Baum ist eine Sammlung benannter Elemente, Knoten genannt, von denen einer als Wurzel ausgezeichnet ist, zusammen mit einer Beziehung („Elternschaft“), die den Knoten eine hierarchische Struktur gibt. (Data Structures and Algorithms; Aho, Hopcroft und Ullman; Addison-Wesley, 1987).  Neben der Verwaltung der Knotenbeziehungen erlaubt diese Baumimplementierung, jedem Knoten beliebig viele Werte unter Schlüsseln zuzuordnen. Die Namen der Elemente können beliebige Zeichenketten sein. Ein Baum ähnelt somit einem Array, weist jedoch drei wesentliche Unterschiede auf:


**\[1\]**
: Der Zugriff auf Bäume erfolgt über einen Objektbefehl, während der Zugriff auf Arrays über Variablen erfolgt. (Das bedeutet, dass Bäume nicht lokal zu einer Prozedur sein können.)

**\[2\]**
: Bäume weisen eine hierarchische Struktur auf, während ein Array lediglich eine ungeordnete Sammlung ist.

**\[3\]**
: Jeder Knoten eines Baums verfügt über eine eigene Sammlung von Attributen und Werten. Dies entspricht einem Array, bei dem jeder Wert ein Dictionary ist. Für Baumobjekte sind folgende Befehle möglich:


*treeName* **append** *node* ?-key *key*? *value*
: Hängt *value* an einen der Werte an, die einem Knoten unter einem Schlüssel zugeordnet sind. Ist kein *key* angegeben, wird der Schlüssel **data** angenommen.

*treeName* **children** *node*
: Gibt eine Liste der Kindknoten von *node* zurück.

*treeName* **cut** *node*
: Entfernt den durch *node* festgelegten Knoten aus dem Baum, jedoch nicht dessen Kinder. Die Kinder von *node* werden zu Kindern des Elternknotens von *node*, und zwar an dem Index, an dem *node* stand.

*treeName* **delete** *node* ?*node* ...?
: Entfernt die angegebenen Knoten aus dem Baum. Alle Kindknoten dieser Knoten werden ebenfalls entfernt, damit keine verwaisten Knoten zurückbleiben.

*treeName* **depth** *node*
: Gibt die Anzahl der Schritte vom Knoten *node* zum Wurzelknoten zurück.

*treeName* **destroy**
: Zerstört den Baum einschließlich seines Speichers und des zugehörigen Befehls.

*treeName* **exists** *node*
: Gibt true zurück, wenn der angegebene Knoten im Baum existiert.

*treeName* **get** *node* ?**-key** *key*?
: Gibt den Wert zurück, der dem Schlüssel *key* für den Knoten *node* zugeordnet ist. Ist kein Schlüssel angegeben, wird der Schlüssel **data** angenommen.

*treeName* **getall** *node*
: Gibt eine serialisierte Liste von Schlüssel-Wert-Paaren (geeignet für \[**array set**\]) für *node* zurück.

*treeName* **keys** *node*
: Gibt eine Liste der Schlüssel von *node* zurück.

*treeName* **keyexists** *node* ?-key *key*?
: Gibt wahr zurück, wenn der angegebene *key* für *node* existiert. Ist kein *key* angegeben, gilt der Schlüssel **data**.

*treeName* **index** *node*
: Gibt den Index von *node* in der Kinderliste seines Elternknotens zurück. Hat ein Knoten beispielsweise *nodeFoo*, *nodeBar* und *nodeBaz* in dieser Reihenfolge als Kinder, beträgt der Index von *nodeBar* 1.

*treeName* **insert** *parent* *index* ?*child* ?*child* ...??
: Fügt einen oder mehrere Knoten als Kinder des Knotens *parent* in den Baum ein. Die Knoten werden in der Reihenfolge hinzugefügt, in der sie angegeben werden. Ist *parent* gleich **root**, bezieht sich dies auf die Wurzel des Baums. Die neuen Knoten werden an dem durch *index* angegebenen Index in die Kinderliste des Knotens *parent* eingefügt. *index* kann **end** sein; dann werden die neuen Knoten hinter dem derzeit letzten Kind eingefügt. Existieren angegebene Kinder bereits in *treeName*, werden diese Knoten von ihrer bisherigen Stelle an die von diesem Befehl angegebene neue Stelle verschoben. Wird kein *child* angegeben, wird ein einzelner Knoten hinzugefügt, und für den neuen Knoten wird ein Name generiert. Der generierte Name hat die Form *node*__x__, wobei **x** eine Zahl ist. Angegebene Namen dürfen weder Leerraum noch Doppelpunkte („:“) enthalten. Das Ergebnis dieses Befehls ist eine Liste der hinzugefügten Knoten.

*treeName* **isleaf** *node*
: Gibt true zurück, wenn *node* ein Blatt des Baums ist (d. h., wenn *node* keine Kinder hat), sonst false.

*treeName* **lappend** *node* ?-key *key*? *value*
: Hängt einen *value* (als Liste) an einen der *node* zugeordneten Schlüsselwerte an. Ist kein *key* angegeben, gilt der Schlüssel **data**.

*treeName* **move** *parent* *index* *node* ?*node* ...?
: Macht die angegebenen Knoten zu Kindern von *parent* und fügt sie an dem durch *index* angegebenen Index in die Kinderliste des Elternknotens ein. Beachten Sie, dass der Befehl alle Knoten aus dem Baum herausnimmt, bevor er sie unter dem neuen Elternknoten einfügt, und dass er die Einfügeposition nach dem Herausnehmen und vor dem erneuten Einfügen bestimmt. Das ist wichtig, wenn ein oder mehrere Knoten an einen anderen Index verschoben werden sollen, ohne dass sich ihr Elternknoten ändert.

*treeName* **next** *node*
: Gibt den rechten Geschwisterknoten von *node* zurück oder die leere Zeichenkette, wenn *node* das letzte Kind seines Elternknotens war.

*treeName* **numchildren** *node*
: Gibt die Anzahl der direkten Kinder von *node* zurück.

*treeName* **parent** *node*
: Gibt den Elternknoten von *node* zurück.

*treeName* **previous** *node*
: Gibt den linken Geschwisterknoten von *node* zurück oder die leere Zeichenkette, wenn *node* das erste Kind seines Elternknotens war.

*treeName* **set** *node* ?**-key** *key*? ?*value*?
: Setzt oder liest einen der Werte, die einem Knoten unter einem Schlüssel zugeordnet sind. Ist kein Schlüssel angegeben, wird der Schlüssel **data** angenommen. Bei jedem Knoten, der einem Baum hinzugefügt wird, erhält der Schlüssel **data** automatisch den Wert "".  Einem Knoten können beliebig viele solcher Werte zugeordnet sein.  Ist *value* nicht angegeben, gibt dieser Befehl den aktuell dem Schlüssel zugewiesenen Wert zurück; ist *value* angegeben, weist dieser Befehl dem Schlüssel diesen Wert zu.

*treeName* **size** ?*node*?
: Gibt die Anzahl der Nachkommen des Knotens *node* zurück; ist kein Knoten angegeben, wird **root** angenommen.

*treeName* **splice** *parent* *from* ?*to*? ?*child*?
: Fügt einen Knoten mit dem Namen *child* als Kind des Knotens *parent* in den Baum ein. Ist *parent* gleich **root**, ist die Wurzel des Baums gemeint. Der neue Knoten wird an dem durch *from* angegebenen Index in die Kinderliste des Elternknotens eingefügt.  Die Kinder von *parent*, die im Bereich der Indizes *from* und *to* liegen, werden zu Kindern von *child* gemacht.  Ist *to* nicht angegeben, ist der Standardwert **end**.  Wenn für *child* kein Name angegeben wird, wird für den neuen Knoten ein Name generiert. Der generierte Name hat die Form *node*__x__, wobei **x** eine Zahl ist. Der Befehl gibt den Namen des neuen Knotens zurück.

*treeName* **swap** *node1* *node2*
: Vertauscht die Positionen von *node1* und *node2* im Baum.

*treeName* **unset** *node* ?**-key** *key*?
: Entfernt einen Wert unter einem Schlüssel vom Knoten *node*. Ist kein Schlüssel angegeben, wird der Schlüssel **data** angenommen.

*treeName* **walk** *node* ?**-order** *order*? ?**-type** *type*? **-command** *cmd*
: Durchläuft den Baum in Breiten- oder Tiefensuche, beginnend am Knoten *node*. Die Art des Durchlaufs – Breitensuche oder Tiefensuche – wird durch den Wert von *type* bestimmt; **bfs** steht für die Breitensuche, **dfs** für die Tiefensuche.  Die Tiefensuche ist die Standardeinstellung. Die Reihenfolge der Durchquerung – Pre-Order, Post-Order, Both-Order oder In-Order – wird durch den Wert von *order* bestimmt; **pre** steht für „Pre-Order“, **post** für „Post-Order“, **both** für „Both-Order“ und **in** für „In-Order“. „Pre-Order“ ist die Standardeinstellung. „Pre-Order“-Durchlauf bedeutet, dass ein Elternknoten vor allen seinen Kindern besucht wird.  Beispielsweise besucht eine Breitensuche, die an der Wurzel beginnt, zunächst die Wurzel, dann alle Kinder der Wurzel und anschließend alle Enkel der Wurzel. „Post-Order“-Durchlauf bedeutet, dass ein Elternknoten nach allen seinen Kindern besucht wird. „Both-Order“-Durchlauf bedeutet, dass ein Elternknoten sowohl vor *als auch* nach allen seinen Kindern besucht wird. Bei der In-Order-Durchquerung wird ein Elternknoten nach seinem ersten Kind und vor dem zweiten besucht. Dies ist eine Verallgemeinerung der In-Order-Durchquerung für Binärbäume und führt zu dem gewünschten Ergebnis, wenn ein Binärbaum durchlaufen wird. Die Kombination einer Breitensuche mit der In-Order-Durchquerung ist unzulässig. Im Verlauf der Durchquerung wird der Befehl *cmd* an jedem Knoten ausgewertet. Vor der Auswertung wird in *cmd* eine Prozentersetzung vorgenommen, genau wie in einem **bind**-Skript. Die folgenden Ersetzungen werden erkannt:


**%%**
: Fügt ein wörtliches Zeichen % ein.

**%t**
: Name des Baumobjekts.

**%n**
: Name des aktuellen Knotens.

**%a**
: Name der stattfindenden Aktion; entweder **enter**, **leave** oder **visit**.  **enter**-Aktionen finden bei Pre-Order-Durchläufen statt; **leave**-Aktionen bei Post-Order-Durchläufen; **visit**-Aktionen bei In-Order-Durchläufen.  Bei einem „Both-Order“-Durchlauf wird der Befehl für jeden Knoten zweimal ausgewertet; die Aktion lautet **enter** für die erste Auswertung und **leave** für die zweite.


# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *struct :: tree* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Datenstrukturen

# COPYRIGHT

```
Copyright (c) 2002 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
