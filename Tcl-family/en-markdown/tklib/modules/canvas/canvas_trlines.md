---
CommandName: canvas::track::lines
title: canvas::track::lines
ManualSection: n
Version: 0.1
TclPart: tklib
TclDescription: Variations on a canvas
Keywords:
 - canvas
 - crosshair
 - rubberband
 - tracking
Copyright:
---

# Name

canvas::track::lines - Manage a group of rubber band lines

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit}
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.5]{.lit}
[package]{.cmd} [require]{.sub} [canvas::tag]{.lit} [0.1]{.optlit}
[::canvas::track]{.cmd} [lines]{.lit} [objectName]{.arg} [canvas]{.arg}
[objectName]{.cmd} [destroy]{.lit}
[objectName]{.cmd} [start]{.lit} [current]{.arg} [p...]{.arg}
[objectName]{.cmd} [move]{.lit} [current]{.arg}
[objectName]{.cmd} [done]{.lit}
:::

# Description

This package provides a utility class managing the drawing of set of semi-crosshair (rubberband) lines.

# Class API

**::canvas::track** **lines** *objectName* *canvas*
: This, the class command, creates and configures a new instance of the tracker, named *objectName*. The instance will be connected to the specified *canvas* widget.

    The result of the command is the fully qualified name of the instance command.


# Instance API

Instances of this class provide the following API:

**objectName** **destroy**
: This method destroys the instance and releases all its internal resources.

    This operation does destroy the items representing the tracked lines. It does not destroy the attached canvas.

    The result of the method is an empty string.

**objectName** **start** *current* *p*...
: This method starts the tracking of a set of lines, one line per point *p*, which specifies the destination end-point of each line. All lines will have *current* as a common end-point.

    Note that a previously tracked set of lines is removed.

    The result of the method is an empty string.

    Each point is specified through a 2-element list containing its x- and y-coordinates, in this order.

**objectName** **move** *current*
: This method updates the shared end-point of all rubberbands and redraws them.

    The result of the method is an empty string.

    The point is specified through a 2-element list containing its x- and y-coordinates, in this order.

**objectName** **done**
: This method ends the tracking of the current set of lines and removes them from the canvas.


# Bugs, ideas, feedback

This document, and the package it describes, will undoubtedly contain bugs and other problems. Please report such in the category *canvas* of the [Tklib Trackers](http://core.tcl-lang.org/tklib/reportlist). Please also report any ideas for enhancements you may have for either package and/or documentation.
