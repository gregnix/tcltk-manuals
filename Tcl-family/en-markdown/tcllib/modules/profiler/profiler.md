---
CommandName: profiler
title: profiler
ManualSection: n
Version: 0.7
TclPart: tcllib
TclDescription: Tcl Profiler
Keywords:
 - performance
 - profile
 - speed
Copyright:
---

# Name

profiler - Tcl source code profiler

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [profiler]{.lit} [0.7]{.optlit}
[::profiler::init]{.cmd}
[::profiler::dump]{.cmd} [pattern]{.arg}
[::profiler::print]{.cmd} [pattern]{.optarg}
[::profiler::reset]{.cmd} [pattern]{.optarg}
[::profiler::suspend]{.cmd} [pattern]{.optarg}
[::profiler::resume]{.cmd} [pattern]{.optarg}
[::profiler::new-disabled]{.cmd}
[::profiler::new-enabled]{.cmd}
[::profiler::sortFunctions]{.cmd} [key]{.arg}
:::

# Description

The **profiler** package provides a simple Tcl source code profiler.  It is a function-level profiler; that is, it collects only function-level information, not the more detailed line-level information.  It operates by redefining the Tcl **proc** command. Profiling is initiated via the **::profiler::init** command.

# Commands

**::profiler::init**
: Initiate profiling.  All procedures created after this command is called will be profiled.  To profile an entire application, this command must be called before any other commands.

**::profiler::dump** *pattern*
: Dump profiling information for the all functions matching *pattern*.  If no pattern is specified, information for all functions will be returned.  The result is a list of key/value pairs that maps function names to information about that function.  The information about each function is in turn a list of key/value pairs. The keys used and their values are:

    **totalCalls**
    : The total number of times *functionName* was called.

    **callerDist**
    : A list of key/value pairs mapping each calling function that called *functionName* to the number of times it called *functionName*.

    **compileTime**
    : The runtime, in clock clicks, of *functionName* the first time that it was called.

    **totalRuntime**
    : The sum of the runtimes of all calls of *functionName*.

    **averageRuntime**
    : Average runtime of *functionName*.

    **descendantTime**
    : Sum of the time spent in descendants of *functionName*.

    **averageDescendantTime**
    : Average time spent in descendants of *functionName*.


**::profiler::print** ?*pattern*?
: Print profiling information for all functions matching *pattern*. If no pattern is specified, information about all functions will be displayed.  The return result is a human readable display of the profiling information.

**::profiler::reset** ?*pattern*?
: Reset profiling information for all functions matching *pattern*. If no pattern is specified, information will be reset for all functions.

**::profiler::suspend** ?*pattern*?
: Suspend profiling for all functions matching *pattern*.  If no pattern is specified, profiling will be suspended for all functions. It stops gathering profiling information after this command is issued. However, it does not erase any profiling information that has been gathered previously.  Use resume command to re-enable profiling.

**::profiler::resume** ?*pattern*?
: Resume profiling for all functions matching *pattern*.  If no pattern is specified, profiling will be resumed for all functions. This command should be invoked after suspending the profiler in the code.

**::profiler::new-disabled**
: Change the initial profiling state for new procedures. Invoking this command disables profiling for all procedures created after this command until **new-enabled** is invoked. Activate profiling of specific procedures via **resume**.

**::profiler::new-enabled**
: Change the initial profiling state for new procedures. Invoking this command enables profiling for all procedures created after this command until **new-disabled** is invoked. Prevent profiling of specific procedures via **suspend**.

**::profiler::sortFunctions** *key*
: Return a list of functions sorted by a particular profiling statistic. Supported values for *key* are: **calls**, **exclusiveTime**, **compileTime**, **nonCompileTime**, **totalRuntime**, **avgExclusiveTime**, and **avgRuntime**.  The return result is a list of lists, where each sublist consists of a function name and the value of *key* for that function.


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *profiler* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Programming tools
