---
CommandName: struct::prioqueue
title: struct::prioqueue
ManualSection: n
Version: 1.5
TclPart: tcllib
TclDescription: Tcl Data Structures
Keywords:
 - ordered list
 - prioqueue
 - priority queue
Copyright:
 - Copyright (c) 2003 Michael Schlenker <mic42@users.sourceforge.net>
---

# Name

struct::prioqueue - Create and manipulate prioqueue objects

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [struct::prioqueue]{.lit} [1.5]{.optlit}
[::struct::prioqueue]{.cmd} [-ascii|-dictionary|-integer|-real]{.optlit} [prioqueueName]{.optarg}
[prioqueueName]{.ins} [option]{.sub} [arg arg]{.optdot}
[prioqueueName]{.ins} [clear]{.sub}
[prioqueueName]{.ins} [remove]{.sub} [item]{.arg}
[prioqueueName]{.ins} [destroy]{.sub}
[prioqueueName]{.ins} [get]{.sub} [count]{.optarg}
[prioqueueName]{.ins} [peek]{.sub} [count]{.optarg}
[prioqueueName]{.ins} [peekpriority]{.sub} [count]{.optarg}
[prioqueueName]{.ins} [put]{.sub} [item]{.arg} [prio]{.arg} [item prio]{.optdot}
[prioqueueName]{.ins} [size]{.sub}
:::

# Description

This package implements a simple priority queue using nested tcl lists.

The command **::struct::prioqueue** creates a new priority queue with default priority key type *-integer*. This means that keys given to the **put** subcommand must have this type.

This also sets the priority ordering. For key types *-ascii* and *-dictionary* the data is sorted in ascending order (as with **lsort** *-increasing*), thereas for *-integer* and *-real* the data is sorted in descending order (as with **lsort** *-decreasing*).

Prioqueue names are unrestricted, but may be recognized as options if no priority type is given.

**::struct::prioqueue** ?**-ascii|-dictionary|-integer|-real**? ?*prioqueueName*?
: The **::struct::prioqueue** command creates a new prioqueue object with an associated global Tcl command whose name is *prioqueueName*. This command may be used to invoke various operations on the prioqueue.  It has the following general form:

*prioqueueName* **option** ?*arg arg ...*?
: **option** and the *arg*s determine the exact behavior of the command.  The following commands are possible for prioqueue objects:

*prioqueueName* **clear**
: Remove all items from the prioqueue.

*prioqueueName* **remove** *item*
: Remove the selected item from this priority queue.

*prioqueueName* **destroy**
: Destroy the prioqueue, including its storage space and associated command.

*prioqueueName* **get** ?*count*?
: Return the front *count* items of the prioqueue (but not their priorities) and remove them from the prioqueue. If *count* is not specified, it defaults to 1.  If *count* is 1, the result is a simple string; otherwise, it is a list.  If specified, *count* must be greater than or equal to 1.  If there are no or too few items in the prioqueue, this command will throw an error.

*prioqueueName* **peek** ?*count*?
: Return the front *count* items of the prioqueue (but not their priorities), without removing them from the prioqueue. If *count* is not specified, it defaults to 1.  If *count* is 1, the result is a simple string; otherwise, it is a list.  If specified, *count* must be greater than or equal to 1.  If there are no or too few items in the queue, this command will throw an error.

*prioqueueName* **peekpriority** ?*count*?
: Return the front *count* items priority keys, without removing them from the prioqueue. If *count* is not specified, it defaults to 1.  If *count* is 1, the result is a simple string; otherwise, it is a list.  If specified, *count* must be greater than or equal to 1.  If there are no or too few items in the queue, this command will throw an error.

*prioqueueName* **put** *item prio* ?*item prio ...*?
: Put the *item* or items specified into the prioqueue. *prio* must be a valid priority key for this type of prioqueue, otherwise an error is thrown and no item is added.  Items are inserted at their priority ranking. Items with equal priority are added in the order they were added.

*prioqueueName* **size**
: Return the number of items in the prioqueue.


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *struct :: prioqueue* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Data structures

# Copyright

```
Copyright (c) 2003 Michael Schlenker <mic42@users.sourceforge.net>
```
