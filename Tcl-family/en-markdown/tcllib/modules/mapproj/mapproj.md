---
CommandName: mapproj
title: mapproj
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: Tcl Library
Keywords:
 - geodesy
 - map
 - projection
Copyright:
 - Copyright (c) 2007 Kevin B. Kenny <kennykb@acm.org>
---

# Name

mapproj - Map projection routines

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5 9]{.optlit}
[package]{.cmd} [require]{.sub} [math::interpolate]{.lit} [1.1]{.optlit}
[package]{.cmd} [require]{.sub} [math::special]{.lit} [0.2.2]{.optlit}
[package]{.cmd} [require]{.sub} [mapproj]{.lit} [1.1]{.optlit}
[::mapproj::toPlateCarree]{.cmd} [lambda\_0]{.arg} [phi\_0]{.arg} [lambda]{.arg} [phi]{.arg}
[::mapproj::fromPlateCarree]{.cmd} [lambda\_0]{.arg} [phi\_0]{.arg} [x]{.arg} [y]{.arg}
[::mapproj::toCylindricalEqualArea]{.cmd} [lambda\_0]{.arg} [phi\_0]{.arg} [lambda]{.arg} [phi]{.arg}
[::mapproj::fromCylindricalEqualArea]{.cmd} [lambda\_0]{.arg} [phi\_0]{.arg} [x]{.arg} [y]{.arg}
[::mapproj::toMercator]{.cmd} [lambda\_0]{.arg} [phi\_0]{.arg} [lambda]{.arg} [phi]{.arg}
[::mapproj::fromMercator]{.cmd} [lambda\_0]{.arg} [phi\_0]{.arg} [x]{.arg} [y]{.arg}
[::mapproj::toMillerCylindrical]{.cmd} [lambda\_0]{.arg} [lambda]{.arg} [phi]{.arg}
[::mapproj::fromMillerCylindrical]{.cmd} [lambda\_0]{.arg} [x]{.arg} [y]{.arg}
[::mapproj::toSinusoidal]{.cmd} [lambda\_0]{.arg} [phi\_0]{.arg} [lambda]{.arg} [phi]{.arg}
[::mapproj::fromSinusoidal]{.cmd} [lambda\_0]{.arg} [phi\_0]{.arg} [x]{.arg} [y]{.arg}
[::mapproj::toMollweide]{.cmd} [lambda\_0]{.arg} [lambda]{.arg} [phi]{.arg}
[::mapproj::fromMollweide]{.cmd} [lambda\_0]{.arg} [x]{.arg} [y]{.arg}
[::mapproj::toEckertIV]{.cmd} [lambda\_0]{.arg} [lambda]{.arg} [phi]{.arg}
[::mapproj::fromEckertIV]{.cmd} [lambda\_0]{.arg} [x]{.arg} [y]{.arg}
[::mapproj::toEckertVI]{.cmd} [lambda\_0]{.arg} [lambda]{.arg} [phi]{.arg}
[::mapproj::fromEckertVI]{.cmd} [lambda\_0]{.arg} [x]{.arg} [y]{.arg}
[::mapproj::toRobinson]{.cmd} [lambda\_0]{.arg} [lambda]{.arg} [phi]{.arg}
[::mapproj::fromRobinson]{.cmd} [lambda\_0]{.arg} [x]{.arg} [y]{.arg}
[::mapproj::toCassini]{.cmd} [lambda\_0]{.arg} [phi\_0]{.arg} [lambda]{.arg} [phi]{.arg}
[::mapproj::fromCassini]{.cmd} [lambda\_0]{.arg} [phi\_0]{.arg} [x]{.arg} [y]{.arg}
[::mapproj::toPeirceQuincuncial]{.cmd} [lambda\_0]{.arg} [lambda]{.arg} [phi]{.arg}
[::mapproj::fromPeirceQuincuncial]{.cmd} [lambda\_0]{.arg} [x]{.arg} [y]{.arg}
[::mapproj::toOrthographic]{.cmd} [lambda\_0]{.arg} [phi\_0]{.arg} [lambda]{.arg} [phi]{.arg}
[::mapproj::fromOrthographic]{.cmd} [lambda\_0]{.arg} [phi\_0]{.arg} [x]{.arg} [y]{.arg}
[::mapproj::toStereographic]{.cmd} [lambda\_0]{.arg} [phi\_0]{.arg} [lambda]{.arg} [phi]{.arg}
[::mapproj::fromStereographic]{.cmd} [lambda\_0]{.arg} [phi\_0]{.arg} [x]{.arg} [y]{.arg}
[::mapproj::toGnomonic]{.cmd} [lambda\_0]{.arg} [phi\_0]{.arg} [lambda]{.arg} [phi]{.arg}
[::mapproj::fromGnomonic]{.cmd} [lambda\_0]{.arg} [phi\_0]{.arg} [x]{.arg} [y]{.arg}
[::mapproj::toAzimuthalEquidistant]{.cmd} [lambda\_0]{.arg} [phi\_0]{.arg} [lambda]{.arg} [phi]{.arg}
[::mapproj::fromAzimuthalEquidistant]{.cmd} [lambda\_0]{.arg} [phi\_0]{.arg} [x]{.arg} [y]{.arg}
[::mapproj::toLambertAzimuthalEqualArea]{.cmd} [lambda\_0]{.arg} [phi\_0]{.arg} [lambda]{.arg} [phi]{.arg}
[::mapproj::fromLambertAzimuthalEqualArea]{.cmd} [lambda\_0]{.arg} [phi\_0]{.arg} [x]{.arg} [y]{.arg}
[::mapproj::toHammer]{.cmd} [lambda\_0]{.arg} [lambda]{.arg} [phi]{.arg}
[::mapproj::fromHammer]{.cmd} [lambda\_0]{.arg} [x]{.arg} [y]{.arg}
[::mapproj::toConicEquidistant]{.cmd} [lambda\_0]{.arg} [phi\_0]{.arg} [phi\_1]{.arg} [phi\_2]{.arg} [lambda]{.arg} [phi]{.arg}
[::mapproj::fromConicEquidistant]{.cmd} [lambda\_0]{.arg} [phi\_0]{.arg} [phi\_1]{.arg} [phi\_2]{.arg} [x]{.arg} [y]{.arg}
[::mapproj::toAlbersEqualAreaConic]{.cmd} [lambda\_0]{.arg} [phi\_0]{.arg} [phi\_1]{.arg} [phi\_2]{.arg} [lambda]{.arg} [phi]{.arg}
[::mapproj::fromAlbersEqualAreaConic]{.cmd} [lambda\_0]{.arg} [phi\_0]{.arg} [phi\_1]{.arg} [phi\_2]{.arg} [x]{.arg} [y]{.arg}
[::mapproj::toLambertConformalConic]{.cmd} [lambda\_0]{.arg} [phi\_0]{.arg} [phi\_1]{.arg} [phi\_2]{.arg} [lambda]{.arg} [phi]{.arg}
[::mapproj::fromLambertConformalConic]{.cmd} [lambda\_0]{.arg} [phi\_0]{.arg} [phi\_1]{.arg} [phi\_2]{.arg} [x]{.arg} [y]{.arg}
[::mapproj::toLambertCylindricalEqualArea]{.cmd} [lambda\_0]{.arg} [phi\_0]{.arg} [lambda]{.arg} [phi]{.arg}
[::mapproj::fromLambertCylindricalEqualArea]{.cmd} [lambda\_0]{.arg} [phi\_0]{.arg} [x]{.arg} [y]{.arg}
[::mapproj::toBehrmann]{.cmd} [lambda\_0]{.arg} [phi\_0]{.arg} [lambda]{.arg} [phi]{.arg}
[::mapproj::fromBehrmann]{.cmd} [lambda\_0]{.arg} [phi\_0]{.arg} [x]{.arg} [y]{.arg}
[::mapproj::toTrystanEdwards]{.cmd} [lambda\_0]{.arg} [phi\_0]{.arg} [lambda]{.arg} [phi]{.arg}
[::mapproj::fromTrystanEdwards]{.cmd} [lambda\_0]{.arg} [phi\_0]{.arg} [x]{.arg} [y]{.arg}
[::mapproj::toHoboDyer]{.cmd} [lambda\_0]{.arg} [phi\_0]{.arg} [lambda]{.arg} [phi]{.arg}
[::mapproj::fromHoboDyer]{.cmd} [lambda\_0]{.arg} [phi\_0]{.arg} [x]{.arg} [y]{.arg}
[::mapproj::toGallPeters]{.cmd} [lambda\_0]{.arg} [phi\_0]{.arg} [lambda]{.arg} [phi]{.arg}
[::mapproj::fromGallPeters]{.cmd} [lambda\_0]{.arg} [phi\_0]{.arg} [x]{.arg} [y]{.arg}
[::mapproj::toBalthasart]{.cmd} [lambda\_0]{.arg} [phi\_0]{.arg} [lambda]{.arg} [phi]{.arg}
[::mapproj::fromBalthasart]{.cmd} [lambda\_0]{.arg} [phi\_0]{.arg} [x]{.arg} [y]{.arg}
:::

