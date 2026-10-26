---
CommandName: term::receive::bind
ManualSection: n
Version: 0.2
TclPart: tcllib
TclDescription: Terminal control
Keywords:
 - character input
 - control
 - dispatcher
 - listener
 - receiver
 - terminal
Copyright:
 - Copyright (c) 2006 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

term::receive::bind - Keyboard dispatch from terminals

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [term::receive::bind]{.lit} [0.2]{.optlit} 
[term::receive::bind]{.cmd} [object]{.arg} [map]{.optarg} 
[object]{.ins} [map]{.sub} [str]{.arg} [cmd]{.arg} 
[object]{.ins} [default]{.sub} [cmd]{.arg} 
[object]{.ins} [listen]{.sub} [chan]{.optarg} 
[object]{.ins} [unlisten]{.sub} [chan]{.optarg} 
[object]{.ins} [reset]{.sub} 
[object]{.ins} [next]{.sub} [char]{.arg} 
[object]{.ins} [process]{.sub} [str]{.arg} 
[object]{.ins} [eof]{.sub} 
:::

# Description

This package provides a class for the creation of simple dispatchers from character sequences to actions. Internally each dispatcher is in essence a deterministic finite automaton with tree structure.

# Class api

The package exports a single command, the class command, enabling the creation of dispatcher instances. Its API is:

**term::receive::bind** *object* ?*map*?
: This command creates a new dispatcher object with the name *object*, initializes it, and returns the fully qualified name of the object command as its result. The argument is a dictionary mapping from strings, i.e. character sequences to the command prefices to invoke when the sequence is found in the input stream.


# Object api

The objects created by the class command provide the methods listed below:

*object* **map** *str* *cmd*
: This method adds an additional mapping from the string *str* to the action *cmd*. The mapping will take effect immediately should the processor be in a prefix of *str*, or at the next reset operation. The action is a command prefix and will be invoked with one argument appended to it, the character sequence causing the invokation. It is executed in the global namespace.

*object* **default** *cmd*
: This method defines a default action *cmd* which will be invoked whenever an unknown character sequence is encountered. The command prefix is handled in the same as the regular action defined via method **map**.

*object* **listen** ?*chan*?
: This methods sets up a filevent listener for the channel with handle *chan* and invokes the dispatcher object whenever characters have been received, or EOF was reached. If not specified *chan* defaults to **stdin**.

*object* **unlisten** ?*chan*?
: This methods removes the filevent listener for the channel with handle *chan*. If not specified *chan* defaults to **stdin**.

*object* **reset**
: This method resets the character processor to the beginning of the tree.

*object* **next** *char*
: This method causes the character processor to process the character *c*. This may simply advance the internal state, or invoke an associated action for a recognized sequence.

*object* **process** *str*
: This method causes the character processor to process the character sequence *str*, advancing the internal state and invoking action as necessary. This is a callback for **listen**.

*object* **eof**
: This method causes the character processor to handle EOF on the input. This is currently no-op. This is a callback for **listen**.


# Notes

The simplicity of the DFA means that it is not possible to recognize a character sequence with has a another recognized character sequence as its prefix.

In other words, the set of recognized strings has to form a *prefix code*.

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *term* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Terminal control

# Copyright

```
Copyright (c) 2006 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
