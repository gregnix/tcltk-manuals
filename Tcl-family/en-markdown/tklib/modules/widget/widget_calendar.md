---
CommandName: widget_calendar
ManualSection: n
Version: 1.0.2
TclPart: tklib
TclDescription: Various megawidgets
Keywords:
 - calendar
 - date
 - megawidget
 - snit
 - widget
Copyright:
---

# Name

widget_calendar - Calendar Megawidget

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.4]{.lit} 
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.4]{.lit} 
[package]{.cmd} [require]{.sub} [widget]{.lit} [3.0]{.optlit} 
[package]{.cmd} [require]{.sub} [widget::calendar]{.lit} [1.0.2]{.optlit} 
[widget::calendar]{.cmd} [pathname]{.arg} [options]{.optarg} 
:::

# Description

This package provides a calendar megawidget (snidget).

**widget::calendar** *pathname* ?options?
: 


# Widget options

**-command**
: A script to evaluate when a date was selected.

**-dateformat**
: The format of the date that is returned. Default: %m/%d/%Y.

**-firstday**
: Set first day the week, Either sunday or monday. It defaults to monday.

**-font**
: Select the font used in the widget. It defaults to Helvetica 9.

**-highlightcolor**
: Selects the background color for the day that has been selected. Default: #FFCC00

**-language**
: Specify language of the calendar contents. The language is specified by abbreviations of the languge, for example: en - english, de - german ... It defaults to en. Supported languages: de en es fr gr he it ja sv pl pt zh fi tr nl ru crk crx-nak crx-lhe

**-shadecolor**
: Selects the color of the parts that have a shaded background. Default: #888888

**-showpast**
: Specify if the past shall be shown. It is a boolean value and defaults to 1.

**-textvariable**
: Specifies the name of a variable whose value is linked to the entry widget's contents. Whenever the variable changes value, the widget's contents are updated, and vice versa.


# Widget command

*pathname* **get** ?*what*?

Returns a part of the selected date or 'all'. The argument *what* selects the part. Valid values for *what* are: day, month, year and all. \\'all' is the default and returns the complete date in the format given with -dateformat.

# Default bindings

On creation of the calendar widget the following bindings are installed. When pressing a key the command is invoked and the textvariable is updated. updated.

**•**
: Home - Move to the current date

**•**
: Up - Move to week before current date

**•**
: Down - Move to week after current date

**•**
: Left - Move to day before current date

**•**
: Right - Move to day after current date

**•**
: Control-Left - Move to month before current date

**•**
: Control-Right - Move to month after current date

**•**
: Control-Up - Move to year before current date

**•**
: Control-Down - Move to year after current date


# Example

```
    package require widget::calendar ; # or widget::all
    set t [widget::calendar .t]
    pack $t -fill x -expand 1
```

# Bugs, ideas, feedback

This document, and the package it describes, will undoubtedly contain bugs and other problems. Please report such in the category *widget::calendar* of the [Tklib Trackers](http://core.tcl-lang.org/tklib/reportlist). Please also report any ideas for enhancements you may have for either package and/or documentation.

# Category

Widget
