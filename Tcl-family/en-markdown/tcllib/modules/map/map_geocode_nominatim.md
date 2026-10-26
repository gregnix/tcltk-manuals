---
CommandName: map::geocode::nominatim
title: map::geocode::nominatim
ManualSection: n
Version: 0.3
TclPart: tcllib
TclDescription: Mapping utilities
Keywords:
 - geocoding
 - http
 - location
 - map
 - nominatim
 - server
 - url
Copyright:
---

# Name

map::geocode::nominatim - Resolving geographical names with a Nominatim service

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [http]{.lit}
[package]{.cmd} [require]{.sub} [json]{.lit}
[package]{.cmd} [require]{.sub} [uri]{.lit}
[package]{.cmd} [require]{.sub} [snit]{.lit}
[package]{.cmd} [require]{.sub} [map::geocode::nominatim]{.lit} [0.3]{.optlit}
[::map::geocode::nominatim]{.cmd} [requestor]{.arg} [[-baseurl]{.lit} [url]{.arg}]{.optarg} [[-callback]{.lit} [callback]{.arg}]{.optarg} [[-error]{.lit} [error]{.arg} callback]{.optarg}
[$cmdprefix]{.cmd} [result]{.arg}
[$cmdprefix]{.cmd} [errorstring]{.arg}
[requestor]{.ins} [search]{.sub} [query]{.arg}
:::

# Description

This package provides a class for accessing geocoding services which implement the *Nominatim* interface (see [References])

# API

**::map::geocode::nominatim** *requestor* ?**-baseurl** *url*? ?**-callback** *callback*? ?**-error** *error callback*?
: Creates a geocoding request object *requestor*, which will send its requests to the *Nominatim* server.

    The result of the command is *name*.


## Options

**-baseurl** *url*
: The base URL of the *Nominatim* service. Default value is *OpenStreetMap's* service at <http://nominatim.openstreetmap.org/search> A possible free alternative is at <http://open.mapquestapi.com//nominatim/v1/search>

**-callback** *cmdprefix*
: A command prefix to be invoked when search result become available. The default setting, active when nothing was specified on object creation, is to print the *result* (see below) to *stdout*. The result of the command prefix is ignored. Errors thrown by the command prefix are caught and cause the invokation of the error callback (see option **-error** below), with the error message as argument.

    The signature of the command prefix is:

    **$cmdprefix** *result*
    : The *result* is a list of dictionaries, containing one item per hit. Each dictionary will have the following entries:

        place\_id
        : The place ID (FIXME: what's this?)

        licence
        : The data licence string

        osm\_type
        : The OSM type of the location

        osm\_id
        : FIXME

        boundingbox
        : The coordinates of the bounding box (min and max latitude, min and max longitude)

        lat
        : The location's latitude

        lon
        : The location's longitude

        display\_name
        : the location's human readable name

        class
        : FIXME

        type
        : FIXME

        icon
        : FIXME



**-error** *cmdprefix*
: A command prefix to be invoked when encountering errors. Typically these are HTTP errors. The default setting, active when nothing was specified on object creation, is to print the *errorstring* (see below) to *stderr*. The result of the command prefix is ignored. Errors thrown by the command prefix are passed to higher levels.

    The signature of the command prefix is:

    - **$cmdprefix** *errorstring*



## Methods

*requestor* **search** *query*
: This method returns a list of dictionaries, one item per hit for the specified *query*.


# References

1. <http://wiki.openstreetmap.org/wiki/Nominatim>

2. <http://open.mapquestapi.com/nominatim/>
