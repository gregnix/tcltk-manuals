---
CommandName: crosshair
title: crosshair
ManualSection: n
Version: 1.2.1
TclPart: tklib
TclDescription: Crosshairs
Keywords:
 - canvas
 - cross-hairs
 - location
 - tracking
 - viewport
Copyright:
 - Copyright (c) 2003 Kevin Kenny
 - Copyright (c) 2008 (docs) Andreas Kupries <andreas_kupries@users.sourceforge.net>
 - Copyright (c) 2013 Frank Gover, Andreas Kupries
---

# Name

crosshair - Crosshairs for Tk canvas

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.4]{.optlit}
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.4]{.optlit}
[package]{.cmd} [require]{.sub} [crosshair]{.lit} [1.2.1]{.optlit}
[crosshair::crosshair]{.cmd} [w]{.arg} [arg...]{.optarg}
[crosshair::off]{.cmd} [w]{.arg}
[crosshair::configure]{.cmd} [w]{.arg} [arg...]{.optarg}
[crosshair::track]{.cmd} [on]{.lit} [w]{.arg} [cmdprefix]{.arg}
[crosshair::track]{.cmd} [off]{.lit} [w]{.arg}
[crosshair::bbox\_add]{.cmd} [w]{.arg} [bbox]{.arg}
[crosshair::bbox\_remove]{.cmd} [token]{.arg}
:::

# Description

The **crosshair** package provides commands to (de)activate and track crosshairs on canvas widgets.

# API

The following commands are exported to the public:

**crosshair::crosshair** *w* ?*arg*...?
: This command activates the display of a pair of cross-hairs for the canvas widget *w*. The cross-hairs track the pointing device. The result of the command is the empty string.

    All arguments after the widget *w* are treated as options as for a canvas line item in *w*. Of particular interest are **-fill** and **-dash**.

**crosshair::off** *w*
: This command removes the cross-hairs from the canvas widget *w*. Nothing is done if the widget had no cross-hairs. The result of the command is the empty string.

**crosshair::configure** *w* ?*arg*...?
: This command changes the appearance of the cross-hairs in the canvas widget *w*. It is an error to call it for a canvas which has no cross-hairs.

    All arguments after the widget *w* are treated as options as for a canvas line item in *w*. Of particular interest are **-fill** and **-dash**.

    The result of the command are the current configuration settings.

**crosshair::track** **on** *w* *cmdprefix*
: This command activates reporting of the location of the cross-hairs in the canvas widget *w*. It is an error to use this command for a canvas which has no cross-hairs. The result of the command is the empty string.

    After the invokation of this command the specified command prefix *cmdprefix* will be called whenever the mouse moves within the canvas, with 7 arguments. These are, in order:

    1. The widget *w*

    2. The x-location of the cross-hairs, in pixels.

    3. The y-location of the cross-hairs, in pixels.

    4. The x-location of the top-left corner of the viewport, in pixels.

    5. The y-location of the top-left corner of the viewport, in pixels.

    6. The x-location of the bottom-right corner of the viewport, in pixels.

    7. The y-location of the bottom-right corner of the viewport, in pixels.


    A previously existing callback for *w* will be disabled. I.e. per canvas widget with cross-hairs only one callback reporting their location is possible.

**crosshair::track** **off** *w*
: This command disables the reporting of the location of the cross-hairs in the canvas widget *w*. It is an error to use this command for a canvas which has no cross-hairs. The result of the command is the empty string.

**crosshair::bbox\_add** *w* *bbox*
: This command adds a bounding box to the crosshairs for canvas *w*. The crosshairs will only be active within that area.

    The result of the command is a token with which the bounding box can be removed again, see **crosshair::bbox\_remove** below.

    The bounding box *bbox* is specified thorugh a list of 4 values, the lower left and upper right corners of the box. The order of values in the list is:

    ```
    llx lly urx ury
    ```

    Note that this command can be used multiple times, each call adding one more bounding box. In such a case the visible area is the *union* of all the specified bounding boxes.

**crosshair::bbox\_remove** *token*
: This command removes the bounding box specified by the *token* (a result of **crosshair::bbox\_add**) from the crosshairs for its canvas widget.


# Bugs, ideas, feedback

This document, and the package it describes, will undoubtedly contain bugs and other problems. Please report such in the category *tklib :: crosshair* of the [Tcllib SF Trackers](http://sourceforge.net/tracker/?group_id=12883). Please also report any ideas for enhancements you may have for either package and/or documentation.

# Bugs, ideas, feedback

This document, and the package it describes, will undoubtedly contain bugs and other problems. Please report such in the category *crosshair* of the [Tklib Trackers](http://core.tcl-lang.org/tklib/reportlist). Please also report any ideas for enhancements you may have for either package and/or documentation.

# Copyright

```
Copyright (c) 2003 Kevin Kenny
Copyright (c) 2008 (docs) Andreas Kupries <andreas_kupries@users.sourceforge.net>
Copyright (c) 2013 Frank Gover, Andreas Kupries
```
