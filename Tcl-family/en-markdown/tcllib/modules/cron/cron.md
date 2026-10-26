---
CommandName: cron
title: cron
ManualSection: n
Version: 2.2
TclPart: tcllib
TclDescription: cron
Keywords:
 - cron
 - odie
Copyright:
 - Copyright (c) 2016-2018 Sean Woods <yoda@etoyoc.com>
---

# Name

cron - Tool for automating the period callback of commands

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [cron]{.lit} [2.2]{.optlit}
[::cron::at]{.cmd} [processname]{.optarg} [timecode]{.arg} [command]{.arg}
[::cron::cancel]{.cmd} [processname]{.arg}
[::cron::every]{.cmd} [processname]{.arg} [frequency]{.arg} [command]{.arg}
[::cron::in]{.cmd} [processname]{.optarg} [timecode]{.arg} [command]{.arg}
[::cron::object\_coroutine]{.cmd} [object]{.arg} [coroutine]{.arg} [info]{.optarg}
[::cron::sleep]{.cmd} [milliseconds]{.arg}
[::cron::task]{.cmd} [delete]{.sub} [process]{.arg}
[::cron::task]{.cmd} [exists]{.sub} [process]{.arg}
[::cron::task]{.cmd} [info]{.sub} [process]{.arg}
[::cron::task]{.cmd} [set]{.sub} [process]{.arg} [field]{.arg} [value]{.arg} [field]{.optdot} [value]{.optdot}
[::cron::wake]{.cmd} [who]{.optarg}
[::cron::clock\_step]{.cmd} [milliseconds]{.arg}
[::cron::clock\_delay]{.cmd} [milliseconds]{.arg}
[::cron::clock\_sleep]{.cmd} [seconds]{.arg} [offset]{.optarg}
[::cron::clock\_set]{.cmd} [newtime]{.arg}
:::

# Description

The **cron** package provides a Pure-tcl set of tools to allow programs to schedule tasks to occur at regular intervals. Rather than force each task to issue it's own call to the event loop, the cron system mimics the cron utility in Unix: on task periodically checks to see if something is to be done, and issues all commands for a given time step at once.

Changes in version 2.0

While cron was originally designed to handle time scales > 1 second, the latest version's internal understand time granularity down to the millisecond, making it easier to integrate with other timed events. Version 2.0 also understands how to properly integrate coroutines and objects. It also adds a facility for an external (or script driven) clock. Note that vwait style events won't work very well with an external clock.

# Commands

**::cron::at** *?processname?* *timecode* *command*
: This command registers a *command* to be called at the time specified by *timecode*. If *timecode* is expressed as an integer, the timecode is assumed to be in unixtime. All other inputs will be interpreted by **clock scan** and converted to unix time. This task can be modified by subsequent calls to this package's commands by referencing *processname*. If *processname* exists, it will be replaced. If *processname* is not given, one is generated and returned by the command.

    ```
    ::cron::at start_coffee {Tomorrow at 9:00am}  {remote::exec::coffeepot power on}
    ::cron::at shutdown_coffee {Tomorrow at 12:00pm}  {remote::exec::coffeepot power off}
    ```

**::cron::cancel** *processname*
: This command unregisters the process *processname* and cancels any pending commands. Note: processname can be a process created by either **::cron::at** or **::cron::every**.

    ```
    ::cron::cancel check_mail
    ```

**::cron::every** *processname* *frequency* *command*
: This command registers a *command* to be called at the interval of *frequency*. *frequency* is given in seconds. This task can be modified by subsequent calls to this package's commands by referencing *processname*. If *processname* exists, it will be replaced.

    ```
    ::cron::every check_mail 900  ::imap_client::check_mail
    ::cron::every backup_db  3600 {::backup_procedure ::mydb}
    ```

**::cron::in** *?processname?* *timecode* *command*
: This command registers a *command* to be called after a delay of time specified by *timecode*. *timecode* is expressed as an seconds. This task can be modified by subsequent calls to this package's commands by referencing *processname*. If *processname* exists, it will be replaced. If *processname* is not given, one is generated and returned by the command.

**::cron::object\_coroutine** *object* *coroutine* *?info?*
: This command registers a *coroutine*, associated with *object* to be called given the parameters of *info*. If now parameters are given, the coroutine is assumed to be an idle task which will self-terminate. *info* can be given in any form compadible with **::cron::task set**

**::cron::sleep** *milliseconds*
: When run within a coroutine, this command will register the coroutine for a callback at the appointed time, and immediately yield.

    If the ::cron::time variable is > 0 this command will advance the internal time, 100ms at a time.

    In all other cases this command will generate a fictious variable, generate an after call, and vwait the variable:

    ```
    set eventid [incr ::cron::eventcount]
    set var ::cron::event_#$eventid
    set $var 0
    ::after $ms "set $var 1"
    ::vwait $var
    ::unset $var
    ```

    Usage:

    ```
    ::cron::sleep 250
    ```

**::cron::task delete** *process*
: Delete the process specified the *process*

**::cron::task exists** *process*
: Returns true if *process* is registered with cron.

**::cron::task info** *process*
: Returns a dict describing *process*. See **::cron::task set** for a description of the options.

**::cron::task set** *process* *field* *value* *?field...?* *?value...?*
: If *process* does not exist, it is created. Options Include:

    **command**
    : If **coroutine** is black, a global command which implements this process. If **coroutine** is not black, the command to invoke to create or recreate the coroutine.

    **coroutine**
    : The name of the coroutine (if any) which implements this process.

    **frequency**
    : If -1, this process is terminated after the next event. If 0 this process should be called during every idle event. If positive, this process should generate events periodically. The frequency is an integer number of milliseconds between events.

    **object**
    : The object associated with this process or coroutine.

    **scheduled**
    : If non-zero, the absolute time from the epoch (in milliseconds) that this process will trigger an event. If zero, and the **frequency** is also zero, this process is called every idle loop.

    **running**
    : A boolean flag. If true it indicates the process never returned or yielded during the event loop, and will not be called again until it does so.


**::cron::wake** *?who?*
: Wake up cron, and arrange for its event loop to be run during the next Idle cycle.

    ```
    ::cron::wake {I just did something important}
    ```


Several utility commands are provided that are used internally within cron and for testing cron, but may or may not be useful in the general cases.

**::cron::clock\_step** *milliseconds*
: Return a clock time absolute to the epoch which falls on the next border between one second and the next for the value of *milliseconds*

**::cron::clock\_delay** *milliseconds*
: Return a clock time absolute to the epoch which falls on the next border between one second and the next *milliseconds* in the future.

**::cron::clock\_sleep** *seconds* *?offset?*
: Return a clock time absolute to the epoch which falls exactly *seconds* in the future. If offset is given it may be positive or negative, and will shift the final time to before or after the second would flip.

**::cron::clock\_set** *newtime*
: Sets the internal clock for cron. This command will advance the time in 100ms increment, triggering events, until the internal time catches up with *newtime*.

    *newtime* is expressed in absolute milliseconds since the beginning of the epoch.


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *odie* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

System

# Copyright

```
Copyright (c) 2016-2018 Sean Woods <yoda@etoyoc.com>
```
