---
CommandName: struct::graph::op
title: struct::graph::op
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

# Name

struct::graph::op - Operations for directed and undirected graph objects

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [struct::graph::op]{.lit} [0.11.4]{.optlit}
[struct::graph::op::toAdjacencyMatrix]{.cmd} [g]{.arg}
[struct::graph::op::toAdjacencyList]{.cmd} [g]{.arg} [options...]{.optarg}
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
[struct::graph::op::dijkstra]{.cmd} [g]{.arg} [start\_node]{.arg} [options...]{.optarg}
[struct::graph::op::distance]{.cmd} [g]{.arg} [start\_node]{.arg} [end\_node]{.arg} [[-arcmode]{.lit} [mode]{.arg}]{.optarg}
[struct::graph::op::eccentricity]{.cmd} [g]{.arg} [node]{.arg} [[-arcmode]{.lit} [mode]{.arg}]{.optarg}
[struct::graph::op::radius]{.cmd} [g]{.arg} [[-arcmode]{.lit} [mode]{.arg}]{.optarg}
[struct::graph::op::diameter]{.cmd} [g]{.arg} [[-arcmode]{.lit} [mode]{.arg}]{.optarg}
[struct::graph::op::BellmanFord]{.cmd} [g]{.arg} [startnode]{.arg}
[struct::graph::op::Johnsons]{.cmd} [g]{.arg} [options...]{.optarg}
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
[struct::graph::op::BFS]{.cmd} [g]{.arg} [s]{.arg} [outputFormat...]{.optarg}
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

# Description

This package, **struct::graph::op**, is a companion to the **struct::graph** package. It provides a series of common operations and algorithms applicable to directed or undirected graphs.

The operations provided by this package can be applied to *any* graph objects which provide the same API as the objects created by **struct::graph**. Therefore this package is not directly dependent on **struct::graph**.

# Operations

**struct::graph::op::toAdjacencyMatrix** *g*
: Returns the adjacency matrix for the graph *g*.

    The elements of the outer list are the matrix’s rows, the inner elements are each row’s column values. The matrix has **n**+1 rows and columns, with the first row and column (index 0) containing the name of the node the row/column is for. All other elements are Boolean values, **1** (true) if there is an arc between the two nodes of the respective row and column, and **0** (false) otherwise.

    Note that the matrix is symmetric. It does *not* represent the directionality of the arcs, only their presence (or absence) between nodes. It is also unable to represent parallel arcs in *g*.

**struct::graph::op::toAdjacencyList** *g* ?*options*...?
: Returns an *adjacency list* for the graph *g*. Each list element is a **dict** whose key is a node and whose value is a list of the node’s adjacent nodes. If **-weights** is used each of the value list’s elements is itself a two-element list of node and weight.

    Arguments:
    : see below ...

        Graph object *g*
        : A graph to convert into an *adjacency list*.


    Options:
    : see below ...

        **-directed**
        : By default the graph *g* is treated as if it were an *undirected graph*. Use this option to make the command handle *g* as a directed graph.

        **-weights**
        : By default the graph *g*’s weight information (if any) is ignored. Use this option to make the command include any weight information in the result.

            Using this option assumes that every arc in graph *g* has an associated weight; if this is not the case an error will be thrown.



**struct::graph::op::kruskal** *g*
: Returns a list of arc names in graph *g* as determined by Kruskal’s algorithm.

    For a connected graph, the arcs are those which span a minimum spanning tree (MST). For a disconnected graph the arcs are those of a minimum spanning forest (which itself is composed of an MST for each connected component; excluding single vertex components).

    The algorithm’s time complexity is *O(E\*log E)* or *O(E\*log V)*, where *V* is the number of vertices and *E* is the number of edges in graph *g*. Note that Prim’s algorithm may produce different results if there is more than one possible MST.

    To find the nodes each returned arc connects, use the graph’s **arc nodes** method on each arc.

    The command will throw an error if any of graph *g*’s arcs has no associated weight.

**struct::graph::op::prim** *g*
: Returns a list of arc names in graph *g* as determined by Prim’s algorithm.

    For a connected graph, the arcs are those which span a minimum spanning tree (MST). For a disconnected graph the arcs are those of a minimum spanning forest (which itself is composed of an MST for each connected component; excluding single vertex components).

    This algorithm has a time complexity between *O(E+V\*log V)* and *O(V\*V)*, depending on the implementation (Fibonacci heap and adjacency list versus adjacency matrix), where *V* is the number of vertices and *E* is the number of edges in graph *g*. Note that Kruskal’s algorithm may produce different results if there is more than one possible MST.

    To find the nodes each returned arc connects, use the graph’s **arc nodes** method on each arc.

    The command will throw an error if any of graph *g*’s arcs has no associated weight.

**struct::graph::op::isBipartite?** *g* ?*partitions*?
: Returns **1** (true) if graph *g* is bipartite; otherwise returns **0** (false).

    If the optional *partitions* variable name is given *and* graph *g* is bipartite, then *partitions* is created if it doesn’t exist, then it is set to the list of the two partitions. If graph *g* is not bipartite, *partitions* is not created if it doesn’t exist; and not changed if it does.

