---
CommandName: map::slippy::cache
title: map::slippy::cache
ManualSection: n
Version: 0.5
TclPart: tcllib
TclDescription: Mapping utilities
Keywords:
 - cache
 - filesystem
 - location
 - map
 - slippy
 - tile
 - zoom
Copyright:
---

# Name

map::slippy::cache - Management of a tile cache in the local filesystem

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.6]{.lit}
[package]{.cmd} [require]{.sub} [map::slippy]{.lit}
[package]{.cmd} [require]{.sub} [map::slippy::cache]{.lit} [0.5]{.optlit}
[::map::slippy::cache]{.cmd} [cacheName]{.arg} [cachedir]{.arg} [provider]{.arg}
[cacheName]{.ins} [valid]{.sub} [tile]{.arg} [msgvar]{.optarg}
[cacheName]{.ins} [exists]{.sub} [tile]{.arg}
[cacheName]{.ins} [get]{.sub} [tile]{.arg} [donecmd]{.arg}
:::

# Description

This package provides a class for managing a cache of tiles for slippy-based maps in the local filesystem.

*BEWARE*, *Attention* Version *0.5* is *NOT backward compatible* with version 0.3 and earlier. This is due to switching this package's internals to the use of version 0.8 of **map::slippy**.

# API

**::map::slippy::cache** *cacheName* *cachedir* *provider*
: Creates the cache *cacheName* and configures it with both the path to the directory contaiing the locally cached tiles (*cachedir*), and the command prefix from which it will pull tiles asked for and not yet known to the cache itself (*provider*).

    The result of the command is *cacheName*.


## Methods

*cacheName* **valid** *tile* ?*msgvar*?
: This method checks the validity of a the given *tile* identifier. This is a convenience wrapper to **::map::slippy tile valid** and has the same interface.

*cacheName* **exists** *tile*
: This methods tests whether the cache contains the specified *tile* or not. The result is a boolean value, **true** if the tile is known, and **false** otherwise. The tile is identified by a list containing three elements, zoom level, row, and column number, in this order.

*cacheName* **get** *tile* *donecmd*
: This is the main method of the cache, retrieving the image for the specified *tile* from the cache. The tile identifier is a list containing three elements, the zoom level, row, and column number of the tile, in this order.

    The command refix *donecmd* will be invoked when the cache either knows the image for the tile or that no image will forthcoming. It will be invoked with either 2 or 3 arguments, i.e.

    1. The string **set**, the *tile*, and the image.

    2. The string **unset**, and the *tile*.


    These two possibilities are used to either signal the image for the *tile*, or that the *tile* has no image defined for it.

    When the cache has no information about the tile it will invoke the *provider* command prefix specified during its construction, adding three arguments: The string **get**, the *tile*, and a callback into the cache. The latter will be invoked by the provider to either transfer the image to the cache, or signal that the tile has no image.

    When multiple requests for the same tile are made only one request will be issued to the provider.


# References

1. <http://wiki.openstreetmap.org/wiki/Main_Page>
