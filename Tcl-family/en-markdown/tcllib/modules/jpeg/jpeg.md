---
CommandName: jpeg
title: jpeg
ManualSection: n
Version: 0.7
TclPart: tcllib
TclDescription: JPEG image manipulation
Keywords:
 - comment
 - exif
 - image
 - jfif
 - jpeg
 - thumbnail
Copyright:
 - "Copyright (c) 2004-2005, Code: Aaron Faupell <afaupell@users.sourceforge.net>"
 - "Copyright (c) 2007, Code: Andreas Kupries <andreas_kupries@users.sourceforge.net>"
 - "Copyright (c) 2004-2009, Doc: Andreas Kupries <andreas_kupries@users.sourceforge.net>"
 - "Copyright (c) 2011, Code: Pat Thoyts <patthoyts@users.sourceforge.net>"
---

# Name

jpeg - JPEG querying and manipulation of meta data

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [jpeg]{.lit} [0.7]{.optlit}
[::jpeg::isJPEG]{.cmd} [file]{.arg}
[::jpeg::imageInfo]{.cmd} [file]{.arg}
[::jpeg::dimensions]{.cmd} [file]{.arg}
[::jpeg::getThumbnail]{.cmd} [file]{.arg}
[::jpeg::getExif]{.cmd} [file]{.arg} [section]{.optarg}
[::jpeg::getExifFromChannel]{.cmd} [channel]{.arg} [section]{.optarg}
[::jpeg::formatExif]{.cmd} [keys]{.arg}
[::jpeg::exifKeys]{.cmd}
[::jpeg::removeExif]{.cmd} [file]{.arg}
[::jpeg::stripJPEG]{.cmd} [file]{.arg}
[::jpeg::getComments]{.cmd} [file]{.arg}
[::jpeg::addComment]{.cmd} [file]{.arg} [text...]{.arg}
[::jpeg::removeComments]{.cmd} [file]{.arg}
[::jpeg::replaceComment]{.cmd} [file]{.arg} [text]{.arg}
[::jpeg::debug]{.cmd} [file]{.arg}
[::jpeg::markers]{.cmd} [channel]{.arg}
:::

# Description

This package provides commands to query and modify JPEG images. JPEG stands for *Joint Photography Experts Group* and is a standard for the lossy compression of photographical images. It is specified at *LINK\_HERE*.

# Commands

**::jpeg::isJPEG** *file*
: Returns a boolean value indicating if *file* is a JPEG image.

**::jpeg::imageInfo** *file*
: Returns a dictionary with keys **version**, **units**, **xdensity**, **ydensity**, **xthumb**, and **ythumb**. The values are the associated properties of the JPEG image in *file*. Throws an error if *file* is not a JPEG image.

**::jpeg::dimensions** *file*
: Returns the dimensions of the JPEG *file* as a list of the horizontal and vertical pixel count. Throws an error if *file* is not a JPEG image.

**::jpeg::getThumbnail** *file*
: This procedure will return the binary thumbnail image data, if a JPEG thumbnail is included in *file*, and the empty string otherwise. Note that it is possible to include thumbnails in formats other than JPEG although that is not common. The command finds thumbnails that are encoded in either the JFXX or EXIF segments of the JPEG information. If both are present the EXIF thumbnail will take precedence. Throws an error if *file* is not a JPEG image.

    ```
        set fh [open thumbnail.jpg w+]
        fconfigure $fh -translation binary -encoding binary
        puts -nonewline $fh [::jpeg::getThumbnail photo.jpg]
        close $fh
    ```

**::jpeg::getExif** *file* ?*section*?
: *section* must be one of **main** or **thumbnail**. The default is **main**. Returns a dictionary containing the EXIF information for the specified section. For example:

    ```
        set exif {
    	Make     Canon
    	Model    {Canon DIGITAL IXUS}
    	DateTime {2001:06:09 15:17:32}
        }
    ```

    Throws an error if *file* is not a JPEG image.

**::jpeg::getExifFromChannel** *channel* ?*section*?
: This command is as per **::jpeg::getExif** except that it uses a previously opened channel.  *channel* should be a seekable channel and *section* is as described in the documentation of **::jpeg::getExif**.

    *Note*: The jpeg parser expects that the start of the channel is the start of the image data. If working with an image embedded in a container file format it may be necessary to read the jpeg data into a temporary container: either a temporary file or a memory channel.

    *Attention*: It is the resonsibility of the caller to close the channel after its use.

**::jpeg::formatExif** *keys*
: Takes a list of key-value pairs as returned by **getExif** and formats many of the values into a more human readable form. As few as one key-value may be passed in, the entire exif is not required.

    ```
        foreach {key val} [::jpeg::formatExif [::jpeg::getExif photo.jpg]] {
            puts "$key: $val"
        }
    ```

    ```
        array set exif [::jpeg::getExif photo.jpg]
        puts "max f-stop: [::jpeg::formatExif [list MaxAperture $exif(MaxAperture)]]
    ```

**::jpeg::exifKeys**
: Returns a list of the EXIF keys which are currently understood. There may be keys present in **getExif** data that are not understood. Those keys will appear in a 4 digit hexadecimal format.

**::jpeg::removeExif** *file*
: Removes the Exif data segment from the specified file and replaces it with a standard JFIF segment. Throws an error if *file* is not a JPEG image.

**::jpeg::stripJPEG** *file*
: Removes all metadata from the JPEG file leaving only the image. This includes comments, EXIF segments, JFXX segments, and application specific segments. Throws an error if *file* is not a JPEG image.

**::jpeg::getComments** *file*
: Returns a list containing all the JPEG comments found in the *file*. Throws an error if *file* is not a valid JPEG image.

**::jpeg::addComment** *file* *text*...
: Adds one or more plain *text* comments to the JPEG image in *file*. Throws an error if *file* is not a valid JPEG image.

**::jpeg::removeComments** *file*
: Removes all comments from the file specified. Throws an error if *file* is not a valid JPEG image.

**::jpeg::replaceComment** *file* *text*
: Replaces the first comment in the file with the new *text*. This is merely a shortcut for **::jpeg::removeComments** and **::jpeg::addComment** Throws an error if *file* is not a valid JPEG image.

**::jpeg::debug** *file*
: Prints everything we know about the given file in a nice format.

**::jpeg::markers** *channel*
: This is an internal helper command, we document it for use by advanced users of the package. The argument *channel* is an open file handle positioned at the start of the first marker (usually 2 bytes). The command returns a list with one element for each JFIF marker found in the file. Each element consists of a list of the marker name, its offset in the file, and its length. The offset points to the beginning of the sections data, not the marker itself.  The length is the length of the data from the offset listed to the start of the next marker.


# Limitations

can only work with files cant write exif data gps exif data not parsed makernote data not yet implemented

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *jpeg* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

File formats

# Copyright

```
Copyright (c) 2004-2005, Code: Aaron Faupell <afaupell@users.sourceforge.net>
Copyright (c) 2007, Code:  Andreas Kupries <andreas_kupries@users.sourceforge.net>
Copyright (c) 2004-2009, Doc:  Andreas Kupries <andreas_kupries@users.sourceforge.net>
Copyright (c) 2011, Code: Pat Thoyts <patthoyts@users.sourceforge.net>
```
