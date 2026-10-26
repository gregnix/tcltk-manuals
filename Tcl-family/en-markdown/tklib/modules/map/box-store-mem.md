---
CommandName: map::box::store::memory
title: map::box::store::memory
ManualSection: n
Version: 0.1
TclPart: tklib
TclDescription: Map display support
Keywords:
 - center
 - geo/box
 - diameter
 - geo/box
 - geo/box pixels
 - zoom
 - geo/box
 - center
 - geo/box
 - diameter
 - geo/box
 - memory store
 - geo/box
 - perimeter length
 - length
 - geo/box
 - perimeter
 - map
 - memory store
 - geo/box
 - perimeter length
 - geo/box
 - pixels
 - zoom
 - geo/box
 - store
 - geo/box
 - memory
 - zoom
 - geo/box pixels
Copyright:
---

# Name

map::box::store::memory - In-memory store for geo/box definitions

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6-]{.lit}
[package]{.cmd} [require]{.sub} [debug]{.lit}
[package]{.cmd} [require]{.sub} [debug::caller]{.lit}
[package]{.cmd} [require]{.sub} [map::slippy]{.lit} [0.8]{.lit}
[package]{.cmd} [require]{.sub} [snit]{.lit}
[package]{.cmd} [require]{.sub} [map::box::store::memory]{.lit} [0.1]{.optlit}
:::

# Description

This package provides an in-memory store for *geo/box* definitions, with memoized calculation of extended attributes.

The base data is pulled from a backing store. A [map::box::store::fs][box-store-fs] or anything API-compatible to it.

# API

# Example

# Bugs, ideas, feedback

This document, and the package it describes, will undoubtedly contain bugs and other problems. Please report such in the category *map* of the [Tklib Trackers](http://core.tcl-lang.org/tklib/reportlist). Please also report any ideas for enhancements you may have for either package and/or documentation.

# Category

Map Display and Supporting Utilities


[box-store-fs]: box-store-fs.md
