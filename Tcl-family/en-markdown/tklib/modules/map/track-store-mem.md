---
CommandName: map::track::store::memory
title: map::track::store::memory
ManualSection: n
Version: 0.1
TclPart: tklib
TclDescription: Map display support
Keywords:
 - center
 - geo/track
 - diameter
 - geo/track
 - geo/track pixels
 - zoom
 - geo/track
 - center
 - geo/track
 - diameter
 - geo/track
 - memory store
 - geo/track
 - perimeter length
 - length
 - geo/track
 - perimeter
 - map
 - memory store
 - geo/track
 - perimeter length
 - geo/track
 - pixels
 - zoom
 - geo/track
 - store
 - geo/track
 - memory
 - zoom
 - geo/track pixels
Copyright:
---

# Name

map::track::store::memory - In-memory store for geo/track definitions

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6-]{.lit}
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6-]{.lit}
[package]{.cmd} [require]{.sub} [debug]{.lit}
[package]{.cmd} [require]{.sub} [debug::caller]{.lit}
[package]{.cmd} [require]{.sub} [map::slippy]{.lit} [0.8]{.lit}
[package]{.cmd} [require]{.sub} [snit]{.lit}
[package]{.cmd} [require]{.sub} [map::track::store::memory]{.lit} [0.1]{.optlit}
:::

# Description

This package provides an in-memory store for *geo/track* definitions, with memoized calculation of extended attributes.

The base data is pulled from a backing store. A [map::track::store::fs][track-store-fs] or anything API-compatible to it.

# API

# Example

# Bugs, ideas, feedback

This document, and the package it describes, will undoubtedly contain bugs and other problems. Please report such in the category *map* of the [Tklib Trackers](http://core.tcl-lang.org/tklib/reportlist). Please also report any ideas for enhancements you may have for either package and/or documentation.

# Category

Map Display and Supporting Utilities


[track-store-fs]: track-store-fs.md
