---
CommandName: piePeripheralLabeler
ManualSection: n
Version: 6.6
TclPart: tklib
TclDescription: piePeripheralLabeler class
Links:
 - canvasLabel
 - pie
 - pieBoxLabeler
Keywords:
 - canvas
 - labeler
 - pie
 - slice
Copyright:
 - Copyright (c) 1995-2004 Jean-Luc Fontaine <jfontain@free.fr>
---

# Name

piePeripheralLabeler - tkpiechart pie peripheral style labeler class

# Synopsis

::: {.synopsis} :::
[stooop::new]{.cmd} [piePeripheralLabeler]{.sub} [canvas]{.arg} [options]{.optarg} 
[switched::configure]{.cmd} [piePeripheralLabelerObject]{.arg} [options]{.optarg} 
[switched::cget]{.cmd} [piePeripheralLabelerObject]{.arg} [option]{.arg} 
:::

# Description

The pie peripheral style labeler object is used as a slice label placer for a **pie** object and is passed to the pie constructor via its **-labeler** option (see the **pie** class manual).

The slice description text labels are arranged in 2 columns below the pie graphics, whereas the slice values are placed next to the slice and actually follow the slice as the pie is updated. Each description label text is placed to the right of a rectangle, the background color of which matches its corresponding slice. Each description label is actually a canvasLabel object.

There is no need to delete a **piePeripheralLabeler** object as it is automatically handled by the pie class.

**stooop::new** **piePeripheralLabeler** *canvas* ?options?
: Creates a piePeripheralLabeler object in the specified Tk canvas. The piePeripheralLabeler object identifier is returned (refered to as *piePeripheralLabelerObject* in this document).

**switched::configure** *piePeripheralLabelerObject* ?options?
: Configures a piePeripheralLabeler object or returns all the options with their current values if no options are passed as parameters.

**switched::cget** *piePeripheralLabelerObject* *option*
: Returns an option value for the specified piePeripheralLabeler object.


# Options

**-font** value
: Specifies a font for the slice labels. If not specified, the default font is system dependent.

**-justify** value
: Specifies how to justify labels within their own column. Must be one of *left*, *center* or *right*. Defaults to *left*. For example, if justification is *right*, all column labels right edges are aligned.

**-offset** value
: Specifies the distance between the pie graphics and the closest slice label. This value may be specified in any of the forms described in the **canvas** *COORDINATES* manual section.

**-smallfont**
: Specifies a font for the slice values. It is usually a small font in order to avoid values overlapping when 2 slices are very close to each other. If not specified, the description label font (**-font** option) is used.

**-widestvaluetext**
: Specifies a string of maximum width for slice values (placed around the pie next to the slices), so that enough room is allocated for these value labels when the pie width and height are set. It defaults to 00.0. For example, it could be set to "00.00 %".


# Tags

The labeler has the following specific tag (see the **canvas** manual page *ITEM IDS AND TAGS* section for more information):

**•**
: piePeripheralLabeler(piePeripheralLabelerObject)


# Bugs, ideas, feedback

This document, and the package it describes, will undoubtedly contain bugs and other problems. Please report such in the category *tkpiechart* of the [Tklib Trackers](http://core.tcl-lang.org/tklib/reportlist). Please also report any ideas for enhancements you may have for either package and/or documentation.

# Copyright

```
Copyright (c) 1995-2004 Jean-Luc Fontaine <jfontain@free.fr>
```
