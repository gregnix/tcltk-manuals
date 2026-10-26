---
CommandName: coroutine
ManualSection: n
Version: 1.4
TclPart: tcllib
TclDescription: Coroutine utilities
Keywords:
 - after
 - channel
 - coroutine
 - events
 - exit
 - gets
 - global
 - green threads
 - read
 - threads
 - update
 - vwait
Copyright:
 - Copyright (c) 2010-2015 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

coroutine - Coroutine based event and IO handling

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [coroutine]{.lit} [1.4]{.lit} 
[coroutine::util]{.cmd} [after]{.sub} [delay]{.arg} 
[coroutine::util]{.cmd} [await]{.sub} [varname...]{.arg} 
[coroutine::util]{.cmd} [create]{.sub} [arg...]{.arg} 
[coroutine::util]{.cmd} [exit]{.sub} [status]{.optarg} 
[coroutine::util]{.cmd} [gets]{.sub} [chan]{.arg} [varname]{.optarg} 
[coroutine::util]{.cmd} [gets_safety]{.sub} [chan]{.arg} [limit]{.arg} [varname]{.arg} 
[coroutine::util]{.cmd} [global]{.sub} [varname...]{.arg} 
[coroutine::util]{.cmd} [puts]{.sub} [-nonewline]{.optlit} [channel]{.arg} [string]{.arg} 
[coroutine::util]{.cmd} [read]{.sub} [-nonewline]{.lit} [chan]{.arg} [n]{.optarg} 
[coroutine::util]{.cmd} [socket]{.sub} [options]{.optdot} [host]{.arg} [port]{.arg} 
[coroutine::util]{.cmd} [update]{.sub} [idletasks]{.optlit} 
[coroutine::util]{.cmd} [vwait]{.sub} [varname]{.arg} 
:::

# Description

The **coroutine** package provides coroutine-aware implementations of various event- and channel related commands. It can be in multiple modes:

**\[1\]**
: Call the commands through their ensemble, in code which is explicitly written for use within coroutines.

**\[2\]**
: Import the commands into a namespace, either directly, or through **namespace path**. This allows the use from within code which is not coroutine-aware per se and restricted to specific namespaces. A more agressive form of making code coroutine-oblivious than point 2 above is available through the package **coroutine::auto**, which intercepts the relevant builtin commands and changes their implementation dependending on the context they are run in, i.e. inside or outside of a coroutine.


# Api

All the commands listed below are synchronous with respect to the coroutine invoking them, i.e. this coroutine blocks until the result is available. The overall eventloop is not blocked however.

**coroutine::util after** *delay*
: This command delays the coroutine invoking it by *delay* milliseconds.

**coroutine::util await** *varname*...
: This command is an extension form of the **coroutine::util vwait** command (see below) which waits on a write to one of many named namespace variables.

**coroutine::util create** *arg*...
: This command creates a new coroutine with an automatically assigned name and causes it to run the code specified by the arguments.

**coroutine::util exit** ?*status*?
: This command exits the current coroutine, causing it to return *status*. If no status was specified the default *0* is returned.

**coroutine::util gets** *chan* ?*varname*?
: This command reads a line from the channel *chan* and returns it either as its result, or, if a *varname* was specified, writes it to the named variable and returns the number of characters read.

**coroutine::util gets_safety** *chan* *limit* *varname*
: This command reads a line from the channel *chan* up to size *limit* and stores the result in *varname*. Of *limit* is reached before the set first newline, an error is thrown. The command returns the number of characters read.

**coroutine::util global** *varname*...
: This command imports the named global variables of the coroutine into the current scope. From the technical point of view these variables reside in level **#1** of the Tcl stack. I.e. these are not the regular global variable in to the global namespace, and each coroutine can have their own set, independent of all others.

**coroutine::util puts** ?**-nonewline**? *channel* *string*
: This commands writes the string to the specified *channel*. Contrary to the builtin **puts** this command waits until the *channel* is writable before actually writing to it.

**coroutine::util read** **-nonewline** *chan* ?*n*?
: This command reads *n* characters from the channel *chan* and returns them as its result. If *n* is not specified the command will read the channel until EOF is reached.

**coroutine::util socket** ?*options...*? *host* *port*
: This command connects to the specified host and port and returns when that is done. Contrary to the builtin command it performs a non-blocking connect in the background. As such, while its blocks the calling coroutine, the overall application is not blocked.

**coroutine::util update** ?**idletasks**?
: This command causes the coroutine invoking it to run pending events or idle handlers before proceeding.

**coroutine::util vwait** *varname*
: This command causes the coroutine calling it to wait for a write to the named namespace variable *varname*.


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *coroutine* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Coroutine

# Copyright

```
Copyright (c) 2010-2015 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
