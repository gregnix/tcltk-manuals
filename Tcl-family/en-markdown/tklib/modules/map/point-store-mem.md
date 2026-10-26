---
CommandName: map::point::store::memory
title: map::point::store::memory
ManualSection: n
Version: 0.1
TclPart: tklib
TclDescription: Map display support
Keywords:
 - center
 - geo/point
 - diameter
 - geo/point
 - geo/point pixels
 - zoom
 - geo/point
 - center
 - geo/point
 - diameter
 - geo/point
 - memory store
 - geo/point
 - perimeter length
 - length
 - geo/point
 - perimeter
 - map
 - memory store
 - geo/point
 - perimeter length
 - geo/point
 - pixels
 - zoom
 - geo/point
 - store
 - geo/point
 - memory
 - zoom
 - geo/point pixels
Copyright:
---

# Name

map::point::store::memory - In-memory store for geo/point definitions

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6-]{.lit}
[package]{.cmd} [require]{.sub} [debug]{.lit}
[package]{.cmd} [require]{.sub} [debug::caller]{.lit}
[package]{.cmd} [require]{.sub} [map::slippy]{.lit} [0.8]{.lit}
[package]{.cmd} [require]{.sub} [snit]{.lit}
[package]{.cmd} [require]{.sub} [map::point::store::memory]{.lit} [0.1]{.optlit}
:::

# Description

This package provides an in-memory store for *geo/point* definitions, with memoized calculation of extended attributes.

The base data is pulled from a backing store. A [map::point::store::fs][point-store-fs] or anything API-compatible to it.

# API

# Example

# Bugs, ideas, feedback

This document, and the package it describes, will undoubtedly contain bugs and other problems. Please report such in the category *map* of the [Tklib Trackers](http://core.tcl-lang.org/tklib/reportlist). Please also report any ideas for enhancements you may have for either package and/or documentation.

# Category

Map Display and Supporting Utilities


[point-store-fs]: point-store-fs.md
