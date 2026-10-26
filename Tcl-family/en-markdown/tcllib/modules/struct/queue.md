---
CommandName: struct::queue
title: struct::queue
ManualSection: n
Version: 1.4.6
TclPart: tcllib
TclDescription: Tcl Data Structures
Keywords:
 - graph
 - list
 - matrix
 - pool
 - prioqueue
 - record
 - set
 - skiplist
 - stack
 - tree
Copyright:
---

# Name

struct::queue - Create and manipulate queue objects

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [struct::queue]{.lit} [1.4.6]{.optlit}
[queueName]{.ins} [option]{.sub} [arg arg]{.optdot}
[queueName]{.ins} [clear]{.sub}
[queueName]{.ins} [destroy]{.sub}
[queueName]{.ins} [get]{.sub} [count]{.optarg}
[queueName]{.ins} [peek]{.sub} [count]{.optarg}
[queueName]{.ins} [put]{.sub} [item]{.arg} [item]{.optdot}
[queueName]{.ins} [unget]{.sub} [item]{.arg}
[queueName]{.ins} [size]{.sub}
:::

# Description

The **::struct** namespace contains a commands for processing finite queues.

It exports a single command, **::struct::queue**. All functionality provided here can be reached through a subcommand of this command.

*Note:* As of version 1.4.1 of this package a critcl based C implementation is available. This implementation however requires Tcl 8.4 to run.

The **::struct::queue** command creates a new queue object with an associated global Tcl command whose name is *queueName*.  This command may be used to invoke various operations on the queue.  It has the following general form:

*queueName* **option** ?*arg arg ...*?
: *Option* and the *arg*s determine the exact behavior of the command.  The following commands are possible for queue objects:

*queueName* **clear**
: Remove all items from the queue.

*queueName* **destroy**
: Destroy the queue, including its storage space and associated command.

*queueName* **get** ?*count*?
: Return the front *count* items of the queue and remove them from the queue.  If *count* is not specified, it defaults to 1.  If *count* is 1, the result is a simple string; otherwise, it is a list.  If specified, *count* must be greater than or equal to 1. If there are not enough items in the queue to fulfull the request, this command will throw an error.

*queueName* **peek** ?*count*?
: Return the front *count* items of the queue, without removing them from the queue.  If *count* is not specified, it defaults to 1. If *count* is 1, the result is a simple string; otherwise, it is a list.  If specified, *count* must be greater than or equal to 1. If there are not enough items in the queue to fulfull the request, this command will throw an error.

*queueName* **put** *item* ?*item ...*?
: Put the *item* or items specified into the queue.  If more than one *item* is given, they will be added in the order they are listed.

*queueName* **unget** *item*
: Put the *item* into the queue, at the front, i.e. before any other items already in the queue. This makes this operation the complement to the method **get**.

*queueName* **size**
: Return the number of items in the queue.


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *struct :: queue* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Data structures
