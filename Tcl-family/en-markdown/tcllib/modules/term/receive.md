---
CommandName: term::receive
ManualSection: n
Version: 0.2
TclPart: tcllib
TclDescription: Terminal control
Keywords:
 - character input
 - control
 - get character
 - listener
 - receiver
 - terminal
Copyright:
 - Copyright (c) 2006 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

term::receive - General input from terminals

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [term::receive]{.lit} [0.2]{.optlit} 
[::term::receive::getch]{.cmd} [chan]{.optarg} 
[::term::receive::listen]{.cmd} [cmd]{.arg} [chan]{.optarg} 
[cmd]{.ins} [process]{.sub} [string]{.arg} 
[cmd]{.ins} [eof]{.sub} 
[::term::receive::unlisten]{.cmd} [chan]{.optarg} 
:::

# Description

This package provides the most primitive commands for receiving characters to a terminal. They are in essence convenient wrappers around the builtin commands **read** and **fileevent**.

**::term::receive::getch** ?*chan*?
: This command reads a single character from the channel with handle *chan* and returns it as the result of the command. If not specified *chan* defaults to **stdin**. It is the responsibility of the caller to make sure that the channel can provide single characters. On unix this can be done, for example, by using the command of package **term::ansi::ctrl::unix**.

**::term::receive::listen** *cmd* ?*chan*?
: This command sets up a filevent listener for the channel with handle *chan* and invokes the command prefix *cmd* whenever characters have been received, or EOF was reached. If not specified *chan* defaults to **stdin**. The signature of the command prefix is


*cmd* **process** *string*
: This method is invoked when characters were received, and *string* holds them for processing.

*cmd* **eof**
: This method is invoked when EOF was reached on the channel we listen on.  It will be the last call to be received by the callback.


**::term::receive::unlisten** ?*chan*?
: This command disables the filevent listener for the channel with handle *chan*. If not specified *chan* defaults to **stdin**.


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
