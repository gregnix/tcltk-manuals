---
CommandName: map_overview
ManualSection: n
Version: 0.1
TclPart: tklib
TclDescription: Map display support
Keywords:
 - map
Copyright:
---

# Name

map_overview - Overview of the packages in the Map module

# Description

**Storage**
: 


**File**
: Definitions of simple file formats to hold various geo/\* resources, and the ability to read/write these files.


**•**
: **map::area::file**

**•**
: **map::box::file**

**•**
: **map::point::file**

**•**
: **map::track::file**


**Disk**
: On-disk stores for various geo/\* resources. Exist as basic examples to start with, and as API demonstrators. In the original project these packages were factored out of **sqlite** was used as a store. This store is however entwined too much with that project to be factored.


**•**
: **map::area::store::fs**

**•**
: **map::box::store::fs**

**•**
: **map::point::store::fs**

**•**
: **map::track::store::fs**


**Memory**
: In-memory stores caching geo/\* data and adding derived attributes. The bridge between the actual on-disk stores and the various widgets and behaviours.


**•**
: **map::area::store::memory**

**•**
: **map::box::store::memory**

**•**
: **map::point::store::memory**

**•**
: **map::track::store::memory**


**Widgets**
: To show maps, singular geo resources, and tables of many geo resources of the same kind.


**Map**
: **map::display**

**Geo Resource Tables**
: 


**•**
: **map::area::table-display**

**•**
: **map::box::table-display**

**•**
: **map::point::table-display**

**•**
: **map::track::table-display**


**Geo Resource Display**
: 


**•**
: **map::area::display**

**•**
: **map::box::display**

**•**
: **map::track::display**


**Behaviours**
: Engines attachable to **map::display** to add custom behaviours to the shown map.  The two classes of engines are for displaying overlays for specific geo resources, and the editing/entry of specific single geo resources.


**Display**
: 


**•**
: **map::area::map-display**

**•**
: **map::box::map-display**

**•**
: **map::point::map-display**

**•**
: **map::track::map-display**


**Editing**
: 


**•**
: **map::box::entry**

**•**
: **map::mark**

**•**
: **map::track::entry**


**Support**
: **map::provider::osm**


# Bugs, ideas, feedback

This document, and the package it describes, will undoubtedly contain bugs and other problems. Please report such in the category *map* of the [Tklib Trackers](http://core.tcl-lang.org/tklib/reportlist). Please also report any ideas for enhancements you may have for either package and/or documentation.

# Category

Map Display and Supporting Utilities
