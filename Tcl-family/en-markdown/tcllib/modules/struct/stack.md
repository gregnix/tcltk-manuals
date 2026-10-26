---
CommandName: struct::stack
title: struct::stack
ManualSection: n
Version: 1.5.4
TclPart: tcllib
TclDescription: Tcl Data Structures
Keywords:
 - graph
 - matrix
 - queue
 - tree
Copyright:
---

# Name

struct::stack - Create and manipulate stack objects

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [struct::stack]{.lit} [1.5.4]{.optlit}
[stackName]{.ins} [option]{.sub} [arg arg]{.optdot}
[stackName]{.ins} [clear]{.sub}
[stackName]{.ins} [destroy]{.sub}
[stackName]{.ins} [get]{.sub}
[stackName]{.ins} [getr]{.sub}
[stackName]{.ins} [peek]{.sub} [count]{.optarg}
[stackName]{.ins} [peekr]{.sub} [count]{.optarg}
[stackName]{.ins} [trim]{.sub} [newsize]{.optarg}
[stackName]{.ins} [trim\*]{.sub} [newsize]{.optarg}
[stackName]{.ins} [pop]{.sub} [count]{.optarg}
[stackName]{.ins} [push]{.sub} [item]{.arg} [item...]{.optarg}
[stackName]{.ins} [size]{.sub}
:::

# Description

The **::struct** namespace contains a commands for processing finite stacks.

It exports a single command, **::struct::stack**. All functionality provided here can be reached through a subcommand of this command.

*Note:* As of version 1.3.3 of this package a critcl based C implementation is available. This implementation however requires Tcl 8.4 to run.

The **::struct::stack** command creates a new stack object with an associated global Tcl command whose name is *stackName*.  This command may be used to invoke various operations on the stack.  It has the following general form:

*stackName* **option** ?*arg arg ...*?
: *Option* and the *arg*s determine the exact behavior of the command.  The following commands are possible for stack objects:

*stackName* **clear**
: Remove all items from the stack.

*stackName* **destroy**
: Destroy the stack, including its storage space and associated command.

*stackName* **get**
: Returns the whole contents of the stack as a list, without removing them from the stack.

*stackName* **getr**
: A variant of **get**, which returns the contents in reversed order.

*stackName* **peek** ?*count*?
: Return the top *count* items of the stack, without removing them from the stack.  If *count* is not specified, it defaults to 1.  If *count* is 1, the result is a simple string; otherwise, it is a list.  If specified, *count* must be greater than or equal to 1. If there are not enoughs items on the stack to fulfull the request, this command will throw an error.

*stackName* **peekr** ?*count*?
: A variant of **peek**, which returns the items in reversed order.

*stackName* **trim** ?*newsize*?
: Shrinks the stack to contain at most *newsize* elements and returns a list containing the elements which were removed. Nothing is done if the stack is already at the specified size, or smaller. In that case the result is the empty list.

*stackName* **trim\*** ?*newsize*?
: A variant of **trim** which performs the shrinking, but does not return the removed elements.

*stackName* **pop** ?*count*?
: Return the top *count* items of the stack, and remove them from the stack.  If *count* is not specified, it defaults to 1. If *count* is 1, the result is a simple string; otherwise, it is a list.  If specified, *count* must be greater than or equal to 1. If there are not enoughs items on the stack to fulfull the request, this command will throw an error.

*stackName* **push** *item* ?*item...*?
: Push the *item* or items specified onto the stack.  If more than one *item* is given, they will be pushed in the order they are listed.

*stackName* **size**
: Return the number of items on the stack.


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *struct :: stack* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Data structures
