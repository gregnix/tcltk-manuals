---
CommandName: log
title: log
ManualSection: n
Version: 1.5
TclPart: tcllib
TclDescription: Logging facility
Keywords:
 - log
 - log level
 - message
 - message level
Copyright:
 - Copyright (c) 2001-2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

log - Procedures to log messages of libraries and applications.

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [log]{.lit} [1.5]{.optlit}
[::log::levels]{.cmd}
[::log::lv2longform]{.cmd} [level]{.arg}
[::log::lv2color]{.cmd} [level]{.arg}
[::log::lv2priority]{.cmd} [level]{.arg}
[::log::lv2cmd]{.cmd} [level]{.arg}
[::log::lv2channel]{.cmd} [level]{.arg}
[::log::lvCompare]{.cmd} [level1]{.arg} [level2]{.arg}
[::log::lvSuppress]{.cmd} [level]{.arg} [{suppress 1}]{.arg}
[::log::lvSuppressLE]{.cmd} [level]{.arg} [{suppress 1}]{.arg}
[::log::lvIsSuppressed]{.cmd} [level]{.arg}
[::log::lvCmd]{.cmd} [level]{.arg} [cmd]{.arg}
[::log::lvCmdForall]{.cmd} [cmd]{.arg}
[::log::lvChannel]{.cmd} [level]{.arg} [chan]{.arg}
[::log::lvChannelForall]{.cmd} [chan]{.arg}
[::log::lvColor]{.cmd} [level]{.arg} [color]{.arg}
[::log::lvColorForall]{.cmd} [color]{.arg}
[::log::log]{.cmd} [level]{.arg} [text]{.arg}
[::log::logarray]{.cmd} [level]{.arg} [arrayvar]{.arg} [pattern]{.optarg}
[::log::loghex]{.cmd} [level]{.arg} [text]{.arg} [data]{.arg}
[::log::logsubst]{.cmd} [level]{.arg} [msg]{.arg}
[::log::logMsg]{.cmd} [text]{.arg}
[::log::logError]{.cmd} [text]{.arg}
[::log::Puts]{.cmd} [level]{.arg} [text]{.arg}
:::

# Description

The **log** package provides commands that allow libraries and applications to selectively log information about their internal operation and state.

To use the package just execute

```
    package require log
    log::log notice "Some message"
```

As can be seen above, each message given to the log facility is associated with a *level* determining the importance of the message. The user can then select which levels to log, what commands to use for the logging of each level and the channel to write the message to. In the following example the logging of all message with level **debug** is deactivated.

```
    package require log
    log::lvSuppress debug
    log::log debug "Unseen message" ; # No output
```

By default all messages associated with an error-level (**emergency**, **alert**, **critical**, and **error**) are written to **stderr**. Messages with any other level are written to **stdout**. In the following example the log module is reconfigured to write **debug** messages to **stderr** too.

```
    package require log
    log::lvChannel debug stderr
    log::log debug "Written to stderr"
```

Each message level is also associated with a command to use when logging a message with that level. The behaviour above for example relies on the fact that all message levels use by default the standard command **::log::Puts** to log any message. In the following example all messages of level **notice** are given to the non-standard command **toText** for logging. This disables the channel setting for such messages, assuming that **toText** does not use it by itself.

```
    package require log
    log::lvCmd notice toText
    log::log notice "Handled by \"toText\""
```

Another database maintained by this facility is a map from message levels to colors. The information in this database has *no* influence on the behaviour of the module. It is merely provided as a convenience and in anticipation of the usage of this facility in **tk**-based application which may want to colorize message logs.

# API

The following commands are available:

**::log::levels**
: Returns the names of all known levels, in alphabetical order.

**::log::lv2longform** *level*
: Converts any unique abbreviation of a level name to the full level name.

**::log::lv2color** *level*
: Converts any level name including unique abbreviations to the corresponding color.

**::log::lv2priority** *level*
: Converts any level name including unique abbreviations to the corresponding priority.

**::log::lv2cmd** *level*
: Converts any level name including unique abbreviations to the command prefix used to write messages with that level.

**::log::lv2channel** *level*
: Converts any level name including unique abbreviations to the channel used by **::log::Puts** to write messages with that level.

