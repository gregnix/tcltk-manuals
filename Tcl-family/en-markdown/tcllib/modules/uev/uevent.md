---
CommandName: uevent
ManualSection: n
Version: 0.3.2
TclPart: tcllib
TclDescription: User events
Links:
 - hook(n)
Keywords:
 - bind
 - event
 - generate event
 - hook
 - unbind
Copyright:
 - Copyright (c) 2007-2012 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

uevent - User events

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [uevent]{.lit} [0.3.2]{.optlit} 
[package]{.cmd} [require]{.sub} [logger]{.lit} 
[::uevent::bind]{.cmd} [tag]{.arg} [event]{.arg} [command]{.arg} 
[command]{.cmd} [tag]{.arg} [event]{.arg} [details]{.arg} 
[::uevent::unbind]{.cmd} [token]{.arg} 
[::uevent::generate]{.cmd} [tag]{.arg} [event]{.arg} [details]{.optarg} 
[::uevent::list]{.cmd} 
[::uevent::list]{.cmd} [tag]{.arg} 
[::uevent::list]{.cmd} [tag]{.arg} [event]{.arg} 
[::uevent::watch::tag::add]{.cmd} [pattern]{.arg} [command]{.arg} 
[::uevent::watch::tag::remove]{.cmd} [token]{.arg} 
[::uevent::watch::event::add]{.cmd} [tag_pattern]{.arg} [event_pattern]{.arg} [command]{.arg} 
[::uevent::watch::event::remove]{.cmd} [token]{.arg} 
:::

**{\*}command** **bound** *tag*

**{\*}command** **unbound** *tag*

**{\*}command** **bound** *tag* *event*

**{\*}command** **unbound** *tag* *event*

# Description

This package provides a general facility for the handling of user events. Allows the binding of arbitrary commands to arbitrary events on arbitrary tags, removal of bindings, and event generation.

The main difference to the event system built into the Tcl/Tk core is that the latter can generate only virtual events, and only for widgets. It is not possible to use the builtin facilities to bind to events on arbitrary (pseudo-)objects, nor is it able to generate events for such.

Here we can, by assuming that each object in question is represented by its own tag. Which is possible as we allow arbitrary tags.

More differences:

**\[1\]**
: The package uses only a two-level hierarchy, tags and events, to handle everything, whereas the Tcl/Tk system uses three levels, i.e. objects, tags, and events, with a n:m relationship between objects and tags.

**\[2\]**
: This package triggers all bound commands for a tag/event combination, and they are independent of each other. A bound command cannot force the event processing core to abort the processing of command coming after it.


# Api

The package exports eight commands, as specified below. Note that when the package is used from within Tcl 8.5+ all the higher commands are ensembles, i.e. the :: separators can be replaceed by spaces.

**::uevent::bind** *tag* *event* *command*
: Using this command registers the *command* prefix to be triggered when the *event* occurs for the *tag*. The result of the command is an opaque token representing the binding. Note that if the same combination of <*tag*,*event*,*command*> is used multiple times the same token is returned by every call. The signature of the *command* prefix is


**command** *tag* *event* *details*
: 


where *details* contains the argument(s) of the event. Its contents are event specific and have to be agreed upon between actual event generator and consumer. This package simply transfers the information and does not perform any processing beyond that.

**::uevent::unbind** *token*
: This command releases the event binding represented by the *token*. The token has to be the result of a call to **::uevent::bind**. The result of the command is the empty string.

**::uevent::generate** *tag* *event* ?*details*?
: This command generates an *event* for the *tag*, triggering all commands bound to that combination. The *details* argument is simply passed unchanged to all event handlers. It is the responsibility of the code generating and consuming the event to have an agreement about the format and contents of the information carried therein. The result of the command is the empty string. Note that all bound commands are triggered, independently of each other. The event handlers cannot assume a specific order. They are also *not* called synchronously with the invokation of this command, but simply put into the event queue for processing when the system returns to the event loop. Generating an event for an unknown tag, or for a <*tag*,*event*> combination which has no commands bound to it is allowed, such calls will be ignored.

**::uevent::list**
: In this form the command returns a list containing the names of all tags which have events with commands bound to them.

**::uevent::list** *tag*
: In this format the command returns a list containing the names of all events for the *tag* with commands bound to them. Specifying an unknown tag, i.e. a tag without event and commands, will cause the command to throw an error.

**::uevent::list** *tag* *event*
: In this format the command returns a list containing all commands bound to the *event* for the *tag*. Specifying an unknown tag or unknown event, will cause the command to throw an error.

**::uevent::watch::tag::add** *pattern* *command*
: This command sets up a sort of reverse events. Events generated, i.e. the *command* prefix invoked, when observers bind to and unbind from specific tags. Note that the command prefix is only invoked twice per tag, first when the first command is bound to any event of the tag, and second when the last command bound to the tag is removed. The signature of the *command* prefix is


**{\*}command** **bound** *tag*
: ...see next...

**{\*}command** **unbound** *tag*
: 


The result of the command is a token representing the watcher.

**::uevent::watch::tag::remove** *token*
: This command removes a watcher for (un)bind events on tags. The result of the command is the empty string.

**::uevent::watch::event::add** *tag_pattern* *event_pattern* *command*
: This command sets up a sort of reverse events. Events generated, i.e. the *command* prefix invoked, when observers bind to and unbind from specific combinations of tags and events. Note that the command prefix is only invoked twice per tag/event combination, first when the first command is bound to it, and second when the last command bound to the it is removed. The signature of the *command* prefix is


**{\*}command** **bound** *tag* *event*
: ...see next...

**{\*}command** **unbound** *tag* *event*
: 


The result of the command is a token representing the watcher.

**::uevent::watch::event::remove** *token*
: This command removes a watcher for (un)bind events on tag/event combinations. The result of the command is the empty string.


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *uevent* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Programming tools

# Copyright

```
Copyright (c) 2007-2012 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
