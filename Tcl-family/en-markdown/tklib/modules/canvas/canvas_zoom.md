---
CommandName: canvas::zoom
ManualSection: n
Version: 0.2.1
TclPart: tklib
TclDescription: Variations on a canvas
Keywords:
 - zoom
Copyright:
---

# Name

canvas::zoom - Zoom control for canvas::sqmap

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.4]{.lit} 
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.4]{.lit} 
[package]{.cmd} [require]{.sub} [snit]{.lit} 
[package]{.cmd} [require]{.sub} [uevent::onidle]{.lit} 
[package]{.cmd} [require]{.sub} [canvas::zoom]{.lit} [0.2.1]{.optlit} 
[::canvas::zoom]{.cmd} [pathName]{.arg} [options]{.optarg} 
:::

# Description

This package provides a widget to enable the user of a map display to control the zoom level.

# Api

**::canvas::zoom** *pathName* ?options?
: Creates the zoom control widget *pathName* and configures it. The methods and options supported by the new widget are described in the following sections. The result of the command is *pathName*.


## Options

**-orient**
: The value for this option is either **vertical**, or **horizontal**, specifying the orientation of the major axis of the widget. The default is **vertical**.

**-levels**
: The value for this option is a non-negative integer. It specifies the number of zoom levels to support.

**-variable**
: The value for this option is the name of a global or namespaced variable which is connected with the widget. changes to the zoom level made the widget are propagated to this variable, and in turn changes to the variable are imported into the widget.

**-command**
: This option specifies a command prefix. This callback will be invoked whenever the zoom level is changed. It is called with two additional arguments, the zoom control widget, and the new zoom level, in this order.


## Methods

The widget supports no methods beyond the standard (**configure**, **cget**, etc.).

# Bugs, ideas, feedback

This document, and the package it describes, will undoubtedly contain bugs and other problems. Please report such in the category *canvas* of the [Tklib Trackers](http://core.tcl-lang.org/tklib/reportlist). Please also report any ideas for enhancements you may have for either package and/or documentation.
