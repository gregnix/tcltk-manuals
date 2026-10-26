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

struct::graph - Create and manipulate directed graph objects

# Synopsis

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

# Description

A directed graph is a data structure containing two collections of elements, *nodes* and *arcs* (also called *edges*), along with a relation that connects the nodes and arcs.

Each arc is connected to two nodes, one of which is called the *source* and the other the *target*. This imposes a direction upon the arc, which is said to go from the source to the target. When an arc’s source and target are the same node, the arc is called a *loop*.

When a node is the source or target of an arc, the node and arc are said to be *adjacent*. Furthermore, if two nodes are connected via one or more arcs, the nodes are also said to be *adjacent*.

A node can be the source of any number of *outgoing arcs*, and also the target of any number of *incoming arcs*. The number of *outgoing arcs* is a node’s *out-degree*, and the number of *incoming arcs* is a node’s *in-degree*.

This **struct::graph** package can manage graphs of nodes, arcs, and their relationships. In addition, the package supports the addition of any number of named *attributes* which can be associated with a graph itself, as well as with any of the graph’s nodes and arcs.

See the **struct::graph::ops** package for commands that implement a wide range of common graph algorithms.

*Note:* The major version of the **struct::graph** package has been changed to version 2, due to backward incompatible changes in the module’s API. Users of version 1 are recommended to read the section [Changes for v2] for a full list of the changes, including incompatibilities with version 1.

As of version 2.2, a critcl based C implementation is now provided, which requires Tcl 8.4 or later.

# API

**::struct::graph** ?*aGraph*? ?**=**|**:=**|**as**|**deserialize** *source*?
: This command creates a new graph object with an associated global Tcl command. If *aGraph* is given, the global command will be called the given name; otherwise, a unique name will be generated by the package itself.

    If a *source* is specified, the new graph will be initialized from it. For the operators **=**, **:=**, and **as**, the *source* argument is interpreted as the name of another graph object, and the assignment operator **=** will be executed. For the operator **deserialize**, the *source* is assumed to be a serialized graph object, and **deserialize** will be executed.

    For example:

    ```
        ::struct::graph graphA = graphB
    ```

    is equivalent to

    ```
        ::struct::graph graphA
        graphA = graphB
    ```

    and

    ```
        ::struct::graph graphA deserialize $graphB
    ```

    is equivalent to

    ```
        ::struct::graph graphA
        graphA deserialize $graphB
    ```

    Once the graph object—and its corresponding command—has been created, the command can be used to apply various graph operations. These all have the same general form:

    *aGraph* *method* ?*arg ...*?

    The *method* and the *arg*s specify what operation to perform.


## Methods

*aGraph* **=** *sourceGraph*
: The **=** operator is the graph object *assignment* operator. It copies the graph contained in the graph object *sourceGraph* over the graph data in *aGraph*. The old contents of *aGraph* are deleted by this operation.

    This operation is in effect equivalent to

    ```
        aGraph deserialize [sourceGraph serialize]
    ```

    The operation assumes that the *sourceGraph* provides a **serialize** method which returns a valid graph serialization.

*aGraph* **-->** *destGraph*
: The **-->** operator is the graph object *reverse assignment* operator. It copies the graph contained in the graph object *aGraph* over the graph data in the object *destGraph*. The old contents of *destGraph* are deleted by this operation.

    This operation is in effect equivalent to

    ```
        destGraph deserialize [aGraph serialize]
    ```

    The operation assumes that the *destGraph* provides a **deserialize** method which takes a graph serialization, and that *aGraph* provides a **serialize** method which returns a valid graph serialization.

*aGraph* **append** *key* *value*
: Appends the *value* to the graph attribute associated with the given *key*. Returns the new value of the graph attribute associated with the *key*.

*aGraph* **deserialize** *serialization*
: This is the complement of the **serialize** method. It replaces the graph data in *aGraph* with the graph described by the *serialization* value. The old contents of *aGraph* are deleted by this operation.

*aGraph* **destroy**
: Destroys the graph, including its storage space and associated command.

*aGraph* **arc append** *arc* *key* *value*
: Appends the *value* to the given *arc*’s attribute associated with the given *key*. Returns the new value of the *arc* attribute associated with the *key*.

