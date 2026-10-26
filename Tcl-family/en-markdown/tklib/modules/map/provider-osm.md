---
CommandName: map::provider::osm
title: map::provider::osm
ManualSection: n
Version: 0.1
TclPart: tklib
TclDescription: Map display support
Keywords:
 - map
 - mapnik
 - openstreetmap
 - provider
 - tiles
 - tile provider
Copyright:
---

# Name

map::provider::osm - Tile provider using OpenStreetMap Mapnik as origin

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6-]{.lit}
[package]{.cmd} [require]{.sub} [debug]{.lit}
[package]{.cmd} [require]{.sub} [debug::caller]{.lit}
[package]{.cmd} [require]{.sub} [map::slippy]{.lit} [0.8]{.lit}
[package]{.cmd} [require]{.sub} [map::slippy::cache]{.lit}
[package]{.cmd} [require]{.sub} [map::slippy::fetcher]{.lit}
[package]{.cmd} [require]{.sub} [snit]{.lit}
[package]{.cmd} [require]{.sub} [map::provider::osm]{.lit} [0.1]{.optlit}
:::

# Description

This package provides a tile provider suitable for use with [map::display][display]. It uses OpenStreetMap Mapnik as origin and caches fetched tiles in the local filesystem.

# API

# Example

# Bugs, ideas, feedback

This document, and the package it describes, will undoubtedly contain bugs and other problems. Please report such in the category *map* of the [Tklib Trackers](http://core.tcl-lang.org/tklib/reportlist). Please also report any ideas for enhancements you may have for either package and/or documentation.

# Category

Map Display and Supporting Utilities


[display]: display.md