**struct::graph::op::tarjan** *g*
: Returns a list of sets, each of which contains the nodes for one of graph *g*’s *strongly connected* components (SCCs). The union of all SCCs covers the whole graph, and no two SCCs intersect.

    If *all* the resulting SCCs contain only one node, then graph *g* is *acyclic*. If the result contains only one SCC containing all graph *g*’s nodes, then the graph is *strongly connected*.

    *Note:* The **struct::set** package must be required before this function is used, since it returns a set of type **struct::set**.

**struct::graph::op::connectedComponents** *g*
: Returns a list of sets, each of which contains the nodes for one of graph *g*’s *connected* components (CCs). The union of all CCs covers the whole graph, and no two CCs intersect.

    If the result contains only one CC containing all graph *g*’s nodes, then the graph is *connected*.

    *Note:* The **struct::set** package must be required before this function is used, since it returns a set of type **struct::set**.

**struct::graph::op::connectedComponentOf** *g* *node*
: Returns a list of graph *g*’s *connected* components (CCs) that contain node *node*.

    The command will throw an error if *node* is not a graph *g* node.

**struct::graph::op::isConnected?** *g*
: Returns **1** (true) if graph *g* is *connected*; otherwise returns **0** (false).

**struct::graph::op::isCutVertex?** *g* *node*
: Returns **1** (true) if graph *g*’s *node* is a *cut vertex* (*also called an* *articulation point*); otherwise returns **0** (false).

    The command will throw an error if *node* is not a graph *g* node.

**struct::graph::op::isBridge?** *g* *arc*
: Returns **1** (true) if graph *g*’s *arc* is a *bridge* (*also called a* *cut edge* *or* *isthmus*); otherwise returns **0** (false).

    The command will throw an error if *arc* is not a graph *g* arc

**struct::graph::op::isEulerian?** *g* ?*tourvar*?
: Returns **1** (true) if graph *g* is *Eulerian*; otherwise returns **0** (false).

    If the graph is Eulerian and *tourvar* is specified, then an Euler tour is computed and stored in the named variable. The tour is represented by a list of the arcs traversed, in order of traversal.

**struct::graph::op::isSemiEulerian?** *g* ?*pathvar*?
: Returns **1** (true) if graph *g* is *semi-Eulerian*; otherwise returns **0** (false).

    If the graph is semi-Eulerian and *pathvar* is specified, then an Euler path is computed and stored in the named variable. The path is represented by a list of the arcs traversed, in order of traversal.

**struct::graph::op::dijkstra** *g* *start\_node* ?*options*...?
: Returns a **dict** whose keys are nodes and whose values vary depending on the options. By default an undirected traversal and tree format are used, resulting in a **dict** whose values are lists of nodes. The traversal is based on the distances in the weighted graph *g* from the *start\_node* to all the graph’s other nodes.

    Two options are supported:

    **-arcmode** mode
    : The *mode* may be **undirected** (the default) or **directed**. If **directed**, all the arcs are traversed from the source to the target. For **undirected**, all the arcs are traversed both ways.

    **-outputformat** format
    : The *format* may be **tree** (the default) or **distances**. In either case the result is a **dict** whose keys are the names of all graph *g*’s nodes. When the *format* is **tree**, each value is the path from the node to the *start\_node* (i.e., a list of nodes; excluding the *start\_node* itself). When the *format* is **distances**, each value is the distance from the node to the *start\_node*. *Note:* When using *format* **distances** it is possible to have distances of **0** or of **Inf**.


**struct::graph::op::distance** *g* *start\_node* *end\_node* ?-arcmode *mode*?
: Returns the distance in graph *g* from the *start\_node* to the *end\_node* using an undirected traversal (i.e., *-arcmode* **undirected**). Use *-arcmode* **directed** for a directed traversal. (See **struct::graph::op::dijkstra**’s **-arcmode** option.)

**struct::graph::op::eccentricity** *g* *node* ?-arcmode *mode*?
: Returns the *eccentricity* in graph *g* of the given *node* using an undirected traversal (i.e., *-arcmode* **undirected**). Use *-arcmode* **directed** for a directed traversal. (See **struct::graph::op::dijkstra**’s **-arcmode** option.)

    A node’s (un)directed *eccentricity* is the maximal (un)directed distance between the node and any other node in the graph.

**struct::graph::op::radius** *g* ?-arcmode *mode*?
: Returns the *radius* of graph *g* using an undirected traversal (i.e., *-arcmode* **undirected**). Use *-arcmode* **directed** for a directed traversal. (See **struct::graph::op::dijkstra**’s **-arcmode** option.)

    A graph’s (un)directed *radius* is the minimal (un)directed *eccentricity* of all nodes in the graph.

**struct::graph::op::diameter** *g* ?-arcmode *mode*?
: Returns the *diameter* of graph *g* using an undirected traversal (i.e., *-arcmode* **undirected**). Use *-arcmode* **directed** for a directed traversal. (See **struct::graph::op::dijkstra**’s **-arcmode** option.)

    A graph’s (un)directed *radius* is the maximal (un)directed *eccentricity* of all nodes in the graph.

