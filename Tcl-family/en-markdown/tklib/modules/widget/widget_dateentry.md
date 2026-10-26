---
CommandName: widget_dateentry
ManualSection: n
Version: 0.99
TclPart: tklib
TclDescription: Various megawidgets
Keywords:
 - date
 - dateentry
 - megawidget
 - snit
 - widget
Copyright:
---

# Name

widget_dateentry - Date Entry Megawidget

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.4]{.lit} 
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.4]{.lit} 
[package]{.cmd} [require]{.sub} [widget]{.lit} [3.0]{.optlit} 
[package]{.cmd} [require]{.sub} [widget::dateentry]{.lit} [0.99]{.optlit} 
[widget::dateentry]{.cmd} [pathname]{.arg} [options]{.optarg} 
[pathname]{.ins} [get]{.sub} 
[pathname]{.ins} [set]{.sub} [date]{.arg} 
:::

# Description

This package provides a dateentry megawidget (snidget). It is based on an ttk::entry. All widget commands of the ttk::entry are available for the dateentry.

**widget::dateentry** *pathname* ?options?
: 


# Widget options

**-command**
: A command prefix to evaluate when a date was selected. The command prefix is executed in the global namespace and given two arguments, the raw date in seconds, and the formatted date, as per option **-dateformat**.

**-dateformat**
: The format of the date that is entered or returned. Default: %m/%d/%Y.

**-firstday**
: See the **widget::calendar** man page.

**-font**
: Select the font used in the widget. It defaults to Helvetica 9.

**-highlightcolor**
: See the **widget::calendar** man page. See the calendar man page.

**-language**
: See the **widget::calendar** man page.

**-shadecolor**
: See the **widget::calendar** man page.

**-showpast**
: See the **widget::calendar** man page.

**-textvariable**
: Specifies the name of a variable whose value is linked to the entry widget's contents. Whenever the variable changes value, the widget's contents are updated, and vice versa.


# Widget command

*pathname* **get**
: Returns the selected date.

*pathname* **set** *date*
: Programmatically sets a new date. Expects that the date is in the same format as configured by option **-dateformat**. The same effect can also be achieved by setting a linked **-textvariable**.


# Default bindings

On creation of the dateentry widget the following bindings are installed. For navigation within the calendar, see its manpage.

**•**
: Button-1 - Accept and select the date and close the calendar window.

**•**
: Return, space - Accept the selected date and close the calendar window

**•**
: Escape - Close calendar window

**•**
: Control-space - Show calendar window


# Example

```
    package require widget::dateentry; # or widget::all
    set t [widget::dateentry .de]
    pack $t -fill x -expand 1
```

# Bugs, ideas, feedback

This document, and the package it describes, will undoubtedly contain bugs and other problems. Please report such in the category *widget::dateentry* of the [Tklib Trackers](http://core.tcl-lang.org/tklib/reportlist). Please also report any ideas for enhancements you may have for either package and/or documentation.

# Category

Widget
