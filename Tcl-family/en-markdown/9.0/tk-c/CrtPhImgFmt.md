---
CommandName: Tk_CreatePhotoImageFormat
title: Tk_CreatePhotoImageFormat
ManualSection: 3
Version: 9.0
TclPart: Tk
TclDescription: Tk Library Procedures
Links:
 - Tk_FindPhoto
 - Tk_PhotoPutBlock
Keywords:
 - photo image
 - image file
Copyright:
 - Copyright (c) 1994 The Australian National University
 - Copyright (c) 1994-1997 Sun Microsystems, Inc.
---

# Name

Tk\_CreatePhotoImageFormat - define new file format for photo images

# Synopsis

::: {.synopsis} :::
**#include <tk.h>**
[Tk\_CreatePhotoImageFormatVersion3]{.ccmd version="9.0"} [formatVersion3Ptr]{.cargs}
[Tk\_CreatePhotoImageFormat]{.ccmd} [formatPtr]{.cargs}
:::

# Arguments

::: {.arguments} :::

[\*formatVersion3Ptr]{.carg .in type="const Tk_PhotoImageFormatVersion3"}
: Structure that defines the new file format including metadata functionality.

[\*formatPtr]{.carg .in type="const Tk_PhotoImageFormat"}
: Structure that defines the new file format.

:::

# Description

**Tk\_CreatePhotoImageFormatVersion3** is invoked to define a new file format for image data for use with photo images.  The code that implements an image file format is called an image file format handler, or handler for short.  The photo image code maintains a list of handlers that can be used to read and write data to or from a file.  Some handlers may also support reading image data from a string or converting image data to a string format. The user can specify which handler to use with the **-format** image configuration option or the **-format** option to the [read] and **write** photo image subcommands.

The alternate version 2 function **Tk\_CreatePhotoImageFormat** has identical functionality, but does not allow the handler to get or return the metadata dictionary of the image. It is described in section [Version 2 interface] below.

An image file format handler consists of a collection of procedures plus a **Tk\_PhotoImageFormatVersion3** structure, which contains the name of the image file format and pointers to six procedures provided by the handler to deal with files and strings in this format.  The Tk\_PhotoImageFormatVersion3 structure contains the following fields:

```
typedef struct {
    const char *name;
    Tk_ImageFileMatchProcVersion3 *fileMatchProc;
    Tk_ImageStringMatchProcVersion3 *stringMatchProc;
    Tk_ImageFileReadProcVersion3 *fileReadProc;
    Tk_ImageStringReadProcVersion3 *stringReadProc;
    Tk_ImageFileWriteProcVersion3 *fileWriteProc;
    Tk_ImageStringWriteProcVersion3 *stringWriteProc;
} Tk_PhotoImageFormatVersion3;
```

The handler need not provide implementations of all six procedures. For example, the procedures that handle string data would not be provided for a format in which the image data are stored in binary, and could therefore contain null characters.  If any procedure is not implemented, the corresponding pointer in the Tk\_PhotoImageFormat structure should be set to NULL.  The handler must provide the *fileMatchProc* procedure if it provides the *fileReadProc* procedure, and the *stringMatchProc* procedure if it provides the *stringReadProc* procedure.

## Name

*formatPtr->name* provides a name for the image type. Once **Tk\_CreatePhotoImageFormatVersion3** returns, this name may be used in the **-format** photo image configuration and subcommand option. The manual page for the photo image (photo(n)) describes how image file formats are chosen based on their names and the value given to the **-format** option. The first character of *formatPtr->name* must not be an uppercase character from the ASCII character set (that is, one of the characters **A**-**Z**).  Such names are used only for legacy interface support (see below).

## fileMatchProc

*formatPtr->fileMatchProc* provides the address of a procedure for Tk to call when it is searching for an image file format handler suitable for reading data in a given file. *formatPtr->fileMatchProc* must match the following prototype:

```
typedef int Tk_ImageFileMatchProcVersion3(
        Tcl_Interp *interp,
        Tcl_Channel chan,
        const char *fileName,
        Tcl_Obj *format,
        Tcl_Obj *metadataIn,
        int *widthPtr,
        int *heightPtr,
        Tcl_Obj *metadataOut);
```

