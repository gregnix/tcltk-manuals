---
CommandName: map::slippy
title: map::slippy
ManualSection: n
Version: 0.10
TclPart: tcllib
TclDescription: Mapping utilities
Keywords:
 - geodesy
 - geography
 - latitute
 - location
 - longitude
 - map
 - slippy
 - zoom
Copyright:
---

# Name

map::slippy - Common code for slippy based map packages

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [map::slippy]{.lit} [0.10]{.optlit}
[::map]{.cmd} [slippy]{.lit} [geo]{.lit} [box]{.lit} [2point]{.lit} [zoom]{.arg} [geobox]{.arg}
[::map]{.cmd} [slippy]{.lit} [geo]{.lit} [box]{.lit} [center]{.lit} [geobox]{.arg}
[::map]{.cmd} [slippy]{.lit} [geo]{.lit} [box]{.lit} [corners]{.lit} [geobox]{.arg}
[::map]{.cmd} [slippy]{.lit} [geo]{.lit} [box]{.lit} [diameter]{.lit} [geobox]{.arg}
[::map]{.cmd} [slippy]{.lit} [geo]{.lit} [box]{.lit} [dimensions]{.lit} [geobox]{.arg}
[::map]{.cmd} [slippy]{.lit} [geo]{.lit} [box]{.lit} [fit]{.lit} [geobox]{.arg} [canvdim]{.arg} [zmax]{.arg} [zmin]{.optarg}
[::map]{.cmd} [slippy]{.lit} [geo]{.lit} [box]{.lit} [inside]{.lit} [geobox]{.arg} [geo]{.arg}
[::map]{.cmd} [slippy]{.lit} [geo]{.lit} [box]{.lit} [limit]{.lit} [geobox]{.arg}
[::map]{.cmd} [slippy]{.lit} [geo]{.lit} [box]{.lit} [opposites]{.lit} [geobox]{.arg}
[::map]{.cmd} [slippy]{.lit} [geo]{.lit} [box]{.lit} [perimeter]{.lit} [geobox]{.arg}
[::map]{.cmd} [slippy]{.lit} [geo]{.lit} [box]{.lit} [valid]{.lit} [geobox]{.arg}
[::map]{.cmd} [slippy]{.lit} [geo]{.lit} [box]{.lit} [valid-list]{.lit} [geoboxes]{.arg}
[::map]{.cmd} [slippy]{.lit} [geo]{.lit} [distance]{.lit} [geo1]{.arg} [geo2]{.arg}
[::map]{.cmd} [slippy]{.lit} [geo]{.lit} [distance\*]{.lit} [closed]{.arg} [geo...]{.arg}
[::map]{.cmd} [slippy]{.lit} [geo]{.lit} [distance-list]{.lit} [closed]{.arg} [geo-list]{.arg}
[::map]{.cmd} [slippy]{.lit} [geo]{.lit} [limit]{.lit} [geo]{.arg}
[::map]{.cmd} [slippy]{.lit} [geo]{.lit} [bbox]{.lit} [geo...]{.arg}
[::map]{.cmd} [slippy]{.lit} [geo]{.lit} [bbox-list]{.lit} [geo-list]{.arg}
[::map]{.cmd} [slippy]{.lit} [geo]{.lit} [center]{.lit} [geo...]{.arg}
[::map]{.cmd} [slippy]{.lit} [geo]{.lit} [center-list]{.lit} [geo-list]{.arg}
[::map]{.cmd} [slippy]{.lit} [geo]{.lit} [diameter]{.lit} [geo...]{.arg}
[::map]{.cmd} [slippy]{.lit} [geo]{.lit} [diameter-list]{.lit} [geo-list]{.arg}
[::map]{.cmd} [slippy]{.lit} [geo]{.lit} [2point]{.lit} [zoom]{.arg} [geo]{.arg}
[::map]{.cmd} [slippy]{.lit} [geo]{.lit} [2point\*]{.lit} [zoom]{.arg} [geo...]{.arg}
[::map]{.cmd} [slippy]{.lit} [geo]{.lit} [2point-list]{.lit} [zoom]{.arg} [geo-list]{.arg}
[::map]{.cmd} [slippy]{.lit} [geo]{.lit} [valid]{.lit} [geo]{.arg}
[::map]{.cmd} [slippy]{.lit} [geo]{.lit} [valid-list]{.lit} [geos]{.arg}
[::map]{.cmd} [slippy]{.lit} [length]{.lit} [level]{.arg}
[::map]{.cmd} [slippy]{.lit} [limit2]{.lit} [x]{.arg}
[::map]{.cmd} [slippy]{.lit} [limit3]{.lit} [x]{.arg}
[::map]{.cmd} [slippy]{.lit} [limit6]{.lit} [x]{.arg}
[::map]{.cmd} [slippy]{.lit} [point]{.lit} [box]{.lit} [2geo]{.lit} [zoom]{.arg} [pointbox]{.arg}
[::map]{.cmd} [slippy]{.lit} [point]{.lit} [box]{.lit} [center]{.lit} [pointbox]{.arg}
[::map]{.cmd} [slippy]{.lit} [point]{.lit} [box]{.lit} [corners]{.lit} [pointbox]{.arg}
[::map]{.cmd} [slippy]{.lit} [point]{.lit} [box]{.lit} [diameter]{.lit} [pointbox]{.arg}
[::map]{.cmd} [slippy]{.lit} [point]{.lit} [box]{.lit} [dimensions]{.lit} [pointbox]{.arg}
[::map]{.cmd} [slippy]{.lit} [point]{.lit} [box]{.lit} [inside]{.lit} [pointbox]{.arg} [point]{.arg}
[::map]{.cmd} [slippy]{.lit} [point]{.lit} [box]{.lit} [opposites]{.lit} [pointbox]{.arg}
[::map]{.cmd} [slippy]{.lit} [point]{.lit} [box]{.lit} [perimeter]{.lit} [pointbox]{.arg}
[::map]{.cmd} [slippy]{.lit} [point]{.lit} [distance]{.lit} [point1]{.arg} [point2]{.arg}
[::map]{.cmd} [slippy]{.lit} [point]{.lit} [distance\*]{.lit} [closed]{.arg} [point...]{.arg}
[::map]{.cmd} [slippy]{.lit} [point]{.lit} [distance-list]{.lit} [closed]{.arg} [point-list]{.arg}
[::map]{.cmd} [slippy]{.lit} [point]{.lit} [bbox]{.lit} [point...]{.arg}
[::map]{.cmd} [slippy]{.lit} [point]{.lit} [bbox-list]{.lit} [point-list]{.arg}
[::map]{.cmd} [slippy]{.lit} [point]{.lit} [center]{.lit} [point...]{.arg}
[::map]{.cmd} [slippy]{.lit} [point]{.lit} [center-list]{.lit} [point-list]{.arg}
[::map]{.cmd} [slippy]{.lit} [point]{.lit} [diameter]{.lit} [point...]{.arg}
[::map]{.cmd} [slippy]{.lit} [point]{.lit} [diameter-list]{.lit} [point-list]{.arg}
[::map]{.cmd} [slippy]{.lit} [point]{.lit} [2geo]{.lit} [zoom]{.arg} [point]{.arg}
[::map]{.cmd} [slippy]{.lit} [point]{.lit} [2geo\*]{.lit} [zoom]{.arg} [point...]{.arg}
[::map]{.cmd} [slippy]{.lit} [point]{.lit} [2geo-list]{.lit} [zoom]{.arg} [point-list]{.arg}
[::map]{.cmd} [slippy]{.lit} [point]{.lit} [simplify]{.lit} [radial]{.lit} [threshold]{.arg} [point-list]{.arg}
[::map]{.cmd} [slippy]{.lit} [point]{.lit} [simplify]{.lit} [rdp]{.lit} [point-list]{.arg}
[::map]{.cmd} [slippy]{.lit} [pretty-distance]{.lit} [x]{.arg}
[::map]{.cmd} [slippy]{.lit} [tiles]{.lit} [level]{.arg}
[::map]{.cmd} [slippy]{.lit} [tile]{.lit} [size]{.lit}
[::map]{.cmd} [slippy]{.lit} [tile]{.lit} [valid]{.lit} [zoom]{.arg} [row]{.arg} [column]{.arg} [levels]{.arg} [msgvar]{.optarg}
[::map]{.cmd} [slippy]{.lit} [valid]{.lit} [latitude]{.lit} [x]{.arg}
[::map]{.cmd} [slippy]{.lit} [valid]{.lit} [longitude]{.lit} [x]{.arg}
:::

