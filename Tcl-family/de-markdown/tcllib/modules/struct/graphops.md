---
CommandName: struct::graph::op
ManualSection: n
Version: 0.11.4
TclPart: tcllib
TclDescription: Tcl Data Structures
Keywords:
 - adjacency list
 - adjacency matrix
 - adjacent
 - approximation algorithm
 - arc
 - articulation point
 - augmenting network
 - augmenting path
 - bfs
 - bipartite
 - blocking flow
 - bridge
 - complete graph
 - connected component
 - cut edge
 - cut vertex
 - degree
 - degree constrained spanning tree
 - diameter
 - dijkstra
 - distance
 - eccentricity
 - edge
 - flow network
 - graph
 - heuristic
 - independent set
 - isthmus
 - level graph
 - local searching
 - loop
 - matching
 - max cut
 - maximum flow
 - minimal spanning tree
 - minimum cost flow
 - minimum degree spanning tree
 - minimum diameter spanning tree
 - neighbour
 - node
 - radius
 - residual graph
 - shortest path
 - squared graph
 - strongly connected component
 - subgraph
 - travelling salesman
 - vertex
 - vertex cover
Copyright:
 - Copyright (c) 2008 Alejandro Paz <vidriloco@gmail.com>
 - Copyright (c) 2008 (docs) Andreas Kupries <andreas_kupries@users.sourceforge.net>
 - Copyright (c) 2009 Michal Antoniewski <antoniewski.m@gmail.com>
---

# NAME

struct::graph::op – Operationen für gerichtete und ungerichtete Graphobjekte

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [struct::graph::op]{.lit} [0.11.4]{.optlit} 
[struct::graph::op::toAdjacencyMatrix]{.cmd} [g]{.arg} 
[struct::graph::op::toAdjacencyList]{.cmd} [g]{.arg} [options]{.optdot} 
[struct::graph::op::kruskal]{.cmd} [g]{.arg} 
[struct::graph::op::prim]{.cmd} [g]{.arg} 
[struct::graph::op::isBipartite?]{.cmd} [g]{.arg} [partitions]{.optarg} 
[struct::graph::op::tarjan]{.cmd} [g]{.arg} 
[struct::graph::op::connectedComponents]{.cmd} [g]{.arg} 
[struct::graph::op::connectedComponentOf]{.cmd} [g]{.arg} [node]{.arg} 
[struct::graph::op::isConnected?]{.cmd} [g]{.arg} 
[struct::graph::op::isCutVertex?]{.cmd} [g]{.arg} [node]{.arg} 
[struct::graph::op::isBridge?]{.cmd} [g]{.arg} [arc]{.arg} 
[struct::graph::op::isEulerian?]{.cmd} [g]{.arg} [tourvar]{.optarg} 
[struct::graph::op::isSemiEulerian?]{.cmd} [g]{.arg} [pathvar]{.optarg} 
[struct::graph::op::dijkstra]{.cmd} [g]{.arg} [start_node]{.arg} [options]{.optdot} 
[struct::graph::op::distance]{.cmd} [g]{.arg} [start_node]{.arg} [end_node]{.arg} [-arcmode mode]{.optarg} 
[struct::graph::op::eccentricity]{.cmd} [g]{.arg} [node]{.arg} [-arcmode mode]{.optarg} 
[struct::graph::op::radius]{.cmd} [g]{.arg} [-arcmode mode]{.optarg} 
[struct::graph::op::diameter]{.cmd} [g]{.arg} [-arcmode mode]{.optarg} 
[struct::graph::op::BellmanFord]{.cmd} [g]{.arg} [startnode]{.arg} 
[struct::graph::op::Johnsons]{.cmd} [g]{.arg} [options]{.optdot} 
[struct::graph::op::FloydWarshall]{.cmd} [g]{.arg} 
[struct::graph::op::MetricTravellingSalesman]{.cmd} [g]{.arg} 
[struct::graph::op::Christofides]{.cmd} [g]{.arg} 
[struct::graph::op::GreedyMaxMatching]{.cmd} [g]{.arg} 
[struct::graph::op::MaxCut]{.cmd} [g]{.arg} [U]{.arg} [V]{.arg} 
[struct::graph::op::UnweightedKCenter]{.cmd} [g]{.arg} [k]{.arg} 
[struct::graph::op::WeightedKCenter]{.cmd} [g]{.arg} [nodeWeights]{.arg} [W]{.arg} 
[struct::graph::op::GreedyMaxIndependentSet]{.cmd} [g]{.arg} 
[struct::graph::op::GreedyWeightedMaxIndependentSet]{.cmd} [g]{.arg} [nodeWeights]{.arg} 
[struct::graph::op::VerticesCover]{.cmd} [g]{.arg} 
[struct::graph::op::EdmondsKarp]{.cmd} [g]{.arg} [s]{.arg} [t]{.arg} 
[struct::graph::op::BusackerGowen]{.cmd} [g]{.arg} [desiredFlow]{.arg} [s]{.arg} [t]{.arg} 
[struct::graph::op::ShortestsPathsByBFS]{.cmd} [g]{.arg} [s]{.arg} [outputFormat]{.arg} 
[struct::graph::op::BFS]{.cmd} [g]{.arg} [s]{.arg} [outputFormat]{.optdot} 
[struct::graph::op::MinimumDiameterSpanningTree]{.cmd} [g]{.arg} 
[struct::graph::op::MinimumDegreeSpanningTree]{.cmd} [g]{.arg} 
[struct::graph::op::MaximumFlowByDinic]{.cmd} [g]{.arg} [s]{.arg} [t]{.arg} [blockingFlowAlg]{.arg} 
[struct::graph::op::BlockingFlowByDinic]{.cmd} [g]{.arg} [s]{.arg} [t]{.arg} 
[struct::graph::op::BlockingFlowByMKM]{.cmd} [g]{.arg} [s]{.arg} [t]{.arg} 
[struct::graph::op::createResidualGraph]{.cmd} [g]{.arg} [f]{.arg} 
[struct::graph::op::createAugmentingNetwork]{.cmd} [g]{.arg} [f]{.arg} [path]{.arg} 
[struct::graph::op::createLevelGraph]{.cmd} [Gf]{.arg} [s]{.arg} 
[struct::graph::op::TSPLocalSearching]{.cmd} [g]{.arg} [C]{.arg} 
[struct::graph::op::TSPLocalSearching3Approx]{.cmd} [g]{.arg} [C]{.arg} 
[struct::graph::op::createSquaredGraph]{.cmd} [g]{.arg} 
[struct::graph::op::createCompleteGraph]{.cmd} [g]{.arg} [originalEdges]{.arg} 
:::

# BESCHREIBUNG

Dieses Paket, **struct::graph::op**, ergänzt das Paket **struct::graph**. Es stellt eine Reihe üblicher Operationen und Algorithmen für gerichtete oder ungerichtete Graphen bereit.

Die Operationen dieses Pakets lassen sich auf *jedes* Graphobjekt anwenden, das dieselbe API bereitstellt wie die von **struct::graph** erzeugten Objekte. Dieses Paket hängt daher nicht unmittelbar von **struct::graph** ab.

# OPERATIONEN

**struct::graph::op::toAdjacencyMatrix** *g*
: Gibt die Adjazenzmatrix des Graphen *g* zurück. Die Elemente der äußeren Liste sind die Zeilen der Matrix, die inneren Elemente die Spaltenwerte jeder Zeile. Die Matrix hat **n**+1 Zeilen und Spalten. Die erste Zeile und die erste Spalte (Index 0) enthalten den Namen des Knotens, zu dem die Zeile beziehungsweise Spalte gehört. Alle übrigen Elemente sind boolesche Werte, **1** (wahr), wenn zwischen den beiden Knoten der jeweiligen Zeile und Spalte ein Bogen besteht, sonst **0** (falsch). Die Matrix ist symmetrisch. Sie bildet die Richtung der Bögen *nicht* ab, nur ihr Vorhandensein oder Fehlen zwischen Knoten. Parallele Bögen in *g* kann sie ebenfalls nicht darstellen.

