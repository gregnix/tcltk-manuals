---
CommandName: canvasLabel
title: canvasLabel
ManualSection: n
Version: 6.6
TclPart: tklib
TclDescription: canvasLabel class
Links:
 - pie
 - pieBoxLabeler
 - piePeripheralLabeler
Keywords:
 - canvas
 - labeler
 - pie
 - slice
Copyright:
 - Copyright (c) 1995-2004 Jean-Luc Fontaine <jfontain@free.fr>
---

# Name

canvasLabel - tkpiechart canvas label class

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [stooop]{.lit} [4.1]{.lit}
[package]{.cmd} [require]{.sub} [switched]{.lit} [2.2]{.lit}
[package]{.cmd} [require]{.sub} [tkpiechart]{.lit} [6.6]{.lit}
[stooop::new]{.cmd} [canvasLabel]{.lit} [canvas]{.arg} [options]{.optarg}
[switched::configure]{.cmd} [canvasLabelObject]{.arg} [options]{.optarg}
[switched::cget]{.cmd} [canvasLabelObject]{.arg} [option]{.arg}
[stooop::delete]{.cmd} [canvasLabelObject]{.arg}
:::

# Description

The canvasLabel class brings some Tk label widget functionality to the canvas text item, such as a background and a border.

The canvasLabel is built with a bullet rectangle on the left side of the text. The relief changes according to the select state, with a traditionally sunken relief when selected.

The label has a specific tag, which can be used to retrieve the coordinates of the object or move it, thanks to the canvas facilities.

**stooop::new** **canvasLabel** *canvas* ?options?
: Creates a canvasLabel object in the specified Tk canvas. The canvasLabel object identifier is returned (referred to as *canvasLabelObject* in this document).

**switched::configure** *canvasLabelObject* ?options?
: Configures a canvasLabel object or returns all the options with their current values if no options are passed as parameters.

**switched::cget** *canvasLabelObject* *option*
: Returns an option value for the specified canvasLabel object.

**stooop::delete** *canvasLabelObject*
: Deletes the specified canvasLabel object.


# Options

**-anchor** value
: Specifies the anchor position of the rectangle and the text, relative to the positioning point. The behavior is similar to the **-anchor** option of the **canvas** *text* item, except that the rectangle is taken into account. The default is *center*.

**-background** color
: Specifies the background color of the bullet rectangle, as in the **-fill** option of the **canvas** *rectangle* item. The default is transparent (empty string).

**-bordercolor** color
: Specifies the border color of the rectangle, as in the **-outline** option of the **canvas** *rectangle* item. The default is black.

**-borderwidth** value
: Specifies the border width of the rectangle, as in the **-width** option of the **canvas** *rectangle* item. By default, the width is 1 pixel, which is the minimum width.

**-bulletwidth** value
: Specifies the width of the rectangle placed to the left of the text. Defaults to *10*.

**-font** value
: Specifies the font of the text, as in the **-font** option of the **canvas** *text* item. The default is system dependent.

**-foreground** color
: Specifies the color of the text, as in the **-fill** option of the **canvas** *text* item. The default is black.

**-justify** value
: Specifies how to justify the text, as in the **-justify** option of the **canvas** *text* item. The default is *left*.

**-minimumwidth** value
: The total label width will not go below the specified value, but may be larger if the label text requires it.

**-padding** value
: Specifies how much space to leave between the text and the closest rectangle edge. Units are identical to those specified in the **canvas** *COORDINATES* manual section.

**-scale** list
: List of 2 floating point numbers used to set the scaling factor in the x and y axis. Scaling is applied immediately and defaults to 1.

**-select** boolean
: Sets the label state.

**-selectrelief** value
: Either *flat*, *raised* or *sunken*. Specifies the 3D effect desired for the text area when the label is selected.

**-stipple** bitmap
: Specifies the stipple pattern filling the rectangle, as in the **-stipple** option of the **canvas** *rectangle* item. There is no bitmap by default.

**-text** text
: Specifies the string to be displayed in the text area, as in the **-text** option of the **canvas** *text* item. The default is an empty string.

**-textbackground** color
: Specifies the color of the text area background.

**-width** value
: Specifies a maximum line length for the text, as in the **-width** option of the **canvas** *text* item. The default is *0*.


# Tags

The labeler has the following specific tag (see the **canvas** manual page *ITEM IDS AND TAGS* section for more information):

- canvasLabel(canvasLabelObject)


# Bugs, ideas, feedback

This document, and the package it describes, will undoubtedly contain bugs and other problems. Please report such in the category *tkpiechart* of the [Tklib Trackers](http://core.tcl-lang.org/tklib/reportlist). Please also report any ideas for enhancements you may have for either package and/or documentation.

# Copyright

```
Copyright (c) 1995-2004 Jean-Luc Fontaine <jfontain@free.fr>
```