**::log::lvCompare** *level1* *level2*
: Compares two levels (including unique abbreviations) with respect to their priority. This command can be used by the -command option of lsort. The result is one of -1, 0 or 1 or an error. A result of -1 signals that level1 is of less priority than level2. 0 signals that both levels have the same priority. 1 signals that level1 has higher priority than level2.

**::log::lvSuppress** *level* {*suppress* 1}
: (Un)suppresses the output of messages having the specified level. Unique abbreviations for the level are allowed here too.

**::log::lvSuppressLE** *level* {*suppress* 1}
: (Un)suppresses the output of messages having the specified level or one of lesser priority. Unique abbreviations for the level are allowed here too.

**::log::lvIsSuppressed** *level*
: Asks the package whether the specified level is currently suppressed. Unique abbreviations of level names are allowed.

**::log::lvCmd** *level* *cmd*
: Defines for the specified level with which command to write the messages having this level. Unique abbreviations of level names are allowed. The command is actually a command prefix and this facility will append 2 arguments before calling it, the level of the message and the message itself, in this order.

**::log::lvCmdForall** *cmd*
: Defines for all known levels with which command to write the messages having this level. The command is actually a command prefix and this facility will append 2 arguments before calling it, the level of the message and the message itself, in this order.

**::log::lvChannel** *level* *chan*
: Defines for the specified level into which channel **::log::Puts** (the standard command) shall write the messages having this level. Unique abbreviations of level names are allowed. The command is actually a command prefix and this facility will append 2 arguments before calling it, the level of the message and the message itself, in this order.

**::log::lvChannelForall** *chan*
: Defines for all known levels with which which channel **::log::Puts** (the standard command) shall write the messages having this level. The command is actually a command prefix and this facility will append 2 arguments before calling it, the level of the message and the message itself, in this order.

**::log::lvColor** *level* *color*
: Defines for the specified level the color to return for it in a call to **::log::lv2color**. Unique abbreviations of level names are allowed.

**::log::lvColorForall** *color*
: Defines for all known levels the color to return for it in a call to **::log::lv2color**. Unique abbreviations of level names are allowed.

**::log::log** *level* *text*
: Log a message according to the specifications for commands, channels and suppression. In other words: The command will do nothing if the specified level is suppressed. If it is not suppressed the actual logging is delegated to the specified command. If there is no command specified for the level the message won't be logged. The standard command **::log::Puts** will write the message to the channel specified for the given level. If no channel is specified for the level the message won't be logged. Unique abbreviations of level names are allowed. Errors in the actual logging command are *not* caught, but propagated to the caller, as they may indicate misconfigurations of the log facility or errors in the callers code itself.

**::log::logarray** *level* *arrayvar* ?*pattern*?
: Like **::log::log**, but logs the contents of the specified array variable *arrayvar*, possibly restricted to entries matching the *pattern*. The pattern defaults to **\*** (i.e. all entries) if none was specified.

**::log::loghex** *level* *text* *data*
: Like **::log::log**, but assumes that *data* contains binary data. It converts this into a mixed hex/ascii representation before writing them to the log.

**::log::logsubst** *level* *msg*
: Like **::log::log**, but *msg* may contain substitutions and variable references, which are evaluated in the caller scope first. The purpose of this command is to avoid overhead in the non-logging case, if the log message building is expensive. Any substitution errors raise an error in the command execution. The following example shows an xml text representation, which is only generated in debug mode:

    ```
        log::logsubst debug {XML of node $node is '[$node toXml]'}
    ```

**::log::logMsg** *text*
: Convenience wrapper around **::log::log**. Equivalent to **::log::log info text**.

**::log::logError** *text*
: Convenience wrapper around **::log::log**. Equivalent to **::log::log error text**.

**::log::Puts** *level* *text*
: The standard log command, it writes messages and their levels to user-specified channels. Assumes that the suppression checks were done by the caller. Expects full level names, abbreviations are *not allowed*.


# Levels

The package currently defines the following log levels, the level of highest importance listed first.

- emergency

- alert

- critical

- error

- warning

- notice

- info

- debug


*Note* that by default all messages with levels **warning** down to **debug** are suppressed. This is done intentionally, because (we believe that) in most situations debugging output is not wanted. Most people wish to have such output only when actually debugging an application.

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *log* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Programming tools

# Copyright

```
Copyright (c) 2001-2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
