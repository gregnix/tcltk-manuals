---
CommandName: namespacex
ManualSection: n
Version: 0.4
TclPart: tcllib
TclDescription: Namespace utility commands
Keywords:
 - extended namespace
 - info
 - namespace unknown
 - namespace utilities
 - state (de)serialization
 - unknown hooking
 - utilities
Copyright:
 - Copyright (c) 200? Neil Madden (http://wiki.tcl.tk/12790)
 - Copyright (c) 200? Various (http://wiki.tcl.tk/1489)
 - Copyright (c) 2010 Documentation, Andreas Kupries
---

# Name

namespacex - Namespace utility commands

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [namespacex]{.lit} [0.4]{.optlit} 
[::namespacex]{.cmd} [hook]{.sub} [add]{.lit} [namespace]{.optarg} [cmdprefix]{.arg} 
[::namespacex]{.cmd} [hook]{.sub} [proc]{.lit} [namespace]{.optarg} [arguments]{.arg} [body]{.arg} 
[::namespacex]{.cmd} [hook]{.sub} [on]{.lit} [namespace]{.optarg} [guardcmdprefix]{.arg} [actioncmdprefix]{.arg} 
[::namespacex]{.cmd} [hook]{.sub} [next]{.lit} [arg...]{.arg} 
[::namespacex]{.cmd} [import]{.sub} [fromns]{.lit} [cmdname]{.arg} [newname]{.optdot} 
[::namespacex]{.cmd} [info]{.sub} [allchildren]{.lit} [namespace]{.arg} 
[::namespacex]{.cmd} [info]{.sub} [allvars]{.lit} [namespace]{.arg} 
[::namespacex]{.cmd} [normalize]{.sub} [namespace]{.arg} 
[::namespacex]{.cmd} [info]{.sub} [vars]{.lit} [namespace]{.arg} [pattern]{.optarg} 
[::namespacex]{.cmd} [state]{.sub} [get]{.lit} [namespace]{.arg} 
[::namespacex]{.cmd} [state]{.sub} [set]{.lit} [namespace]{.arg} [dict]{.arg} 
[::namespacex]{.cmd} [state]{.sub} [drop]{.lit} [namespace]{.arg} 
[::namespacex]{.cmd} [strip]{.sub} [prefix]{.arg} [namespaces]{.arg} 
:::

# Description

This package provides a number of utility commands for working with namespaces. The commands fall into four categories:

**\[1\]**
: Hook commands provide and manipulate a chain of commands which replaces the single regular **namespace unknown** handler.

**\[2\]**
: An import command provides the ability to import any command from another namespace.

**\[3\]**
: Information commands allow querying of variables and child namespaces.

**\[4\]**
: State commands provide a means to serialize variable values in a namespace.


# Commands

**::namespacex hook add** ?*namespace*? *cmdprefix*
: Adds the *cmdprefix* to the chain of unknown command handlers that are invoked when the *namespace* would otherwise invoke its unknown handler. If *namespace* is not specified, then *cmdprefix* is added to the chain of handlers for the namespace of the caller. The chain of *cmdprefix* are executed in reverse order of addition, *i.e.* the most recently added *cmdprefix* is executed first. When executed, *cmdprefix* has additional arguments appended to it as would any namespace unknown handler.

**::namespacex hook proc** ?*namespace*? *arguments* *body*
: Adds an anonymous procedure to the chain of namespace unknown handlers for the *namespace*. If *namespace* is not specified, then the handler is added to the chain of handlers for the namespace of the caller. The *arguments* and *body* are specified as for the core **proc** command.

**::namespacex hook on** ?*namespace*? *guardcmdprefix* *actioncmdprefix*
: Adds a guarded action to the chain of namespace unknown handlers for the *namespace*. If *namespace* is not specified, then the handler is added to the chain of handlers for the namespace of the caller. The *guardcmdprefix* is executed first. If it returns a value that can be interpreted as false, then the next unknown hander in the chain is executed. Otherwise, *actioncmdprefix* is executed and the return value of the handler is the value returned by *actioncmdprefix*. When executed, both *guardcmdprefix* and *actioncmdprefix* have the same additional arguments appended as for any namespace unknown handler.

**::namespacex hook next** *arg*...
: This command is available to namespace hooks to execute the next hook in the chain of handlers for the namespace.

**::namespacex import fromns** *cmdname ?newname* ...?
: Imports the command *cmdname* from the *fromns* namespace into the namespace of the caller. The *cmdname* command is imported even if the *fromns* did not originally export the command. If *newname* is specified, then the imported command will be known by that name. Otherwise, the command retains is original name as given by *cmdname*. Additional pairs of *cmdname* / *newname* arguments may also be specified.

**::namespacex info allchildren** *namespace*
: Returns a list containing the names of all child namespaces in the specified *namespace* and its children. The names are all fully qualified.

**::namespacex info allvars** *namespace*
: Returns a list containing the names of all variables in the specified *namespace* and its children. The names are all given relative to *namespace*, and *not* fully qualified.

**::namespacex normalize** *namespace*
: Returns the absolute name of *namespace*, which is resolved relative to the namespace of the caller, with all unneeded colon characters removed.

**::namespacex info vars** *namespace* ?*pattern*?
: Returns a list containing the names of all variables in the specified *namespace*. If the *pattern* argument is specified, then only variables matching *pattern* are returned. Matching is determined using the same rules as for **string match**.

**::namespacex state get** *namespace*
: Returns a dictionary holding the names and values of all variables in the specified *namespace* and its child namespaces. Note that the names are all relative to *namespace*, and *not* fully qualified.

**::namespacex state set** *namespace* *dict*
: Takes a dictionary holding the names and values for a set of variables and replaces the current state of the specified *namespace* and its child namespaces with this state. The result of the command is the empty string.

**::namespacex state drop** *namespace*
: Unsets all variables in the specified *namespace* and its child namespaces. The result of the command is the empty string.

**::namespacex strip** *prefix* *namespaces*
: Each item in *namespaces* must be the absolute normalized name of a child namespace of namespace *prefix*. Returns the corresponding list of relative names of child namespaces.


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *namespacex* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Copyright

```
Copyright (c) 200? Neil Madden (http://wiki.tcl.tk/12790)
Copyright (c) 200? Various (http://wiki.tcl.tk/1489)
Copyright (c) 2010 Documentation, Andreas Kupries
```