# Description

The **mapproj** package provides a set of procedures for converting between world co-ordinates (latitude and longitude) and map co-ordinates on a number of different map projections.

# Commands

The following commands convert between world co-ordinates and map co-ordinates:

**::mapproj::toPlateCarree** *lambda\_0* *phi\_0* *lambda* *phi*
: Converts to the *plate carrée* (cylindrical equidistant) projection.

**::mapproj::fromPlateCarree** *lambda\_0* *phi\_0* *x* *y*
: Converts from the *plate carrée* (cylindrical equidistant) projection.

**::mapproj::toCylindricalEqualArea** *lambda\_0* *phi\_0* *lambda* *phi*
: Converts to the cylindrical equal-area projection.

**::mapproj::fromCylindricalEqualArea** *lambda\_0* *phi\_0* *x* *y*
: Converts from the cylindrical equal-area projection.

**::mapproj::toMercator** *lambda\_0* *phi\_0* *lambda* *phi*
: Converts to the Mercator (cylindrical conformal) projection.

**::mapproj::fromMercator** *lambda\_0* *phi\_0* *x* *y*
: Converts from the Mercator (cylindrical conformal) projection.

**::mapproj::toMillerCylindrical** *lambda\_0* *lambda* *phi*
: Converts to the Miller Cylindrical projection.

