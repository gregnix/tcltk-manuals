---
CommandName: logger::appender
title: logger::appender
ManualSection: n
Version: 1.4
TclPart: tcllib
TclDescription: Object Oriented logging facility
Keywords:
 - appender
 - logger
Copyright:
 - Copyright (c) 2005 Aamer Akhter <aakhter@cisco.com>
---

# Name

logger::appender - Collection of predefined appenders for logger

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [logger::appender]{.lit} [1.4]{.optlit}
[::logger::appender::console]{.cmd} [-level]{.lit} [level]{.arg} [-service]{.lit} [service]{.arg} [options...]{.optarg}
[::logger::appender::colorConsole]{.cmd} [-level]{.lit} [level]{.arg} [-service]{.lit} [service]{.arg} [options...]{.optarg}
:::

# Description

This package provides a predefined set of logger templates.

**::logger::appender::console** **-level** *level* **-service** *service* ?*options*...?
: see below ...

    **-level** level
    : Name of the level to fill in as "priority" in the log procedure.

    **-service** service
    : Name of the service to fill in as "category" in the log procedure.

    **-appenderArgs** appenderArgs
    : Any additional arguments for the log procedure in list form

    **-conversionPattern** conversionPattern
    : The log pattern to use (see **logger::utils::createLogProc** for the allowed substitutions).

    **-procName** procName
    : Explicitly set the name of the created procedure.

    **-procNameVar** procNameVar
    : Name of the variable to set in the calling context. This variable will contain the name of the procedure.


**::logger::appender::colorConsole** **-level** *level* **-service** *service* ?*options*...?
: See **::logger::appender::colorConsole** for a description of the applicable options.


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *logger* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Programming tools

# Copyright

```
Copyright (c) 2005 Aamer Akhter <aakhter@cisco.com>
```