**struct::graph::op::toAdjacencyList** *g* ?*options*...?
: Gibt eine *Adjazenzliste* des Graphen *g* zurück. Jedes Listenelement ist ein **dict**, dessen Schlüssel ein Knoten ist und dessen Wert eine Liste der benachbarten Knoten ist. Mit **-weights** ist jedes Element der Werteliste selbst eine zweielementige Liste aus Knoten und Gewicht.


**Argumente:**
: 


Graphobjekt *g*
: Ein Graph, der in eine *Adjazenzliste* umgewandelt wird.


**Optionen:**
: 


**-directed**
: In der Vorgabe wird der Graph *g* wie ein *ungerichteter Graph* behandelt. Mit dieser Option behandelt der Befehl *g* als gerichteten Graphen.

**-weights**
: In der Vorgabe werden die Gewichtsangaben von *g* (falls vorhanden) ignoriert. Mit dieser Option nimmt der Befehl vorhandene Gewichtsangaben in das Ergebnis auf. Die Option setzt voraus, dass jeder Bogen in *g* ein zugeordnetes Gewicht hat; sonst wird ein Fehler ausgelöst.


**struct::graph::op::kruskal** *g*
: Gibt eine Liste von Bogennamen im Graphen *g* zurück, bestimmt durch den Algorithmus von Kruskal. In einem zusammenhängenden Graphen sind das die Bögen, die einen minimalen Spannbaum (MST) aufspannen. In einem unzusammenhängenden Graphen sind das die Bögen eines minimalen Spannwaldes (selbst aus einem MST je zusammenhängender Komponente zusammengesetzt, ohne Komponenten aus einem einzelnen Knoten). Die Zeitkomplexität des Algorithmus ist *O(E\*log E)* oder *O(E\*log V)*, wobei *V* die Zahl der Knoten und *E* die Zahl der Kanten in *g* ist. Der Algorithmus von Prim kann andere Ergebnisse liefern, wenn mehr als ein MST möglich ist. Welche Knoten ein zurückgegebener Bogen verbindet, liefert die Methode **arc nodes** des Graphen für jeden Bogen. Der Befehl löst einen Fehler aus, wenn irgendein Bogen von *g* kein zugeordnetes Gewicht hat.

**struct::graph::op::prim** *g*
: Gibt eine Liste von Bogennamen im Graphen *g* zurück, bestimmt durch den Algorithmus von Prim. In einem zusammenhängenden Graphen sind das die Bögen, die einen minimalen Spannbaum (MST) aufspannen. In einem unzusammenhängenden Graphen sind das die Bögen eines minimalen Spannwaldes (selbst aus einem MST je zusammenhängender Komponente zusammengesetzt, ohne Komponenten aus einem einzelnen Knoten). Die Zeitkomplexität liegt zwischen *O(E+V\*log V)* und *O(V\*V)*, je nach Implementierung (Fibonacci-Heap und Adjazenzliste gegenüber Adjazenzmatrix), wobei *V* die Zahl der Knoten und *E* die Zahl der Kanten in *g* ist. Der Algorithmus von Kruskal kann andere Ergebnisse liefern, wenn mehr als ein MST möglich ist. Welche Knoten ein zurückgegebener Bogen verbindet, liefert die Methode **arc nodes** des Graphen für jeden Bogen. Der Befehl löst einen Fehler aus, wenn irgendein Bogen von *g* kein zugeordnetes Gewicht hat.

**struct::graph::op::isBipartite?** *g* ?*partitions*?
: Gibt **1** (wahr) zurück, wenn der Graph *g* bipartit ist, sonst **0** (falsch). Ist der optionale Variablenname *partitions* angegeben *und* ist *g* bipartit, wird *partitions* angelegt, falls die Variable nicht existiert, und auf die Liste der beiden Partitionen gesetzt. Ist *g* nicht bipartit, wird *partitions* nicht angelegt, wenn die Variable nicht existiert, und nicht geändert, wenn sie existiert.

**struct::graph::op::tarjan** *g*
: Gibt eine Liste von Mengen zurück. Jede Menge enthält die Knoten einer *stark zusammenhängenden* Komponente (SCC) von *g*. Die Vereinigung aller SCCs überdeckt den gesamten Graphen, und keine zwei SCCs schneiden sich. Enthalten *alle* entstandenen SCCs nur einen Knoten, ist *g* *azyklisch*. Enthält das Ergebnis nur eine SCC mit allen Knoten von *g*, ist der Graph *stark zusammenhängend*. *Hinweis:* Das Paket **struct::set** muss geladen sein, bevor diese Funktion verwendet wird, denn sie gibt eine Menge des Typs **struct::set** zurück.

**struct::graph::op::connectedComponents** *g*
: Gibt eine Liste von Mengen zurück. Jede Menge enthält die Knoten einer *zusammenhängenden* Komponente (CC) von *g*. Die Vereinigung aller CCs überdeckt den gesamten Graphen, und keine zwei CCs schneiden sich. Enthält das Ergebnis nur eine CC mit allen Knoten von *g*, ist der Graph *zusammenhängend*. *Hinweis:* Das Paket **struct::set** muss geladen sein, bevor diese Funktion verwendet wird, denn sie gibt eine Menge des Typs **struct::set** zurück.

**struct::graph::op::connectedComponentOf** *g* *node*
: Gibt eine Liste der *zusammenhängenden* Komponenten (CCs) von *g* zurück, die den Knoten *node* enthalten. Der Befehl löst einen Fehler aus, wenn *node* kein Knoten von *g* ist.

**struct::graph::op::isConnected?** *g*
: Gibt **1** (wahr) zurück, wenn der Graph *g* *zusammenhängend* ist, sonst **0** (falsch).

**struct::graph::op::isCutVertex?** *g* *node*
: Gibt **1** (wahr) zurück, wenn *node* von *g* ein *Schnittknoten* ist (*auch* *Artikulationspunkt* *genannt*), sonst **0** (falsch). Der Befehl löst einen Fehler aus, wenn *node* kein Knoten von *g* ist.

**struct::graph::op::isBridge?** *g* *arc*
: Gibt **1** (wahr) zurück, wenn *arc* von *g* eine *Brücke* ist (*auch* *Schnittkante* *oder* *Isthmus* *genannt*), sonst **0** (falsch). Der Befehl löst einen Fehler aus, wenn *arc* kein Bogen von *g* ist.

**struct::graph::op::isEulerian?** *g* ?*tourvar*?
: Gibt **1** (wahr) zurück, wenn der Graph *g* *eulersch* ist, sonst **0** (falsch). Ist der Graph eulersch und ist *tourvar* angegeben, wird eine Eulertour berechnet und in der benannten Variablen gespeichert. Die Tour ist eine Liste der durchlaufenen Bögen, in der Reihenfolge des Durchlaufs.

**struct::graph::op::isSemiEulerian?** *g* ?*pathvar*?
: Gibt **1** (wahr) zurück, wenn der Graph *g* *halb-eulersch* ist, sonst **0** (falsch). Ist der Graph halb-eulersch und ist *pathvar* angegeben, wird ein Eulerweg berechnet und in der benannten Variablen gespeichert. Der Weg ist eine Liste der durchlaufenen Bögen, in der Reihenfolge des Durchlaufs.

**struct::graph::op::dijkstra** *g* *start_node* ?*options*...?
: Gibt ein **dict** zurück, dessen Schlüssel Knoten sind und dessen Werte von den Optionen abhängen. In der Vorgabe werden ein ungerichteter Durchlauf und das Baumformat verwendet. Das Ergebnis ist dann ein **dict**, dessen Werte Listen von Knoten sind. Der Durchlauf beruht auf den Abständen im gewichteten Graphen *g* vom *start_node* zu allen anderen Knoten des Graphen. Zwei Optionen werden unterstützt:


**-arcmode** mode
: *mode* kann **undirected** (die Vorgabe) oder **directed** sein. Bei **directed** werden alle Bögen von der Quelle zum Ziel durchlaufen. Bei **undirected** werden alle Bögen in beide Richtungen durchlaufen.

**-outputformat** format
: *format* kann **tree** (die Vorgabe) oder **distances** sein. In beiden Fällen ist das Ergebnis ein **dict**, dessen Schlüssel die Namen aller Knoten von *g* sind. Ist *format* **tree**, ist jeder Wert der Weg vom Knoten zum *start_node* (eine Liste von Knoten, ohne *start_node* selbst). Ist *format* **distances**, ist jeder Wert der Abstand vom Knoten zum *start_node*. *Hinweis:* Mit *format* **distances** sind Abstände **0** oder **Inf** möglich.


**struct::graph::op::distance** *g* *start_node* *end_node* ?-arcmode *mode*?
: Gibt den Abstand im Graphen *g* von *start_node* nach *end_node* bei ungerichtetem Durchlauf zurück (also *-arcmode* **undirected**). Für einen gerichteten Durchlauf verwenden Sie *-arcmode* **directed**. (Siehe die Option **-arcmode** von **struct::graph::op::dijkstra**.)

**struct::graph::op::eccentricity** *g* *node* ?-arcmode *mode*?
: Gibt die *Exzentrizität* des angegebenen *node* im Graphen *g* bei ungerichtetem Durchlauf zurück (also *-arcmode* **undirected**). Für einen gerichteten Durchlauf verwenden Sie *-arcmode* **directed**. (Siehe die Option **-arcmode** von **struct::graph::op::dijkstra**.) Die (un)gerichtete *Exzentrizität* eines Knotens ist der größte (un)gerichtete Abstand zwischen diesem Knoten und irgendeinem anderen Knoten im Graphen.

**struct::graph::op::radius** *g* ?-arcmode *mode*?
: Gibt den *Radius* des Graphen *g* bei ungerichtetem Durchlauf zurück (also *-arcmode* **undirected**). Für einen gerichteten Durchlauf verwenden Sie *-arcmode* **directed**. (Siehe die Option **-arcmode** von **struct::graph::op::dijkstra**.) Der (un)gerichtete *Radius* eines Graphen ist die kleinste (un)gerichtete *Exzentrizität* aller Knoten im Graphen.

**struct::graph::op::diameter** *g* ?-arcmode *mode*?
: Gibt den *Durchmesser* des Graphen *g* bei ungerichtetem Durchlauf zurück (also *-arcmode* **undirected**). Für einen gerichteten Durchlauf verwenden Sie *-arcmode* **directed**. (Siehe die Option **-arcmode** von **struct::graph::op::dijkstra**.) Der (un)gerichtete *Durchmesser* eines Graphen ist die größte (un)gerichtete *Exzentrizität* aller Knoten im Graphen.

**struct::graph::op::BellmanFord** *g* *startnode*
: Sucht **kürzeste Wege** zwischen einem gewählten Knoten und allen anderen Knoten im Graphen *g*. Grundlage ist das Relaxationsverfahren. Im Vergleich zu **struct::graph::op::dijkstra** setzt der Algorithmus nicht voraus, dass alle Kantengewichte im Eingabegraphen *g* positiv sind. Diese Allgemeinheit setzt die Komplexität des Algorithmus auf *O(V\*E)*, wobei *V* die Zahl der Knoten und *E* die Zahl der Kanten in *g* ist.


**Argumente:**
: 


Graphobjekt *g* (Eingabe)
: Gerichteter, zusammenhängender und kantengewichteter Graph *g* ohne negative Kreise (Kreise mit negativer Gewichtsumme bedeuten, dass es keinen kürzesten Weg gibt, weil das Gesamtgewicht bei jedem Durchlauf des Kreises sinkt). Negative Kantengewichte sind zulässig.

Knoten *startnode* (Eingabe)
: Der Knoten, für den alle kürzesten Wege zu jedem anderen Knoten in *g* gesucht werden.


**Ergebnis:**
: Dictionary, das für jeden Knoten (Schlüssel) die Abstände zu jedem anderen Knoten in *g* enthält.


*Hinweis:* Findet der Algorithmus einen negativen Kreis, gibt er eine Fehlermeldung zurück.

**struct::graph::op::Johnsons** *g* ?*options*...?
: Sucht **kürzeste Wege** zwischen allen Knotenpaaren im Graphen. Für dünne Graphen asymptotisch schneller als der Algorithmus **struct::graph::op::FloydWarshall**. Der Algorithmus von Johnson verwendet **struct::graph::op::BellmanFord** und **struct::graph::op::dijkstra** als Unterprozeduren. Zeitkomplexität: *O(n\*\*2\*log(n) +n\*m)*, wobei *n* die Zahl der Knoten und *m* die Zahl der Kanten in *g* ist.


**Argumente:**
: 


Graphobjekt *g* (Eingabe)
: Gerichteter Graph *g*, kantengewichtet und ohne Kreise mit negativer Gewichtsumme (solche Kreise bedeuten, dass es keinen kürzesten Weg gibt, weil das Gesamtgewicht bei jedem Durchlauf des Kreises sinkt). Negative Kantengewichte sind zulässig.


**Optionen:**
: 


**-filter**
: Gibt nur vorhandene Abstände zurück und schneidet alle Werte *Inf* für nicht vorhandene Verbindungen zwischen Knotenpaaren ab.


**Ergebnis:**
: Dictionary mit den Abständen zwischen allen Knotenpaaren.


**struct::graph::op::FloydWarshall** *g*
: Sucht **kürzeste Wege** zwischen allen Knotenpaaren in gewichteten Graphen. Zeitkomplexität: *O(V^3)*, wobei *V* die Zahl der Knoten ist. Speicherkomplexität: *O(V^2)*.


**Argumente:**
: 


Graphobjekt *g* (Eingabe)
: Gerichteter und gewichteter Graph *g*.


**Ergebnis:**
: Dictionary mit den kürzesten Abständen von jedem Knoten zu jedem Knoten.


: *Hinweis:* Der Algorithmus findet die Lösungen dynamisch. Er vergleicht alle möglichen Wege durch den Graphen zwischen jedem Knotenpaar. Der Graph darf keinen Kreis mit negativer Gewichtsumme besitzen (solche Kreise bedeuten, dass es keinen kürzesten Weg gibt, weil das Gesamtgewicht bei jedem Durchlauf des Kreises sinkt). Umgekehrt lässt sich der Algorithmus verwenden, um solche Kreise zu finden: Ist irgendein vom Algorithmus gefundener kürzester Abstand für Knoten *v* und *u* negativ (wenn *v* derselbe Knoten wie *u* ist), gehört dieser Knoten sicher zu mindestens einem negativen Kreis.


**struct::graph::op::MetricTravellingSalesman** *g*
: Algorithmus für eine metrische Variante des **Problems des Handlungsreisenden**. Das *TSP-Problem* ist *NP-vollständig*, es gibt also keinen effizienten Algorithmus, der es löst. Gierige Verfahren werden mit wachsender Knotenmenge extrem langsam.


**Argumente:**
: 


Graphobjekt *g* (Eingabe)
: Ungerichteter, gewichteter Graph *g*.


**Ergebnis:**
: Näherungslösung eines minimalen *Hamilton-Kreises*, eines geschlossenen Weges, der alle Knoten besucht, jeden genau einmal.


: *Hinweis:* **Es ist ein 2-Approximationsalgorithmus.**


**struct::graph::op::Christofides** *g*
: Ein weiterer Algorithmus für das **metrische** *TSP-Problem*. Die Implementierung von Christofides verwendet ein *Maximum-Matching*, um einen besseren Approximationsfaktor zu erreichen.


**Argumente:**
: 


Graphobjekt *g* (Eingabe)
: Ungerichteter, gewichteter Graph *g*.


**Ergebnis:**
: Näherungslösung eines minimalen *Hamilton-Kreises*, eines geschlossenen Weges, der alle Knoten besucht, jeden genau einmal.


