---
CommandName: history
title: history
ManualSection: n
Version: 0.3
TclPart: tklib
TclDescription: Provides a history for Entry widgets
Keywords:
 - entry
 - history
Copyright:
---

# Name

history - Provides a history for Entry widgets

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.4]{.lit}
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.4]{.lit}
[package]{.cmd} [require]{.sub} [history]{.lit} [0.3]{.optlit}
[::history::init]{.cmd} [pathName]{.arg} [length]{.optarg}
[::history::remove]{.cmd} [pathName]{.arg}
[::history::add]{.cmd} [pathName]{.arg} [text]{.arg}
[::history::get]{.cmd} [pathName]{.arg}
[::history::clear]{.cmd} [pathName]{.arg}
[::history::configure]{.cmd} [pathName]{.arg} [option]{.arg} [value]{.optarg}
:::

bell

# Description

This package provides a convenient history mechanism for Entry widgets. The history may be accessed with the up and down arrow keys.

**::history::init** *pathName* ?length?
: Arranges to remember the history of the named Entry widget. An optional length determines the number of history entries to keep. This may be changed later with **::history::configure**. History entries must be added with the **::history::add** command before they can be seen.

**::history::remove** *pathName*
: Forgets all history entries for the Entry *pathName* and removes the history bindings.

**::history::add** *pathName* *text*
: This command is used to add history entries to an Entry that has previously had **::history::init** called on it. This command should be called from your Entry handler with the contents of the entry (or whatever you wish to add to the history).

**::history::get** *pathName*
: This command returns a list containing the history entries for the Entry *pathName*

**::history::clear** *pathName*
: This command clears the history list for the named Entry.

**::history::configure** *pathName* *option* ?value?
: This command queries or sets configuration options. Currently the options recognized are *length* and *alert*. Setting the length determines the number of history entries to keep for the named Entry. Alert specifies the command to run when the user reaches the end of the history, it defaults to

bell
: . Although configure requires a *pathName* argument, the setting for alert is global and the path is ignored.


```
entry .e
bind .e <Return> [list ProcessEntry %W]
::history::init .e
pack .e

proc ProcessEntry {w} {
    set text [$w get]
    if {$text == ""} { return }
    ::history::add $w $text
    puts $text
    $w delete 0 end
}
```

# Bugs, ideas, feedback

This document, and the package it describes, will undoubtedly contain bugs and other problems. Please report such in the category *entry::history* of the [Tklib Trackers](http://core.tcl-lang.org/tklib/reportlist). Please also report any ideas for enhancements you may have for either package and/or documentation.