*aGraph* **arc attr** *key*
: see below ...

*aGraph* **arc attr** *key* **-arcs** *list*
: see below ...

*aGraph* **arc attr** *key* **-glob** *globpattern*
: see below ...

*aGraph* **arc attr** *key* **-regexp** *repattern*
: When no options are specified, the **arc attr** method returns a **dict** whose keys are the names of *every* arc in the *aGraph* graph. For each of the resultant dict’s keys, the corresponding value is the value of the arc attribute associated with the given *key*. Arcs which do not have the given *key* are not included in the result **dict**.

    If one of the options is specified, in effect the same results **dict** is created as for no options, but filtered so that only the arcs which match the given option’s constraint are included in the result **dict**.

    The possible constraints are:

    **-arcs**
    : The value must be a list of arc names. Only the arcs mentioned in this list are searched for the *key* attribute.

    **-glob**
    : The value is a glob pattern. Only the arcs in the graph whose names match this pattern are searched for the *key* attribute.

    **-regexp**
    : The value is a regular expression. Only the arcs in the graph whose names match this pattern are searched for the *key* attribute.


*aGraph* **arc delete** *arc* ?*arc* ...?
: Removes the specified arcs from the graph.

    If one or more of the arcs doesn’t exit an error is thrown.

*aGraph* **arc exists** *arc*
: Returns **1** (true) if the specified *arc* exists in the graph; otherwise returns **0** (false).

*aGraph* **arc flip** *arc*
: Reverses the direction of the *arc*, i.e., the arc’s source and target nodes are exchanged with each other.

*aGraph* **arc get** *arc* *key*
: Returns the value associated with the *arc*’s *key*.

    If the *arc* doesn’t exist or if the *key* doesn’t exist, an error is thrown.

*aGraph* **arc getall** *arc* ?*glob*?
: Returns a dictionary (suitable for use with \[**array set**\]) of the *arc*’s attribute keys and values.

    If a *glob* pattern is specified, only the attributes whose keys match will be included.

*aGraph* **arc getunweighted**
: Returns a list of the names of all the graph’s arcs which have *no* weight associated with them.

*aGraph* **arc getweight** *arc*
: Returns the weight associated with the *arc*.

    If the *arc* doesn’t exist or if it has no weight, an error is thrown.

*aGraph* **arc keys** *arc* ?*glob*?
: Returns a list of keys for the *arc*.

    If *glob* is specified only the attributes whose names match the glob will be part of the returned list.

*aGraph* **arc keyexists** *arc* *key*
: Returns **1** (true) if the *arc* has the specified *key*; otherwise returns **0** (false).

*aGraph* **arc insert** *start* *end* ?*name*?
: Inserts an arc into the graph beginning at the *start* node and ending at the *end* node. The new arc is called *name* if specified; otherwise a unique system-generated name of form *arcx* is used.

*aGraph* **arc lappend** *arc* *key* *value*
: Appends the given *value* (as a list) to the value associated with the *arc*’s *key* and returns the *arc*’s *key*’s new value.

*aGraph* **arc rename** *arc* *newname*
: Renames the *arc* to *newname* and returns *newname*.

    Thows an error if the given *arc* does not exist, or if an arc called *newname* already exists.

*aGraph* **arc set** *arc* *key* ?*value*?
: Get or set the value of the given *arc*’s associated *key*.

    If *value* *is not* specified, the value of the given *arc*’s associated *key* is returned. If a *value* *is* specified, then the *value* is assigned to the given *key*, and the value of the given *arc*’s associated *key* is returned.

    An arc may have any number of key-value pairs associated with it.

*aGraph* **arc setunweighted** ?*weight*?
: Sets the weight of all arcs without a weight to *weight*. If no *weight* is specified it defaults to **0**. Returns the empty string.

*aGraph* **arc setweight** *arc* *weight*
: Sets the weight of the *arc* to *weight* and returns *weight*.

*aGraph* **arc unsetweight** *arc*
: Removes the weight of the *arc*, if present; otherwise does nothing. Returns the empty string.

*aGraph* **arc hasweight** *arc*
: Returns **1** (true) if the *arc* has a weight; otherwise returns **0** (false).

