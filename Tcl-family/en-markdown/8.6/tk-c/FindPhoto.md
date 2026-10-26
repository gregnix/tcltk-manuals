---
CommandName: Tk_FindPhoto
title: Tk_FindPhoto
ManualSection: 3
Version: 8.0
TclPart: Tk
TclDescription: Tk Library Procedures
Keywords:
 - photo
 - image
Copyright:
 - Copyright (c) 1994 The Australian National University
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

Tk\_FindPhoto, Tk\_PhotoPutBlock, Tk\_PhotoPutZoomedBlock, Tk\_PhotoGetImage, Tk\_PhotoBlank, Tk\_PhotoExpand, Tk\_PhotoGetSize, Tk\_PhotoSetSize - manipulate the image data stored in a photo image.

# Synopsis

::: {.synopsis} :::
**#include <tk.h>**
[Tk\_PhotoHandle]{.ret} [Tk\_FindPhoto]{.ccmd} [interp, imageName]{.cargs}
[int]{.ret} [Tk\_PhotoPutBlock]{.ccmd} [interp, handle, blockPtr, x, y, width, height, compRule]{.cargs}
[int]{.ret} [Tk\_PhotoPutZoomedBlock]{.ccmd} [interp, handle, blockPtr, x, y, width, height, zoomX, zoomY, subsampleX, subsampleY, compRule]{.cargs}
[int]{.ret} [Tk\_PhotoGetImage]{.ccmd} [handle, blockPtr]{.cargs}
[void]{.ret} [Tk\_PhotoBlank]{.ccmd} [handle]{.cargs}
[int]{.ret} [Tk\_PhotoExpand]{.ccmd} [interp, handle, width, height]{.cargs}
[void]{.ret} [Tk\_PhotoGetSize]{.ccmd} [handle, widthPtr, heightPtr]{.cargs}
[int]{.ret} [Tk\_PhotoSetSize]{.ccmd} [interp. handle, width, height]{.cargs}
:::

# Arguments

::: {.arguments} :::

[\*interp]{.carg .in type="Tcl_Interp"}
: Interpreter in which image was created and in which error reporting is to be done.

[\*imageName]{.carg .in type="const char"}
: Name of the photo image.

[handle]{.carg .in type="Tk_PhotoHandle"}
: Opaque handle identifying the photo image to be affected.

[\*blockPtr]{.carg .in type="Tk_PhotoImageBlock"}
: Specifies the address and storage layout of image data.

[x]{.carg .in type="int"}
: Specifies the X coordinate where the top-left corner of the block is to be placed within the image.

[y]{.carg .in type="int"}
: Specifies the Y coordinate where the top-left corner of the block is to be placed within the image.

[width]{.carg .in type="int"}
: Specifies the width of the image area to be affected (for **Tk\_PhotoPutBlock**) or the desired image width (for **Tk\_PhotoExpand** and **Tk\_PhotoSetSize**).

[compRule]{.carg .in type="int"}
: Specifies the compositing rule used when combining transparent pixels in a block of data with a photo image.  Must be one of **TK\_PHOTO\_COMPOSITE\_OVERLAY** (which puts the block of data over the top of the existing photo image, with the previous contents showing through in the transparent bits) or **TK\_PHOTO\_COMPOSITE\_SET** (which discards the existing photo image contents in the rectangle covered by the data block.)

[height]{.carg .in type="int"}
: Specifies the height of the image area to be affected (for **Tk\_PhotoPutBlock**) or the desired image height (for **Tk\_PhotoExpand** and **Tk\_PhotoSetSize**).

[\*widthPtr]{.carg .out type="int"}
: Pointer to location in which to store the image width.

[\*heightPtr]{.carg .out type="int"}
: Pointer to location in which to store the image height.

[subsampleX]{.carg .in type="int"}
: Specifies the subsampling factor in the X direction for input image data.

[subsampleY]{.carg .in type="int"}
: Specifies the subsampling factor in the Y direction for input image data.

[zoomX]{.carg .in type="int"}
: Specifies the zoom factor to be applied in the X direction to pixels being written to the photo image.

[zoomY]{.carg .in type="int"}
: Specifies the zoom factor to be applied in the Y direction to pixels being written to the photo image.

:::

# Description

