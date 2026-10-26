---
CommandName: map_overview
title: map_overview
ManualSection: n
Version: 0.1
TclPart: tklib
TclDescription: Map display support
Keywords:
 - map
Copyright:
---

# Name

map\_overview - Overview of the packages in the Map module

# Description

Storage
: see below ...

    File
    : Definitions of simple file formats to hold various geo/\* resources, and the ability to read/write these files.

        - [map::area::file][area-file]

        - [map::box::file][box-file]

        - [map::point::file][point-file]

        - [map::track::file][track-file]


    Disk
    : On-disk stores for various geo/\* resources. Exist as basic examples to start with, and as API demonstrators. In the original project these packages were factored out of **sqlite** was used as a store. This store is however entwined too much with that project to be factored.

        - [map::area::store::fs][area-store-fs]

        - [map::box::store::fs][box-store-fs]

        - [map::point::store::fs][point-store-fs]

        - [map::track::store::fs][track-store-fs]


    Memory
    : In-memory stores caching geo/\* data and adding derived attributes. The bridge between the actual on-disk stores and the various widgets and behaviours.

        - [map::area::store::memory][area-store-mem]

        - [map::box::store::memory][box-store-mem]

        - [map::point::store::memory][point-store-mem]

        - [map::track::store::memory][track-store-mem]



Widgets
: To show maps, singular geo resources, and tables of many geo resources of the same kind.

    Map
    : [map::display][display]

    Geo Resource Tables
    : - [map::area::table-display][area-table-display]

        - [map::box::table-display][box-table-display]

        - [map::point::table-display][point-table-display]

        - [map::track::table-display][track-table-display]


    Geo Resource Display
    : - [map::area::display][area-display]

        - [map::box::display][box-display]

        - [map::track::display][track-display]



Behaviours
: Engines attachable to [map::display][display] to add custom behaviours to the shown map.  The two classes of engines are for displaying overlays for specific geo resources, and the editing/entry of specific single geo resources.

    Display
    : - [map::area::map-display][area-map-display]

        - [map::box::map-display][box-map-display]

        - [map::point::map-display][point-map-display]

        - [map::track::map-display][track-map-display]


    Editing
    : - [map::box::entry][box-entry]

        - [map::mark][mark]

        - [map::track::entry][track-entry]



Support
: [map::provider::osm][provider-osm]


# Bugs, ideas, feedback

This document, and the package it describes, will undoubtedly contain bugs and other problems. Please report such in the category *map* of the [Tklib Trackers](http://core.tcl-lang.org/tklib/reportlist). Please also report any ideas for enhancements you may have for either package and/or documentation.

# Category

Map Display and Supporting Utilities


[area-display]: area-display.md
[area-file]: area-file.md
[area-map-display]: area-map-display.md
[area-store-fs]: area-store-fs.md
[area-store-mem]: area-store-mem.md
[area-table-display]: area-table-display.md
[box-display]: box-display.md
[box-entry]: box-entry.md
[box-file]: box-file.md
[box-map-display]: box-map-display.md
[box-store-fs]: box-store-fs.md
[box-store-mem]: box-store-mem.md
[box-table-display]: box-table-display.md
[display]: display.md
[mark]: mark.md
[point-file]: point-file.md
[point-map-display]: point-map-display.md
[point-store-fs]: point-store-fs.md
[point-store-mem]: point-store-mem.md
[point-table-display]: point-table-display.md
[provider-osm]: provider-osm.md
[track-display]: track-display.md
[track-entry]: track-entry.md
[track-file]: track-file.md
[track-map-display]: track-map-display.md
[track-store-fs]: track-store-fs.md
[track-store-mem]: track-store-mem.md
[track-table-display]: track-table-display.md
