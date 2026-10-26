---
CommandName: gpx
title: gpx
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: GPS eXchange Format (GPX)
Keywords:
 - gps
 - gpx
Copyright:
 - Copyright (c) 2010, Keith Vetter <kvetter@gmail.com>
---

# Name

gpx - Extracts waypoints, tracks and routes from GPX files

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [gpx]{.lit} [1.1]{.optlit}
[::gpx::Create]{.cmd} [gpxFilename]{.arg} [rawXML]{.optarg}
[::gpx::Cleanup]{.cmd} [token]{.arg}
[::gpx::GetGPXMetadata]{.cmd} [token]{.arg}
[::gpx::GetWaypointCount]{.cmd} [token]{.arg}
[::gpx::GetAllWaypoints]{.cmd} [token]{.arg}
[::gpx::GetTrackCount]{.cmd} [token]{.arg}
[::gpx::GetTrackMetadata]{.cmd} [token]{.arg} [whichTrack]{.arg}
[::gpx::GetTrackPoints]{.cmd} [token]{.arg} [whichTrack]{.arg}
[::gpx::GetRouteCount]{.cmd} [token]{.arg}
[::gpx::GetRouteMetadata]{.cmd} [token]{.arg} [whichRoute]{.arg}
[::gpx::GetRoutePoints]{.cmd} [token]{.arg} [whichRoute]{.arg}
:::

# Description

This module parses and extracts waypoints, tracks, routes and metadata from a GPX (GPS eXchange) file. Both GPX version 1.0 and 1.1 are supported.

# Commands

**::gpx::Create** *gpxFilename* ?*rawXML*?
: The **::gpx::Create** is the first command called to process GPX data. It takes the GPX data from either the *rawXML* parameter if present or from the contents of *gpxFilename*, and parses it using *tdom*. It returns a token value that is used by all the other commands.

**::gpx::Cleanup** *token*
: This procedure cleans up resources associated with *token*. It is *strongly* recommended that you call this function after you are done with a given GPX file. Not doing so will result in memory not being freed, and if your app calls **::gpx::Create** enough times, the memory leak could cause a performance hit...or worse.

**::gpx::GetGPXMetadata** *token*
: This procedure returns a dictionary of the metadata associated with the GPX data identified by *token*. The format of the metadata dictionary is described below, but keys *version* and *creator* will always be present.

**::gpx::GetWaypointCount** *token*
: This procedure returns the number of waypoints defined in the GPX data identified by *token*.

**::gpx::GetAllWaypoints** *token*
: This procedure returns the a list of waypoints defined in the GPX data identified by *token*. The format of each waypoint item is described below.

**::gpx::GetTrackCount** *token*
: This procedure returns the number of tracks defined in the GPX data identified by *token*.

**::gpx::GetTrackMetadata** *token* *whichTrack*
: This procedure returns a dictionary of the metadata associated track number *whichTrack* (1 based) in the GPX data identified by *token*. The format of the metadata dictionary is described below.

**::gpx::GetTrackPoints** *token* *whichTrack*
: The procedure returns a list of track points comprising track number *whichTrack* (1 based) in the GPX data identified by *token*. The format of the metadata dictionary is described below.

**::gpx::GetRouteCount** *token*
: This procedure returns the number of routes defined in the GPX data identified by *token*.

**::gpx::GetRouteMetadata** *token* *whichRoute*
: This procedure returns a dictionary of the metadata associated route number *whichRoute* (1 based) in the GPX data identified by *token*. The format of the metadata dictionary is described below.

**::gpx::GetRoutePoints** *token* *whichRoute*
: The procedure returns a list of route points comprising route number *whichRoute* (1 based) in the GPX data identified by *token*. The format of the metadata dictionary is described below.


# Data structures

metadata dictionary
: The metadata associated with either the GPX document, a track, a route, a waypoint, a track point or route point is returned in a dictionary. The keys of that dictionary will be whatever optional GPX elements are present. The value for each key depends on the GPX schema for that element. For example, the value for a version key will be a string, while for a link key will be a sub-dictionary with keys *href* and optionally *text* and *type*.

point item
: Each item in a track or route list of points consists of a list of three elements: *latitude*, *longitude* and *metadata dictionary*. *Latitude* and *longitude* are decimal numbers. The *metadata dictionary* format is described above. For points in a track, typically there will always be ele (elevation) and time metadata keys.


# Example

```
% set token [::gpx::Create myGpxFile.gpx]
% set version [dict get [::gpx::GetGPXMetadata $token] version]
% set trackCnt [::gpx::GetTrackCount $token]
% set firstPoint [lindex [::gpx::GetTrackPoints $token 1] 0]
% lassign $firstPoint lat lon ptMetadata
% puts "first point in the first track is at $lat, $lon"
% if {[dict exists $ptMetadata ele]} {
     puts "at elevation [dict get $ptMetadata ele] meters"
  }
% ::gpx::Cleanup $token
```

# References

1. GPX: the GPS Exchange Format (<http://www.topografix.com/gpx.asp>)

2. GPX 1.1 Schema Documentation (<http://www.topografix.com/GPX/1/1/>)

3. GPX 1.0 Developer's Manual (<http://www.topografix.com/gpx_manual.asp>)


# Author

Keith Vetter

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *gpx* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

File formats

# Copyright

```
Copyright (c) 2010, Keith Vetter <kvetter@gmail.com>
```
