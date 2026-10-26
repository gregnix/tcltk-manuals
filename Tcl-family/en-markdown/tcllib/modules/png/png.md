---
CommandName: png
title: png
ManualSection: n
Version: 0.4.1
TclPart: tcllib
TclDescription: Image manipulation
Keywords:
 - comment
 - image
 - png
 - timestamp
Copyright:
 - "Copyright (c) 2004, Code: Aaron Faupell <afaupell@users.sourceforge.net>"
 - "Copyright (c) 2004, Doc: Andreas Kupries <andreas_kupries@users.sourceforge.net>"
---

# Name

png - PNG querying and manipulation of meta data

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [crc32]{.lit}
[package]{.cmd} [require]{.sub} [png]{.lit} [0.4.1]{.optlit}
[::png::validate]{.cmd} [file]{.arg}
[::png::isPNG]{.cmd} [file]{.arg}
[::png::imageInfo]{.cmd} [file]{.arg}
[::png::getTimestamp]{.cmd} [file]{.arg}
[::png::setTimestamp]{.cmd} [file]{.arg} [time]{.arg}
[::png::getComments]{.cmd} [file]{.arg}
[::png::removeComments]{.cmd} [file]{.arg}
[::png::addComment]{.cmd} [file]{.arg} [keyword]{.arg} [text]{.arg}
[::png::addComment]{.cmd} [file]{.arg} [keyword]{.arg} [lang]{.arg} [keyword2]{.arg} [text]{.arg}
[::png::getPixelDimension]{.cmd} [file]{.arg}
[::png::image]{.cmd} [file]{.arg}
[::png::write]{.cmd} [file]{.arg} [data]{.arg}
:::

# Description

This package provides commands to query and modify PNG images. PNG stands for *Portable Network Graphics* and is specified at <http://www.libpng.org/pub/png/spec/1.2>.

# Commands

**::png::validate** *file*
: Returns a value indicating if *file* is a valid PNG file. The file is checked for PNG signature, each chunks checksum is verified, existence of a data chunk is verified, first chunk is checked for header, last chunk is checked for ending. Things *not* checked for are: validity of values within a chunk, multiple header chunks, noncontiguous data chunks, end chunk before actual eof. This procedure can take lots of time.

    Possible return values:

    OK
    : File is a valid PNG file.

    SIG
    : no/broken PNG signature.

    BADLEN
    : corrupt chunk length.

    EOF
    : premature end of file.

    NOHDR
    : missing header chunk.

    CKSUM
    : crc mismatch.

    NODATA
    : missing data chunk(s).

    NOEND
    : missing end marker.


**::png::isPNG** *file*
: Returns a boolean value indicating if the file *file* starts with a PNG signature. This is a much faster and less intensive check than **::png::validate** as it does not check if the PNG data is valid.

**::png::imageInfo** *file*
: Returns a dictionary with keys **width**, **height**, **depth**, **color**, **compression**, **filter**, and **interlace**. The values are the associated properties of the PNG image in *file*. Throws an error if file is not a PNG image, or if the checksum of the header is invalid. For information on interpreting the values for the returned properties see <http://www.libpng.org/pub/png/spec/1.2/PNG-Chunks.html>.

**::png::getTimestamp** *file*
: Returns the epoch time if a timestamp chunk is found in the PNG image contained in the *file*, otherwise returns the empty string. Does not attempt to verify the checksum of the timestamp chunk. Throws an error if the *file* is not a valid PNG image.

**::png::setTimestamp** *file* *time*
: Writes a new timestamp to the *file*, either replacing the old timestamp, or adding one just before the data chunks if there was no previous timestamp. *time* is the new time in the gmt epoch format. Throws an error if *file* is not a valid PNG image.

**::png::getComments** *file*
: Currently supports only uncompressed comments. Does not attempt to verify the checksums of the comment chunks. Returns a list where each element is a comment. Each comment is itself a list. The list for a plain text comment consists of 2 elements: the human readable keyword, and the text data. A unicode (international) comment consists of 4 elements: the human readable keyword, the language identifier, the translated keyword, and the unicode text data. Throws an error if *file* is not a valid PNG image.

**::png::removeComments** *file*
: Removes all comments from the PNG image in *file*. Beware - This uses memory equal to the file size minus comments, to hold the intermediate result. Throws an error if *file* is not a valid PNG image.

**::png::addComment** *file* *keyword* *text*
: Adds a plain *text* comment to the PNG image in *file*, just before the first data chunk. Will throw an error if no data chunk is found. *keyword* has to be less than 80 characters long to conform to the PNG specification.

**::png::addComment** *file* *keyword* *lang* *keyword2* *text*
: Adds a unicode (international) comment to the PNG image in *file*, just before the first data chunk. Will throw an error if no data chunk is found. *keyword* has to be less than 80 characters long to conform to the PNG specification. *keyword2* is the translated *keyword*, in the language specified by the language identifier *lang*.

**::png::getPixelDimension** *file*
: Returns a dictionary with keys **ppux**, **ppuy** and **unit** if the information is present.  Otherwise, it returns the empty string.

    The values of **ppux** and **ppuy** return the pixel per unit value in X or Y direction.

    The allowed values for key **unit** are **meter** and **unknown**. In the case of meter, the dpi value can be calculated by multiplying with the conversion factor **0.0254**.

**::png::image** *file*
: Given a PNG file returns the image in the list of scanlines format used by Tk\_GetColor.

**::png::write** *file* *data*
: Takes a list of scanlines in the Tk\_GetColor format and writes the represented image to *file*.


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *png* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

File formats

# Copyright

```
Copyright (c) 2004, Code: Aaron Faupell <afaupell@users.sourceforge.net>
Copyright (c) 2004, Doc:  Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
