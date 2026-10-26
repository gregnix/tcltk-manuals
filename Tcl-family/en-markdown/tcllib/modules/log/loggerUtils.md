---
CommandName: logger::utils
ManualSection: n
Version: 1.3.2
TclPart: tcllib
TclDescription: Object Oriented logging facility
Keywords:
 - appender
 - logger
Copyright:
 - Copyright (c) 2005 Aamer Akhter <aakhter@cisco.com>
---

# Name

logger::utils - Utilities for logger

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [logger::utils]{.lit} [1.3.2]{.optlit} 
[::logger::utils::createFormatCmd]{.cmd} [formatString]{.arg} 
[::logger::utils::createLogProc]{.cmd} [-procName]{.sub} [procName]{.arg} [options]{.optdot} 
[::logger::utils::applyAppender]{.cmd} [-appender]{.sub} [appenderType]{.arg} [options]{.optdot} 
[::logger::utils::autoApplyAppender]{.cmd} [command]{.arg} [command-string]{.arg} [log]{.arg} [op]{.arg} [args...]{.arg} 
:::

# Description

This package adds template based *appenders*.

**::logger::utils::createFormatCmd** *formatString*
: This command translates *formatString* into an expandable command string. The following strings are the known substitutions (from log4perl) allowed to occur in the *formatString*:


**%c**
: Category of the logging event

**%C**
: Fully qualified name of logging event

**%d**
: Current date in yyyy/MM/dd hh:mm:ss

**%H**
: Hostname

**%m**
: Message to be logged

**%M**
: Method where logging event was issued

**%p**
: Priority of logging event

**%P**
: Pid of current process


**::logger::utils::createLogProc** **-procName** *procName* ?*options*...?
: This command ...


**-procName** procName
: The name of the procedure to create.

**-conversionPattern** pattern
: See **::logger::utils::createFormatCmd** for the substitutions allowed in the *pattern*.

**-category** category
: The category (service).

**-priority** priority
: The priority (level).

**-outputChannel** channel
: channel to output on (default stdout)


**::logger::utils::applyAppender** **-appender** *appenderType* ?*options*...?
: This command will create an appender for the specified logger services. If no service is specified then the appender will be added as the default appender for the specified levels. If no levels are specified, then all levels are assumed.


**-service** loggerservices
: ...see next...

**-serviceCmd** loggerserviceCmds
: Name of the logger instance to modify. **-serviceCmd** takes as input the return of **logger::init**.

**-appender** appenderType
: Type of the appender to use. One of **console**, **colorConsole**.

**-appenderArgs** appenderArgs
: Additional arguments to apply to the appender. The argument of the option is a list of options and their arguments. For example


```
logger::utils::applyAppender -serviceCmd $log -appender console -appenderArgs {-conversionPattern {\[%M\] \[%p\] - %m}}
```

: The usual Tcl quoting rules apply.


**-levels** levelList
: The list of levels to apply this appender to. If not specified all levels are assumed.


Example of usage:

```
   % set log [logger::init testLog]
   ::logger::tree::testLog
   % logger::utils::applyAppender -appender console -serviceCmd $log
   % ${log}::error "this is an error"
   [2005/08/22 10:14:13] [testLog] [global] [error] this is an error
```

**::logger::utils::autoApplyAppender** *command* *command-string* *log* *op* *args*...
: This command is designed to be added via **trace leave** to calls of **logger::init**. It will look at preconfigured state (via **::logger::utils::applyAppender**) to autocreate appenders for newly created logger instances. It will return its argument *log*. Example of usage:


```
  logger::utils::applyAppender -appender console
  set log [logger::init applyAppender-3]
  ${log}::error "this is an error"
```

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