**::mapproj::fromMillerCylindrical** *lambda\_0* *x* *y*
: Converts from the Miller Cylindrical projection.

**::mapproj::toSinusoidal** *lambda\_0* *phi\_0* *lambda* *phi*
: Converts to the sinusoidal (Sanson-Flamsteed) projection. projection.

**::mapproj::fromSinusoidal** *lambda\_0* *phi\_0* *x* *y*
: Converts from the sinusoidal (Sanson-Flamsteed) projection. projection.

**::mapproj::toMollweide** *lambda\_0* *lambda* *phi*
: Converts to the Mollweide projection.

**::mapproj::fromMollweide** *lambda\_0* *x* *y*
: Converts from the Mollweide projection.

**::mapproj::toEckertIV** *lambda\_0* *lambda* *phi*
: Converts to the Eckert IV projection.

**::mapproj::fromEckertIV** *lambda\_0* *x* *y*
: Converts from the Eckert IV projection.

**::mapproj::toEckertVI** *lambda\_0* *lambda* *phi*
: Converts to the Eckert VI projection.

**::mapproj::fromEckertVI** *lambda\_0* *x* *y*
: Converts from the Eckert VI projection.

**::mapproj::toRobinson** *lambda\_0* *lambda* *phi*
: Converts to the Robinson projection.