# Description

This package provides a number of methods doing things needed by all types of slippy-based map packages.

*BEWARE*, *Attention* Version *0.9* is *NOT backward compatible* with version 0.7 and earlier.  The entire API was *heavily revised and changed*.

*Note:* For the representation of locations in the various coordinate systems used by the commands of this package please read section [Coordinate systems]. The command descriptions will not repeat them, and assume that they are understood already.

# Coordinate systems

The commands of this package operate in two distinct coordinate systems, geographical locations, and points. The former represents coordinates for locations on Earth, while the latter is for use on Tk *canvas* widgets.

## Geographic

Geographical locations (short: *geo*) are represented by a pair of *Latitude* and *Longitude* values, each of which is measured in degrees, as they are essentially angles.

The **Zero** longitude is the *Greenwich meridian*, with positive values going *east*, and negative values going *west*, for a total range of +/- 180 degrees. Note that +180 and -180 longitude are the same *meridian*, opposite to Greenwich.

The **zero** latitude is the *Equator*, with positive values going *north* and negative values going *south*. While the true range is +/- 90 degrees the projection used by the package requires us to cap the range at roughly +/- **85.05112877983284** degrees. This means that the North and South poles are not representable and not part of any map.

A geographical location is represented by a list containing two values, the latitude, and longitude of the location, in this order.