**struct::graph::op::BellmanFord** *g* *startnode*
: Searching for **shortests paths** between chosen node and all other nodes in graph *g*. Based on relaxation method. In comparison to **struct::graph::op::dijkstra** it doesn't need assumption that all weights on edges in input graph *g* have to be positive.

    That generality sets the complexity of algorithm to - *O(V\*E)*, where *V* is the number of vertices and *E* is number of edges in graph *g*.

    Arguments:
    : see below ...

        Graph object *g* (input)
        : Directed, connected and edge weighted graph *g*, without any negative cycles ( presence of cycles with the negative sum of weight means that there is no shortest path, since the total weight becomes lower each time the cycle is traversed ). Negative weights on edges are allowed.

        Node *startnode* (input)
        : The node for which we find all shortest paths to each other node in graph *g*.


    Result:
    : Dictionary containing for each node (key) distances to each other node in graph *g*.


    *Note:* If algorithm finds a negative cycle, it will return error message.

**struct::graph::op::Johnsons** *g* ?*options*...?
: Searching for **shortest paths** between all pairs of vertices in graph. For sparse graphs asymptotically quicker than **struct::graph::op::FloydWarshall** algorithm. Johnson's algorithm uses **struct::graph::op::BellmanFord** and **struct::graph::op::dijkstra** as subprocedures.

    Time complexity: *O(n\*\*2\*log(n) +n\*m)*, where *n* is the number of nodes and *m* is the number of edges in graph *g*.

    Arguments:
    : see below ...

        Graph object *g* (input)
        : Directed graph *g*, weighted on edges and not containing any cycles with negative sum of weights ( the presence of such cycles means there is no shortest path, since the total weight becomes lower each time the cycle is traversed ). Negative weights on edges are allowed.


    Options:
    : see below ...

        **-filter**
        : Returns only existing distances, cuts all *Inf* values for non-existing connections between pairs of nodes.


    Result:
    : Dictionary containing distances between all pairs of vertices.


**struct::graph::op::FloydWarshall** *g*
: Searching for **shortest paths** between all pairs of edges in weighted graphs.

    Time complexity: *O(V^3)* - where *V* is number of vertices.

    Memory complexity: *O(V^2)*.

    Arguments:
    : see below ...

        Graph object *g* (input)
        : Directed and weighted graph *g*.


    Result:
    : Dictionary containing shortest distances to each node from each node.


    *Note:* Algorithm finds solutions dynamically. It compares all possible paths through the graph between each pair of vertices. Graph shouldn't possess any cycle with negative sum of weights (the presence of such cycles means there is no shortest path, since the total weight becomes lower each time the cycle is traversed).

    On the other hand algorithm can be used to find those cycles - if any shortest distance found by algorithm for any nodes *v* and *u* (when *v* is the same node as *u*) is negative, that node surely belong to at least one negative cycle.

**struct::graph::op::MetricTravellingSalesman** *g*
: Algorithm for solving a metric variation of [Travelling Salesman problem]. *TSP problem* is *NP-Complete*, so there is no efficient algorithm to solve it. Greedy methods are getting extremely slow, with the increase in the set of nodes.

    Arguments:
    : see below ...

        Graph object *g* (input)
        : Undirected, weighted graph *g*.


    Result:
    : Approximated solution of minimum *Hamilton Cycle* - closed path visiting all nodes, each exactly one time.


    *Note:* **It's 2-approximation algorithm.**

**struct::graph::op::Christofides** *g*
: Another algorithm for solving **metric** *TSP problem*. Christofides implementation uses *Max Matching* for reaching better approximation factor.

    Arguments:
    : see below ...

        Graph Object *g* (input)
        : Undirected, weighted graph *g*.


    Result:
    : Approximated solution of minimum *Hamilton Cycle* - closed path visiting all nodes, each exactly one time.


    *Note:* **It's is a 3/2 approximation algorithm.**

**struct::graph::op::GreedyMaxMatching** *g*
: *Greedy Max Matching* procedure, which finds **maximal matching** (not maximum) for given graph *g*. It adds edges to solution, beginning from edges with the lowest cost.

    Arguments:
    : see below ...

        Graph Object *g* (input)
        : Undirected graph *g*.


    Result:
    : Set of edges - the max matching for graph *g*.


**struct::graph::op::MaxCut** *g* *U* *V*
: Algorithm solving a **Maximum Cut Problem**.

    Arguments:
    : see below ...

        Graph Object *g* (input)
        : The graph to cut.

        List *U* (output)
        : Variable storing first set of nodes (cut) given by solution.

        List *V* (output)
        : Variable storing second set of nodes (cut) given by solution.


    Result:
    : Algorithm returns number of edges between found two sets of nodes.


    *Note:* *MaxCut* is a **2-approximation algorithm.**

**struct::graph::op::UnweightedKCenter** *g* *k*
: Approximation algorithm that solves a [K-center problem].

    Arguments:
    : see below ...

        Graph Object *g* (input)
        : Undirected complete graph *g*, which satisfies triangle inequality.

        Integer *k* (input)
        : Positive integer that sets the number of nodes that will be included in *k-center*.


    Result:
    : Set of nodes - *k* center for graph *g*.


    *Note:* *UnweightedKCenter* is a **2-approximation algorithm.**