**::mapproj::fromRobinson** *lambda\_0* *x* *y*
: Converts from the Robinson projection.

**::mapproj::toCassini** *lambda\_0* *phi\_0* *lambda* *phi*
: Converts to the Cassini (transverse cylindrical equidistant) projection.

**::mapproj::fromCassini** *lambda\_0* *phi\_0* *x* *y*
: Converts from the Cassini (transverse cylindrical equidistant) projection.

**::mapproj::toPeirceQuincuncial** *lambda\_0* *lambda* *phi*
: Converts to the Peirce Quincuncial Projection.

**::mapproj::fromPeirceQuincuncial** *lambda\_0* *x* *y*
: Converts from the Peirce Quincuncial Projection.

**::mapproj::toOrthographic** *lambda\_0* *phi\_0* *lambda* *phi*
: Converts to the orthographic projection.

**::mapproj::fromOrthographic** *lambda\_0* *phi\_0* *x* *y*
: Converts from the orthographic projection.

**::mapproj::toStereographic** *lambda\_0* *phi\_0* *lambda* *phi*
: Converts to the stereographic (azimuthal conformal) projection.

**::mapproj::fromStereographic** *lambda\_0* *phi\_0* *x* *y*
: Converts from the stereographic (azimuthal conformal) projection.

**::mapproj::toGnomonic** *lambda\_0* *phi\_0* *lambda* *phi*
: Converts to the gnomonic projection.

**::mapproj::fromGnomonic** *lambda\_0* *phi\_0* *x* *y*
: Converts from the gnomonic projection.

**::mapproj::toAzimuthalEquidistant** *lambda\_0* *phi\_0* *lambda* *phi*
: Converts to the azimuthal equidistant projection.

**::mapproj::fromAzimuthalEquidistant** *lambda\_0* *phi\_0* *x* *y*
: Converts from the azimuthal equidistant projection.

**::mapproj::toLambertAzimuthalEqualArea** *lambda\_0* *phi\_0* *lambda* *phi*
: Converts to the Lambert azimuthal equal-area projection.

**::mapproj::fromLambertAzimuthalEqualArea** *lambda\_0* *phi\_0* *x* *y*
: Converts from the Lambert azimuthal equal-area projection.

**::mapproj::toHammer** *lambda\_0* *lambda* *phi*
: Converts to the Hammer projection.

**::mapproj::fromHammer** *lambda\_0* *x* *y*
: Converts from the Hammer projection.

**::mapproj::toConicEquidistant** *lambda\_0* *phi\_0* *phi\_1* *phi\_2* *lambda* *phi*
: Converts to the conic equidistant projection.

**::mapproj::fromConicEquidistant** *lambda\_0* *phi\_0* *phi\_1* *phi\_2* *x* *y*
: Converts from the conic equidistant projection.

**::mapproj::toAlbersEqualAreaConic** *lambda\_0* *phi\_0* *phi\_1* *phi\_2* *lambda* *phi*
: Converts to the Albers equal-area conic projection.

**::mapproj::fromAlbersEqualAreaConic** *lambda\_0* *phi\_0* *phi\_1* *phi\_2* *x* *y*
: Converts from the Albers equal-area conic projection.

**::mapproj::toLambertConformalConic** *lambda\_0* *phi\_0* *phi\_1* *phi\_2* *lambda* *phi*
: Converts to the Lambert conformal conic projection.

**::mapproj::fromLambertConformalConic** *lambda\_0* *phi\_0* *phi\_1* *phi\_2* *x* *y*
: Converts from the Lambert conformal conic projection.


Among the cylindrical equal-area projections, there are a number of choices of standard parallels that have names:

**::mapproj::toLambertCylindricalEqualArea** *lambda\_0* *phi\_0* *lambda* *phi*
: Converts to the Lambert cylindrical equal area projection. (standard parallel is the Equator.)

