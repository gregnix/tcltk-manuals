---
CommandName: pieBoxLabeler
ManualSection: n
Version: 6.6
TclPart: tklib
TclDescription: pieBoxLabeler class
Links:
 - canvasLabel
 - pie
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

pieBoxLabeler - tkpiechart pie box style labeler class

# Synopsis

::: {.synopsis} :::
[stooop::new]{.cmd} [pieBoxLabeler]{.sub} [canvas]{.arg} [options]{.optarg} 
[switched::configure]{.cmd} [pieBoxLabelerObject]{.arg} [options]{.optarg} 
[switched::cget]{.cmd} [pieBoxLabelerObject]{.arg} [option]{.arg} 
:::

# Description

The pie box style labeler object is used as a slice label placer for a **pie** object and is passed to the pie constructor via its **-labeler** option (see the **pie** class manual).

The labels are arranged in 2 columns below the pie graphics. Each label text is placed to the right of a rectangle, the background color of which matches its corresponding slice. The slice share value is placed to the right of the label text, separated by a semicolon. Each label is actually a canvasLabel object (see the **canvasLabel** class manual for further information).

There is no need to delete a **pieBoxLabeler** object as it is automatically handled by the pie class.

**stooop::new** **pieBoxLabeler** *canvas* ?options?
: Creates a pieBoxLabeler object in the specified Tk canvas. The pieBoxLabeler object identifier is returned (referred to as *pieBoxLabelerObject* in this document).

**switched::configure** *pieBoxLabelerObject* ?options?
: Configures a pieBoxLabeler object or returns all the options with their current values if no options are passed as parameters.

**switched::cget** *pieBoxLabelerObject* *option*
: Returns an option value for the specified pieBoxLabeler object.


# Options

**-font** value
: Specifies a font for the slice labels. If not specified, the default font is system dependent.

**-justify** value
: Specifies how to justify labels within their own column. Must be one of *left*, *center* or *right*. Defaults to *left*. For example, if justification is *right*, all column labels right edges are aligned.

**-offset** value
: Specifies the distance between the pie graphics and the closest slice label. This value may be specified in any of the forms described in the **canvas** *COORDINATES* manual section.


# Tags

The labeler has the following specific tag (see the **canvas** manual page *ITEM IDS AND TAGS* section for more information):

**•**
: pieBoxLabeler(pieBoxLabelerObject)


# Bugs, ideas, feedback

This document, and the package it describes, will undoubtedly contain bugs and other problems. Please report such in the category *tkpiechart* of the [Tklib Trackers](http://core.tcl-lang.org/tklib/reportlist). Please also report any ideas for enhancements you may have for either package and/or documentation.

# Copyright

```
Copyright (c) 1995-2004 Jean-Luc Fontaine <jfontain@free.fr>
```
