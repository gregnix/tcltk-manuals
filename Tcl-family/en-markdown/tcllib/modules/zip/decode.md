---
CommandName: zipfile::decode
ManualSection: n
Version: 0.11.0
TclPart: tcllib
TclDescription: Zip archive handling
Keywords:
 - decompression
 - zip
Copyright:
 - Copyright (c) 2008-2022 Andreas Kupries
---

# Name

zipfile::decode - Access to zip archives

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [fileutil::decode]{.lit} [0.2.1]{.lit} 
[package]{.cmd} [require]{.sub} [Trf]{.lit} 
[package]{.cmd} [require]{.sub} [zlibtcl]{.lit} 
[package]{.cmd} [require]{.sub} [zipfile::decode]{.lit} [0.11.0]{.optlit} 
[::zipfile::decode::archive]{.cmd} 
[::zipfile::decode::close]{.cmd} 
[::zipfile::decode::comment]{.cmd} [adict]{.arg} 
[::zipfile::decode::content]{.cmd} [archive]{.arg} 
[::zipfile::decode::copyfile]{.cmd} [adict]{.arg} [path]{.arg} [dst]{.arg} 
[::zipfile::decode::files]{.cmd} [adict]{.arg} 
[::zipfile::decode::filetime]{.cmd} [adict]{.arg} [path]{.arg} 
[::zipfile::decode::getfile]{.cmd} [zdict]{.arg} [path]{.arg} 
[::zipfile::decode::hasfile]{.cmd} [adict]{.arg} [path]{.arg} 
[::zipfile::decode::filesize]{.cmd} [zdict]{.arg} [path]{.arg} 
[::zipfile::decode::filecomment]{.cmd} [zdict]{.arg} [path]{.arg} 
[::zipfile::decode::iszip]{.cmd} [archive]{.arg} 
[::zipfile::decode::open]{.cmd} [archive]{.arg} 
[::zipfile::decode::unzip]{.cmd} [adict]{.arg} [dstdir]{.arg} 
[::zipfile::decode::unzipfile]{.cmd} [archive]{.arg} [dstdir]{.arg} 
:::

# Description

Note: packages Trf and zlibtcl are not required if TCL 8.6 is available. This package provides commands to decompress and access the contents of zip archives.

# Api

**::zipfile::decode::archive**
: This command decodes the last opened (and not yet closed) zip archive file. The result of the command is a dictionary describing the contents of the archive. The structure of this dictionary is not public. Proper access should be made through the provided accessor commands of this package.

**::zipfile::decode::close**
: This command releases all state associated with the last call of **::zipfile::decode::open**. The result of the command is the empty string.

**::zipfile::decode::comment** *adict*
: This command takes a dictionary describing the currently open zip archive file, as returned by **::zipfile::decode::archive**, and returns the global comment of the archive.

**::zipfile::decode::content** *archive*
: This is a convenience command which decodes the specified zip *archive* file and returns the list of paths found in it as its result.

**::zipfile::decode::copyfile** *adict* *path* *dst*
: This command takes a dictionary describing the currently open zip archive file, as returned by **::zipfile::decode::archive**, and copies the decompressed contents of the file *path* in the archive to the the file *dst*. An error is thrown if the file is not found in the archive.

**::zipfile::decode::files** *adict*
: This command takes a dictionary describing the currently open zip archive file, as returned by **::zipfile::decode::archive**, and returns the list of files found in the archive.

**::zipfile::decode::filetime** *adict* *path*
: This command takes a dictionary describing the currently open zip archive file, as returned by **::zipfile::decode::archive**, and returns the datestamp of the file *path* in the archive.

**::zipfile::decode::getfile** *zdict* *path*
: This command takes a dictionary describing the currently open zip archive file, as returned by **::zipfile::decode::archive**, and returns the decompressed contents of the file *path* in the archive. An error is thrown if the file is not found in the archive.

**::zipfile::decode::hasfile** *adict* *path*
: This command takes a dictionary describing the currently open zip archive file, as returned by **::zipfile::decode::archive**, and check if the specified *path* is found in the archive. The result of the command is a boolean flag, **true** if the path is found, and **false** otherwise.

**::zipfile::decode::filesize** *zdict* *path*
: This command takes a dictionary describing the currently open zip archive file, as returned by **::zipfile::decode::archive**, and returns the decompressed size of the file *path* in the archive. An error is thrown if the file is not found in the archive.

**::zipfile::decode::filecomment** *zdict* *path*
: This command takes a dictionary describing the currently open zip archive file, as returned by **::zipfile::decode::archive**, and returns the per-file comment of the file *path* in the archive. An error is thrown if the file is not found in the archive.

**::zipfile::decode::iszip** *archive*
: This command takes the path of a presumed zip *archive* file and returns a boolean flag as the result of the command telling us if it actually is a zip archive (**true**), or not (**false**).

**::zipfile::decode::open** *archive*
: This command takes the path of a zip *archive* file and prepares it for decoding. The result of the command is the empty string. All important information is stored in global state.  If multiple open calls are made one after the other only the state of the last call is available to the other commands.

**::zipfile::decode::unzip** *adict* *dstdir*
: This command takes a dictionary describing the currently open zip archive file, as returned by **::zipfile::decode::archive**, and unpacks the archive in the given destination directory *dstdir*. The result of the command is the empty string.

**::zipfile::decode::unzipfile** *archive* *dstdir*
: This is a convenience command which unpacks the specified zip *archive* file in the given destination directory *dstdir*. The result of the command is the empty string.


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *zipfile* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

File

# Copyright

```
Copyright (c) 2008-2022 Andreas Kupries
```