*aGraph* **arc source** *arc*
: Returns the node the given *arc* begins at.

*aGraph* **arc target** *arc*
: Returns the node the given *arc* ends at.

*aGraph* **arc nodes** *arc*
: Returns a two-element list of the nodes the given *arc* begins and ends at.

*aGraph* **arc move-source** *arc* *newsource*
: Changes the *arc*’s source node to *newsource*. This can be described as rotating the arc around its target node.

*aGraph* **arc move-target** *arc* *newtarget*
: Changes the *arc*’s target node to *newtarget*. This can be described as rotating the arc around its source node.

*aGraph* **arc move** *arc* *newsource* *newtarget*
: Changes the *arc*’s source and target nodes to *newsource* and *newtarget* respectively.

*aGraph* **arc unset** *arc* *key*
: Removes the *arc*’s *key* and its corresponding value. Does nothing if the *key* doesn’t exist.

*aGraph* **arc weights**
: Returns a **dict** where each key is the name of an arc which has a weight and each corresponding value is that arc’s weight.

*aGraph* **arcs** ?-key *key* ?-value *value*?? ?-filter *cmdprefix*? ?-in|-out|-adj|-inner|-embedding *node* ?node? ...?
: Returns a list of the graph’s arcs.

    If no constraint is specified, every arc is in the returned list.

    *Constraints*

    Constraints can limit which arcs are included in the returned list based on the nodes that are connected by the arc, on the keyed values associated with the arc, or both. A general filter command can also be used. The constraints that involve connected nodes take a variable number of nodes as argument, specified after the name of the constraint itself.

    At most one **-key** constraint may be specified, and if present then at most one **-value** constraint my also be used. The **key** (and if present **-value**), if specified, will be applied *second*. (If two or more **-key** options are used or if a **-value** is used without a corresponding **key**, an error will be thrown.)

    **-key** *key*
    : Only return arcs that have the associated *key*.

    **-value** *value*
    : Only return arcs that have the associated *key* (which *must* be specified using the **-key** option), *and* for which the *key*’s value is *value*.


    At most one **-filter** command may be specified, and if present, this is applied *last*. (If two or more **-filter** options are used an error will be thrown.)

    **-filter** *cmdprefix*
    : Only return arcs for which the given *cmdprefix* returns **1** (true).

        For each candidate arc the *cmdprefix* is executed in the context of the caller. It is called with two arguments, the name of the graph object, and the name of the candidate arc. The *cmdprefix* command should return either **1** (true; to keep the arc in the list to be returned), or **0** (false; to remove the arc from the list to be returned).


    At most one constraint may be specified using one of **-in**, **-out**, **-adj**, **-inner**, or **-embedding**. If one of these is present, it is applied *first*. (If two or more of these options is used an error will be thrown.)

    **-in**
    : Only return arcs whose target is one of the specified nodes. In other words, compute the union of all the incoming arcs for the specified nodes.

    **-out**
    : Only return arcs whose source is one of the specified nodes. In other words, compute the union of all the outgoing arcs for the specified nodes.

    **-adj**
    : Only return arcs that are adjacent to at least one of the specified nodes. In other words, compute the union of all the incoming *and* outgoing arcs for the specified nodes (i.e., the union of using **-in** and **-out**).

    **-inner**
    : Only return arcs that are adjacent to two of the specified nodes. This is the set of arcs in the subgraph formed by the specified nodes.

    **-embedding**
    : Only return arcs that are adjacent to exactly one of the specified nodes. This is the set of arcs connecting the subgraph formed by the specified nodes to the rest of the graph.


    *Note*: After specifiying one of the options above, any word with a leading dash which is not a valid option is treated as a node name instead of an invalid option. This condition holds until either a valid option terminates the list of nodes, or the end of the command is reached, whichever comes first.

*aGraph* **lappend** *key* *value*
: Appends the *value* (as a list) to the graph attribute with the given *key*, and returns the attribute with the *key*’s new value.

*aGraph* **node append** *node* *key* *value*
: Appends the *value* to the *node*’s attribute with the given *key*, and returns the attribute with the *key*’s new value.

*aGraph* **node attr** *key*
: see below ...