*Hinweis:* **Es ist ein 3/2-Approximationsalgorithmus.**

**struct::graph::op::GreedyMaxMatching** *g*
: Das Verfahren *Greedy Max Matching* findet ein **maximales Matching** (kein Maximum-Matching) für den gegebenen Graphen *g*. Es nimmt Kanten in die Lösung auf, beginnend bei den Kanten mit den niedrigsten Kosten.


**Argumente:**
: 


Graphobjekt *g* (Eingabe)
: Ungerichteter Graph *g*.


**Ergebnis:**
: Menge von Kanten, das maximale Matching für den Graphen *g*.


**struct::graph::op::MaxCut** *g* *U* *V*
: Algorithmus für das **Maximum-Schnitt-Problem**.


**Argumente:**
: 


Graphobjekt *g* (Eingabe)
: Der zu schneidende Graph.

Liste *U* (Ausgabe)
: Variable, die die erste Knotenmenge (Schnitt) der Lösung speichert.

Liste *V* (Ausgabe)
: Variable, die die zweite Knotenmenge (Schnitt) der Lösung speichert.


**Ergebnis:**
: Der Algorithmus gibt die Zahl der Kanten zwischen den beiden gefundenen Knotenmengen zurück.


: *Hinweis:* *MaxCut* ist ein **2-Approximationsalgorithmus.**


**struct::graph::op::UnweightedKCenter** *g* *k*
: Approximationsalgorithmus für das **k-Zentrum-Problem**.


**Argumente:**
: 


Graphobjekt *g* (Eingabe)
: Ungerichteter vollständiger Graph *g*, der die Dreiecksungleichung erfüllt.

Ganzzahl *k* (Eingabe)
: Positive Ganzzahl, die festlegt, wie viele Knoten im *k-Zentrum* enthalten sind.


**Ergebnis:**
: Menge von Knoten, das *k*-Zentrum des Graphen *g*.


: *Hinweis:* *UnweightedKCenter* ist ein **2-Approximationsalgorithmus.**


**struct::graph::op::WeightedKCenter** *g* *nodeWeights* *W*
: Approximationsalgorithmus für eine gewichtete Variante des **k-Zentrum-Problems**.


**Argumente:**
: 


Graphobjekt *g* (Eingabe)
: Ungerichteter vollständiger Graph *g*, der die Dreiecksungleichung erfüllt.

Ganzzahl *W* (Eingabe)
: Positive Ganzzahl, die das höchstmögliche Gewicht des vom Algorithmus gefundenen *k-Zentrums* festlegt.

Liste *nodeWeights* (Eingabe)
: Liste der Knoten und ihrer Gewichte im Graphen *g*.


**Ergebnis:**
: Menge von Knoten, die der Algorithmus als Lösung gefunden hat.


: *Hinweis:* *WeightedKCenter* ist ein **3-Approximationsalgorithmus.**


**struct::graph::op::GreedyMaxIndependentSet** *g*
: Eine *maximale unabhängige Menge* ist eine *unabhängige Menge*, bei der das Hinzufügen jedes weiteren Knotens die Menge zwingt, eine Kante zu enthalten. Der Algorithmus gibt für den Eingabegraphen *g* eine Menge von Knoten (Liste) zurück, die in der vom Algorithmus gefundenen maximalen unabhängigen Menge enthalten sind.

**struct::graph::op::GreedyWeightedMaxIndependentSet** *g* *nodeWeights*
: Gewichtete Variante der *maximalen unabhängigen Menge*. Als Argument nimmt sie nicht nur den Graphen *g*, sondern auch eine Menge von Gewichten für alle Knoten in *g*. *Hinweis:* Lesen Sie dazu auch die Beschreibung der *maximalen unabhängigen Menge*.

**struct::graph::op::VerticesCover** *g*
: Eine *Knotenüberdeckung* ist eine Menge von Knoten, sodass jede Kante des Graphen zu mindestens einem Knoten der Menge inzident ist. Dieser 2-Approximationsalgorithmus sucht eine minimale *Knotenüberdeckung*, ein klassisches Optimierungsproblem der Informatik und ein typisches Beispiel eines *NP-schweren* Optimierungsproblems mit Approximationsalgorithmus. Für den Eingabegraphen *g* gibt der Algorithmus die Menge der Kanten (Liste) zurück, die die vom Algorithmus gefundene Knotenüberdeckung ist.

**struct::graph::op::EdmondsKarp** *g* *s* *t*
: Verbesserter Algorithmus von Ford und Fulkerson. Er berechnet den **maximalen Fluss** im gegebenen Flussnetz *g*.


**Argumente:**
: 


Graphobjekt *g* (Eingabe)
: Gewichteter und gerichteter Graph. Jede Kante soll ein ganzzahliges Attribut haben, das als maximaler Durchsatz gilt, den diese Verbindung (Kante) tragen kann.

Knoten *s* (Eingabe)
: Der Knoten, der die Quelle des Graphen *g* ist.

Knoten *t* (Eingabe)
: Der Knoten, der die Senke des Graphen *g* ist.


**Ergebnis:**
: Die Prozedur gibt das Dictionary mit den Durchsätzen aller Kanten zurück. Zu jedem Schlüssel (die Kante zwischen den Knoten *u* und *v* in der Form *list u v*) gibt es einen Wert, den Durchsatz dieses Schlüssels. Kanten, deren Durchsatz 0 ist, werden nicht zurückgegeben (das entspricht einer fehlenden Verbindung im Flussnetz zwischen den durch eine solche Kante verbundenen Knoten).


Die Grundidee des Algorithmus ist, die kürzesten Erweiterungspfade in *g* zu finden, solange es sie gibt, und für jeden Pfad die Kantengewichte entlang dieses Pfades mit dem größtmöglichen Durchsatz zu aktualisieren. Der endgültige (maximale) Fluss ist gefunden, wenn es keinen weiteren Erweiterungspfad von der Quelle zur Senke gibt.

*Hinweis:* Komplexität des Algorithmus: *O(V\*E)*, wobei *V* die Zahl der Knoten und *E* die Zahl der Kanten in *g* ist.

**struct::graph::op::BusackerGowen** *g* *desiredFlow* *s* *t*
: Der Algorithmus findet eine Lösung für das **Problem des kostenminimalen Flusses**. Gesucht ist ein Fluss, dessen Höchstwert *desiredFlow* sein kann, vom Quellknoten *s* zum Senkenknoten *t* im gegebenen Flussnetz *g*. Dieses Netz hat neben den Durchsätzen an den Kanten auch nichtnegative Kosten auf jeder Kante, die Kosten der Nutzung dieser Kante beim Leiten des Flusses über sie (zum Beispiel Treibstoffverbrauch, Zeit oder ein anderes nutzungsabhängiges Maß).


**Argumente:**
: 


Graphobjekt *g* (Eingabe)
: Flussnetz (gerichteter Graph). Jede Kante im Graphen soll zwei ganzzahlige Attribute haben: *cost* und *throughput*.

Ganzzahl *desiredFlow* (Eingabe)
: Höchstwert des Flusses für dieses Netz.

Knoten *s* (Eingabe)
: Der Quellknoten des Graphen *g*.

Knoten *t* (Eingabe)
: Der Senkenknoten des Graphen *g*.


**Ergebnis:**
: Dictionary mit den Werten der genutzten Durchsätze für jede Kante (Schlüssel), vom Algorithmus gefunden.


: *Hinweis:* Komplexität des Algorithmus: *O(V\*\*2\*desiredFlow)*, wobei *V* die Zahl der Knoten in *g* ist.


**struct::graph::op::ShortestsPathsByBFS** *g* *s* *outputFormat*
: Algorithmus für kürzeste Wege mit der BFS-Methode. Im Vergleich zu **struct::graph::op::dijkstra** kann er mit negativen Kantengewichten arbeiten. Negative Kreise sind nicht zulässig. Für dünne Graphen ist der Algorithmus besser als Dijkstra, es gibt aber pathologische Fälle (die in der Praxis gewöhnlich nicht auftreten), in denen die Zeitkomplexität mit der Knotenzahl exponentiell wächst.