The *fileName* argument is the name of the file containing the image data, which is open for reading as *chan*.  The *format* argument contains the value given for the **-format** option, or NULL if the option was not specified. **metadataIn** and **metadataOut** inputs and returns a metadata dictionary as described in section [Metadata interface] below. If the data in the file appears to be in the format supported by this handler, the *formatPtr->fileMatchProc* procedure should store the width and height of the image in \**widthPtr* and \**heightPtr* respectively, and return 1.  Otherwise it should return 0.

## stringMatchProc

*formatPtr->stringMatchProc* provides the address of a procedure for Tk to call when it is searching for an image file format handler suitable for reading data from a given string. *formatPtr->stringMatchProc* must match the following prototype:

```
typedef int Tk_ImageStringMatchProcVersion3(
        Tcl_Interp *interp,
        Tcl_Obj *data,
        Tcl_Obj *format,
        Tcl_Obj *metadataIn,
        int *widthPtr,
        int *heightPtr,
        Tcl_Obj *metadataOut);
```

The *data* argument points to the object containing the image data.  The *format* argument contains the value given for the **-format** option, or NULL if the option was not specified. **metadataIn** and **metadataOut** inputs and returns a metadata dictionary as described in section [Metadata interface] below. If the data in the string appears to be in the format supported by this handler, the *formatPtr->stringMatchProc* procedure should store the width and height of the image in \**widthPtr* and \**heightPtr* respectively, and return 1.  Otherwise it should return 0.

## fileReadProc

*formatPtr->fileReadProc* provides the address of a procedure for Tk to call to read data from an image file into a photo image. *formatPtr->fileReadProc* must match the following prototype:

```
typedef int Tk_ImageFileReadProcVersion3(
        Tcl_Interp *interp,
        Tcl_Channel chan,
        const char *fileName,
        Tcl_Obj *format,
        Tcl_Obj *metadataIn,
        PhotoHandle imageHandle,
        int destX, int destY,
        int width, int height,
        int srcX, int srcY,
        Tcl_Obj *metadataOut);
```

The *interp* argument is the interpreter in which the command was invoked to read the image; it should be used for reporting errors. The image data is in the file named *fileName*, which is open for reading as *chan*.  The *format* argument contains the value given for the **-format** option, or NULL if the option was not specified.  The image data in the file, or a subimage of it, is to be read into the photo image identified by the handle *imageHandle*.  The subimage of the data in the file is of dimensions *width* x *height* and has its top-left corner at coordinates (*srcX*,*srcY*).  It is to be stored in the photo image with its top-left corner at coordinates (*destX*,*destY*) using the [Tk\_PhotoPutBlock][FindPhoto] procedure. **metadataIn** and **metadataOut** inputs and returns a metadata dictionary as described in section [Metadata interface] below. The return value is a standard Tcl return value.

## stringReadProc

*formatPtr->stringReadProc* provides the address of a procedure for Tk to call to read data from a string into a photo image. *formatPtr->stringReadProc* must match the following prototype:

```
typedef int Tk_ImageStringReadProcVersion3(
        Tcl_Interp *interp,
        Tcl_Obj *data,
        Tcl_Obj *format,
        Tcl_Obj *metadataIn,
        PhotoHandle imageHandle,
        int destX, int destY,
        int width, int height,
        int srcX, int srcY,
        Tcl_Obj *metadataOut);
```

The *interp* argument is the interpreter in which the command was invoked to read the image; it should be used for reporting errors. The *data* argument points to the image data in object form. The *format* argument contains the value given for the **-format** option, or NULL if the option was not specified.  The image data in the string, or a subimage of it, is to be read into the photo image identified by the handle *imageHandle*.  The subimage of the data in the string is of dimensions *width* x *height* and has its top-left corner at coordinates (*srcX*,*srcY*).  It is to be stored in the photo image with its top-left corner at coordinates (*destX*,*destY*) using the [Tk\_PhotoPutBlock][FindPhoto] procedure. **metadataIn** and **metadataOut** inputs and returns a metadata dictionary as described in section [Metadata interface] below. The return value is a standard Tcl return value.