*aGraph* **node attr** *key* **-nodes** *list*
: see below ...

*aGraph* **node attr** *key* **-glob** *globpattern*
: see below ...

*aGraph* **node attr** *key* **-regexp** *repattern*
: Returns a **dict** whose keys are node names and whose corresponding values are those of the nodes’ attribute values associated with the given *key*.

    The returned **dict** will include all the graph’s nodes that have the given *key* *or* if an optional constraint is specified, the subset of those nodes which match the given constraint. This means that any nodes which do *not* have the given *key* or which do *not* satisfy the constraint (if given) will not be included in the returned **dict**.

    The possible constraints are:

    **-nodes**
    : Only the graph’s nodes that are in the given *list* and have the specified *key*, will be included in the results **dict**.

    **-glob**
    : Only the graph’s nodes whose names match the given *globpattern* glob pattern and have the specified *key*, will be included in the results **dict**.

    **-regexp**
    : Only the graph’s nodes whose names match the given *repattern* regular expression and have the specified *key*, will be included in the results **dict**.


*aGraph* **node degree** ?-in|-out? *node*
: Returns the number of arcs adjacent to the specified *node*.

    If the **-in** constraint is specified, only the incoming arcs are counted; if the **-out** constraint is specified, only the outgoing arcs are counted. If neither constraint is specified, then all incoming and outgoing arcs are counted.

*aGraph* **node delete** *node* ?*node*...?
: Deletes the specified nodes from the graph, *and also* deletes all the nodes’ arcs (to prevent unconnected arcs).

*aGraph* **node exists** *node*
: Returns **1** (true) if the specified *node* exists in the graph; otherwise returns **0** (false).

*aGraph* **node get** *node* *key*
: Returns the value associated with the *node*’s *key*.

    Throws an error if the *node* does not have the given *key*.

*aGraph* **node getall** *node* ?*glob*?
: Returns a **dict** (suitable for use with \[**array set**\]) for the *node*. The **dict**’s keys are attribute names (i.e., their keys) and the values are the corresponding attribute values.

    If *glob* is specified, only the attributes whose names (i.e., keys) match this glob pattern, will included in the returned dictionary.

*aGraph* **node keys** *node* ?*glob*?
: Returns a list of the *node*’s attribute keys.

    If *glob* is specified, only the attributes whose names (i.e., keys) match this glob pattern, will included in the returned list.

*aGraph* **node keyexists** *node* *key*
: Returns **1** (true) if the *node* has the specified *key*; otherwise returns **0** (false).

*aGraph* **node insert** ?*node*...?
: Inserts one or more nodes into the graph, and returns a list of the inserted nodes. These new nodes are not connected to any arcs.

    If no node is specified, a single new node will be inserted and returned. The new node will have a unique name generated by the system and having the form *nodex*.

*aGraph* **node lappend** *node* *key* *value*
: Appends the *value* (as a list) the *node*’s attribute with the given *key*, and returns the attribute with the *key*’s new value.

*aGraph* **node opposite** *node* *arc*
: Returns the node at the other end of the specified *arc*, which must be adjacent to the given *node*.

*aGraph* **node rename** *node* *newname*
: Renames the *node* to *newname* and returns the node’s new name.

    An error is thrown if the node does not exist, or if a node called *newname* already exists.

*aGraph* **node set** *node* *key* ?*value*?
: Get or set the given *node*’s attribute that’s identified by the given *key*.

    If *value* is not specified, this command returns the *key*’s current value. If *value* is specified, this command assigns *value* to the *node*’s *key*.

    Each node may have any number of keyed values associated with it.

*aGraph* **node unset** *node* *key*
: Removes the *node*’s *key* and its associated value from the *node*’s attributes. Does nothing if the *node* does not have the given *key*.