**Argumente:**
: 


Graphobjekt *g* (Eingabe)
: Eingabegraph.

Knoten *s* (Eingabe)
: Quellknoten, für den alle Abstände zu jedem anderen Knoten in *g* berechnet werden.


**Optionen und Ergebnis:**
: 


**distances**
: Ist das gewählte *outputFormat* **distances**, gibt die Prozedur ein Dictionary mit den Abständen zwischen dem Quellknoten *s* und jedem anderen Knoten in *g* zurück.

**paths**
: Ist das gewählte *outputFormat* **paths**, gibt die Prozedur ein Dictionary zurück, das für jeden Knoten *v* eine Liste von Knoten enthält, den Weg zwischen dem Quellknoten *s* und dem Knoten *v*.


**struct::graph::op::BFS** *g* *s* ?*outputFormat*...?
: Breitensuche. Der Algorithmus erzeugt den BFS-Baum. Speicher- und Zeitkomplexität: *O(V + E)*, wobei *V* die Zahl der Knoten und *E* die Zahl der Kanten ist.


**Argumente:**
: 


Graphobjekt *g* (Eingabe)
: Eingabegraph.

Knoten *s* (Eingabe)
: Quellknoten für die BFS-Prozedur.


**Optionen und Ergebnis:**
: 


**graph**
: Ist das gewählte **outputFormat** **graph**, gibt die Prozedur eine Graphstruktur (**struct::graph**) zurück, die dem vom Algorithmus gefundenen BFS-Baum entspricht.

**tree**
: Ist das gewählte **outputFormat** **tree**, gibt die Prozedur eine Baumstruktur (**struct::tree**) zurück, die dem vom Algorithmus gefundenen BFS-Baum entspricht.


**struct::graph::op::MinimumDiameterSpanningTree** *g*
: Ziel ist, für den Eingabegraphen *g* den *Spannbaum* mit dem kleinsten *Durchmesser* zu finden. Die Grundidee ist, *BFS* über alle Knoten in *g* laufen zu lassen. Ist der Durchmesser *d* des Baumes ungerade, ist der von *BFS* gelieferte Baum minimal (bezogen auf den Durchmesser). Ist der Durchmesser *d* gerade, kann der optimale Baum einen minimalen *Durchmesser* von *d* oder *d-1* haben. Dann baut der Algorithmus den von *BFS* gelieferten Baum neu auf, indem er einen Knoten zwischen dem Wurzelknoten und dem Kindknoten (den Kindknoten) der Wurzel einfügt, sodass der mit diesem Kindknoten als Wurzel gebildete Teilbaum der größte ist (die größte Höhe hat). Im nächsten Schritt wird auf diesem neu aufgebauten Baum erneut *BFS* ausgeführt, mit dem neuen Knoten als Wurzel. Hat sich die Höhe des Baumes nicht geändert, ist eine bessere Lösung gefunden. Für den Eingabegraphen *g* gibt der Algorithmus die Graphstruktur (**struct::graph**) zurück, die der vom Algorithmus gefundene Spannbaum mit minimalem Durchmesser ist.

**struct::graph::op::MinimumDegreeSpanningTree** *g*
: Der Algorithmus findet für den Eingabegraphen *g* einen Spannbaum *T* mit dem kleinstmöglichen Grad. Das Problem ist *NP-schwer*, der Algorithmus ist daher ein Approximationsalgorithmus. Sei *V* die Knotenmenge von *g* und *W* eine beliebige Teilmenge von *V*. Sei außerdem *OPT* die optimale Lösung und *ALG* die vom Algorithmus für *g* gefundene Lösung. Es lässt sich beweisen, dass die gefundene Lösung die Ungleichung *((|W| + k - 1) / |W|) <= ALG <= 2\*OPT + log2(n) + 1* erfüllen muss.


**Argumente:**
: 


Graphobjekt *g* (Eingabe)
: Ungerichteter schlichter Graph.


**Ergebnis:**
: Der Algorithmus gibt eine Graphstruktur zurück, die dem vom Algorithmus gefundenen Spannbaum *T* entspricht.


**struct::graph::op::MaximumFlowByDinic** *g* *s* *t* *blockingFlowAlg*
: Der Algorithmus findet den **maximalen Fluss** für das durch *g* dargestellte Flussnetz. Er beruht auf Verfahren zum Finden blockierender Flüsse. Die unterschiedlichen Komplexitäten passen dadurch besser zu verschiedenen Graphen.


**Argumente:**
: 


Graphobjekt *g* (Eingabe)
: Gerichteter Graph *g*, der das Flussnetz darstellt. Jede Kante soll das Attribut *throughput* mit einem ganzzahligen Wert haben.

Knoten *s* (Eingabe)
: Der Quellknoten des Flussnetzes *g*.

Knoten *t* (Eingabe)
: Der Senkenknoten des Flussnetzes *g*.


**Optionen:**
: 


**dinic**
: Die Prozedur findet den maximalen Fluss für das Flussnetz *g* mit dem Algorithmus von Dinic (**struct::graph::op::BlockingFlowByDinic**) für die Berechnung des blockierenden Flusses.

**mkm**
: Die Prozedur findet den maximalen Fluss für das Flussnetz *g* mit dem Algorithmus von Malhotra, Kumar und Maheshwari (**struct::graph::op::BlockingFlowByMKM**) für die Berechnung des blockierenden Flusses.


**Ergebnis:**
: Der Algorithmus gibt ein Dictionary zurück, das für jede Kante (Schlüssel) im Netz *g* den Flusswert enthält.


*Hinweis:* **struct::graph::op::BlockingFlowByDinic** hat die Komplexität *O(m\*n^2)* und **struct::graph::op::BlockingFlowByMKM** die Komplexität *O(n^3)*, wobei *n* die Zahl der Knoten und *m* die Zahl der Kanten im Flussnetz *g* ist.

**struct::graph::op::BlockingFlowByDinic** *g* *s* *t*
: Der Algorithmus findet für das gegebene Netz *g* mit Quelle *s* und Senke *t* einen **blockierenden Fluss**, aus dem sich ein *maximaler Fluss* für dieses Netz *g* gewinnen lässt.


**Argumente:**
: 


Graphobjekt *g* (Eingabe)
: Gerichteter Graph *g*, der das Flussnetz darstellt. Jede Kante soll das Attribut *throughput* mit einem ganzzahligen Wert haben.

Knoten *s* (Eingabe)
: Der Quellknoten des Flussnetzes *g*.

Knoten *t* (Eingabe)
: Der Senkenknoten des Flussnetzes *g*.


**Ergebnis:**
: Der Algorithmus gibt ein Dictionary zurück, das für jede Kante (Schlüssel) im Netz *g* den Wert des blockierenden Flusses enthält.


: *Hinweis:* Die Komplexität des Algorithmus ist *O(n\*m)*, wobei *n* die Zahl der Knoten und *m* die Zahl der Kanten im Flussnetz *g* ist.


**struct::graph::op::BlockingFlowByMKM** *g* *s* *t*
: Der Algorithmus findet für das gegebene Netz *g* mit Quelle *s* und Senke *t* einen **blockierenden Fluss**, aus dem sich ein *maximaler Fluss* für dieses *Netz* *g* gewinnen lässt.


**Argumente:**
: 


Graphobjekt *g* (Eingabe)
: Gerichteter Graph *g*, der das Flussnetz darstellt. Jede Kante soll das Attribut *throughput* mit einem ganzzahligen Wert haben.

Knoten *s* (Eingabe)
: Der Quellknoten des Flussnetzes *g*.

Knoten *t* (Eingabe)
: Der Senkenknoten des Flussnetzes *g*.


**Ergebnis:**
: Der Algorithmus gibt ein Dictionary zurück, das für jede Kante (Schlüssel) im Netz *g* den Wert des blockierenden Flusses enthält.