**Tk\_FindPhoto** returns an opaque handle that is used to identify a particular photo image to the other procedures.  The parameter is the name of the image, that is, the name specified to the **image create photo** command, or assigned by that command if no name was specified. If *imageName* does not exist or is not a photo image, **Tk\_FindPhoto** returns NULL.

**Tk\_PhotoPutBlock** is used to supply blocks of image data to be displayed.  The call affects an area of the image of size *width* x *height* pixels, with its top-left corner at coordinates (*x*,*y*).  All of *width*, *height*, *x*, and *y* must be non-negative. If part of this area lies outside the current bounds of the image, the image will be expanded to include the area, unless the user has specified an explicit image size with the **-width** and/or **-height** widget configuration options (see photo(n)); in that case the area is silently clipped to the image boundaries.

The *block* parameter is a pointer to a **Tk\_PhotoImageBlock** structure, defined as follows:

```
typedef struct {
    unsigned char *pixelPtr;
    int width;
    int height;
    int pitch;
    int pixelSize;
    int offset[4];
} Tk_PhotoImageBlock;
```

The *pixelPtr* field points to the first pixel, that is, the top-left pixel in the block. The *width* and *height* fields specify the dimensions of the block of pixels.  The *pixelSize* field specifies the address difference between two horizontally adjacent pixels.  It should be 4 for RGB and 2 for grayscale image data.  Other values are possible, if the offsets in the *offset* array are adjusted accordingly (e.g. for red, green and blue data stored in different planes).  Using such a layout is strongly discouraged, though. Due to a bug, it might not work correctly if an alpha channel is provided. (see the [Bugs] section below). The *pitch* field specifies the address difference between two vertically adjacent pixels.  The *offset* array contains the offsets from the address of a pixel to the addresses of the bytes containing the red, green, blue and alpha (transparency) components.  If the offsets for red, green and blue are equal, the image is interpreted as grayscale. If they differ, RGB data is assumed. Normally the offsets will be 0, 1, 2, 3 for RGB data and 0, 0, 0, 1 for grayscale.  It is possible to provide image data without an alpha channel by setting the offset for alpha to a negative value and adjusting the *pixelSize* field accordingly. This use is discouraged, though (see the [Bugs] section below).

The *compRule* parameter to **Tk\_PhotoPutBlock** specifies a compositing rule that says what to do with transparent pixels.  The value **TK\_PHOTO\_COMPOSITE\_OVERLAY** says that the previous contents of the photo image should show through, and the value **TK\_PHOTO\_COMPOSITE\_SET** says that the previous contents of the photo image should be completely ignored, and the values from the block be copied directly across.  The behavior in Tk8.3 and earlier was equivalent to having **TK\_PHOTO\_COMPOSITE\_OVERLAY** as a compositing rule.

The value given for the *width* and *height* parameters to **Tk\_PhotoPutBlock** do not have to correspond to the values specified in *block*.  If they are smaller, **Tk\_PhotoPutBlock** extracts a sub-block from the image data supplied.  If they are larger, the data given are replicated (in a tiled fashion) to fill the specified area. These rules operate independently in the horizontal and vertical directions.

**Tk\_PhotoPutBlock** normally returns [TCL\_OK][catch], though if it cannot allocate sufficient memory to hold the resulting image, [TCL\_ERROR][catch] is returned instead and, if the *interp* argument is non-NULL, an error message is placed in the interpreter's result.

**Tk\_PhotoPutZoomedBlock** works like **Tk\_PhotoPutBlock** except that the image can be reduced or enlarged for display.  The *subsampleX* and *subsampleY* parameters allow the size of the image to be reduced by subsampling. **Tk\_PhotoPutZoomedBlock** will use only pixels from the input image whose X coordinates are multiples of *subsampleX*, and whose Y coordinates are multiples of *subsampleY*.  For example, an image of 512x512 pixels can be reduced to 256x256 by setting *subsampleX* and *subsampleY* to 2.

The *zoomX* and *zoomY* parameters allow the image to be enlarged by pixel replication.  Each pixel of the (possibly subsampled) input image will be written to a block *zoomX* pixels wide and *zoomY* pixels high of the displayed image.  Subsampling and zooming can be used together for special effects.

**Tk\_PhotoGetImage** can be used to retrieve image data from a photo image.  **Tk\_PhotoGetImage** fills in the structure pointed to by the *blockPtr* parameter with values that describe the address and layout of the image data that the photo image has stored internally.  The values are valid until the image is destroyed or its size is changed.

