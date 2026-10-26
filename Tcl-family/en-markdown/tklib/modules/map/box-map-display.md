---
CommandName: map::box::map-display
title: map::box::map-display
ManualSection: n
Version: 0.1
TclPart: tklib
TclDescription: Map display support
Keywords:
 - addon
 - box display
 - map display
 - box display
 - map display
 - addon
 - map
 - map display
 - addon
 - box display
Copyright:
---

# Name

map::box::map-display - Map Action Engine - Layer to display box definitions

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6-]{.lit}
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.6-]{.lit}
[package]{.cmd} [require]{.sub} [canvas::edit::rectangle]{.lit}
[package]{.cmd} [require]{.sub} [debug]{.lit}
[package]{.cmd} [require]{.sub} [debug::caller]{.lit}
[package]{.cmd} [require]{.sub} [map::slippy]{.lit} [0.8]{.lit}
[package]{.cmd} [require]{.sub} [snit]{.lit}
[package]{.cmd} [require]{.sub} [map::box::map-display]{.lit} [0.1]{.optlit}
:::

# Description

This package provides a [map::display][display] attachment extending the map's behaviour. This attachment shows a set of *geo/box* definitions. It ensures that only the visible boxes use canvas resources (items).

# API

# Example

# Bugs, ideas, feedback

This document, and the package it describes, will undoubtedly contain bugs and other problems. Please report such in the category *map* of the [Tklib Trackers](http://core.tcl-lang.org/tklib/reportlist). Please also report any ideas for enhancements you may have for either package and/or documentation.

# Category

Map Display and Supporting Utilities


[display]: display.md