A geographical bounding box is represented by a list containing four values, the minimal latitude and longitude of the box, and the maximal latitude and longitude of the box, in this order.

Geographical locations and boxes can be converted to points and their boxes by means of an additional parameter, the *zoom* level. This parameter indicates the size of the map in the canvas the coordinates are to be projected into.

## Points

Points (short: *point*) are represented by a pair of *x* and *y* values, each of which is measured in pixels. They reference a location in a Tk *canvas* widget. As a map can be shown at different degrees of magnification, the exact pixel coordinates for a geographical location depend on this *zoom* level.

For the following explanation to make sense it should be noted that a map shown in a Tk *canvas* widget is split into equal-sized quadratic *tiles*.

Point coordinates are tile coordinates scaled by the size of these tiles. This package uses tiles of size **256**, which is the standard size used by many online servers providing map tiles of some kind or other.

A point is represented by a list containing the x- and y-coordinates of the lcoation, in this in this order.

A point bounding box is represented by a list containing four values, the minimal x and y of the box, and the maximal x and y of the box, in this order.

Point locations and boxes can be converted to geographical locations and their boxes by means of an additional parameter, the *zoom* level. This parameter indicates the size of the map in the canvas the coordinates are projected from.

Tile coordinates appear only in one place of the API, in the signature of command **map slippy tile valid**. Everything else uses Point coordinates.

Using tile coordinates in the following however makes the structure of the map at the various *zoom* levels (maginification factors) easier to explain.

Generally the integer part of the tile coordinates represent the row and column number of a tile of the map, wheras the fractional parts signal how far inside that tile the location in question is, with pure integer coordinates (no fractional part) representing the upper left corner of a tile.

The zero point of the map is at the upper left corner, regardless of zoom level, with larger coordinates going right (east) and down (south), and smaller coordinates going left (west) and up (north). Again regardless of zoom level.

Negative coordinates are not allowed.

At zoom level **0** the entire map is represented by a single tile, putting the geographic zero at 1/2, 1/2 in terms of tile coordinates, and the range of tile coordinates as \[0...1\].

When going from zoom level **N** to the next deeper (magnified) level (**N**+1) each tile of level **N** is split into its four quadrants, which then are the tiles of level **N**+1.

This means that at zoom level **N** the map is sliced (horizontally and vertically) into **2^N** rows and columns, for a total of **4^N** tiles, with the tile coordinates ranging from **0** to **2^N+1**.

# API

**::map** **slippy geo box 2point** *zoom* *geobox*
: The command converts the geographical box *geobox* to a point box in the canvas, for the specified *zoom* level, and returns that box.

**::map** **slippy geo box center** *geobox*
: The command returns the center of the geographical box *geobox*.

**::map** **slippy geo box corners** *geobox*
: This command returns a list containing the four corner locations implied by the geographical box *geobox*. The four points are top-left, bottom-left, top-right, and bottom-right, in that order.

**::map** **slippy geo box diameter** *geobox*
: The command returns the diameter of the geographical box *geobox*, in meters.

**::map** **slippy geo box dimensions** *geobox*
: The command returns the dimensions of the geographical box *geobox*, width and height, in this order.

**::map** **slippy geo box fit** *geobox* *canvdim* *zmax* ?*zmin*?
: This command calculates the zoom level such that the *geobox* will fit into a viewport given by *canvdim* (a 2-element list containing the width and height of said viewport) and returns it.

    The zoom level will be made to fit within the range *zmin*...*zmax*. When *zmin* is not specified it will default to **0**.

**::map** **slippy geo box inside** *geobox* *geo*
: The command tests if the geographical location *geo* is contained in the geographical box *geobox* or not. It returns **true** if so, and **false** else.

**::map** **slippy geo box limit** *geobox*
: This command limits the geographical box to at most 6 decimals and returns the result.

    For geographical coordinates 6 decimals is roughly equivalent to a grid of 11.1 cm.