## fileWriteProc

*formatPtr->fileWriteProc* provides the address of a procedure for Tk to call to write data from a photo image to a file. *formatPtr->fileWriteProc* must match the following prototype:

```
typedef int Tk_ImageFileWriteProcVersion3(
        Tcl_Interp *interp,
        const char *fileName,
        Tcl_Obj *format,
        Tcl_Obj *metadataIn,
        Tk_PhotoImageBlock *blockPtr);
```

The *interp* argument is the interpreter in which the command was invoked to write the image; it should be used for reporting errors. The image data to be written are in memory and are described by the Tk\_PhotoImageBlock structure pointed to by *blockPtr*; see the manual page FindPhoto(3) for details.  The *fileName* argument points to the string giving the name of the file in which to write the image data.  The *format* argument contains the value given for the **-format** option, or NULL if the option was not specified.  The format string can contain extra characters after the name of the format.  If appropriate, the *formatPtr->fileWriteProc* procedure may interpret these characters to specify further details about the image file. **metadataIn** may contain metadata keys that a driver may include into the output data. The return value is a standard Tcl return value.

## stringWriteProc

*formatPtr->stringWriteProc* provides the address of a procedure for Tk to call to translate image data from a photo image into a string. *formatPtr->stringWriteProc* must match the following prototype:

```
typedef int Tk_ImageStringWriteProcVersion3(
        Tcl_Interp *interp,
        Tcl_Obj *format,
        Tcl_Obj *metadataIn,
        Tk_PhotoImageBlock *blockPtr);
```

The *interp* argument is the interpreter in which the command was invoked to convert the image; it should be used for reporting errors. The image data to be converted are in memory and are described by the Tk\_PhotoImageBlock structure pointed to by *blockPtr*; see the manual page FindPhoto(3) for details.  The data for the string should be put in the interpreter *interp* result. The *format* argument contains the value given for the **-format** option, or NULL if the option was not specified.  The format string can contain extra characters after the name of the format.  If appropriate, the *formatPtr->stringWriteProc* procedure may interpret these characters to specify further details about the image file. **metadataIn** may contain metadata keys that a driver may include into the output data. The return value is a standard Tcl return value.

# Metadata interface

Image formats contain a description of the image bitmap and may contain additional information like image resolution or comments. Image metadata may be read from image files and passed to the script level by including dictionary keys into the metadata property of the image. Image metadata may be written to image data on file write or image data output.

## Metadata keys

The metadata may contain any key. A driver will handle only a set of dictionary keys documented in the documentation. See the photo image manual page for currently defined keys for the system drivers.

The following rules may give guidance to name metadata keys:

- Abbreviations are in upper case.

- Words are in US English in small case (except proper nouns)

- Vertical DPI is expressed as DPI/aspect. The reason is, that some image formats may feature aspect and no resolution value.


## Metadata input

Each driver function gets a Tcl object pointer **metadataIn** as parameter. This parameter serves to input a metadata dict to the driver function. It may be NULL to flag that the metadata dict is empty.

A typical driver code snipped to check for a metadata key is:

```
if (NULL != metadataIn) {
    Tcl_Obj *itemData;
    Tcl_DictObjGet(interp, metadataIn, Tcl_NewStringObj("Comment",-1),
            &itemData));
    // use value reference in itemData
}
```

The **-metadata** command option data of the following commands is passed to the driver: [image create][image], **configure**, **put**, **read**, **data** and **write**. If no **-metadata** command option available or not given, the metadata property of the image is passed to the driver using the following commands: **cget**, **configure**, **data** and **write**.

Note that setting the **-metadata** property of an image using **configure** without any other option does not invoke any driver function.

The metadata dictionary is not suited to pass options to the driver related to the bitmap representation, as the image bitmap is not recreated on a metadata change. The format string should be used for this purpose.

## Metadata output