: *Hinweis:* Die Komplexität des Algorithmus ist *O(n^2)*, wobei *n* die Zahl der Knoten im Flussnetz *g* ist.


**struct::graph::op::createResidualGraph** *g* *f*
: Die Prozedur erzeugt einen *Residualgraphen* (oder ein **Residualnetz**) für das Netz *g* und den gegebenen Fluss *f*.


**Argumente:**
: 


Graphobjekt *g* (Eingabe)
: Flussnetz (gerichteter Graph, in dem jede Kante das Attribut *throughput* gesetzt hat).

Dictionary *f* (Eingabe)
: Die aktuellen Flüsse im Flussnetz *g*.


**Ergebnis:**
: Die Prozedur gibt eine Graphstruktur zurück, die ein aus dem Eingabeflussnetz *g* erzeugter *Residualgraph* ist.


**struct::graph::op::createAugmentingNetwork** *g* *f* *path*
: Die Prozedur erzeugt ein **Erweiterungsnetz** für ein gegebenes Residualnetz *g*, einen Fluss *f* und einen Erweiterungspfad *path*.


**Argumente:**
: 


Graphobjekt *g* (Eingabe)
: Residualnetz (gerichteter Graph), in dem für jede Kante zwei Attribute gesetzt sind: throughput und cost.

Dictionary *f* (Eingabe)
: Dictionary, das für jede Kante (Schlüssel) den aktuellen Flusswert auf dieser Kante enthält.

Liste *path* (Eingabe)
: Erweiterungspfad, eine Menge von Kanten (Liste), für die die Netzänderung erzeugt wird.


**Ergebnis:**
: Der Algorithmus gibt eine Graphstruktur zurück, die das geänderte Erweiterungsnetz enthält.


**struct::graph::op::createLevelGraph** *Gf* *s*
: Für den gegebenen Residualgraphen *Gf* findet die Prozedur den **Schichtengraphen**.


**Argumente:**
: 


Graphobjekt *Gf* (Eingabe)
: Residualnetz, in dem jede Kante ihr Attribut *throughput* auf einen bestimmten Wert gesetzt hat.

Knoten *s* (Eingabe)
: Der Quellknoten des Residualnetzes *Gf*.


**Ergebnis:**
: Die Prozedur gibt einen aus dem Eingabe-*Residualnetz* erzeugten *Schichtengraphen* zurück.


**struct::graph::op::TSPLocalSearching** *g* *C*
: Der Algorithmus ist eine *Heuristik der lokalen Suche* für das *Problem des Handlungsreisenden*. Für eine Lösung des *TSP-Problems* prüft er, ob sich eine bessere Lösung finden lässt. Da *TSP* ein bekanntes NP-vollständiges Problem ist, ist der Algorithmus ein Approximationsalgorithmus (mit Approximationsfaktor 2).


**Argumente:**
: 


Graphobjekt *g* (Eingabe)
: Ungerichteter und vollständiger Graph, bei dem auf jeder einzelnen Kante das Attribut "weight" gesetzt ist.

Liste *C* (Eingabe)
: Eine Liste von Kanten, die ein *Hamilton-Kreis* sind, die Lösung des *TSP-Problems* für den Graphen *g*.


**Ergebnis:**
: Der Algorithmus gibt die beste Lösung für das *TSP-Problem* zurück, die er finden konnte.


: *Hinweis:* Die Lösung hängt von der Wahl des Anfangskreises *C* ab. Ein besserer Kreis garantiert nicht, dass eine bessere Lösung gefunden wird. Die Praxis zeigt aber, dass der Startkreis eine möglichst kleine Gewichtsumme haben sollte.


**struct::graph::op::TSPLocalSearching3Approx** *g* *C*
: Der Algorithmus ist eine *Heuristik der lokalen Suche* für das *Problem des Handlungsreisenden*. Für eine Lösung des *TSP-Problems* prüft er, ob sich eine bessere Lösung finden lässt. Da *TSP* ein bekanntes NP-vollständiges Problem ist, ist der Algorithmus ein Approximationsalgorithmus (mit Approximationsfaktor 3).


**Argumente:**
: 


Graphobjekt *g* (Eingabe)
: Ungerichteter und vollständiger Graph, bei dem auf jeder einzelnen Kante das Attribut "weight" gesetzt ist.

Liste *C* (Eingabe)
: Eine Liste von Kanten, die ein *Hamilton-Kreis* sind, die Lösung des *TSP-Problems* für den Graphen *g*.


**Ergebnis:**
: Der Algorithmus gibt die beste Lösung für das *TSP-Problem* zurück, die er finden konnte.


: *Hinweis:* In der Praxis erweist sich der 3-Approximationsalgorithmus als deutlich wirksamer als die 2-Approximation, er hat aber den schlechteren Approximationsfaktor. Weitere Heuristiken der lokalen Suche (zum Beispiel die 4-Approximation) bringen nicht genug Gewinn, um den schlechteren Approximationsfaktor auszugleichen. Verwendet werden daher vor allem die 2- und die 3-Approximation.


**struct::graph::op::createSquaredGraph** *g*
: Ein X-Quadrat-Graph hat dieselbe Knotenmenge wie der Eingabegraph *g*, aber eine andere Kantenmenge. Der X-Quadrat-Graph hat die Kante *(u,v)* genau dann, wenn der Abstand zwischen den Knoten *u* und *v* nicht größer als X ist und *u != v*. Die Prozedur gibt für den Eingabegraphen *g* dessen Zweiquadrat-Graphen zurück. *Hinweis:* Die Abstände bei der Wahl der neuen Kantenmenge zählen die Zahl der Kanten, nicht die Summe der Kantengewichte.

**struct::graph::op::createCompleteGraph** *g* *originalEdges*
: Für den Eingabegraphen *g* fügt die Prozedur fehlende Bögen hinzu, sodass ein *vollständiger Graph* entsteht. In der Variablen *originalEdges* hält sie außerdem die Menge der Bögen, die *g* vor dieser Operation besaß.


# HINTERGRUND UND BEGRIFFE

## Kürzeste Wege

Definition (*Kürzester-Weg-Problem für ein Paar*):
: Formal: Gegeben ein gewichteter Graph (sei *V* die Knotenmenge und *E* eine Kantenmenge) und ein Knoten *v* aus *V*. Gesucht ist ein Weg *P* von *v* zu einem *v'* aus V, sodass die Summe der Kantengewichte entlang des Weges unter allen Wegen von v nach v' minimal ist.

**Verallgemeinerungen:**
: 


**•**
: *Das Kürzester-Weg-Problem mit einer Quelle*, bei dem kürzeste Wege von einem Quellknoten v zu allen anderen Knoten im Graphen zu finden sind.

**•**
: *Das Kürzester-Weg-Problem mit einem Ziel*, bei dem kürzeste Wege von allen Knoten im Graphen zu einem einzelnen Zielknoten v zu finden sind. Das lässt sich auf das Problem mit einer Quelle zurückführen, indem die Kanten im Graphen umgekehrt werden.

**•**
: *Das Kürzester-Weg-Problem für alle Paare*, bei dem kürzeste Wege zwischen jedem Knotenpaar v, v' im Graphen zu finden sind.


: *Hinweis:* Das Ergebnis des *Kürzester-Weg-Problems* kann ein *Kürzester-Weg-Baum* sein, ein Teilgraph eines gegebenen (möglicherweise gewichteten) Graphen, so konstruiert, dass der Abstand zwischen einem gewählten Wurzelknoten und allen anderen Knoten minimal ist. Es ist ein Baum, weil sich bei zwei Wegen zwischen dem Wurzelknoten und einem Knoten v (also einem Kreis) die letzte Kante des längeren Weges löschen lässt, ohne den Abstand vom Wurzelknoten zu irgendeinem Knoten im Teilgraphen zu vergrößern.


## Problem des Handlungsreisenden

