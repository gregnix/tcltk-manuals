---
CommandName: ipentry
title: ipentry
ManualSection: n
Version: 0.3.2
TclPart: tklib
TclDescription: An IP address entry widget
Keywords:
 - entry
 - ip address
 - network
Copyright:
---

# Name

ipentry - An IP address entry widget

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.4]{.lit}
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.4]{.lit}
[package]{.cmd} [require]{.sub} [ipentry]{.lit} [0.3.2]{.optlit}
[::ipentry::ipentry]{.cmd} [pathName]{.arg} [option value...]{.optarg}
[::ipentry::ipentry6]{.cmd} [pathName]{.arg} [option value...]{.optarg}
[pathName]{.ins} [complete]{.sub}
[pathName]{.ins} [get]{.sub}
[pathName]{.ins} [insert]{.sub} [iplist]{.arg}
[pathName]{.ins} [icursor]{.sub} [index]{.arg}
[pathName]{.ins} [configure]{.sub} [option]{.arg} [value...]{.arg}
[pathName]{.ins} [cget]{.sub} [option]{.arg}
:::

# Description

This package provides a widget for the entering of a IP address.

**::ipentry::ipentry** *pathName* ?*option* *value*...?
: Creates a new IPv4 ipentry widget and configures it with the given options and their values.

**::ipentry::ipentry6** *pathName* ?*option* *value*...?
: Creates a new ipentry widget for the entry of an IPv6 address. All options are the same as the IPv4 widget.


Each widget created with the command above supports the following methods:

*pathName* **complete**
: Returns a boolean value. True indicates that the entry contains a complete IP address, meaning all fields have a value. In some cases IPv6 address are valid when fields are missing. You will need to do your own validation to detect this.

*pathName* **get**
: Returns the contents of the entry as a list consisting of 4 or 8 elements.

*pathName* **insert** *iplist*
: IPv4 Takes a list of 4 elements and inserts one into each quad of the entry, in order. All values in the list must be empty or integers. Values outside the range 0 to 255 are modified to be within the range. IPv6 Takes a list of 8 elements and inserts one into each quad of the entry, in order. All values in the list must be empty or 1 to 4 hex digits.

*pathName* **icursor** *index*
: Sets the position of the widgets insertion cursor. Only integer values between 0 and 15 are valid for ipentry and 0 to 31 for ipentry6. Setting the icursor will only have an effect if the widget already has the input focus.

*pathName* **configure** *option* *value*...
: Modifies the configuration of the widget. For options and their meaning see the widget options section.

*pathName* **cget** *option*
: Returns information about the current configuration of the widget, for the specified option. For options and their meaning see the widget options section.


# Widget options

**-textvariable** (**textvariable**/**Variable**)
: The name of a variable which holds the value of the IP address. The value must be a string of the form NNN.NNN.NNN.NNN for IPv4 or HHHH:HHHH:HHHH:HHHH:HHHH:HHHH:HHHH:HHHH for IPv6 where H is a hex digit. The variable will be modified to represent a valid IP address if it is not already.

**-state** (**state**/**State**)
: Specifies one of three states for the entry: **normal**, **disabled**, or **readonly**.

**-font** (**font**/**Font**)
: see below ...

**-bd** (**borderWidth**/**BorderWidth**)
: see below ...

**-fg** (**foreground**/**Foreground**)
: see below ...

**-bg** (**background**/**Background**)
: see below ...

**-relief** (**relief**/**Relief**)
: see below ...

**-highlightthickness** (**highlightThickness**/**HighlightThickness**)
: see below ...

**-highlightcolor** (**highlightColor**/**HighlightColor**)
: see below ...

**-highlightbackground** (**highlightBackground**/**HighlightBackground**)
: see below ...

**-selectbackground** (**selectBackground**/**Background**)
: see below ...

**-selectforeground** (**selectForeground**/**Foreground**)
: see below ...

**-selectborderwidth** (**selectBorderWidth**/**BorderWidth**)
: see below ...

**-disabledbackground** (**disabledBackground**/**DisabledBackground**)
: see below ...

**-disabledforeground** (**disabledForeground**/**DisabledForeground**)
: see below ...

**-readonlybackground** (**readonlyBackground**/**ReadonlyBackground**)
: see below ...

**-insertbackground** (**insertBackground**/**Background**)
: Standard widget options. See **options** for a description of their meanings and values.


# Bugs, ideas, feedback

This document, and the package it describes, will undoubtedly contain bugs and other problems. Please report such in the category *ipentry* of the [Tklib Trackers](http://core.tcl-lang.org/tklib/reportlist). Please also report any ideas for enhancements you may have for either package and/or documentation.

# Category

Widget
