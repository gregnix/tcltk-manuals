---
CommandName: Tk_GetImage
title: Tk_GetImage
ManualSection: 3
Version: 4.0
TclPart: Tk
TclDescription: Tk Library Procedures
Links:
 - Tk_CreateImageType
Keywords:
 - images
 - redisplay
Copyright:
 - Copyright (c) 1994 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

Tk\_GetImage, Tk\_RedrawImage, Tk\_SizeOfImage, Tk\_FreeImage - use an image in a widget

# Synopsis

::: {.synopsis} :::
**#include <tk.h>**
[Tk\_Image]{.ret} [Tk\_GetImage]{.ccmd} [interp, tkwin, name, changeProc, clientData]{.cargs}
[Tk\_RedrawImage]{.ccmd} [image, imageX, imageY, width, height, drawable, drawableX, drawableY]{.cargs}
[Tk\_SizeOfImage]{.ccmd} [image, widthPtr, heightPtr]{.cargs}
[Tk\_FreeImage]{.ccmd} [image]{.cargs}
:::

# Arguments

::: {.arguments} :::

[\*interp]{.carg .in type="Tcl_Interp"}
: Place to leave error message.

[tkwin]{.carg .in type="Tk_Window"}
: Window in which image will be used.

[\*name]{.carg .in type="const char"}
: Name of image.

[\*changeProc]{.carg .in type="Tk_ImageChangedProc"}
: Procedure for Tk to invoke whenever image content or size changes.

[\*clientData]{.carg .in type="void"}
: One-word value for Tk to pass to *changeProc*.

[image]{.carg .in type="Tk_Image"}
: Token for image instance;  must have been returned by a previous call to **Tk\_GetImage**.

[imageX]{.carg .in type="int"}
: X-coordinate of upper-left corner of region of image to redisplay (measured in pixels from the image's upper-left corner).

[imageY]{.carg .in type="int"}
: Y-coordinate of upper-left corner of region of image to redisplay (measured in pixels from the image's upper-left corner).

[width]{.carg .(in) type="int"}
: Width of region of image to redisplay.

[height]{.carg .(in) type="int"}
: Height of region of image to redisplay.

[drawable]{.carg .in type="Drawable"}
: Where to display image.  Must either be window specified to **Tk\_GetImage** or a pixmap compatible with that window.

[drawableX]{.carg .in type="int"}
: Where to display image in *drawable*: this is the x-coordinate in *drawable* where x-coordinate *imageX* of the image should be displayed.

[drawableY]{.carg .in type="int"}
: Where to display image in *drawable*: this is the y-coordinate in *drawable* where y-coordinate *imageY* of the image should be displayed.

[widthPtr]{.carg .out type="int"}
: Store width of *image* (in pixels) here.

[heightPtr]{.carg .out type="int"}
: Store height of *image* (in pixels) here.

:::

# Description

These procedures are invoked by widgets that wish to display images. **Tk\_GetImage** is invoked by a widget when it first decides to display an image. *name* gives the name of the desired image and *tkwin* identifies the window where the image will be displayed. **Tk\_GetImage** looks up the image in the table of existing images and returns a token for a new instance of the image. If the image does not exist then **Tk\_GetImage** returns NULL and leaves an error message in interpreter *interp*'s result.

When a widget wishes to actually display an image it must call **Tk\_RedrawImage**, identifying the image (*image*), a region within the image to redisplay (*imageX*, *imageY*, *width*, and *height*), and a place to display the image (*drawable*, *drawableX*, and *drawableY*). Tk will then invoke the appropriate image manager, which will display the requested portion of the image before returning.

A widget can find out the dimensions of an image by calling **Tk\_SizeOfImage**:  the width and height will be stored in the locations given by *widthPtr* and *heightPtr*, respectively.

When a widget is finished with an image (e.g., the widget is being deleted or it is going to use a different image instead of the current one), it must call **Tk\_FreeImage** to release the image instance. The widget should never again use the image token after passing it to **Tk\_FreeImage**. There must be exactly one call to **Tk\_FreeImage** for each call to **Tk\_GetImage**.

If the contents or size of an image changes, then any widgets using the image will need to find out about the changes so that they can redisplay themselves. The *changeProc* and *clientData* arguments to **Tk\_GetImage** are used for this purpose. *changeProc* will be called by Tk whenever a change occurs in the image;  it must match the following prototype:

```
typedef void Tk_ImageChangedProc(
        void *clientData,
        int x,
        int y,
        int width,
        int height,
        int imageWidth,
        int imageHeight);
```

The *clientData* argument to *changeProc* is the same as the *clientData* argument to **Tk\_GetImage**. It is usually a pointer to the widget record for the widget or some other data structure managed by the widget. The arguments *x*, *y*, *width*, and *height* identify a region within the image that must be redisplayed; they are specified in pixels measured from the upper-left corner of the image. The arguments *imageWidth* and *imageHeight* give the image's (new) size.
