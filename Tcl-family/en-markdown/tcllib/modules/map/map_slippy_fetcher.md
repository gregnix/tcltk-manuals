---
CommandName: map::slippy::fetcher
ManualSection: n
Version: 0.7
TclPart: tcllib
TclDescription: Mapping utilities
Keywords:
 - http
 - location
 - map
 - server
 - slippy
 - tile
 - url
 - zoom
Copyright:
---

# Name

map::slippy::fetcher - Accessing a server providing tiles for slippy-based maps

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.6]{.lit} 
[package]{.cmd} [require]{.sub} [map::slippy]{.lit} 
[package]{.cmd} [require]{.sub} [map::slippy::fetcher]{.lit} [0.7]{.optlit} 
[::map::slippy::fetcher]{.cmd} [fetcherName]{.arg} [levels]{.arg} [url]{.arg} 
[fetcherName]{.ins} [levels]{.sub} 
[fetcherName]{.ins} [tileheight]{.sub} 
[fetcherName]{.ins} [tilewidth]{.sub} 
[fetcherName]{.ins} [get]{.sub} [tile]{.arg} [donecmd]{.arg} 
:::

# Description

This package provides a class for accessing http servers providing tiles for slippy-based maps.

*BEWARE*, *Attention* Version *0.7* is *NOT backward compatible* with version 0.5 and earlier. This is due to switching this package's internals to the use of version 0.8 of **map::slippy**.

# Api

**::map::slippy::fetcher** *fetcherName* *levels* *url*
: Creates the fetcher *fetcherName* and configures it with the number of zoom *levels* supported by the tile server, and the *url* it is listening on for tile requests. The result of the command is *fetcherName*.


## Methods

*fetcherName* **levels**
: This method returns the number of zoom levels supported by the fetcher object, and the tile server it is accessing.

*fetcherName* **tileheight**
: This method returns the height of tiles served, in pixels.

*fetcherName* **tilewidth**
: This method returns the width of tiles served, in pixels.

*fetcherName* **get** *tile* *donecmd*
: This is the main method of the fetcher, retrieving the image for the specified *tile*. The tile identifier is a list containing three elements, the zoom level, row, and column number of the tile, in this order. The command refix *donecmd* will be invoked when the fetcher either knows the image for the tile or that no image will forthcoming. It will be invoked with either 2 or 3 arguments, i.e.


**\[1\]**
: The string **set**, the *tile*, and the image.

**\[2\]**
: The string **unset**, and the *tile*.


: These two possibilities are used to either signal the image for the *tile*, or that the *tile* has no image defined for it.


# References

**\[1\]**
: *http://wiki.openstreetmap.org/wiki/Main_Page*