**Definition:**
: Für einen kantengewichteten Graphen (die Kantengewichte sollen positiv sein) ist das Ziel, den Kreis zu finden, der jeden Knoten im Graphen genau einmal besucht (*Hamilton-Kreis*).

**Verallgemeinerungen:**
: 


**•**
: *Metrisches TSP* – Eine sehr natürliche Einschränkung des *TSP* verlangt, dass die Abstände zwischen den Städten eine *Metrik* bilden, also die *Dreiecksungleichung* erfüllen. Für beliebige drei Städte *A*, *B* und *C* darf der Abstand zwischen *A* und *C* höchstens der Abstand von *A* nach *B* plus der Abstand von *B* nach *C* sein. Die meisten natürlichen Instanzen des *TSP* erfüllen diese Einschränkung.

**•**
: *Euklidisches TSP* – Das euklidische TSP, oder *planare TSP*, ist das *TSP*, bei dem der Abstand der gewöhnliche *euklidische Abstand* ist. Das *euklidische TSP* ist ein Sonderfall des *TSP* mit *Dreiecksungleichung*, denn Abstände in der Ebene erfüllen die Dreiecksungleichung. Es scheint aber leichter zu sein als das allgemeine *TSP* mit *Dreiecksungleichung*. Zum Beispiel ist *der minimale Spannbaum* des zu einer Instanz des *euklidischen TSP* gehörigen Graphen ein *euklidischer minimaler Spannbaum* und lässt sich für *n* Punkte in erwarteter Zeit *O(n log n)* berechnen (deutlich weniger als die Kantenzahl). Dadurch arbeitet der einfache *2-Approximationsalgorithmus* für das TSP mit Dreiecksungleichung von oben schneller.

**•**
: *Asymmetrisches TSP* – In den meisten Fällen ist der Abstand zwischen zwei Knoten im *TSP*-Netz in beiden Richtungen gleich. Der Fall, in dem der Abstand von *A* nach *B* nicht gleich dem Abstand von *B* nach *A* ist, heißt *asymmetrisches TSP*. Eine praktische Anwendung eines *asymmetrischen TSP* ist die Routenoptimierung mit straßengenauer Wegeführung (asymmetrisch durch Einbahnstraßen, Verbindungsrampen und Autobahnen).


## Zuordnungsproblem

**Definition:**
: Gegeben ein Graph *G = (V,E)*. Ein Matching oder eine *kantenunabhängige Menge* *M* in *G* ist eine Menge paarweise nicht benachbarter Kanten, das heißt, keine zwei Kanten teilen einen gemeinsamen Knoten. Ein Knoten ist *zugeordnet*, wenn er zu einer Kante im *Matching M* inzident ist. Sonst ist der Knoten *nicht zugeordnet*.

**Verallgemeinerungen:**
: 


**•**
: *Maximales Matching* – ein Matching *M* eines Graphen G mit der Eigenschaft, dass *M* kein *Matching* mehr ist, wenn irgendeine nicht in *M* liegende Kante zu *M* hinzugefügt wird. *M* ist also maximal, wenn es keine echte Teilmenge eines anderen *Matchings* im Graphen G ist. Anders gesagt: Ein *Matching M* eines Graphen G ist maximal, wenn jede Kante in G einen nichtleeren Schnitt mit mindestens einer Kante in *M* hat.

**•**
: *Maximum-Matching* – ein Matching, das die größtmögliche Zahl von Kanten enthält. Es kann viele *Maximum-Matchings* geben. Die *Matchingzahl* eines Graphen G ist die Größe eines *Maximum-Matchings*. Jedes *Maximum-Matching* ist *maximal*, aber nicht jedes *maximale Matching* ist ein *Maximum-Matching*.

**•**
: *Perfektes Matching* – ein Matching, das alle Knoten des Graphen zuordnet. Jeder Knoten des Graphen ist also zu genau einer Kante des Matchings inzident. Jedes *perfekte Matching* ist *maximum* und damit *maximal*. In einem Teil der Literatur heißt es *vollständiges Matching*. Ein *perfektes Matching* ist auch eine *Kantenüberdeckung minimaler Größe*. Außerdem ist die Größe eines *Maximum-Matchings* nicht größer als die Größe einer *minimalen Kantenüberdeckung*.

**•**
: *Fast perfektes Matching* – ein Matching, in dem genau ein Knoten nicht zugeordnet ist. Das ist nur möglich, wenn der Graph eine ungerade Knotenzahl hat, und ein solches *Matching* muss *maximum* sein. Gibt es für jeden Knoten eines Graphen ein fast perfektes Matching, das nur diesen Knoten auslässt, heißt der Graph auch *faktorkritisch*.


**Verwandte Begriffe:**
: 


**•**
: *Alternierender Weg* – zu einem Matching *M* ist ein *alternierender Weg* ein Weg, dessen Kanten abwechselnd zum Matching und nicht zum Matching gehören.

**•**
: *Erweiterungspfad* – zu einem Matching *M* ist ein *Erweiterungspfad* ein *alternierender Weg*, der an freien (nicht zugeordneten) Knoten beginnt und endet.


## Schnittprobleme

**Definition:**
: Ein *Schnitt* ist eine Partition der Knoten eines Graphen in zwei *disjunkte Teilmengen*. Die *Schnittmenge* des *Schnitts* ist die Menge der Kanten, deren Endpunkte in verschiedenen Teilmengen der Partition liegen. Kanten kreuzen den Schnitt, wenn sie in seiner *Schnittmenge* liegen. Formal:


**•**
: Ein *Schnitt* *C = (S,T)* ist eine Partition von *V* eines Graphen *G = (V, E)*.

**•**
: Ein *s-t-Schnitt* *C = (S,T)* eines *Flussnetzes* *N = (V, E)* ist ein Schnitt von *N*, bei dem *s* in *S* und *t* in *T* liegt, wobei *s* und *t* die *Quelle* beziehungsweise die *Senke* von *N* sind.

**•**
: Die *Schnittmenge* eines *Schnitts C = (S,T)* ist diejenige Kantenmenge des Graphen *G = (V, E)*, bei der jede Kante *(u, v)* die Bedingung erfüllt, dass *u* in *S* und *v* in *T* liegt.


In einem *ungewichteten ungerichteten* Graphen ist die Größe oder das Gewicht eines Schnitts die Zahl der Kanten, die den Schnitt kreuzen. In einem *gewichteten Graphen* ist derselbe Begriff die Summe der Gewichte der Kanten, die den Schnitt kreuzen.

In einem *Flussnetz* ist ein *s-t-Schnitt* ein Schnitt, der *Quelle* und *Senke* in verschiedenen Teilmengen verlangt, und seine *Schnittmenge* besteht nur aus Kanten, die von der Seite der *Quelle* zur Seite der *Senke* führen. Die Kapazität eines *s-t-Schnitts* ist die Summe der Kapazitäten aller Kanten in der *Schnittmenge*.

Der *Schnitt* eines Graphen kann manchmal seine *Schnittmenge* meinen statt der Partition.

**Verallgemeinerungen:**
: 


**•**
: *Minimaler Schnitt* – Ein Schnitt ist minimal, wenn die Größe des Schnitts nicht größer ist als die Größe jedes anderen Schnitts.

**•**
: *Maximaler Schnitt* – Ein Schnitt ist maximal, wenn die Größe des Schnitts nicht kleiner ist als die Größe jedes anderen Schnitts.

**•**
: *Dünnster Schnitt* – Das *Problem des dünnsten Schnitts* ist, die Knoten so in zwei Teile zu teilen, dass das Verhältnis aus der Zahl der Kanten über den Schnitt und der Zahl der Knoten in der kleineren Hälfte der Partition minimal wird.


## K-Zentrum-Problem

**Definitionen:**
: 