**::mapproj::fromLambertCylindricalEqualArea** *lambda\_0* *phi\_0* *x* *y*
: Converts from the Lambert cylindrical equal area projection. (standard parallel is the Equator.)

**::mapproj::toBehrmann** *lambda\_0* *phi\_0* *lambda* *phi*
: Converts to the Behrmann cylindrical equal area projection. (standard parallels are 30 degrees North and South)

**::mapproj::fromBehrmann** *lambda\_0* *phi\_0* *x* *y*
: Converts from the Behrmann cylindrical equal area projection. (standard parallels are 30 degrees North and South.)

**::mapproj::toTrystanEdwards** *lambda\_0* *phi\_0* *lambda* *phi*
: Converts to the Trystan Edwards cylindrical equal area projection. (standard parallels are 37.4 degrees North and South)

**::mapproj::fromTrystanEdwards** *lambda\_0* *phi\_0* *x* *y*
: Converts from the Trystan Edwards cylindrical equal area projection. (standard parallels are 37.4 degrees North and South.)

**::mapproj::toHoboDyer** *lambda\_0* *phi\_0* *lambda* *phi*
: Converts to the Hobo-Dyer cylindrical equal area projection. (standard parallels are 37.5 degrees North and South)

**::mapproj::fromHoboDyer** *lambda\_0* *phi\_0* *x* *y*
: Converts from the Hobo-Dyer cylindrical equal area projection. (standard parallels are 37.5 degrees North and South.)

**::mapproj::toGallPeters** *lambda\_0* *phi\_0* *lambda* *phi*
: Converts to the Gall-Peters cylindrical equal area projection. (standard parallels are 45 degrees North and South)

**::mapproj::fromGallPeters** *lambda\_0* *phi\_0* *x* *y*
: Converts from the Gall-Peters cylindrical equal area projection. (standard parallels are 45 degrees North and South.)

**::mapproj::toBalthasart** *lambda\_0* *phi\_0* *lambda* *phi*
: Converts to the Balthasart cylindrical equal area projection. (standard parallels are 50 degrees North and South)

**::mapproj::fromBalthasart** *lambda\_0* *phi\_0* *x* *y*
: Converts from the Balthasart cylindrical equal area projection. (standard parallels are 50 degrees North and South.)


# Arguments

The following arguments are accepted by the projection commands:

*lambda*
: Longitude of the point to be projected, in degrees.

*phi*
: Latitude of the point to be projected, in degrees.

*lambda\_0*
: Longitude of the center of the sheet, in degrees.  For many projections, this figure is also the reference meridian of the projection.

*phi\_0*
: Latitude of the center of the sheet, in degrees.  For the azimuthal projections, this figure is also the latitude of the center of the projection.

*phi\_1*
: Latitude of the first reference parallel, for projections that use reference parallels.

*phi\_2*
: Latitude of the second reference parallel, for projections that use reference parallels.

*x*
: X co-ordinate of a point on the map, in units of Earth radii.

*y*
: Y co-ordinate of a point on the map, in units of Earth radii.


# Results

For all of the procedures whose names begin with 'to', the return value is a list comprising an *x* co-ordinate and a *y* co-ordinate. The co-ordinates are relative to the center of the map sheet to be drawn, measured in Earth radii at the reference location on the map. For all of the functions whose names begin with 'from', the return value is a list comprising the longitude and latitude, in degrees.

# Choosing a projection

This package offers a great many projections, because no single projection is appropriate to all maps.  This section attempts to provide guidance on how to choose a projection.