It is possible to modify an image by writing directly to the data the *pixelPtr* field points to. The size of the image cannot be changed this way, though. Also, changes made by writing directly to *pixelPtr* will not be immediately visible, but only after a call to [Tk\_ImageChanged][ImgChanged] or after an event that causes the interested widgets to redraw themselves. For these reasons usually it is preferable to make changes to a copy of the image data and write it back with **Tk\_PhotoPutBlock** or **Tk\_PhotoPutZoomedBlock**.

**Tk\_PhotoGetImage** returns 1 for compatibility with the corresponding procedure in the old photo widget.

**Tk\_PhotoBlank** blanks the entire area of the photo image.  Blank areas of a photo image are transparent.

**Tk\_PhotoExpand** requests that the widget's image be expanded to be at least *width* x *height* pixels in size.  The width and/or height are unchanged if the user has specified an explicit image width or height with the **-width** and/or **-height** configuration options, respectively. If the image data are being supplied in many small blocks, it is more efficient to use **Tk\_PhotoExpand** or **Tk\_PhotoSetSize** at the beginning rather than allowing the image to expand in many small increments as image blocks are supplied.

**Tk\_PhotoExpand** normally returns [TCL\_OK][catch], though if it cannot allocate sufficient memory to hold the resulting image, [TCL\_ERROR][catch] is returned instead and, if the *interp* argument is non-NULL, an error message is placed in the interpreter's result.

**Tk\_PhotoSetSize** specifies the size of the image, as if the user had specified the given *width* and *height* values to the **-width** and **-height** configuration options.  A value of zero for *width* or *height* does not change the image's width or height, but allows the width or height to be changed by subsequent calls to **Tk\_PhotoPutBlock**, **Tk\_PhotoPutZoomedBlock** or **Tk\_PhotoExpand**.

**Tk\_PhotoSetSize** normally returns [TCL\_OK][catch], though if it cannot allocate sufficient memory to hold the resulting image, [TCL\_ERROR][catch] is returned instead and, if the *interp* argument is non-NULL, an error message is placed in the interpreter's result.

**Tk\_PhotoGetSize** returns the dimensions of the image in \**widthPtr* and \**heightPtr*.

# Portability

In Tk 8.3 and earlier, **Tk\_PhotoPutBlock** and **Tk\_PhotoPutZoomedBlock** had different signatures. If you want to compile code that uses the old interface against 8.4 without updating your code, compile it with the flag -DUSE\_COMPOSITELESS\_PHOTO\_PUT\_BLOCK.  Code linked using Stubs against older versions of Tk will continue to work.

In Tk 8.4, **Tk\_PhotoPutBlock**, **Tk\_PhotoPutZoomedBlock**, **Tk\_PhotoExpand** and **Tk\_PhotoSetSize** did not take an *interp* argument or return any result code.  If insufficient memory was available for an image, Tk would panic.  This behaviour is still supported if you compile your extension with the additional flag -DUSE\_PANIC\_ON\_PHOTO\_ALLOC\_FAILURE.  Code linked using Stubs against older versions of Tk will continue to work.

# Bugs

The **Tk\_PhotoImageBlock** structure used to provide image data to **Tk\_PhotoPutBlock** promises great flexibility in the layout of the data (e.g. separate planes for the red, green, blue and alpha channels).  Unfortunately, the implementation fails to hold this promise.  The problem is that the *pixelSize* field is (incorrectly) used to determine whether the image has an alpha channel. Currently, if the offset for the alpha channel is greater than or equal to *pixelSize*, **tk\_PhotoPutblock** assumes no alpha data is present and makes the image fully opaque.  This means that for layouts where the channels are separate (or any other exotic layout where *pixelSize* has to be smaller than the alpha offset), the alpha channel will not be read correctly.  In order to be on the safe side if this issue will be corrected in a future release, it is strongly recommended you always provide alpha data - even if the image has no transparency - and only use the "standard" layout with a *pixelSize* of 2 for grayscale and 4 for RGB data with *offset*s of 0, 0, 0, 1 or 0, 1, 2, 3 respectively.

# Credits

The code for the photo image type was developed by Paul Mackerras, based on his earlier photo widget code.


[catch]: ../tcl/catch.md
[ImgChanged]: ImgChanged.md
