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

struct::skiplist - Create and manipulate skiplists

# Synopsis

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

# Description

The **::struct::skiplist** command creates a new skiplist object with an associated global Tcl command whose name is *skiplistName*. This command may be used to invoke various operations on the skiplist. It has the following general form:

**skiplistName** *option* ?*arg arg ...*?
: *Option* and the *arg*s determine the exact behavior of the command.


Skip lists are an alternative data structure to binary trees. They can be used to maintain ordered lists over any sequence of insertions and deletions. Skip lists use randomness to achieve probabilistic balancing, and as a result the algorithms for insertion and deletion in skip lists are much simpler and faster than those for binary trees.

To read more about skip lists see Pugh, William. *Skip lists: a probabilistic alternative to balanced trees* In: Communications of the ACM, June 1990, 33(6) 668-676.

Currently, the key can be either a number or a string, and comparisons are performed with the built in greater than operator. The following commands are possible for skiplist objects:

*skiplistName* **delete** *node* ?*node*...?
: Remove the specified nodes from the skiplist.

*skiplistName* **destroy**
: Destroy the skiplist, including its storage space and associated command.

*skiplistName* **insert** *key value*
: Insert a node with the given *key* and *value* into the skiplist. If a node with that key already exists, then the that node's value is updated and its node level is returned. Otherwise a new node is created and 0 is returned.

*skiplistName* **search** *node* ?**-key** *key*?
: Search for a given key in a skiplist. If not found then 0 is returned. If found, then a two element list of 1 followed by the node's value is retuned.

*skiplistName* **size**
: Return a count of the number of nodes in the skiplist.

*skiplistName* **walk** *cmd*
: Walk the skiplist from the first node to the last. At each node, the command *cmd* will be evaluated with the key and value of the current node appended.


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *struct :: skiplist* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Data structures

# Copyright

```
Copyright (c) 2000 Keith Vetter
```
