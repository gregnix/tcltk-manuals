---
CommandName: mkdoc
title: mkdoc
ManualSection: n
Version: 0.7.0
TclPart: tcllib
TclDescription: Source code documentation using Markdown
Copyright:
 - Copyright (c) 2019-2022, Detlef Groth <detlef(at)dgroth(dot)de>
---

# Name

mkdoc - Source code documentation extractor/converter application

# Synopsis

::: {.synopsis} :::
[mkdoc]{.cmd} [--help]{.lit}
[mkdoc]{.cmd} [--version]{.lit}
[mkdoc]{.cmd} [--license]{.lit}
[mkdoc]{.cmd} [input]{.arg} [output]{.arg} [[--css]{.lit} [cssfile]{.arg}]{.optarg}
:::

# Description

This document describes **mkdoc**, an application to extract documentation embedded in source code files, be they "*.tcl*", or other.

# Command line

**mkdoc** **--help**
: The application prints a short help to standard output and exits.

**mkdoc** **--version**
: The application prints its version number to standard output and exits.

**mkdoc** **--license**
: The application prints its license to standard output and exits.

**mkdoc** *input* *output* ?**--css** *cssfile*?
: The application reads the *input* file, extracts the embedded documentation, and writes it to the *output* file.

    If the output file is not a "*.md*" file the extracted documentation is converted to HTML before being written.

    When generating and writing HTML the default CSS stylesheet can be overridden by specifying the path to a custom stylesheet via option **--css**.

    If the input file is a "*.md*" file it is expected to contain Markdown as-is, instead of Markdown embedded into code.

    On the other side, when the file is considered code then the documentation is expected to be contained in all lines starting with the marker **#'**. For script languages like Tcl the **#** character of this marker means that the documentation is contained in the so-flagged comments. For other languages the marker and documentation may have to be embedded into multi-line comments.


# Examples

```
    # Create HTML manual for a CPP file using a custom style sheet
    mkdoc sample.cpp sample.html --css manual.css

    # Extract the documentation from code as simple Markdown, ready to be processed
    # further, for example with pandoc, or similar
    mkdoc sample.cpp sample.md

    # Convert a Markdown file to HTML
    mkdoc sample.md sample.html
```

# Bugs, ideas, feedback

This document, and the package it describes, will undoubtedly contain bugs and other problems. Please report such to the author of this package. Please also report any ideas for enhancements you may have for either package and/or documentation.

# Code copyright

BSD License type:

The following terms apply to all files a ssociated with the software unless explicitly disclaimed in individual files.

The authors hereby grant permission to use, copy, modify, distribute, and license this software and its documentation for any purpose, provided that existing copyright notices are retained in all copies and that this notice is included verbatim in any distributions. No written agreement, license, or royalty fee is required for any of the authorized uses.  Modifications to this software may be copyrighted by their authors and need not follow the licensing terms described here, provided that the new terms are clearly indicated on the first page of each file where they apply.

In no event shall the authors or distributors be liable to any party for direct, indirect, special, incidental, or consequential damages arising out of the use of this software, its documentation, or any derivatives thereof, even if the authors have been advised of the possibility of such damage.

The authors and distributors specifically disclaim any warranties, including, but not limited to, the implied warranties of merchantability, fitness for a particular purpose, and non-infringement. This software is provided on an "as is" basis, and the authors and distributors have no obligation to provide maintenance, support, updates, enhancements, or modifications.

*RESTRICTED RIGHTS*: Use, duplication or disclosure by the government is subject to the restrictions as set forth in subparagraph (c) (1) (ii) of the Rights in Technical Data and Computer Software Clause as DFARS 252.227-7013 and FAR 52.227-19.

# Category

Text processing

# Copyright

```
Copyright (c) 2019-2022, Detlef Groth <detlef(at)dgroth(dot)de>
```
