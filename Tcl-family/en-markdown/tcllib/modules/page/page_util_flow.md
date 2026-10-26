---
CommandName: page_util_flow
title: page_util_flow
ManualSection: n
Version: 1.0
TclPart: tcllib
TclDescription: Parser generator tools
Keywords:
 - dataflow
 - graph walking
 - page
 - parser generator
 - text processing
 - tree walking
Copyright:
 - Copyright (c) 2007 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

page\_util\_flow - page dataflow/treewalker utility

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [page::util::flow]{.lit} [0.2]{.optlit}
[package]{.cmd} [require]{.sub} [snit]{.lit}
[::page::util::flow]{.cmd} [start]{.arg} [flowvar]{.arg} [nodevar]{.arg} [script]{.arg}
[flow]{.ins} [visit]{.sub} [node]{.arg}
[flow]{.ins} [visitl]{.sub} [nodelist]{.arg}
[flow]{.ins} [visita]{.sub} [node...]{.arg}
:::

# Description

This package provides a single utility command for easy dataflow based manipulation of arbitrary data structures, especially abstract syntax trees.

# API

**::page::util::flow** *start* *flowvar* *nodevar* *script*
: This command contains the core logic to drive the walking of an arbitrary data structure which can partitioned into separate parts. Examples of such structures are trees and graphs.

    The command makes no assumptions at all about the API of the structure to be walked, except that that its parts, here called *nodes*, are identified by strings. These strings are taken as is, from the arguments, and the body, and handed back to the body, without modification.

    Access to the actual data structure, and all decisions regarding which nodes to visit in what order are delegated to the body of the loop, i.e. the *script*.

    The body is invoked first for the nodes in the start-set specified via *start*), and from then on for the nodes the body has requested to be visited. The command stops when the set of nodes to visit becomes empty. Note that a node can be visited more than once. The body has complete control about this.

    The body is invoked in the context of the caller. The variable named by *nodevar* will be set to the current node, and the variable named by *flowvar* will be set to the command of the flow object through which the body can request the nodes to visit next. The API provided by this object is described in the next section, [Flow API].

    Note that the command makes no promises regarding the order in which nodes are visited, excpt that the nodes requested to be visited by the current iteration will be visited afterward, in some order.


# Flow API

This section describes the API provided by the flow object made accessible to the body script of **::page::util::flow**.

*flow* **visit** *node*
: Invoking this method requests that the node *n* is visited after the current iteration.

*flow* **visitl** *nodelist*
: Invoking this method requests that all the nodes found in the list *nodelist* are visited after the current iteration.

*flow* **visita** *node*...
: This is the variadic arguments form of the method **visitl**, see above.


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *page* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Page Parser Generator

# Copyright

```
Copyright (c) 2007 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