First, consider the type of data that you intend to display on the map. If the data are *directional* (*e.g.,* winds, ocean currents, or magnetic fields) then you need to use a projection that preserves angles; these are known as *conformal* projections.  Conformal projections include the Mercator, the Albers azimuthal equal-area, the stereographic, and the Peirce Quincuncial projection.  If the data are *thematic*, describing properties of land or water, such as temperature, population density, land use, or demographics; then you need a projection that will show these data with the areas on the map proportional to the areas in real life.  These so-called *equal area* projections include the various cylindrical equal area projections, the sinusoidal projection, the Lambert azimuthal equal-area projection, the Albers equal-area conic projection, and several of the world-map projections (Miller Cylindrical, Mollweide, Eckert IV, Eckert VI, Robinson, and Hammer). If the significant factor in your data is distance from a central point or line (such as air routes), then you will do best with an *equidistant* projection such as *plate carrée*, Cassini, azimuthal equidistant, or conic equidistant.  If direction from a central point is a critical factor in your data (for instance, air routes, radio antenna pointing), then you will almost surely want to use one of the azimuthal projections. Appropriate choices are azimuthal equidistant, azimuthal equal-area, stereographic, and perhaps orthographic.

Next, consider how much of the Earth your map will cover, and the general shape of the area of interest.  For maps of the entire Earth, the cylindrical equal area, Eckert IV and VI, Mollweide, Robinson, and Hammer projections are good overall choices.  The Mercator projection is traditional, but the extreme distortions of area at high latitudes make it a poor choice unless a conformal projection is required. The Peirce projection is a better choice of conformal projection, having less distortion of landforms.  The Miller Cylindrical is a compromise designed to give shapes similar to the traditional Mercator, but with less polar stretching. The Peirce Quincuncial projection shows all the continents with acceptable distortion if a reference meridian close to +20 degrees is chosen. The Robinson projection yields attractive maps for things like political divisions, but should be avoided in presenting scientific data, since other projections have moe useful geometric properties.

If the map will cover a hemisphere, then choose stereographic, azimuthal-equidistant, Hammer, or Mollweide projections; these all project the hemisphere into a circle.

If the map will cover a large area (at least a few hundred km on a side), but less than a hemisphere, then you have several choices.  Azimuthal projections are usually good (choose stereographic, azimuthal equidistant, or Lambert azimuthal equal-area according to whether shapes, distances from a central point, or areas are important).  Azimuthal projections (and possibly the Cassini projection) are the only really good choices for mapping the polar regions.

If the large area is in one of the temperate zones and is round or has a primarily east-west extent, then the conic projections are good choices. Choose the Lambert conformal conic, the conic equidistant, or the Albers equal-area conic according to whether shape, distance, or area are the most important parameters.  For any of these, the reference parallels should be chosen at approximately 1/6 and 5/6 of the range of latitudes to be displayed.  For instance, maps of the 48 coterminous United States are attractive with reference parallels of 28.5 and 45.5 degrees.

If the large area is equatorial and is round or has a primarily east-west extent, then the Mercator projection is a good choice for a conformal projection; Lambert cylindrical equal-area and sinusoidal projections are good equal-area projections; and the *plate carrée* is a good equidistant projection.

Large areas having a primarily North-South aspect, particularly those spanning the Equator, need some other choices.  The Cassini projection is a good choice for an equidistant projection (for instance, a Cassini projection with a central meridian of 80 degrees West produces an attractive map of the Americas). The cylindrical equal-area, Albers equal-area conic, sinusoidal, Mollweide and Hammer projections are possible choices for equal-area projections. A good conformal projection in this situation is the Transverse Mercator, which alas, is not yet implemented.

Small areas begin to get into a realm where the ellipticity of the Earth affects the map scale.  This package does not attempt to handle accurate mapping for large-scale topographic maps.  If slight scale errors are acceptable in your application, then any of the projections appropriate to large areas should work for small ones as well.

There are a few projections that are included for their special properties.  The orthographic projection produces views of the Earth as seen from space.  The gnomonic projection produces a map on which all great circles (the shortest distance between two points on the Earth's surface) are rendered as straight lines. While this projection is useful for navigational planning, it has extreme distortions of shape and area, and can display only a limited area of the Earth (substantially less than a hemisphere).

# Copyright

```
Copyright (c) 2007 Kevin B. Kenny <kennykb@acm.org>
```