*aGraph* **nodes** ?-key *key*? ?-value *value*? ?-filter *cmdprefix*? ?-in|-out|-adj|-inner|-embedding *node* *node*...?
: Returns a list of the graph’s nodes. Every node is included in the list unless constraints are specified.

    Constraints can limit the nodes included in the list based on the keyed values associated with the node or on neighboring nodes. The constraints that involve neighboring nodes take a list of nodes as argument, specified after the name of the constraint itself.

    The constraints are essentially the same as for the **arcs** method. Although the exact meanings change slightly, since here the contraints operate on nodes rather than arcs, the general behaviour is the same, especially when it comes to the handling of words with a leading dash in node lists.

    *Constraints*

    **-in**
    : Return the *incoming neighbours*, i.e., a list of all the nodes with at least one outgoing arc ending in a node in the specified set of nodes. (Alternatively specified as the set of source nodes for the node set’s **-in** arcs.)

    **-out**
    : Return the *outgoing neighbours*, i.e., a list of all the nodes with at least one incoming arc starting in a node in the specified set of nodes. (Alternatively specified as the set of target nodes for the node set’s **-out** arcs.)

    **-adj**
    : Return the *neighbours*, i.e., the union of the nodes returned by **-in** and **-out**.

    **-inner**
    : Return the set of neighbours (see **-adj** above) which are also in the given set of nodes, i.e., the intersection of the neighbours returned by **-adj** and the set of nodes.

    **-embedding**
    : Return the set of neighbours (see **-adj** above) which are *not* in the set of nodes, i.e., the difference between the neighbours returned by **-adj** and the set of nodes.

    **-key** *key*
    : Return only nodes which have the given *key*.

    **-value** *value*
    : Return only nodes which have the given *key* and whose associated value is *value*.

        This constraint can only be used in combination with **-key**.

    **-filter** *cmdprefix*
    : Return only those nodes for which the command *cmdprefix* returns **1** (true).

        The command *cmdprefix* is called with two arguments, the name of the graph object, and the name of the node in question. It is executed in the context of the caller and must return a Boolean value, **0** (false; do not include the node) or **1** (true; include the node).


*aGraph* **get** *key*
: Returns the value associated with the graph’s *key*.

    Throws an error if the graph does not have the given *key*.

    See the **set** method.

*aGraph* **getall** ?*pattern*?
: Returns a dictionary (suitable for use with \[**array set**\]) containing all the graph’s keys and their associated values.

    If the *pattern* is specified only those attributes whose names match the pattern will be part of the returned dictionary. The pattern is a **glob** pattern.

*aGraph* **keys** ?*pattern*?
: Returns a list of all the graph’s keys.

    If the *pattern* is specified only those attributes whose names match the pattern will be part of the returned list. The pattern is a **glob** pattern.

*aGraph* **keyexists** *key*
: Returns **1** (true) if the graph has the specified *key*; otherwise returns **0** (false).

*aGraph* **serialize** ?*node*...?
: Returns the graph (or a subgraph of the graph) serialized into a single Tcl value. The value can be deserialized back into a graph using the **deserialize** method.

    The serialization is of the entire graph, unless one or more *node*s are specified, in which case only the subgraph spanned by the given nodes is serialized.

    Since a serialized graph is a Tcl value it can be copied like any Tcl string, e.g., sent to a channel, persisted into a file, etc.

    This method also serves as the basis for the graph’s copy constructor and assignment operator.

    Every graph interface’s serialize method’s implementation must produce semantically equivalent serialization values so that these values may be used interchangeably between implementations.

    The serialized value is a list of triples, plus a **dict** at the end. This means that *\[llength $serial\] % 3 == 1*. Valid values include 1, 4, 7, ….

    The last element of the list is a **dict** containing the attributes associated with the whole graph.

    All the preceding elements are triples, one per node, each consisting of:

    1. The node’s name.

    2. A **dict** containing the node’s attributes.

    3. A list of all the arcs starting at this node (see below).


    Each element of a node’s list of arcs is itself a list of three or four elements as follows:

    1. The arc’s name.

    2. A reference to the arc’s destination node. This reference is the integer index of the destination node in the main serialization list. (This integer will always be *>= 0* and *< \[llength $serial\]* and a multiple of three.)

        *Note:* For internal consistency serialization requires that every arc name used in a graph must be unique, whether in the same node, or at some other node.

    3. A **dict** containing the arc’s attributes.

    4. An optional arc weight. If absent it means that this arc has no associated weight.

        *Note:* This information is new, compared to the serialization of **graph** 2.3 and earlier. Making arc weights optional in the new format preserves some compatibility with the old. In particular, any graph that does *not* use weights will have a serialization which is deserializeable by the older graph package. However, if weights are used, older packages will not be able to deserialize.


    For all attribute dictionaries, each key is an attribute name and each key’s associated value holds the attribute’s value.

    *Note:* The serialization’s order of nodes and of arcs within each node has no significance. In other words two semantically equivalent graphs could have different serializations.

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
: Get or set the value associated with the given graph *key*.

    If no *value* is given the value associated with the *key* is returned. If *value* is given, the *key* is set to the specified *value* and the *value* is returned.

    Throws an error if no *value* is specified (i.e., when getting) and the graph does not have the given *key*.

    A graph may have any number of keyed values associated with it. See also the **get** method.