**::map** **slippy geo box opposites** *geobox*
: This command returns a list containing the two principal corner locations implied by the geographical box *geobox*. The two points are top-left, and bottom-right, in that order.

**::map** **slippy geo box perimeter** *geobox*
: The command returns the perimeter of the geographical box *geobox*, in meters.

**::map** **slippy geo box valid** *geobox*
: This commands tests if the specified geographical box contains only valid latitudes and longitudes. It returns **true** if the box is valid, and **false** else.

**::map** **slippy geo box valid-list** *geoboxes*
: This commands tests if the list of geographical boxes contains only valid latitudes and longitudes. It returns **true** if all the boxes are valid, and **false** else.

**::map** **slippy geo distance** *geo1* *geo2*
: This command computes the great-circle distance between the two geographical locations in meters and returns that value.

    The code is based on <https://wiki.tcl-lang.org/page/geodesy> take on the [haversine formula](https://en.wikipedia.org/wiki/Haversine_formula).

**::map** **slippy geo distance\*** *closed* *geo*...
: An extension of **map slippy geo distance** this command computes the cumulative distance along the path specified by the ordered set of geographical locations in meters, and returns it.

    If the path is marked as *closed* (i.e. a polygon/loop) the result contains the distance between last and first element of the path as well, making the result the length of the perimeter of the area described by the locations.

**::map** **slippy geo distance-list** *closed* *geo-list*
: As a variant of **map slippy geo distance\*** this command takes the path to compute the length of as a single list of geographical locations, instead of a varying number of arguments.

**::map** **slippy geo limit** *geo*
: This command limits the geographical location to at most 6 decimals and returns the result.

    For geographical coordinates 6 decimals is roughly equivalent to a grid of 11.1 cm.

**::map** **slippy geo bbox** *geo*...
: see below ...

**::map** **slippy geo bbox-list** *geo-list*
: These two commands compute the bounding box for the specified set of geographical locations and return a geographical box.

    When no geographical locations are specified the box is "**0 0 0 0**".

    The locations are specified as either a varying number of arguments, or as a single list.

**::map** **slippy geo center** *geo*...
: see below ...

**::map** **slippy geo center-list** *geo-list*
: These two commands compute the center of the bounding box for the specified set of geographical locations.

    When no geographical locations are specified the center is "**0 0**".

    The locations are specified as either a varying number of arguments, or as a single list.

**::map** **slippy geo diameter** *geo*...
: see below ...

**::map** **slippy geo diameter-list** *geo-list*
: These two commands compute the diameter for the specified set of geographical locations, in meters. The diameter is the maximum of the pair-wise distances between all locations.

    When less than two geographical locations are specified the diameter is "**0**".

    The locations are specified as either a varying number of arguments, or as a single list.

**::map** **slippy geo 2point** *zoom* *geo*
: This command converts the geographical location *geo* to a point in the canvas, for the specified *zoom* level, and returns that point.

**::map** **slippy geo 2point\*** *zoom* *geo*...
: see below ...

**::map** **slippy geo 2point-list** *zoom* *geo-list*
: These two commands are extensions of **map slippy geo 2point** which take a series of geographical locations as either a varying number of arguments or a single list, convert them all to points as per the specified *zoom* level and return a list of the results.

**::map** **slippy geo valid** *geo*
: This commands tests if the specified geographical location contains only valid latitudes and longitudes. It returns **true** if the location is valid, and **false** else.

**::map** **slippy geo valid-list** *geos*
: This commands tests if the list of geographical locations contains only valid latitudes and longitudes. It returns **true** if all the locations are valid, and **false** else.

**::map** **slippy length** *level*
: This command returns the width/height of a slippy-based map at the specified zoom *level*, in pixels. This is, in essence, the result of

    ```
    expr { [tiles $level] * [tile size] }
    ```

**::map** **slippy limit2** *x*
: see below ...

**::map** **slippy limit3** *x*
: see below ...

**::map** **slippy limit6** *x*
: This command limits the value to at most 2, 3, or 6 decimals and returns the result.

    For geographical coordinates 6 decimals is roughly equivalent to a grid of 11.1 cm.

**::map** **slippy point box 2geo** *zoom* *pointbox*
: The command converts the point box *pointbox* to a geographical box in the canvas, as per the specified *zoom* level, and returns that box.

**::map** **slippy point box center** *pointbox*
: The command returns the center of the *pointbox*.

**::map** **slippy point box corners** *pointbox*
: This command returns a list containing the four corner locations implied by the point box *pointbox*. The four points are top-left, bottom-left, top-right, and bottom-right, in that order.

