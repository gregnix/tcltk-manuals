---
CommandName: bitmap-editor
title: bitmap-editor
ManualSection: n
Version: 1.0
TclPart: tklib
TclDescription: Bitmap handling
Keywords:
 - bitmap
 - editor
 - image
 - pixel
 - xbm
Copyright:
 - Copyright (c)
---

# Name

bitmap-editor - Editor for XBM images

# Synopsis

::: {.synopsis} :::
[bitmap-editor]{.cmd} [xbmfile]{.optarg}
:::

# Description

The application described by this document, **bitmap-editor**, is a simple editor for XBM based bitmap images. Written by Keith Vetter the original code can be found at <http://wiki.tcl-lang.org/6298>.

## Command line

**bitmap-editor** ?*xbmfile*?
: Invoked without argument the editor GUI will be opened and show a standard bitmap to edit. Invoked with an argument it is expected to be the path to a bitmap file in XBM format, and the contained bitmap is shown.

    path *xbmfile* (in/out)
    : This argument specifies the path to a bitmap file in XBM format, whose contents is to shown and edited by the application.



# Bugs, ideas, feedback

This document, and the application it describes, will undoubtedly contain bugs and other problems. Please report such in the category *bitmap* of the [Tcllib SF Trackers](http://sourceforge.net/tracker/?group_id=12883). Please also report any ideas for enhancements you may have for either application and/or documentation.

# Bugs, ideas, feedback

This document, and the package it describes, will undoubtedly contain bugs and other problems. Please report such in the category *bitmap-editor* of the [Tklib Trackers](http://core.tcl-lang.org/tklib/reportlist). Please also report any ideas for enhancements you may have for either package and/or documentation.

# Category

Image processing

# Copyright

```
Copyright (c)
```
