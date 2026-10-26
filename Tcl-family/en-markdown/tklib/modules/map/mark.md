---
CommandName: map::mark
title: map::mark
ManualSection: n
Version: 0.1
TclPart: tklib
TclDescription: Map display support
Keywords:
 - location marking
 - map
 - mark location
Copyright:
---

# Name

map::mark - Map Action Engine - Mark A Point

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6-]{.lit}
[package]{.cmd} [require]{.sub} [debug]{.lit}
[package]{.cmd} [require]{.sub} [debug::caller]{.lit}
[package]{.cmd} [require]{.sub} [snit]{.lit}
[package]{.cmd} [require]{.sub} [map::mark]{.lit} [0.1]{.optlit}
:::

# Description

This package provides a [map::display][display] attachment extending the map's behaviour. This attachment enables the user to mark locations, i.e. *geo/point*s. The marked locations are reported via a callback.

# API

# Example

# Bugs, ideas, feedback

This document, and the package it describes, will undoubtedly contain bugs and other problems. Please report such in the category *map* of the [Tklib Trackers](http://core.tcl-lang.org/tklib/reportlist). Please also report any ideas for enhancements you may have for either package and/or documentation.

# Category

Map Display and Supporting Utilities


[display]: display.md
