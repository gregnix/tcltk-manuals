---
CommandName: Tk_ImageChanged
title: Tk_ImageChanged
ManualSection: 3
Version: 4.0
TclPart: Tk
TclDescription: Tk Library Procedures
Links:
 - Tk_CreateImageType
Keywords:
 - images
 - redisplay
 - image size changes
Copyright:
 - Copyright (c) 1994 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

Tk\_ImageChanged - notify widgets that image needs to be redrawn

# Synopsis

::: {.synopsis} :::
**#include <tk.h>**
[Tk\_ImageChanged]{.ccmd} [model, x, y, width, height, imageWidth, imageHeight]{.cargs}
:::

# Arguments

::: {.arguments} :::

[model]{.carg .in type="Tk_ImageModel"}
: Token for image, which was passed to image's *createProc* when the image was created.

[x]{.carg .in type="int"}
: X-coordinate of upper-left corner of region that needs redisplay (measured from upper-left corner of image).

[y]{.carg .in type="int"}
: Y-coordinate of upper-left corner of region that needs redisplay (measured from upper-left corner of image).

[width]{.carg .in type="int"}
: Width of region that needs to be redrawn, in pixels.

[height]{.carg .in type="int"}
: Height of region that needs to be redrawn, in pixels.

[imageWidth]{.carg .in type="int"}
: Current width of image, in pixels.

[imageHeight]{.carg .in type="int"}
: Current height of image, in pixels.

:::

# Description

An image manager calls **Tk\_ImageChanged** for an image whenever anything happens that requires the image to be redrawn. As a result of calling **Tk\_ImageChanged**, any widgets using the image are notified so that they can redisplay themselves appropriately. The *model* argument identifies the image, and *x*, *y*, *width*, and *height* specify a rectangular region within the image that needs to be redrawn. *imageWidth* and *imageHeight* specify the image's (new) size.

An image manager should call **Tk\_ImageChanged** during its *createProc* to specify the image's initial size and to force redisplay if there are existing instances for the image. If any of the pixel values in the image should change later on, **Tk\_ImageChanged** should be called again with *x*, *y*, *width*, and *height* values that cover all the pixels that changed. If the size of the image should change, then **Tk\_ImageChanged** must be called to indicate the new size, even if no pixels need to be redisplayed.
