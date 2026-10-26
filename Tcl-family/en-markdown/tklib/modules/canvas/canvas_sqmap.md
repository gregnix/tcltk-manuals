---
CommandName: canvas::sqmap
title: canvas::sqmap
ManualSection: n
Version: 0.3.1
TclPart: tklib
TclDescription: Variations on a canvas
Keywords:
 - canvas
 - cell
 - grid
 - image
 - map
 - square map
 - tile
Copyright:
---

# Name

canvas::sqmap - Canvas with map background based on square tiles

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.4]{.lit}
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.4]{.lit}
[package]{.cmd} [require]{.sub} [snit]{.lit}
[package]{.cmd} [require]{.sub} [uevent::onidle]{.lit}
[package]{.cmd} [require]{.sub} [cache::async]{.lit}
[package]{.cmd} [require]{.sub} [canvas::sqmap]{.lit} [0.3.1]{.optlit}
[::canvas::sqmap]{.cmd} [pathName]{.arg} [options]{.optarg}
[canvasName]{.ins} [image]{.sub} [set]{.lit} [cell]{.arg} [image]{.arg}
[canvasName]{.ins} [image]{.sub} [unset]{.lit} [cell]{.arg}
[canvasName]{.ins} [flush]{.sub}
:::

# Description

This package provides an extended canvas widget for the display of maps based on a set of square image tiles. The tiles are the background of the canvas, with all other canvas items added always shown in front of them. The number of tiles shown, tile size, and where to get the images to show are all configurable.

# API

**::canvas::sqmap** *pathName* ?options?
: Creates the canvas *pathName* and configures it. The new widget supports all of the options and methods of a regular canvas, plus the options and methods described below.

    The result of the command is *pathName*.


## Options

**-grid-cell-width**
: The value for this option is a non-negative integer. It specifies the width of the cells the background is made up of.

**-grid-cell-height**
: The value for this option is a non-negative integer. It specifies the height of the cells the background is made up of.

**-grid-cell-command**
: The value for this option is a command prefix. It is invoked whenever the canvas needs the image for a specific cell of the background, with two additional arguments, the id of the cell, and a command prefix to invoke when the image is ready, or known to not exist.

    The id of the cell is a 2-element list containing the row and column number of the cell, in this order. The result command prefix (named "$result" in the example below) has to be invoked with either two or three arguments, i.e.

    ```
        $result set   $cellid $image ; # image is known and ready
        $result unset $cellid        ; # image does not exist
    ```

    This option may be left undefined, i.e. the canvas can operate without it. In that case the only images shown in grid cells are those explicitly set with the method **image set**, see the next section. All other grid cells will simply be empty.

**-viewport-command**
: This option specifies a command prefix to invoke when the viewport of the canvas is changed, to allow users keep track of where in the scroll-region we are at all times. This can be used, for example, to drive derivate displays, or to keep items in view by moving them as the viewport moves.

**-image-on-load**
: The value for this option is an image. If specified the image is shown in a cell while the actual image for that cell is getting loaded through the callback specified by the **-grid-cell-command**.

**-image-on-unset**
: The value for this option is an image. If specified the image is shown in a cell for which the callback specified by the **-grid-cell-command** reported that there is no actual image to be shown.


## Methods

*canvasName* **image set** *cell* *image*
: Invoking this method places the *image* into the specified *cell* of the background. The cell is given as a 2-element list containing row and column number, in this order.

    Note that an image is allowed to be associated with and displayed in multiple cells of the canvas.

*canvasName* **image unset** *cell*
: Invoking this method declares the specified *cell* of the background as empty, an existing image shown by this cell will be forgotten.  The cell is given as a 2-element list containing row and column number, in this order.

*canvasName* **flush**
: Invoking this method forces the canvas to completely reload the images for all cells. Do not use this method if the canvas is operated without a **-grid-cell-command**, as in that case the canvas will simply forget all images without being able to reload them.


# Image ownership

Note that the canvas *does not* take ownership of the images it shows in the background. In other words, when we say that the canvas forgets an image this means only that the association between a grid cell and shown image is broken. The image is *not* deleted. Managing the lifecycle of the images shown by the canvas is responsibility of the user of the canvas.

# Bugs, ideas, feedback

This document, and the package it describes, will undoubtedly contain bugs and other problems. Please report such in the category *canvas* of the [Tklib Trackers](http://core.tcl-lang.org/tklib/reportlist). Please also report any ideas for enhancements you may have for either package and/or documentation.
