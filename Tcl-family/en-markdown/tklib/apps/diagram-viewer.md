---
CommandName: diagram-viewer
ManualSection: n
Version: 1.0
TclPart: tklib
TclDescription: Documentation toolbox
Keywords:
 - canvas
 - conversion
 - diagram
 - vector
Copyright:
 - Copyright (c) 2010 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

diagram-viewer - Lightweight Diagram Processor

# Synopsis

::: {.synopsis} :::
[diagram-viewer]{.cmd} [show]{.sub} [inputfile...]{.arg} 
[diagram-viewer]{.cmd} [convert]{.sub} [-o]{.lit} [output]{.arg} [format]{.arg} [inputfile...]{.arg} 
:::

# Description

The application described by this document, **diagram-viewer**, is a lightweight processor for tklib diagram files

**diagram-viewer** is based upon the package **diagram**. See it for examples and language reference.

## Use cases

**diagram-viewer** was written with the following two use cases in mind.

**\[1\]**
: Processing and display of one or more diagram files.

**\[2\]**
: Batch conversion of one or more diagram files into raster image files.


## Command line

**diagram-viewer** **show** *inputfile*...
: This is the form for use case \[1\]. The application opens a gui showing the list of input files to the left, allowing the user to choose which of them to render to the canvas on the right.

**diagram-viewer** **convert** **-o** *output* *format* *inputfile*...
: This is the form for use case \[2\]. The application converts the input files into raster image of the specified *format*.


path *output* (in)
: This argument specifies where to write the generated image. It can be the path to a file or directory. If the *output* does not exist then \[file dirname \$output\] has to exist and must be a writable directory. In case of multiple input files the generated image will be written to a file in the directory, and the name of that file will be derived from the *inputfile*, and *format*. In case of a single input file the generated image will be written to the file.

(handle) *format* (in)
: This argument specifies the image format to convert the diagrams into when processing the input. The application recognizes all formats supported by the **Img** package, i.e. for which it can load a package **img::format** (together with **canvas::snap**), and all formats for which it can load a package **canvas::format**. These are (currently) **mvg**, and **pdf**.

path *inputfile* (in)
: This argument specifies the path to the diagram file to process. It has to exist, must be readable, and written in *diagram* format.


# Bugs, ideas, feedback

This document, and the application it describes, will undoubtedly contain bugs and other problems. Please report such in the category *diagram* of the [Tcllib SF Trackers](http://sourceforge.net/tracker/?group_id=12883). Please also report any ideas for enhancements you may have for either application and/or documentation.

# Bugs, ideas, feedback

This document, and the package it describes, will undoubtedly contain bugs and other problems. Please report such in the category *diagram* of the [Tklib Trackers](http://core.tcl-lang.org/tklib/reportlist). Please also report any ideas for enhancements you may have for either package and/or documentation.

# Category

Documentation tools

# Copyright

```
Copyright (c) 2010 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
