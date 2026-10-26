---
CommandName: datefield
title: datefield
ManualSection: n
Version: 0.3
TclPart: tklib
TclDescription: Tk datefield widget
Links:
 - clock(n)
 - entry(n)
Keywords:
 - clock
 - date
 - dateentry
 - entry
 - widget
Copyright:
 - Copyright (c) Keith Vetter <keith@ebook.gemstar.com>
 - Copyright (c) Thomas Wunderlich <tcl.tk@blindenfreizeiten.de>
---

# Name

datefield - Tk datefield widget

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tk]{.lit}
[package]{.cmd} [require]{.sub} [datefield]{.lit} [0.3]{.optlit}
[::datefield::datefield]{.cmd} [widgetpath]{.arg} [options]{.optarg}
[-format]{.ins}
:::

# Description

The **datefield** package provides the datefield widget which is an enhanced text entry widget for the purpose of date entry. There are three valid formats for the dates which can be entered:

1. English form MM/DD/YYYY using *-format "%m/%d/%Y"* (default)

2. German form DD.MM.YYYY using *-format "%d.%m.%Y"*

3. ISO form YYYY-MM-DD using *-format "%Y-%m-%d"*


The datefield widget is, in fact, just an entry widget with specialized bindings. This means all the command and options for an entry widget apply equally here.

# Commands

**::datefield::datefield** *widgetpath* ?*options*?
: Creates and configures a date field widget.


# Options

*-format*
: One of "%m/%d/%Y" (English, default if option left), "%d.%m.%Y" (German), or "%Y-%m-%d" (ISO).


See the **entry** manual entry for details on all remaining/available options.

# Example

```
 package require datefield

 wm title . "Datefield example"
 proc DayOfWeek {args} {
     set now [clock scan $::myDate]
     set ::myDate2 [clock format $now -format %A]
 }
 trace variable myDate w DayOfWeek

 ::datefield::datefield .df -textvariable myDate -format "%m/%d/%Y"
 label .l1 -text "Enter a date:"   -anchor e
 label .l2 -text "That date is a:" -anchor e
 label .l3 -textvariable myDate2 -relief sunken -width 12

 grid .l1 .df -sticky ew
 grid .l2 .l3 -sticky ew
 focus .df
```

# Bugs, ideas, feedback

This document, and the package it describes, will undoubtedly contain bugs and other problems. Please report such in the category *datefield* of the [Tklib Trackers](http://core.tcl-lang.org/tklib/reportlist). Please also report any ideas for enhancements you may have for either package and/or documentation.

# Category

Widget

# Copyright

```
Copyright (c) Keith Vetter <keith@ebook.gemstar.com>
Copyright (c) Thomas Wunderlich <tcl.tk@blindenfreizeiten.de>
```
