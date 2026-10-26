---
CommandName: map::display
title: map::display
ManualSection: n
Version: 0.1
TclPart: tklib
TclDescription: Map display support
Keywords:
 - display
 - map
 - map
 - map display
Copyright:
---

# Name

map::display - Map Display Widget

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6-]{.lit}
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.6-]{.lit}
[package]{.cmd} [require]{.sub} [canvas::sqmap]{.lit}
[package]{.cmd} [require]{.sub} [canvas::zoom]{.lit}
[package]{.cmd} [require]{.sub} [crosshair]{.lit}
[package]{.cmd} [require]{.sub} [debug]{.lit}
[package]{.cmd} [require]{.sub} [debug::caller]{.lit}
[package]{.cmd} [require]{.sub} [snit]{.lit}
[package]{.cmd} [require]{.sub} [widget::scrolledwindow]{.lit}
[package]{.cmd} [require]{.sub} [map::display]{.lit} [0.1]{.optlit}
:::

# Description

This package provides a map display widget with basic behaviour (Drag, Center, Zoom +/-). The map tiles are fetched from a configurable provider like [map::provider::osm][provider-osm] or anything API compatible. The widget is extensible with attachable engines providing additional behaviours, like the display of geo/\* resources, and/or editing of geo/\* resources.

# API

# Example

# Bugs, ideas, feedback

This document, and the package it describes, will undoubtedly contain bugs and other problems. Please report such in the category *map* of the [Tklib Trackers](http://core.tcl-lang.org/tklib/reportlist). Please also report any ideas for enhancements you may have for either package and/or documentation.

# Category

Map Display and Supporting Utilities


[provider-osm]: provider-osm.md
