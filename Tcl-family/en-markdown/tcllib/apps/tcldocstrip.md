---
CommandName: tcldocstrip
title: tcldocstrip
ManualSection: n
Version: 1.0
TclPart: tcllib
TclDescription: Textprocessing toolbox
Links:
 - docstrip
Keywords:
 - \.dtx
 - LaTeX
 - conversion
 - docstrip
 - documentation
 - literate programming
 - markup
 - source
Copyright:
 - Copyright (c) 2005 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

tcldocstrip - Tcl-based Docstrip Processor

# Synopsis

::: {.synopsis} :::
[tcldocstrip]{.cmd} [output]{.arg} [options]{.optarg} [input]{.arg} [guards]{.optarg}
[tcldocstrip]{.cmd} [options]{.optarg} [output]{.arg} ([options]{.optarg} [input]{.arg} [guards]{.arg})...
[tcldocstrip]{.cmd} [-guards]{.lit} [input]{.arg}
:::

# Description

The application described by this document, **tcldocstrip**, is a relative of **docstrip**, a simple literate programming tool for LaTeX.

**tcldocstrip** is based upon the package **docstrip**.

## Use cases

**tcldocstrip** was written with the following three use cases in mind.

1. Conversion of a single input file according to the listed guards into the stripped output. This handles the most simple case of a set of guards specifying a single document found in a single input file.

2. Stitching, or the assembly of an output from several sets of guards, in a specific order, and possibly from different files. This is the second common case. One document spread over several inputs, and/or spread over different guard sets.

3. Extraction and listing of all the unique guard expressions and guards used within a document to help a person which did not author the document in question in familiarizing itself with it.


## Command line

**tcldocstrip** *output* ?options? *input* ?*guards*?
: This is the form for use case \[1\]. It converts the *input* file according to the specified *guards* and options. The result is written to the named *output* file. Usage of the string **-** as the name of the output signals that the result should be written to **stdout**. The guards are document-specific and have to be known to the caller. The *options* will be explained later, in section [Options].

    path *output* (in)
    : This argument specifies where to write the generated document. It can be the path to a file or directory, or **-**. The last value causes the application to write the generated documented to **stdout**.

        If the *output* does not exist then \[file dirname $output\] has to exist and must be a writable directory.

    path *inputfile* (in)
    : This argument specifies the path to the file to process. It has to exist, must be readable, and written in *docstrip* format.


**tcldocstrip** ?options? *output* (?options? *input* *guards*)...
: This is the form for use case \[2\]. It differs from the form for use case \[1\] by the possibility of having options before the output file, which apply in general, and specifying more than one inputfile, each with its own set of input specific options and guards.

    It extracts data from the various *input* files, according to the specified *options* and *guards*, and writes the result to the given *output*, in the order of their specification on the command line. Options specified before the output are global settings, whereas the options specified before each input are valid only just for this input file. Unspecified values are taken from the global settings, or defaults. As for form \[1\] using the string **-** as output causes the application to write to stdout. Using the string **.** for an input file signals that the last input file should be used again. This enables the assembly of the output from one input file using multiple and different sets of guards, without having to specify the full name of the file every time.

**tcldocstrip** **-guards** *input*
: This is the form for use case \[3\]. It determines the guards, and unique guard expressions used within the provided *input* document. The found strings are written to stdout, one string per line.


## Options

This section describes all the options available to the user of the application, with the exception of the option **-guards**. This option was described already, in section [Command line].

**-metaprefix** string
: This option is inherited from the command **docstrip::extract** provided by the package **docstrip**.

    It specifies the string by which the '%%' prefix of a metacomment line will be replaced. Defaults to '%%'. For Tcl code this would typically be '#'.

**-onerror** mode
: This option is inherited from the command **docstrip::extract** provided by the package **docstrip**.

    It controls what will be done when a format error in the *text* being processed is detected. The settings are:

    **ignore**
    : Just ignore the error; continue as if nothing happened.

    **puts**
    : Write an error message to **stderr**, then continue processing.

    **throw**
    : Throw an error. **::errorCode** is set to a list whose first element is **DOCSTRIP**, second element is the type of error, and third element is the line number where the error is detected. This is the default.


**-trimlines** bool
: This option is inherited from the command **docstrip::extract** provided by the package **docstrip**.

    Controls whether *spaces* at the end of a line should be trimmed away before the line is processed. Defaults to **true**.

**-preamble** text
: see below ...

**-postamble** text
: see below ...

**-nopreamble**
: see below ...

**-nopostamble**
: The -no\*amble options deactivate file pre- and postambles altogether, whereas the -\*amble options specify the *user* part of the file pre- and postambles. This part can be empty, in that case only the standard parts are shown. This is the default.

    Preambles, when active, are written before the actual content of a generated file. In the same manner postambles are, when active, written after the actual content of a generated file.


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *docstrip* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Documentation tools

# Copyright

```
Copyright (c) 2005 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