**struct::graph::op::WeightedKCenter** *g* *nodeWeights* *W*
: Approximation algorithm that solves a weighted version of [K-center problem].

    Arguments:
    : see below ...

        Graph Object *g* (input)
        : Undirected complete graph *g*, which satisfies triangle inequality.

        Integer *W* (input)
        : Positive integer that sets the maximum possible weight of *k-center* found by algorithm.

        List *nodeWeights* (input)
        : List of nodes and its weights in graph *g*.


    Result:
    : Set of nodes, which is solution found by algorithm.


    *Note:WeightedKCenter* is a **3-approximation algorithm.**

**struct::graph::op::GreedyMaxIndependentSet** *g*
: A *maximal independent set* is an *independent set* such that adding any other node to the set forces the set to contain an edge.

    Algorithm for input graph *g* returns set of nodes (list), which are contained in Max Independent Set found by algorithm.

**struct::graph::op::GreedyWeightedMaxIndependentSet** *g* *nodeWeights*
: Weighted variation of *Maximal Independent Set*. It takes as an input argument not only graph *g* but also set of weights for all vertices in graph *g*.

    *Note:* Read also *Maximal Independent Set* description for more info.

**struct::graph::op::VerticesCover** *g*
: *Vertices cover* is a set of vertices such that each edge of the graph is incident to at least one vertex of the set. This 2-approximation algorithm searches for minimum *vertices cover*, which is a classical optimization problem in computer science and is a typical example of an *NP-hard* optimization problem that has an approximation algorithm. For input graph *g* algorithm returns the set of edges (list), which is Vertex Cover found by algorithm.

**struct::graph::op::EdmondsKarp** *g* *s* *t*
: Improved Ford-Fulkerson's algorithm, computing the **maximum flow** in given flow network *g*.

    Arguments:
    : see below ...

        Graph Object *g* (input)
        : Weighted and directed graph. Each edge should have set integer attribute considered as maximum throughputs that can be carried by that link (edge).

        Node *s* (input)
        : The node that is a source for graph *g*.

        Node *t* (input)
        : The node that is a sink for graph *g*.


    Result:
    : Procedure returns the dictionary containing throughputs for all edges. For each key ( the edge between nodes *u* and *v* in the form of *list u v* ) there is a value that is a throughput for that key. Edges where throughput values are equal to 0 are not returned ( it is like there was no link in the flow network between nodes connected by such edge).


    The general idea of algorithm is finding the shortest augumenting paths in graph *g*, as long as they exist, and for each path updating the edge's weights along that path, with maximum possible throughput. The final (maximum) flow is found when there is no other augumenting path from source to sink.

    *Note:* Algorithm complexity : *O(V\*E)*, where *V* is the number of nodes and *E* is the number of edges in graph *g*.

**struct::graph::op::BusackerGowen** *g* *desiredFlow* *s* *t*
: Algorithm finds solution for a **minimum cost flow problem**. So, the goal is to find a flow, whose max value can be *desiredFlow*, from source node *s* to sink node *t* in given flow network *g*. That network except throughputs at edges has also defined a non-negative cost on each edge - cost of using that edge when directing flow with that edge ( it can illustrate e.g. fuel usage, time or any other measure dependent on usages ).

    Arguments:
    : see below ...

        Graph Object *g* (input)
        : Flow network (directed graph), each edge in graph should have two integer attributes: *cost* and *throughput*.

        Integer *desiredFlow* (input)
        : Max value of the flow for that network.

        Node *s* (input)
        : The source node for graph *g*.

        Node *t* (input)
        : The sink node for graph *g*.


    Result:
    : Dictionary containing values of used throughputs for each edge ( key ). found by algorithm.


    *Note:* Algorithm complexity : *O(V\*\*2\*desiredFlow)*, where *V* is the number of nodes in graph *g*.

