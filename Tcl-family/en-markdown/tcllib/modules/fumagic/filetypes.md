---
CommandName: fileutil::magic::filetype
ManualSection: n
Version: 2.0
TclPart: tcllib
TclDescription: file utilities
Links:
 - file(1)
 - fileutil
 - magic(5)
Keywords:
 - file recognition
 - file type
 - file utilities
 - type
Copyright:
---

# Name

fileutil::magic::filetype - Procedures implementing file-type recognition

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [fileutil::magic::filetype]{.lit} [2.0]{.optlit} 
[::fileutil::magic::filetype]{.cmd} [filename]{.arg} 
:::

# Description

This package provides a command for the recognition of file types in pure Tcl.

The core part of the recognizer was generated from a "magic(5)" file containing the checks to perform to recognize files, and associated file-types.

*Beware!* This recognizer is large, about 752 Kilobyte of generated Tcl code.

**::fileutil::magic::filetype** *filename*
: This command is similar to the command **fileutil::fileType**. Returns a list containing a list of descriptions, a list of mimetype components, and a list file extensions.  Returns an empty string if the file content is not recognized.


# References

**\[1\]**
: [File(1) sources](ftp://ftp.astron.com/pub/file/) This site contains the current sources for the file command, including the magic definitions used by it. The latter were used by us to generate this recognizer.


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *fileutil :: magic* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Programming tools
