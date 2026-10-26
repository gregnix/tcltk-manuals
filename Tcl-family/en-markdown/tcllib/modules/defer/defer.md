---
CommandName: defer
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: Defered execution ala Go
Keywords:
 - cleanup
 - golang
Copyright:
 - Copyright (c) 2017, Roy Keene
---

# Name

defer - Defered execution

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [defer]{.lit} [1.1]{.optlit} 
[::defer::defer]{.cmd} [command]{.optarg} [arg1]{.optarg} [arg2]{.optarg} [argN]{.optdot} 
[::defer::with]{.cmd} [variableList]{.arg} [script]{.arg} 
[::defer::autowith]{.cmd} [script]{.arg} 
[::defer::cancel]{.cmd} [id]{.optdot} 
:::

# Description

The **defer** commands allow a developer to schedule actions to happen as part of the current variable scope terminating.  This is most useful for dealing with cleanup activities.  Since the defered actions always execute, and always execute in the reverse order from which the defer statements themselves execute, the programmer can schedule the cleanup of a resource (for example, a channel) as soon as that resource is acquired.  Then, later if the procedure or lambda ends, either due to an error, or an explicit return, the cleanup of that resource will always occur.

# Commands

**::defer::defer** ?*command*? ?*arg1*? ?*arg2*? ?*argN...*?
: Defers execution of some code until the current variable scope ends.  Each argument is concatencated together to form the script to execute at deferal time. Multiple defer statements may be used, they are executed in the order of last-in, first-out. The return value is an identifier which can be used later with **defer::cancel**

**::defer::with** *variableList* *script*
: Defers execution of a script while copying the current value of some variables, whose names specified in *variableList*, into the script. The script acts like a lambda but executes at the same level as the **defer::with** call. The return value is the same as **::defer::defer**

**::defer::autowith** *script*
: The same as **::defer::with** but uses all local variables in the variable list.

**::defer::cancel** ?*id...*?
: Cancels the execution of a defered action.  The *id* argument is the identifier returned by **::defer::defer**, **::defer::with**, or **::defer::autowith**. Any number of arguments may be supplied, and all of the IDs supplied will be cancelled.


# Examples

```
	package require defer 1
	apply {{} {
		set fd [open /dev/null]
		defer::defer close $fd
	}}
```

# References

**\[1\]**
: 


# Authors

Roy Keene

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *defer* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Utility

# Copyright

```
Copyright (c) 2017, Roy Keene
```
