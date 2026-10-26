---
CommandName: processman
title: processman
ManualSection: n
Version: 0.8
TclPart: tcllib
TclDescription: processman
Keywords:
 - odie
 - processman
Copyright:
 - Copyright (c) 2015 Sean Woods <yoda@etoyoc.com>
---

# Name

processman - Tool for automating the period callback of commands

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [twapi]{.lit} [3.1]{.lit}
[package]{.cmd} [require]{.sub} [cron]{.lit} [1.1]{.lit}
[package]{.cmd} [require]{.sub} [processman]{.lit} [0.8]{.optlit}
[::processman::find\_exe]{.cmd} [name]{.arg}
[::processman::kill]{.cmd} [id]{.arg}
[::processman::kill\_all]{.cmd}
[::processman::killexe]{.cmd} [name]{.arg}
[::processman::onexit]{.cmd} [id]{.arg} [cmd]{.arg}
[::processman::priority]{.cmd} [id]{.arg} [level]{.arg}
[::processman::process\_list]{.cmd}
[::processman::process\_list]{.cmd} [id]{.arg}
[::processman::spawn]{.cmd} [id]{.arg} [cmd]{.arg} [args]{.arg}
:::

# Description

The **processman** package provides a Pure-tcl set of utilities to manage child processes in a platform-generic nature.

# Commands

**::processman::find\_exe** *name*
: Locate an executable by the name of *name* in the system path. On windows, also add the .exe extention if not given.

**::processman::kill** *id*
: Kill a child process *id*.

**::processman::kill\_all**
: Kill all processes spawned by this program

**::processman::killexe** *name*
: Kill a process identified by the executable. On Unix, this triggers a killall. On windows, **twapi::get\_process\_ids** is used to map a name one or more IDs, which are then killed.

**::processman::onexit** *id* *cmd*
: Arrange to execute the script *cmd* when this programe detects that process *id* as terminated.

**::processman::priority** *id* *level*
: Mark process *id* with the priorty *level*. Valid levels: low, high, default.

    On Unix, the process is tagged using the **nice** command.

    On Windows, the process is modifed via the **twapi::set\_priority\_class**

**::processman::process\_list**
: Return a list of processes that have been triggered by this program, as well as a boolean flag to indicate if the process is still running.

**::processman::process\_list** *id*
: Return true if process *id* is still running, false otherwise.

**::processman::spawn** *id* *cmd* *args*
: Start a child process, identified by *id*. *cmd* is the name of the command to execute. *args* are arguments to pass to that command.


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *odie* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

System

# Copyright

```
Copyright (c) 2015 Sean Woods <yoda@etoyoc.com>
```
