---
CommandName: Tk_ImageChanged
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

Tk_ImageChanged - notify widgets that image needs to be redrawn

# Synopsis

::: {.synopsis} :::
[#include]{.cmd} [\<tk.h>]{.lit}

[Tk_ImageChanged]{.cmd}([model]{.arg}, [x]{.arg}, [y]{.arg}, [width]{.arg}, [height]{.arg}, [imageWidth]{.arg}, [imageHeight]{.arg})
:::

# Arguments

Tk_ImageModel *model* (in)
: Token for image, which was passed to image's *createProc* when the image was created.

int *x* (in)
: X-coordinate of upper-left corner of region that needs redisplay (measured from upper-left corner of image).

int *y* (in)
: Y-coordinate of upper-left corner of region that needs redisplay (measured from upper-left corner of image).

int *width* (in)
: Width of region that needs to be redrawn, in pixels.

int *height* (in)
: Height of region that needs to be redrawn, in pixels.

int *imageWidth* (in)
: Current width of image, in pixels.

int *imageHeight* (in)
: Current height of image, in pixels.


# Description

An image manager calls **Tk_ImageChanged** for an image whenever anything happens that requires the image to be redrawn. As a result of calling **Tk_ImageChanged**, any widgets using the image are notified so that they can redisplay themselves appropriately. The *model* argument identifies the image, and *x*, *y*, *width*, and *height* specify a rectangular region within the image that needs to be redrawn. *imageWidth* and *imageHeight* specify the image's (new) size.

An image manager should call **Tk_ImageChanged** during its *createProc* to specify the image's initial size and to force redisplay if there are existing instances for the image. If any of the pixel values in the image should change later on, **Tk_ImageChanged** should be called again with *x*, *y*, *width*, and *height* values that cover all the pixels that changed. If the size of the image should change, then **Tk_ImageChanged** must be called to indicate the new size, even if no pixels need to be redisplayed.