*aGraph* **swap** *node1* *node2*
: Swap the positions of *node1* and *node2* in the graph.

*aGraph* **unset** *key*
: Removes the graph’s *key* and its corresponding value. Does nothing if the *key* doesn’t exist.

*aGraph* **walk** *node* ?-type *type*? ?-order *order*? ?-dir *direction*? -command *cmd*
: Perform a breadth-first or depth-first walk of the graph starting at *node* and going **forward** (the direction of outgoing arcs) or **backward** (the opposite direction to the incoming arcs).

    If specified, the walk’s type must be **dfs** (depth-first; the default), or **bfs** breadth-first.

    If specified, the walk’s order must be **pre** (pre-order; the default), or **post** (post-order), or **both**.

    Pre-order means that a node is visited before any of its neighbours (as defined by the *direction*, see below). Post-order means that a node is visited after any of its neighbours. Both-order walking means that a node is visited before *and* after any of its neighbours. Note that the breadth-first type of walk may *only* be combined with pre-order; only depth-first may be used with pre-order, post-order, or both-order.

    If specified, the walk’s direction must be **backward** (the direction opposite to the incoming arcs), or **forward** (the direction of the outgoing arcs).

    As the walk progresses, the command *cmd* will be evaluated at each node and passed three arguments. The arguments are the call’s mode (**enter** or **leave**), the graph itself (i.e., *aGraph*), and the current node’s name. For a pre-order walk, all nodes are entered (mode **enter** is passed to *cmd*); for a post-order all nodes are left (mode **leave** is passed). In a both-order walk the first visit to a node is the entry (mode **enter**), and the second visit is the leave (mode **leave**).


# Changes for v2

## Changes for v2.4

The **serialize** method’s serialization format changed to account for the (optional) use of weights. See the method’s documentation for details.

## Changes for v2.x

The following noteworthy changes have occurred:

1. The API for accessing attributes and their values has been simplified.

    All functionality regarding the default attribute "data" has been removed. This default attribute no longer exists. All accesses to attributes must specify the attribute’s name. This backward *incompatible* change led to simplified signatures for all methods involving attributes.

    In particular, the flag **-key** has gone. Please read the documentation for the arc and node methods **get**, **getall**, **set**, **unset**, **append**, **lappend**, **keyexists**, and **keys**, for a description of the new APIs.

2. The methods **keys** and **getall** now take an optional glob pattern argument which if specified will limit the returned attribute data to only those keys which match the pattern.

3. Arcs and nodes can now be renamed. See the documentation for the methods **arc rename** and **node rename**.

4. The structure has been extended with APIs for graph serialization and deserialization, and a number of operations based on these methods (e.g., graph assignment, copy construction).

    Please read the documentation for the methods **serialize**, **deserialize**, **=**, and **-->**, and the documentation on the construction of graph objects.

    Serialization and deserialization mean that graphs can be copied like any Tcl string, e.g., sent to a channel, persisted into a file, etc.

5. Both **arc**’s and **node**’s now have an **attr** method which supports access to attribute data regardless of arc and node relationships.

6. Both **arcs** and **nodes** have been extended with the ability to specify constraints to filter the arcs or nodes they return; see their documentation for details.


# Examples

The following example shows the basics of using the **struct::graph** package.

An illustration of the graph used in the example:

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

The code that represents the graph shown above, along with weights (flight distances in kilometers).

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

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *struct :: graph* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Data structures

# Copyright

```
Copyright (c) 2002-2009,2019 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
