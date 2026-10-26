---
CommandName: tiff
title: tiff
ManualSection: n
Version: 0.2.3
TclPart: tcllib
TclDescription: TIFF image manipulation
Keywords:
 - image
 - tif
 - tiff
Copyright:
 - Copyright (c) 2005-2006, Aaron Faupell <afaupell@users.sourceforge.net>
---

# Name

tiff - TIFF reading, writing, and querying and manipulation of meta data

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [tiff]{.lit} [0.2.3]{.optlit}
[::tiff::isTIFF]{.cmd} [file]{.arg}
[::tiff::byteOrder]{.cmd} [file]{.arg}
[::tiff::numImages]{.cmd} [file]{.arg}
[::tiff::dimensions]{.cmd} [file]{.arg} [image]{.optarg}
[::tiff::imageInfo]{.cmd} [file]{.arg} [image]{.optarg}
[::tiff::entries]{.cmd} [file]{.arg} [image]{.optarg}
[::tiff::getEntry]{.cmd} [file]{.arg} [entry]{.arg} [image]{.optarg}
[::tiff::addEntry]{.cmd} [file]{.arg} [entry]{.arg} [image]{.optarg}
[::tiff::deleteEntry]{.cmd} [file]{.arg} [entry]{.arg} [image]{.optarg}
[::tiff::getImage]{.cmd} [file]{.arg} [image]{.optarg}
[::tiff::writeImage]{.cmd} [image]{.arg} [file]{.arg} [entry]{.optarg}
[::tiff::nametotag]{.cmd} [names]{.arg}
[::tiff::tagtoname]{.cmd} [tags]{.arg}
[::tiff::debug]{.cmd} [file]{.arg}
:::

# Description

This package provides commands to query, modify, read, and write TIFF images. TIFF stands for *Tagged Image File Format* and is a standard for lossless storage of photographical images and associated metadata. It is specified at <http://partners.adobe.com/public/developer/tiff/index.html>.

Multiple images may be stored in a single TIFF file. The ?image? options to the functions in this package are for accessing images other than the first. Data in a TIFF image is stored as a series of tags having a numerical value, which are represented in either a 4 digit hexadecimal format or a string name. For a reference on defined tags and their meanings see <http://www.awaresystems.be/imaging/tiff/tifftags.html>

# Commands

**::tiff::isTIFF** *file*
: Returns a boolean value indicating if *file* is a TIFF image.

**::tiff::byteOrder** *file*
: Returns either **big** or **little**. Throws an error if *file* is not a TIFF image.

**::tiff::numImages** *file*
: Returns the number of images in *file*. Throws an error if *file* is not a TIFF image.

**::tiff::dimensions** *file* ?image?
: Returns the dimensions of image number ?image? in *file* as a list of the horizontal and vertical pixel count. Throws an error if *file* is not a TIFF image.

**::tiff::imageInfo** *file* ?image?
: Returns a dictionary with keys **ImageWidth**, **ImageLength**, **BitsPerSample**, **Compression**, **PhotometricInterpretation**, **ImageDescription**, **Orientation**, **XResolution**, **YResolution**, **ResolutionUnit**, **DateTime**, **Artist**, and **HostComputer**. The values are the associated properties of the TIFF ?image? in *file*. Values may be empty if the associated tag is not present in the file.

    ```
        puts [::tiff::imageInfo photo.tif]

        ImageWidth 686 ImageLength 1024 BitsPerSample {8 8 8} Compression 1
        PhotometricInterpretation 2 ImageDescription {} Orientation 1
        XResolution 170.667 YResolution 170.667 ResolutionUnit 2 DateTime {2005:12:28 19:44:45}
        Artist {} HostComputer {}
    ```

    There is nothing special about these tags, this is simply a convience procedure which calls **getEntry** with common entries. Throws an error if *file* is not a TIFF image.

**::tiff::entries** *file* ?image?
: Returns a list of all entries in the given *file* and ?image? in hexadecimal format. Throws an error if *file* is not a TIFF image.

**::tiff::getEntry** *file* *entry* ?image?
: Returns the value of *entry* from image ?image? in the TIFF *file*. *entry* may be a list of multiple entries. If an entry does not exist, an empty string is returned

    ```
        set data [::tiff::getEntry photo.tif {0131 0132}]
        puts "file was written at [lindex $data 0] with software [lindex $data 1]"
    ```

    Throws an error if *file* is not a TIFF image.

**::tiff::addEntry** *file* *entry* ?image?
: Adds the specified entries to the image named by ?image? (default 0), or optionally **all**. *entry* must be a list where each element is a list of tag, type, and value. If a tag already exists, it is overwritten.

    ```
        ::tiff::addEntry photo.tif {{010e 2 "an example photo"} {013b 2 "Aaron F"}}
    ```

    The data types are defined as follows

    **1**
    : BYTE (8 bit unsigned integer)

    **2**
    : ASCII

    **3**
    : SHORT (16 bit unsigned integer)

    **4**
    : LONG (32 bit unsigned integer)

    **5**
    : RATIONAL

    **6**
    : SBYTE (8 bit signed byte)

    **7**
    : UNDEFINED (uninterpreted binary data)

    **8**
    : SSHORT (signed 16 bit integer)

    **9**
    : SLONG (signed 32 bit integer)

    **10**
    : SRATIONAL

    **11**
    : FLOAT (32 bit floating point number)

    **12**
    : DOUBLE (64 bit floating point number)


    Throws an error if *file* is not a TIFF image.

**::tiff::deleteEntry** *file* *entry* ?image?
: Deletes the specified entries from the image named by ?image? (default 0), or optionally **all**. Throws an error if *file* is not a TIFF image.

**::tiff::getImage** *file* ?image?
: Returns the name of a Tk image containing the image at index ?image? from *file* Throws an error if *file* is not a TIFF image, or if image is an unsupported format. Supported formats are uncompressed 24 bit RGB and uncompressed 8 bit palette.

**::tiff::writeImage** *image* *file* ?entry?
: Writes the contents of the Tk image *image* to a tiff file *file*. Files are written in the 24 bit uncompressed format, with big endian byte order. Additional entries to be added to the image may be specified, in the same format as **tiff::addEntry**

**::tiff::nametotag** *names*
: Returns a list with *names* translated from string to 4 digit format. 4 digit names in the input are passed through unchanged. Strings without a defined tag name will throw an error.

**::tiff::tagtoname** *tags*
: Returns a list with *tags* translated from 4 digit to string format. If a tag does not have a defined name it is passed through unchanged.

**::tiff::debug** *file*
: Prints everything we know about the given file in a nice format.


# Variables

The mapping of 4 digit tag names to string names uses the array ::tiff::tiff\_tags. The reverse mapping uses the array ::tiff::tiff\_sgat.

# Limitations

1. Cannot write exif ifd

2. Reading limited to uncompressed 8 bit rgb and 8 bit palletized images

3. Writing limited to uncompressed 8 bit rgb


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *tiff* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

File formats

# Copyright

```
Copyright (c) 2005-2006, Aaron Faupell <afaupell@users.sourceforge.net>
```