**::map** **slippy point box diameter** *pointbox*
: The command returns the diameter of the *pointbox*, in pixels.

**::map** **slippy point box dimensions** *pointbox*
: The command returns the dimensions of the *pointbox*, width and height, in this order.

**::map** **slippy point box inside** *pointbox* *point*
: The command tests if the *point* is contained in the *pointbox* or not. It returns **true** if so, and **false** else.

**::map** **slippy point box opposites** *pointbox*
: This command returns a list containing the two principal corner locations implied by the point box *pointbox*. The two points are top-left, and bottom-right, in that order.

**::map** **slippy point box perimeter** *pointbox*
: The command returns the perimeter of the *pointbox*, in pixels.

**::map** **slippy point distance** *point1* *point2*
: This command computes the euclidena distance between the two points in pixels and returns that value.

**::map** **slippy point distance\*** *closed* *point*...
: An extension of **map slippy point distance** this command computes the cumulative distance along the path specified by the ordered set of points, and returns it.

    If the path is marked as *closed* (i.e. a polygon/loop) the result contains the distance between last and first element of the path as well, making the result the length of the perimeter of the area described by the locations.

**::map** **slippy point distance-list** *closed* *point-list*
: As a variant of **map slippy point distance\*** this command takes the path to compute the length of as a single list of points, instead of a varying number of arguments.

**::map** **slippy point bbox** *point*...
: see below ...

**::map** **slippy point bbox-list** *point-list*
: These two commands compute the bounding box for the specified set of points and return a point box.

    When no points are specified the box is "**0 0 0 0**".

    The locations are specified as either a varying number of arguments, or as a single list.

**::map** **slippy point center** *point*...
: see below ...

**::map** **slippy point center-list** *point-list*
: These two commands compute the center of the bounding box for the specified set of points.

    When no points are specified the center is "**0 0**".

    The locations are specified as either a varying number of arguments, or as a single list.

**::map** **slippy point diameter** *point*...
: see below ...

**::map** **slippy point diameter-list** *point-list*
: These two commands compute the diameter for the specified set of points, in pixels. The diameter is the maximum of the pair-wise distances between all locations.

    When less than two points are specified the diameter is "**0**".

    The locations are specified as either a varying number of arguments, or as a single list.

**::map** **slippy point 2geo** *zoom* *point*
: This command converts the *point* in the canvas, for the specified *zoom* level, to a geograhical location, and returns that location.

**::map** **slippy point 2geo\*** *zoom* *point*...
: see below ...

**::map** **slippy point 2geo-list** *zoom* *point-list*
: These two commands are extensions of **map slippy point 2geo** which take a series of points as either a varying number of arguments or a single list, convert them all to geographical locations as per the specified *zoom* level and return a list of the results.

**::map** **slippy point simplify radial** *threshold* *point-list*
: This command takes a path of points (as a single list), simplifies the path using the *Radial Distance* algorithm and returns the simplified path as list of points.

    In essence the algorithm keeps only the first of adjacent points nearer to that first point than the threshold, and drops the others.

**::map** **slippy point simplify rdp** *point-list*
: This command takes a patch of points (as a single list), simplifies it using the *non-parametric* *Ramer-Douglas-Peucker* algorithm and returns the simplified path as list of points.

**::map** **slippy pretty-distance** *x*
: This methods formats the distance *x* (in meters) for display and returns the resulting string (including the chosen unit).

    Sub-kilometer distances are limited to 2 decimals, i.e. centimeters, whereas Kilometers are limited to 3 decimals, i.e. meters.

**::map** **slippy tiles** *level*
: This command returns the width/height of a slippy-based map at the specified zoom *level*, in *tiles*.

**::map** **slippy tile size**
: This command returns the width/height of a tile in a slippy-based map, in pixels.

**::map** **slippy tile valid** *zoom* *row* *column* *levels* ?*msgvar*?
: This command checks if the tile described by *zoom*, *row*, and *column* is valid for a slippy-based map having that many zoom *levels*, or not. The result is a boolean value, **true** if the tile is valid, and **false** otherwise. In the latter case a message is left in the variable named by *msgvar*, should it be specified.

**::map** **slippy valid latitude** *x*
: This commands tests if the argument *x* is a valid latitude value, and returns the boolean result of that test. I.e. **true** if the value is valid, and **false** else.

**::map** **slippy valid longitude** *x*
: This commands tests if the argument *x* is a valid longitude value, and returns the boolean result of that test. I.e. **true** if the value is valid, and **false** else.


# References

1. <http://wiki.openstreetmap.org/wiki/Main_Page>