**struct::graph::op::ShortestsPathsByBFS** *g* *s* *outputFormat*
: Shortest pathfinding algorithm using BFS method. In comparison to **struct::graph::op::dijkstra** it can work with negative weights on edges. Of course negative cycles are not allowed. Algorithm is better than dijkstra for sparse graphs, but also there exist some pathological cases (those cases generally don't appear in practise) that make time complexity increase exponentially with the growth of the number of nodes.

    Arguments:
    : see below ...

        Graph Object *g* (input)
        : Input graph.

        Node *s* (input)
        : Source node for which all distances to each other node in graph *g* are computed.


    Options and result:
    : see below ...

        **distances**
        : When selected *outputFormat* is **distances** - procedure returns dictionary containing distances between source node *s* and each other node in graph *g*.

        **paths**
        : When selected *outputFormat* is **paths** - procedure returns dictionary containing for each node *v*, a list of nodes, which is a path between source node *s* and node *v*.



**struct::graph::op::BFS** *g* *s* ?*outputFormat*...?
: Breadth-First Search - algorithm creates the BFS Tree. Memory and time complexity: *O(V + E)*, where *V* is the number of nodes and *E* is number of edges.

    Arguments:
    : see below ...

        Graph Object *g* (input)
        : Input graph.

        Node *s* (input)
        : Source node for BFS procedure.


    Options and result:
    : see below ...

        **graph**
        : When selected **outputFormat** is **graph** - procedure returns a graph structure (**struct::graph**), which is equivalent to BFS tree found by algorithm.

        **tree**
        : When selected **outputFormat** is **tree** - procedure returns a tree structure (**struct::tree**), which is equivalent to BFS tree found by algorithm.



**struct::graph::op::MinimumDiameterSpanningTree** *g*
: The goal is to find for input graph *g*, the *spanning tree* that has the minimum *diameter* value.

    General idea of algorithm is to run *BFS* over all vertices in graph *g*. If the diameter *d* of the tree is odd, then we are sure that tree given by *BFS* is minimum (considering diameter value). When, diameter *d* is even, then optimal tree can have minimum *diameter* equal to *d* or *d-1*.

    In that case, what algorithm does is rebuilding the tree given by *BFS*, by adding a vertice between root node and root's child node (nodes), such that subtree created with child node as root node is the greatest one (has the greatests height). In the next step for such rebuilded tree, we run again *BFS* with new node as root node. If the height of the tree didn't changed, we have found a better solution.

    For input graph *g* algorithm returns the graph structure (**struct::graph**) that is a spanning tree with minimum diameter found by algorithm.

**struct::graph::op::MinimumDegreeSpanningTree** *g*
: Algorithm finds for input graph *g*, a spanning tree *T* with the minimum possible degree. That problem is *NP-hard*, so algorithm is an approximation algorithm.

    Let *V* be the set of nodes for graph *g* and let *W* be any subset of *V*. Lets assume also that *OPT* is optimal solution and *ALG* is solution found by algorithm for input graph *g*.

    It can be proven that solution found with the algorithm must fulfil inequality:

    *((|W| + k - 1) / |W|) <= ALG <= 2\*OPT + log2(n) + 1*.

    Arguments:
    : see below ...

        Graph Object *g* (input)
        : Undirected simple graph.


    Result:
    : Algorithm returns graph structure, which is equivalent to spanning tree *T* found by algorithm.


**struct::graph::op::MaximumFlowByDinic** *g* *s* *t* *blockingFlowAlg*
: Algorithm finds **maximum flow** for the flow network represented by graph *g*. It is based on the blocking-flow finding methods, which give us different complexities what makes a better fit for different graphs.

    Arguments:
    : see below ...

        Graph Object *g* (input)
        : Directed graph *g* representing the flow network. Each edge should have attribute *throughput* set with integer value.

        Node *s* (input)
        : The source node for the flow network *g*.

        Node *t* (input)
        : The sink node for the flow network *g*.


    Options:
    : see below ...

        **dinic**
        : Procedure will find maximum flow for flow network *g* using Dinic's algorithm (**struct::graph::op::BlockingFlowByDinic**) for blocking flow computation.

        **mkm**
        : Procedure will find maximum flow for flow network *g* using Malhotra, Kumar and Maheshwari's algorithm (**struct::graph::op::BlockingFlowByMKM**) for blocking flow computation.


    Result:
    : Algorithm returns dictionary containing it's flow value for each edge (key) in network *g*.


    *Note:* **struct::graph::op::BlockingFlowByDinic** gives *O(m\*n^2)* complexity and **struct::graph::op::BlockingFlowByMKM** gives *O(n^3)* complexity, where *n* is the number of nodes and *m* is the number of edges in flow network *g*.

**struct::graph::op::BlockingFlowByDinic** *g* *s* *t*
: Algorithm for given network *g* with source *s* and sink *t*, finds a **blocking flow**, which can be used to obtain a *maximum flow* for that network *g*.

    Arguments:
    : see below ...

        Graph Object *g* (input)
        : Directed graph *g* representing the flow network. Each edge should have attribute *throughput* set with integer value.

        Node *s* (input)
        : The source node for the flow network *g*.

        Node *t* (input)
        : The sink node for the flow network *g*.


    Result:
    : Algorithm returns dictionary containing it's blocking flow value for each edge (key) in network *g*.


    *Note:* Algorithm's complexity is *O(n\*m)*, where *n* is the number of nodes and *m* is the number of edges in flow network *g*.

**struct::graph::op::BlockingFlowByMKM** *g* *s* *t*
: Algorithm for given network *g* with source *s* and sink *t*, finds a **blocking flow**, which can be used to obtain a *maximum flow* for that *network* *g*.

    Arguments:
    : see below ...

        Graph Object *g* (input)
        : Directed graph *g* representing the flow network. Each edge should have attribute *throughput* set with integer value.

        Node *s* (input)
        : The source node for the flow network *g*.

        Node *t* (input)
        : The sink node for the flow network *g*.


    Result:
    : Algorithm returns dictionary containing it's blocking flow value for each edge (key) in network *g*.


    *Note:* Algorithm's complexity is *O(n^2)*, where *n* is the number of nodes in flow network *g*.

**struct::graph::op::createResidualGraph** *g* *f*
: Procedure creates a *residual graph* (or **residual network** ) for network *g* and given flow *f*.

    Arguments:
    : see below ...

        Graph Object *g* (input)
        : Flow network (directed graph where each edge has set attribute: *throughput* ).

        dictionary *f* (input)
        : Current flows in flow network *g*.


    Result:
    : Procedure returns graph structure that is a *residual graph* created from input flow network *g*.


**struct::graph::op::createAugmentingNetwork** *g* *f* *path*
: Procedure creates an **augmenting network** for a given residual network *g* , flow *f* and augmenting path *path*.

    Arguments:
    : see below ...

        Graph Object *g* (input)
        : Residual network (directed graph), where for every edge there are set two attributes: throughput and cost.

        Dictionary *f* (input)
        : Dictionary which contains for every edge (key), current value of the flow on that edge.

        List *path* (input)
        : Augmenting path, set of edges (list) for which we create the network modification.


    Result:
    : Algorithm returns graph structure containing the modified augmenting network.


**struct::graph::op::createLevelGraph** *Gf* *s*
: For given residual graph *Gf* procedure finds the **level graph**.

    Arguments:
    : see below ...

        Graph Object *Gf* (input)
        : Residual network, where each edge has it's attribute *throughput* set with certain value.

        Node *s* (input)
        : The source node for the residual network *Gf*.


    Result:
    : Procedure returns a *level graph* created from input *residual network*.


**struct::graph::op::TSPLocalSearching** *g* *C*
: Algorithm is a *heuristic of local searching* for *Travelling Salesman Problem*. For some solution of *TSP problem*, it checks if it's possible to find a better solution. As *TSP* is well known NP-Complete problem, so algorithm is a approximation algorithm (with 2 approximation factor).

    Arguments:
    : see below ...

        Graph Object *g* (input)
        : Undirected and complete graph with attributes "weight" set on each single edge.

        List *C* (input)
        : A list of edges being *Hamiltonian cycle*, which is solution of *TSP Problem* for graph *g*.


    Result:
    : Algorithm returns the best solution for *TSP problem*, it was able to find.


    *Note:* The solution depends on the choosing of the beginning cycle *C*. It's not true that better cycle assures that better solution will be found, but practise shows that we should give starting cycle with as small sum of weights as possible.

**struct::graph::op::TSPLocalSearching3Approx** *g* *C*
: Algorithm is a *heuristic of local searching* for *Travelling Salesman Problem*. For some solution of *TSP problem*, it checks if it's possible to find a better solution. As *TSP* is well known NP-Complete problem, so algorithm is a approximation algorithm (with 3 approximation factor).

    Arguments:
    : see below ...

        Graph Object *g* (input)
        : Undirected and complete graph with attributes "weight" set on each single edge.

        List *C* (input)
        : A list of edges being *Hamiltonian cycle*, which is solution of *TSP Problem* for graph *g*.


    Result:
    : Algorithm returns the best solution for *TSP problem*, it was able to find.


    *Note:* In practise 3-approximation algorithm turns out to be far more effective than 2-approximation, but it gives worser approximation factor. Further heuristics of local searching (e.g. 4-approximation) doesn't give enough boost to square the increase of approximation factor, so 2 and 3 approximations are mainly used.

**struct::graph::op::createSquaredGraph** *g*
: X-Squared graph is a graph with the same set of nodes as input graph *g*, but a different set of edges. X-Squared graph has edge *(u,v)*, if and only if, the distance between *u* and *v* nodes is not greater than X and *u != v*.

    Procedure for input graph *g*, returns its two-squared graph.

    *Note:* Distances used in choosing new set of edges are considering the number of edges, not the sum of weights at edges.

**struct::graph::op::createCompleteGraph** *g* *originalEdges*
: For input graph *g* procedure adds missing arcs to make it a *complete graph*. It also holds in variable *originalEdges* the set of arcs that graph *g* possessed before that operation.


# Background theory and terms

## Shortest path problem

Definition (*single-pair shortest path problem*):
: Formally, given a weighted graph (let *V* be the set of vertices, and *E* a set of edges), and one vertice *v* of *V*, find a path *P* from *v* to a *v'* of V so that the sum of weights on edges along the path is minimal among all paths connecting v to v'.

Generalizations:
: - *The single-source shortest path problem*, in which we have to find shortest paths from a source vertex v to all other vertices in the graph.

    - *The single-destination shortest path problem*, in which we have to find shortest paths from all vertices in the graph to a single destination vertex v. This can be reduced to the single-source shortest path problem by reversing the edges in the graph.

    - *The all-pairs shortest path problem*, in which we have to find shortest paths between every pair of vertices v, v' in the graph.


    *Note:* The result of *Shortest Path problem* can be *Shortest Path tree*, which is a subgraph of a given (possibly weighted) graph constructed so that the distance between a selected root node and all other nodes is minimal. It is a tree because if there are two paths between the root node and some vertex v (i.e. a cycle), we can delete the last edge of the longer path without increasing the distance from the root node to any node in the subgraph.


## Travelling Salesman problem

Definition:
: For given edge-weighted (weights on edges should be positive) graph the goal is to find the cycle that visits each node in graph exactly once (*Hamiltonian cycle*).

Generalizations:
: - *Metric TSP* - A very natural restriction of the *TSP* is to require that the distances between cities form a *metric*, i.e., they satisfy *the triangle inequality*. That is, for any 3 cities *A*, *B* and *C*, the distance between *A* and *C* must be at most the distance from *A* to *B* plus the distance from *B* to *C*. Most natural instances of *TSP* satisfy this constraint.

    - *Euclidean TSP* - Euclidean TSP, or *planar TSP*, is the *TSP* with the distance being the ordinary *Euclidean distance*. *Euclidean TSP* is a particular case of *TSP* with *triangle inequality*, since distances in plane obey triangle inequality. However, it seems to be easier than general *TSP* with *triangle inequality*. For example, *the minimum spanning tree* of the graph associated with an instance of *Euclidean TSP* is a *Euclidean minimum spanning tree*, and so can be computed in expected *O(n log n)* time for *n* points (considerably less than the number of edges). This enables the simple *2-approximation algorithm* for TSP with triangle inequality above to operate more quickly.

    - *Asymmetric TSP* - In most cases, the distance between two nodes in the *TSP* network is the same in both directions. The case where the distance from *A* to *B* is not equal to the distance from *B* to *A* is called *asymmetric TSP*. A practical application of an *asymmetric TSP* is route optimisation using street-level routing (asymmetric due to one-way streets, slip-roads and motorways).



## Matching problem

Definition:
: Given a graph *G = (V,E)*, a matching or *edge-independent set* *M* in *G* is a set of pairwise non-adjacent edges, that is, no two edges share a common vertex. A vertex is *matched* if it is incident to an edge in the *matching M*. Otherwise the vertex is *unmatched*.

Generalizations:
: - *Maximal matching* - a matching *M* of a graph G with the property that if any edge not in *M* is added to *M*, it is no longer a *matching*, that is, *M* is maximal if it is not a proper subset of any other *matching* in graph G. In other words, a *matching M* of a graph G is maximal if every edge in G has a non-empty intersection with at least one edge in *M*.

    - *Maximum matching* - a matching that contains the largest possible number of edges. There may be many *maximum matchings*. The *matching number* of a graph G is the size of a *maximum matching*. Note that every *maximum matching* is *maximal*, but not every *maximal matching* is a *maximum matching*.

    - *Perfect matching* - a matching which matches all vertices of the graph. That is, every vertex of the graph is incident to exactly one edge of the matching. Every *perfect matching* is *maximum* and hence *maximal*. In some literature, the term *complete matching* is used. A *perfect matching* is also a *minimum-size edge cover*. Moreover, the size of a *maximum matching* is no larger than the size of a *minimum edge cover*.

    - *Near-perfect matching* - a matching in which exactly one vertex is unmatched. This can only occur when the graph has an odd number of vertices, and such a *matching* must be *maximum*. If, for every vertex in a graph, there is a near-perfect matching that omits only that vertex, the graph is also called *factor-critical*.


Related terms:
: - *Alternating path* - given a matching *M*, an *alternating path* is a path in which the edges belong alternatively to the matching and not to the matching.

    - *Augmenting path* - given a matching *M*, an *augmenting path* is an *alternating path* that starts from and ends on free (unmatched) vertices.



## Cut problems

Definition:
: A *cut* is a partition of the vertices of a graph into two *disjoint subsets*. The *cut-set* of the *cut* is the set of edges whose end points are in different subsets of the partition. Edges are said to be crossing the cut if they are in its *cut-set*.

    Formally:

    - a *cut* *C = (S,T)* is a partition of *V* of a graph *G = (V, E)*.

    - an *s-t cut* *C = (S,T)* of a *flow network* *N = (V, E)* is a cut of *N* such that *s* is included in *S* and *t* is included in *T*, where *s* and *t* are the *source* and the *sink* of *N* respectively.

    - The *cut-set* of a *cut C = (S,T)* is such set of edges from graph *G = (V, E)* that each edge *(u, v)* satisfies condition that *u* is included in *S* and *v* is included in *T*.


    In an *unweighted undirected* graph, the size or weight of a cut is the number of edges crossing the cut. In a *weighted graph*, the same term is defined by the sum of the weights of the edges crossing the cut.

    In a *flow network*, an *s-t cut* is a cut that requires the *source* and the *sink* to be in different subsets, and its *cut-set* only consists of edges going from the *source's* side to the *sink's* side. The capacity of an *s-t cut* is defined by the sum of capacity of each edge in the *cut-set*.

    The *cut* of a graph can sometimes refer to its *cut-set* instead of the partition.

Generalizations:
: - *Minimum cut* - A cut is minimum if the size of the cut is not larger than the size of any other cut.

    - *Maximum cut* - A cut is maximum if the size of the cut is not smaller than the size of any other cut.

    - *Sparsest cut* - The *Sparsest cut problem* is to bipartition the vertices so as to minimize the ratio of the number of edges across the cut divided by the number of vertices in the smaller half of the partition.



## K-center problem

Definitions:
: see below ...

    *Unweighted K-Center*
    : For any set *S* ( which is subset of *V* ) and node *v*, let the *connect(v,S)* be the cost of cheapest edge connecting *v* with any node in *S*. The goal is to find such *S*, that *|S| = k* and *max\_v{connect(v,S)}* is possibly small.

        In other words, we can use it i.e. for finding best locations in the city ( nodes of input graph ) for placing k buildings, such that those buildings will be as close as possible to all other locations in town.

    *Weighted K-Center*
    : The variation of *unweighted k-center problem*. Besides the fact graph is edge-weighted, there are also weights on vertices of input graph *g*. We've got also restriction *W*. The goal is to choose such set of nodes *S* ( which is a subset of *V* ), that it's total weight is not greater than *W* and also function: *max\_v { min\_u { cost(u,v) }}* has the smallest possible worth ( *v* is a node in *V* and *u* is a node in *S* ).



## Flow problems

Definitions:
: - *the maximum flow problem* - the goal is to find a feasible flow through a single-source, single-sink flow network that is maximum. The *maximum flow problem* can be seen as a special case of more complex network flow problems, such as the *circulation problem*. The maximum value of an *s-t flow* is equal to the minimum capacity of an *s-t cut* in the network, as stated in the *max-flow min-cut theorem*.

        More formally for flow network *G = (V,E)*, where for each edge *(u, v)* we have its throuhgput *c(u,v)* defined. As *flow* *F* we define set of non-negative integer attributes *f(u,v)* assigned to edges, satisfying such conditions:

        1. for each edge *(u, v)* in *G* such condition should be satisfied:      0 <= f(u,v) <= c(u,v)

        2. Network *G* has source node *s* such that the flow *F* is equal to the sum of outcoming flow decreased by the sum of incoming flow from that source node *s*.

        3. Network *G* has sink node *t* such that the the *-F* value is equal to the sum of the incoming flow decreased by the sum of outcoming flow from that sink node *t*.

        4. For each node that is not a *source* or *sink* the sum of incoming flow and sum of outcoming flow should be equal.


    - *the minimum cost flow problem* - the goal is finding the cheapest possible way of sending a certain amount of flow through a *flow network*.

    - *blocking flow* - a *blocking flow* for a *residual network* *Gf* we name such flow *b* in *Gf* that:

        1. Each path from *sink* to *source* is the shortest path in *Gf*.

        2. Each shortest path in *Gf* contains an edge with fully used throughput in *Gf+b*.


    - *residual network* - for a flow network *G* and flow *f* *residual network* is built with those edges, which can send larger flow. It contains only those edges, which can send flow larger than 0.

    - *level network* - it has the same set of nodes as *residual graph*, but has only those edges *(u,v)* from *Gf* for which such equality is satisfied: *distance(s,u)+1 = distance(s,v)*.

    - *augmenting network* - it is a modification of *residual network* considering the new flow values. Structure stays unchanged but values of throughputs and costs at edges are different.



## Approximation algorithm

k-approximation algorithm:
: Algorithm is a k-approximation, when for *ALG* (solution returned by algorithm) and *OPT* (optimal solution), such inequality is true:

    - for minimalization problems: *ALG/OPT <= k*

    - for maximalization problems: *OPT/ALG <= k*



# References

1. [Adjacency matrix](http://en.wikipedia.org/wiki/Adjacency_matrix)

2. [Adjacency list](http://en.wikipedia.org/wiki/Adjacency_list)

3. [Kruskal's algorithm](http://en.wikipedia.org/wiki/Kruskal%27s_algorithm)

4. [Prim's algorithm](http://en.wikipedia.org/wiki/Prim%27s_algorithm)

5. [Bipartite graph](http://en.wikipedia.org/wiki/Bipartite_graph)

6. [Strongly connected components](http://en.wikipedia.org/wiki/Strongly_connected_components)

7. [Tarjan's strongly connected components algorithm](http://en.wikipedia.org/wiki/Tarjan%27s_strongly_connected_components_algorithm)

8. [Cut vertex](http://en.wikipedia.org/wiki/Cut_vertex)

9. [Bridge](http://en.wikipedia.org/wiki/Bridge_(graph_theory))

10. [Bellman-Ford's algorithm](http://en.wikipedia.org/wiki/Bellman-Ford_algorithm)

11. [Johnson's algorithm](http://en.wikipedia.org/wiki/Johnson_algorithm)

12. [Floyd-Warshall's algorithm](http://en.wikipedia.org/wiki/Floyd-Warshall_algorithm)

13. [Travelling Salesman Problem](http://en.wikipedia.org/wiki/Travelling_salesman_problem)

14. [Christofides Algorithm](http://en.wikipedia.org/wiki/Christofides_algorithm)

15. [Max Cut](http://en.wikipedia.org/wiki/Maxcut)

16. [Matching](http://en.wikipedia.org/wiki/Matching)

17. [Max Independent Set](http://en.wikipedia.org/wiki/Maximal_independent_set)

18. [Vertex Cover](http://en.wikipedia.org/wiki/Vertex_cover_problem)

19. [Ford-Fulkerson's algorithm](http://en.wikipedia.org/wiki/Ford-Fulkerson_algorithm)

20. [Maximum Flow problem](http://en.wikipedia.org/wiki/Maximum_flow_problem)

21. [Busacker-Gowen's algorithm](http://en.wikipedia.org/wiki/Minimum_cost_flow_problem)

22. [Dinic's algorithm](http://en.wikipedia.org/wiki/Dinic's_algorithm)

23. [K-Center problem](http://www.csc.kth.se/~viggo/wwwcompendium/node128.html)

24. [BFS](http://en.wikipedia.org/wiki/Breadth-first_search)

25. [Minimum Degree Spanning Tree](http://en.wikipedia.org/wiki/Degree-constrained_spanning_tree)

26. [Approximation algorithm](http://en.wikipedia.org/wiki/Approximation_algorithm)


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *struct :: graph* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Data structures

# Copyright

```
Copyright (c) 2008 Alejandro Paz <vidriloco@gmail.com>
Copyright (c) 2008 (docs) Andreas Kupries <andreas_kupries@users.sourceforge.net>
Copyright (c) 2009 Michal Antoniewski <antoniewski.m@gmail.com>
```
