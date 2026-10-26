---
CommandName: fileutil::magic::cfront
ManualSection: n
Version: 1.3.3
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
 - mime
 - type
Copyright:
---

# Name

fileutil::magic::cfront - Generator core for compiler of magic(5) files

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [fileutil::magic::cfront]{.lit} [1.3.3]{.optlit} 
[package]{.cmd} [require]{.sub} [fileutil::magic::cgen]{.lit} [1.2.0]{.optlit} 
[package]{.cmd} [require]{.sub} [fileutil::magic::rt]{.lit} [1.2.0]{.optlit} 
[package]{.cmd} [require]{.sub} [struct::list]{.lit} 
[package]{.cmd} [require]{.sub} [fileutil]{.lit} 
[::fileutil::magic::cfront::compile]{.cmd} [path...]{.arg} 
[::fileutil::magic::cfront::generate]{.cmd} [compressed boolean]{.optarg} -- [path...]{.arg} 
[::fileutil::magic::cfront::install]{.cmd} [path...]{.arg} 
:::

# Description

This package provides the frontend of a compiler of magic(5) files into recognizers based on the **fileutil::magic::rt** recognizer runtime package. For the generator backed used by this compiler see the package **fileutil::magic::cgen**.

# Commands

**::fileutil::magic::cfront::compile** *path*...
: This command takes the paths of one or more files and directories and compiles all the files, and the files in all the directories into a single analyzer for all the file types specified in these files.  It returns a list whose first item is a list per-file dictionaries of analyzer scripts and whose second item is a list of analyzer commands. All the files have to be in the format specified by magic(5). The result of the command is a Tcl script containing the generated recognizer.

**::fileutil::magic::cfront::generate** ?*compressed*
: **boolean**? -- *path*... This command behaves like **::fileutil::magic::cfront::compile** with regard to the specified path arguments, then wraps the resulting recognizer script into a variable named **named** and a procedure named **analyzer**, and returns the resulting script. Argument *compressed* defaults to **boolean** **true**, meaning that whitespace is minimised in the script that the command returns. The argument *--* is always required.

**::fileutil::magic::cfront::install** *path*...
: This command behaves like **::fileutil::magic::cfront::compile** with regard to the specified path arguments.  It uses **::fileutil::magic::cfront::generate** to compile a recognizer script, and evaluates this script in the current interpreter so that it will be used by command **::fileutil::magic::filetype**.


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *fileutil :: magic* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Programming tools