The image match and read driver functions may set keys in a prepared metadata dict to return them. Those functions get a Tcl object pointer *metadataOut* as parameter. *metadataOut* may be NULL to indicate, that no metadata return is required (**put**, [read] subcommands). The variable pointed to by *metadataOut* is initialized to an empty unshared dict object if metadata return is attended ([image create][image] command, **configure** subcommand). The driver may set dict keys in this object to return metadata. If a match function succeeds, the metadataOut pointer is passed to the corresponding read function.

A sample driver code snippet is:

```
if (NULL != metadataOut) {
    Tcl_DictObjPut(NULL, metadataOut, Tcl_NewStringObj("XMP",-1),
            Tcl_NewStringObj(xmpMetadata));
}
```

The metadata keys returned by the driver are merged into the present metadata property of the image or into the metadata dict given by the **-metadata** command line option. At the script level, the command [image create][image] and the **configure** method may return metadata from the driver.

Format string options or metadata keys may influence the creation of metadata within the driver. For example, the creation of an expensive metadata key may depend on a format string option or on a metadata input key.

# Version 2 interface

Version 2 Interface does not include the possibility for the driver to use the metadata dict for input or output.

## Synopsis

**#include <tk.h>** **Tk\_CreatePhotoImageFormat**(*formatPtr*)

## Arguments

[\*formatPtr]{.carg .in type="const Tk_PhotoImageFormat"}
: Structure that defines the new file format.


## Description

A driver using the version 2 interface invokes **Tk\_CreatePhotoImageFormat** for driver registration. The Tk\_PhotoImageFormat structure contains the following fields:

```
typedef struct {
    const char *name;
    Tk_ImageFileMatchProc *fileMatchProc;
    Tk_ImageStringMatchProc *stringMatchProc;
    Tk_ImageFileReadProc *fileReadProc;
    Tk_ImageStringReadProc *stringReadProc;
    Tk_ImageFileWriteProc *fileWriteProc;
    Tk_ImageStringWriteProc *stringWriteProc;
} Tk_PhotoImageFormat;
```

## fileMatchProc

*formatPtr->fileMatchProc* must match the following prototype:

```
typedef int Tk_ImageFileMatchProc(
        Tcl_Channel chan,
        const char *fileName,
        Tcl_Obj *format,
        int *widthPtr,
        int *heightPtr,
        Tcl_Interp *interp);
```

## stringMatchProc

*formatPtr->stringMatchProc* must match the following prototype:

```
typedef int Tk_ImageStringMatchProc(
        Tcl_Obj *data,
        Tcl_Obj *format,
        int *widthPtr,
        int *heightPtr,
        Tcl_Interp *interp);
```

## fileReadProc

*formatPtr->fileReadProc* must match the following prototype:

```
typedef int Tk_ImageFileReadProc(
        Tcl_Interp *interp,
        Tcl_Channel chan,
        const char *fileName,
        Tcl_Obj *format,
        PhotoHandle imageHandle,
        int destX, int destY,
        int width, int height,
        int srcX, int srcY);
```

## stringReadProc

*formatPtr->stringReadProc* must match the following prototype:

```
typedef int Tk_ImageStringReadProc(
        Tcl_Interp *interp,
        Tcl_Obj *data,
        Tcl_Obj *format,
        PhotoHandle imageHandle,
        int destX, int destY,
        int width, int height,
        int srcX, int srcY);
```

## fileWriteProc

*formatPtr->fileWriteProc* must match the following prototype:

```
typedef int Tk_ImageFileWriteProc(
        Tcl_Interp *interp,
        const char *fileName,
        Tcl_Obj *format,
        Tk_PhotoImageBlock *blockPtr);
```

## stringWriteProc

*formatPtr->stringWriteProc* must match the following prototype:

```
typedef int Tk_ImageStringWriteProc(
        Tcl_Interp *interp,
        Tcl_Obj *format,
        Tk_PhotoImageBlock *blockPtr);
```


[FindPhoto]: FindPhoto.md
[image]: ../tk/image.md
[read]: ../tcl/read.md