*Ungewichtetes K-Zentrum*
: Für jede Menge *S* (eine Teilmenge von *V*) und einen Knoten *v* sei *connect(v,S)* die Kosten der billigsten Kante, die *v* mit irgendeinem Knoten in *S* verbindet. Ziel ist ein *S* mit *|S| = k*, für das *max_v{connect(v,S)}* möglichst klein ist. Anders gesagt lässt sich das zum Beispiel verwenden, um die besten Standorte in der Stadt (Knoten des Eingabegraphen) für k Gebäude zu finden, sodass diese Gebäude allen anderen Orten der Stadt möglichst nah sind.

*Gewichtetes K-Zentrum*
: Die Variante des *ungewichteten k-Zentrum-Problems*. Der Graph ist kantengewichtet, und die Knoten des Eingabegraphen *g* haben ebenfalls Gewichte. Außerdem gibt es die Einschränkung *W*. Ziel ist eine Knotenmenge *S* (eine Teilmenge von *V*), deren Gesamtgewicht nicht größer als *W* ist und für die die Funktion *max_v { min_u { cost(u,v) }}* den kleinstmöglichen Wert hat (*v* ist ein Knoten in *V* und *u* ein Knoten in *S*).


## Flussprobleme

**Definitionen:**
: 


**•**
: *das maximale Flussproblem* – Ziel ist ein zulässiger Fluss durch ein Flussnetz mit einer Quelle und einer Senke, der maximal ist. Das *maximale Flussproblem* ist ein Sonderfall komplexerer Netzflussprobleme, etwa des *Zirkulationsproblems*. Der Höchstwert eines *s-t-Flusses* ist gleich der minimalen Kapazität eines *s-t-Schnitts* im Netz, wie der *Satz vom maximalen Fluss und minimalen Schnitt* sagt. Formaler für ein Flussnetz *G = (V,E)*, in dem für jede Kante *(u, v)* ihr Durchsatz *c(u,v)* festgelegt ist. Als *Fluss* *F* definieren wir eine Menge nichtnegativer ganzzahliger Attribute *f(u,v)* auf den Kanten, die folgende Bedingungen erfüllen:


**\[1\]**
: für jede Kante *(u, v)* in *G* soll diese Bedingung erfüllt sein:      0 <= f(u,v) <= c(u,v)

**\[2\]**
: Das Netz *G* hat einen Quellknoten *s*, sodass der Fluss *F* gleich der Summe des ausgehenden Flusses vermindert um die Summe des eingehenden Flusses an diesem Quellknoten *s* ist.

**\[3\]**
: Das Netz *G* hat einen Senkenknoten *t*, sodass der Wert *-F* gleich der Summe des eingehenden Flusses vermindert um die Summe des ausgehenden Flusses an diesem Senkenknoten *t* ist.

**\[4\]**
: Für jeden Knoten, der weder *Quelle* noch *Senke* ist, sollen die Summe des eingehenden Flusses und die Summe des ausgehenden Flusses gleich sein.


**•**
: *das Problem des kostenminimalen Flusses* – Ziel ist der billigstmögliche Weg, eine bestimmte Flussmenge durch ein *Flussnetz* zu schicken.

**•**
: *blockierender Fluss* – einen *blockierenden Fluss* für ein *Residualnetz* *Gf* nennen wir einen Fluss *b* in *Gf*, für den gilt:


**\[1\]**
: Jeder Weg von der *Senke* zur *Quelle* ist der kürzeste Weg in *Gf*.

**\[2\]**
: Jeder kürzeste Weg in *Gf* enthält eine Kante mit voll ausgeschöpftem Durchsatz in *Gf+b*.


**•**
: *Residualnetz* – für ein Flussnetz *G* und einen Fluss *f* wird das *Residualnetz* aus den Kanten aufgebaut, die einen größeren Fluss senden können. Es enthält nur die Kanten, die einen Fluss größer als 0 senden können.

**•**
: *Schichtennetz* – es hat dieselbe Knotenmenge wie der *Residualgraph*, aber nur die Kanten *(u,v)* aus *Gf*, für die die Gleichung *distance(s,u)+1 = distance(s,v)* gilt.

**•**
: *Erweiterungsnetz* – eine Änderung des *Residualnetzes* unter Berücksichtigung der neuen Flusswerte. Die Struktur bleibt unverändert, die Durchsätze und Kosten an den Kanten sind andere.


## Approximationsalgorithmus

**k-Approximationsalgorithmus:**
: Ein Algorithmus ist eine k-Approximation, wenn für *ALG* (die vom Algorithmus zurückgegebene Lösung) und *OPT* (die optimale Lösung) diese Ungleichung gilt:


**•**
: für Minimierungsprobleme: *ALG/OPT <= k*

**•**
: für Maximierungsprobleme: *OPT/ALG <= k*


# LITERATUR

**\[1\]**
: [Adjacency matrix](http://en.wikipedia.org/wiki/Adjacency_matrix)

**\[2\]**
: [Adjacency list](http://en.wikipedia.org/wiki/Adjacency_list)

**\[3\]**
: [Kruskal's algorithm](http://en.wikipedia.org/wiki/Kruskal%27s_algorithm)

**\[4\]**
: [Prim's algorithm](http://en.wikipedia.org/wiki/Prim%27s_algorithm)

**\[5\]**
: [Bipartite graph](http://en.wikipedia.org/wiki/Bipartite_graph)

**\[6\]**
: [Strongly connected components](http://en.wikipedia.org/wiki/Strongly_connected_components)

**\[7\]**
: [Tarjan's strongly connected components algorithm](http://en.wikipedia.org/wiki/Tarjan%27s_strongly_connected_components_algorithm)

**\[8\]**
: [Cut vertex](http://en.wikipedia.org/wiki/Cut_vertex)

**\[9\]**
: [Bridge](http://en.wikipedia.org/wiki/Bridge_(graph_theory))

**\[10\]**
: [Bellman-Ford's algorithm](http://en.wikipedia.org/wiki/Bellman-Ford_algorithm)

**\[11\]**
: [Johnson's algorithm](http://en.wikipedia.org/wiki/Johnson_algorithm)

**\[12\]**
: [Floyd-Warshall's algorithm](http://en.wikipedia.org/wiki/Floyd-Warshall_algorithm)

**\[13\]**
: [Travelling Salesman Problem](http://en.wikipedia.org/wiki/Travelling_salesman_problem)

**\[14\]**
: [Christofides Algorithm](http://en.wikipedia.org/wiki/Christofides_algorithm)

**\[15\]**
: [Max Cut](http://en.wikipedia.org/wiki/Maxcut)

**\[16\]**
: [Matching](http://en.wikipedia.org/wiki/Matching)

**\[17\]**
: [Max Independent Set](http://en.wikipedia.org/wiki/Maximal_independent_set)

**\[18\]**
: [Vertex Cover](http://en.wikipedia.org/wiki/Vertex_cover_problem)

**\[19\]**
: [Ford-Fulkerson's algorithm](http://en.wikipedia.org/wiki/Ford-Fulkerson_algorithm)

**\[20\]**
: [Maximum Flow problem](http://en.wikipedia.org/wiki/Maximum_flow_problem)

**\[21\]**
: [Busacker-Gowen's algorithm](http://en.wikipedia.org/wiki/Minimum_cost_flow_problem)

**\[22\]**
: [Dinic's algorithm](http://en.wikipedia.org/wiki/Dinic's_algorithm)

**\[23\]**
: [K-Center problem](http://www.csc.kth.se/~viggo/wwwcompendium/node128.html)

**\[24\]**
: [BFS](http://en.wikipedia.org/wiki/Breadth-first_search)

**\[25\]**
: [Minimum Degree Spanning Tree](http://en.wikipedia.org/wiki/Degree-constrained_spanning_tree)

**\[26\]**
: [Approximation algorithm](http://en.wikipedia.org/wiki/Approximation_algorithm)


# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *struct :: graph* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Datenstrukturen

# COPYRIGHT

```
Copyright (c) 2008 Alejandro Paz <vidriloco@gmail.com>
Copyright (c) 2008 (docs) Andreas Kupries <andreas_kupries@users.sourceforge.net>
Copyright (c) 2009 Michal Antoniewski <antoniewski.m@gmail.com>
```
